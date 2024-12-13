# See LICENSE file for copyright and license details
# libgrapheme - unicode string library
.POSIX:
.SUFFIXES:

VERSION_MAJOR = 2
VERSION_MINOR = 0
VERSION_PATCH = 1
UNICODE_VERSION = 15.0.0
UCD_URL = https://www.unicode.org/Public/$(UNICODE_VERSION)/ucd/UCD.zip
MAN_DATE = 2022-10-06

include config.mk

VERSION = $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)

BENCHMARK =\
	benchmark/bidirectional\
	benchmark/case\
	benchmark/character\
	benchmark/sentence\
	benchmark/line\
	benchmark/utf8-decode\
	benchmark/word\

DATA =\
	data/BidiBrackets.txt\
	data/BidiCharacterTest.txt\
	data/BidiMirroring.txt\
	data/BidiTest.txt\
	data/extracted/DerivedBidiClass.txt\
	data/DerivedCoreProperties.txt\
	data/EastAsianWidth.txt\
	data/emoji/emoji-data.txt\
	data/auxiliary/GraphemeBreakProperty.txt\
	data/auxiliary/GraphemeBreakTest.txt\
	data/LineBreak.txt\
	data/auxiliary/LineBreakTest.txt\
	data/auxiliary/SentenceBreakProperty.txt\
	data/auxiliary/SentenceBreakTest.txt\
	data/SpecialCasing.txt\
	data/UnicodeData.txt\
	data/auxiliary/WordBreakProperty.txt\
	data/auxiliary/WordBreakTest.txt\

GEN =\
	gen/bidirectional\
	gen/bidirectional-test\
	gen/case\
	gen/character\
	gen/character-test\
	gen/line\
	gen/line-test\
	gen/sentence\
	gen/sentence-test\
	gen/word\
	gen/word-test\

SRC =\
	src/bidirectional\
	src/case\
	src/character\
	src/line\
	src/sentence\
	src/utf8\
	src/util\
	src/word\

TEST =\
	test/bidirectional\
	test/case\
	test/character\
	test/line\
	test/sentence\
	test/utf8-decode\
	test/utf8-encode\
	test/word\

MAN_TEMPLATE =\
	man/template/is_case.sh\
	man/template/next_break.sh\
	man/template/to_case.sh\

MAN3 =\
	man/grapheme_decode_utf8\
	man/grapheme_encode_utf8\
	man/grapheme_is_character_break\
	man/grapheme_is_uppercase\
	man/grapheme_is_uppercase_utf8\
	man/grapheme_is_lowercase\
	man/grapheme_is_lowercase_utf8\
	man/grapheme_is_titlecase\
	man/grapheme_is_titlecase_utf8\
	man/grapheme_next_character_break\
	man/grapheme_next_line_break\
	man/grapheme_next_sentence_break\
	man/grapheme_next_word_break\
	man/grapheme_next_character_break_utf8\
	man/grapheme_next_line_break_utf8\
	man/grapheme_next_sentence_break_utf8\
	man/grapheme_next_word_break_utf8\
	man/grapheme_to_uppercase\
	man/grapheme_to_uppercase_utf8\
	man/grapheme_to_lowercase\
	man/grapheme_to_lowercase_utf8\
	man/grapheme_to_titlecase\
	man/grapheme_to_titlecase_utf8\

MAN7 =\
	man/libgrapheme\

all: data/LICENSE $(MAN3:=.3) $(MAN7:=.7) $(ANAME) $(SONAME)

UCD.zip:
	if command -v wget > /dev/null 2>&1; then \
		wget -O $@ https://www.unicode.org/Public/$(UNICODE_VERSION)/ucd/UCD.zip; \
	elif command -v curl > /dev/null 2>&1; then \
		curl -L https://www.unicode.org/Public/$(UNICODE_VERSION)/ucd/UCD.zip -o UCD.zip; \
	else \
		echo "Neither wget nor curl is installed. Please install one to download the file."; \
		exit 1; \
	fi

benchmark/bidirectional.o: benchmark/bidirectional.c Makefile config.mk gen/bidirectional-test.h grapheme.h benchmark/util.h
benchmark/case.o: benchmark/case.c Makefile config.mk gen/word-test.h grapheme.h benchmark/util.h
benchmark/character.o: benchmark/character.c Makefile config.mk gen/character-test.h grapheme.h benchmark/util.h
benchmark/line.o: benchmark/line.c Makefile config.mk gen/line-test.h grapheme.h benchmark/util.h
benchmark/utf8-decode.o: benchmark/utf8-decode.c Makefile config.mk gen/character-test.h grapheme.h benchmark/util.h
benchmark/sentence.o: benchmark/sentence.c Makefile config.mk gen/sentence-test.h grapheme.h benchmark/util.h
benchmark/util.o: benchmark/util.c Makefile config.mk benchmark/util.h
benchmark/word.o: benchmark/word.c Makefile config.mk gen/word-test.h grapheme.h benchmark/util.h
gen/bidirectional.o: gen/bidirectional.c Makefile config.mk gen/util.h
gen/bidirectional-test.o: gen/bidirectional-test.c Makefile config.mk gen/util.h
gen/case.o: gen/case.c Makefile config.mk gen/util.h
gen/character.o: gen/character.c Makefile config.mk gen/util.h
gen/character-test.o: gen/character-test.c Makefile config.mk gen/util.h
gen/line.o: gen/line.c Makefile config.mk gen/util.h
gen/line-test.o: gen/line-test.c Makefile config.mk gen/util.h
gen/sentence.o: gen/sentence.c Makefile config.mk gen/util.h
gen/sentence-test.o: gen/sentence-test.c Makefile config.mk gen/util.h
gen/word.o: gen/word.c Makefile config.mk gen/util.h
gen/word-test.o: gen/word-test.c Makefile config.mk gen/util.h
gen/util.o: gen/util.c Makefile config.mk gen/util.h
src/bidirectional.o: src/bidirectional.c Makefile config.mk gen/bidirectional.h grapheme.h src/util.h
src/case.o: src/case.c Makefile config.mk gen/case.h grapheme.h src/util.h
src/character.o: src/character.c Makefile config.mk gen/character.h grapheme.h src/util.h
src/line.o: src/line.c Makefile config.mk gen/line.h grapheme.h src/util.h
src/sentence.o: src/sentence.c Makefile config.mk gen/sentence.h grapheme.h src/util.h
src/utf8.o: src/utf8.c Makefile config.mk grapheme.h
src/util.o: src/util.c Makefile config.mk gen/types.h grapheme.h src/util.h
src/word.o: src/word.c Makefile config.mk gen/word.h grapheme.h src/util.h
test/bidirectional.o: test/bidirectional.c Makefile config.mk gen/bidirectional-test.h grapheme.h test/util.h
test/case.o: test/case.c Makefile config.mk grapheme.h test/util.h
test/character.o: test/character.c Makefile config.mk gen/character-test.h grapheme.h test/util.h
test/line.o: test/line.c Makefile config.mk gen/line-test.h grapheme.h test/util.h
test/sentence.o: test/sentence.c Makefile config.mk gen/sentence-test.h grapheme.h test/util.h
test/utf8-encode.o: test/utf8-encode.c Makefile config.mk grapheme.h test/util.h
test/utf8-decode.o: test/utf8-decode.c Makefile config.mk grapheme.h test/util.h
test/util.o: test/util.c Makefile config.mk test/util.h
test/word.o: test/word.c Makefile config.mk gen/word-test.h grapheme.h test/util.h

benchmark/bidirectional$(BINSUFFIX): benchmark/bidirectional.o benchmark/util.o $(ANAME)
benchmark/case$(BINSUFFIX): benchmark/case.o benchmark/util.o $(ANAME)
benchmark/character$(BINSUFFIX): benchmark/character.o benchmark/util.o $(ANAME)
benchmark/line$(BINSUFFIX): benchmark/line.o benchmark/util.o $(ANAME)
benchmark/sentence$(BINSUFFIX): benchmark/sentence.o benchmark/util.o $(ANAME)
benchmark/utf8-decode$(BINSUFFIX): benchmark/utf8-decode.o benchmark/util.o $(ANAME)
benchmark/word$(BINSUFFIX): benchmark/word.o benchmark/util.o $(ANAME)
gen/bidirectional$(BINSUFFIX): gen/bidirectional.o gen/util.o
gen/bidirectional-test$(BINSUFFIX): gen/bidirectional-test.o gen/util.o
gen/case$(BINSUFFIX): gen/case.o gen/util.o
gen/character$(BINSUFFIX): gen/character.o gen/util.o
gen/character-test$(BINSUFFIX): gen/character-test.o gen/util.o
gen/line$(BINSUFFIX): gen/line.o gen/util.o
gen/line-test$(BINSUFFIX): gen/line-test.o gen/util.o
gen/sentence$(BINSUFFIX): gen/sentence.o gen/util.o
gen/sentence-test$(BINSUFFIX): gen/sentence-test.o gen/util.o
gen/word$(BINSUFFIX): gen/word.o gen/util.o
gen/word-test$(BINSUFFIX): gen/word-test.o gen/util.o
test/bidirectional$(BINSUFFIX): test/bidirectional.o test/util.o $(ANAME)
test/case$(BINSUFFIX): test/case.o test/util.o $(ANAME)
test/character$(BINSUFFIX): test/character.o test/util.o $(ANAME)
test/line$(BINSUFFIX): test/line.o test/util.o $(ANAME)
test/sentence$(BINSUFFIX): test/sentence.o test/util.o $(ANAME)
test/utf8-encode$(BINSUFFIX): test/utf8-encode.o test/util.o $(ANAME)
test/utf8-decode$(BINSUFFIX): test/utf8-decode.o test/util.o $(ANAME)
test/word$(BINSUFFIX): test/word.o test/util.o $(ANAME)

gen/bidirectional.h: data/BidiBrackets.txt data/BidiMirroring.txt data/extracted/DerivedBidiClass.txt data/UnicodeData.txt gen/bidirectional$(BINSUFFIX)
gen/bidirectional-test.h: data/BidiCharacterTest.txt data/BidiTest.txt gen/bidirectional-test$(BINSUFFIX)
gen/case.h: data/DerivedCoreProperties.txt data/UnicodeData.txt data/SpecialCasing.txt gen/case$(BINSUFFIX)
gen/character.h: data/emoji/emoji-data.txt data/auxiliary/GraphemeBreakProperty.txt gen/character$(BINSUFFIX)
gen/character-test.h: data/auxiliary/GraphemeBreakTest.txt gen/character-test$(BINSUFFIX)
gen/line.h: data/emoji/emoji-data.txt data/EastAsianWidth.txt data/LineBreak.txt gen/line$(BINSUFFIX)
gen/line-test.h: data/auxiliary/LineBreakTest.txt gen/line-test$(BINSUFFIX)
gen/sentence.h: data/auxiliary/SentenceBreakProperty.txt gen/sentence$(BINSUFFIX)
gen/sentence-test.h: data/auxiliary/SentenceBreakTest.txt gen/sentence-test$(BINSUFFIX)
gen/word.h: data/auxiliary/WordBreakProperty.txt gen/word$(BINSUFFIX)
gen/word-test.h: data/auxiliary/WordBreakTest.txt gen/word-test$(BINSUFFIX)

man/grapheme_is_character_break.3: man/grapheme_is_character_break.sh Makefile config.mk
man/grapheme_is_uppercase.3: man/grapheme_is_uppercase.sh man/template/is_case.sh Makefile config.mk
man/grapheme_is_uppercase_utf8.3: man/grapheme_is_uppercase_utf8.sh man/template/is_case.sh Makefile config.mk
man/grapheme_is_lowercase.3: man/grapheme_is_lowercase.sh man/template/is_case.sh Makefile config.mk
man/grapheme_is_lowercase_utf8.3: man/grapheme_is_lowercase_utf8.sh man/template/is_case.sh Makefile config.mk
man/grapheme_is_titlecase.3: man/grapheme_is_titlecase.sh man/template/is_case.sh Makefile config.mk
man/grapheme_is_titlecase_utf8.3: man/grapheme_is_titlecase_utf8.sh man/template/is_case.sh Makefile config.mk
man/grapheme_next_character_break.3: man/grapheme_next_character_break.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_line_break.3: man/grapheme_next_line_break.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_sentence_break.3: man/grapheme_next_sentence_break.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_word_break.3: man/grapheme_next_word_break.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_character_break_utf8.3: man/grapheme_next_character_break_utf8.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_line_break_utf8.3: man/grapheme_next_line_break_utf8.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_sentence_break_utf8.3: man/grapheme_next_sentence_break_utf8.sh man/template/next_break.sh Makefile config.mk
man/grapheme_next_word_break_utf8.3: man/grapheme_next_word_break_utf8.sh man/template/next_break.sh Makefile config.mk
man/grapheme_to_uppercase.3: man/grapheme_to_uppercase.sh man/template/to_case.sh Makefile config.mk
man/grapheme_to_lowercase.3: man/grapheme_to_lowercase.sh man/template/to_case.sh Makefile config.mk
man/grapheme_to_titlecase.3: man/grapheme_to_titlecase.sh man/template/to_case.sh Makefile config.mk
man/grapheme_to_uppercase_utf8.3: man/grapheme_to_uppercase_utf8.sh man/template/to_case.sh Makefile config.mk
man/grapheme_to_lowercase_utf8.3: man/grapheme_to_lowercase_utf8.sh man/template/to_case.sh Makefile config.mk
man/grapheme_to_titlecase_utf8.3: man/grapheme_to_titlecase_utf8.sh man/template/to_case.sh Makefile config.mk
man/grapheme_decode_utf8.3: man/grapheme_decode_utf8.sh Makefile config.mk
man/grapheme_encode_utf8.3: man/grapheme_encode_utf8.sh Makefile config.mk

man/libgrapheme.7: man/libgrapheme.sh Makefile config.mk

$(DATA): UCD.zip
	unzip -DD -d data UCD.zip

$(GEN:=.o) gen/util.o:
	$(BUILD_CC) -c -o $@ $(BUILD_CPPFLAGS) $(BUILD_CFLAGS) $(@:.o=.c)

$(BENCHMARK:=.o) benchmark/util.o $(TEST:=.o) test/util.o:
	$(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $(@:.o=.c)

$(SRC:=.o):
	$(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $(SHFLAGS) $(@:.o=.c)

$(BENCHMARK:=$(BINSUFFIX)):
	$(CC) -o $@ $(LDFLAGS) $(@:$(BINSUFFIX)=.o) benchmark/util.o $(ANAME) -lutf8proc

$(GEN:=$(BINSUFFIX)):
	$(BUILD_CC) -o $@ $(BUILD_LDFLAGS) $(@:$(BINSUFFIX)=.o) gen/util.o

$(TEST:=$(BINSUFFIX)):
	$(CC) -o $@ $(LDFLAGS) $(@:$(BINSUFFIX)=.o) test/util.o $(ANAME)

$(GEN:=.h):
	$(@:.h=$(BINSUFFIX)) > $@

$(ANAME): $(SRC:=.o)
	$(AR) -rc $@ $?
	$(RANLIB) $@

$(SONAME): $(SRC:=.o)
	$(CC) -o $@ $(SOFLAGS) $(LDFLAGS) $(SRC:=.o)

$(MAN3:=.3):
	SH="$(SH)" MAN_DATE="$(MAN_DATE)" UNICODE_VERSION="$(UNICODE_VERSION)" $(SH) $(@:.3=.sh) > $@

$(MAN7:=.7):
	SH="$(SH)" MAN_DATE="$(MAN_DATE)" UNICODE_VERSION="$(UNICODE_VERSION)" $(SH) $(@:.7=.sh) > $@

benchmark: $(BENCHMARK:=$(BINSUFFIX))
	for m in $(BENCHMARK:=$(BINSUFFIX)); do ./$$m; done

check: test

test: $(TEST:=$(BINSUFFIX))
	for m in $(TEST:=$(BINSUFFIX)); do ./$$m; done

install: all
	mkdir -p "$(DESTDIR)$(LIBPREFIX)"
	mkdir -p "$(DESTDIR)$(INCPREFIX)"
	mkdir -p "$(DESTDIR)$(MANPREFIX)/man3"
	mkdir -p "$(DESTDIR)$(MANPREFIX)/man7"
	cp -f $(MAN3:=.3) "$(DESTDIR)$(MANPREFIX)/man3"
	cp -f $(MAN7:=.7) "$(DESTDIR)$(MANPREFIX)/man7"
	cp -f $(ANAME) "$(DESTDIR)$(LIBPREFIX)"
	cp -f $(SONAME) "$(DESTDIR)$(LIBPREFIX)/$(SONAME)"
	if [ "$(SOSYMLINK)" = "true" ]; then i=0; while [ "$$i" -le $(VERSION_MINOR) ]; do ln -sf "$(SONAME)" "$(DESTDIR)$(LIBPREFIX)/libgrapheme.so.$(VERSION_MAJOR).$$i"; i=$$((i+1)); done; fi
	if [ "$(SOSYMLINK)" = "true" ]; then ln -sf "$(SONAME)" "$(DESTDIR)$(LIBPREFIX)/libgrapheme.so.$(VERSION_MAJOR)"; fi
	if [ "$(SOSYMLINK)" = "true" ]; then ln -sf "$(SONAME)" "$(DESTDIR)$(LIBPREFIX)/libgrapheme.so"; fi
	cp -f grapheme.h "$(DESTDIR)$(INCPREFIX)"
	if ! [ -z "$(LDCONFIG)" ]; then $(SHELL) -c "$(LDCONFIG)"; fi
	if ! [ -z "$(PCPREFIX)" ]; then mkdir -p "$(DESTDIR)$(PCPREFIX)"; printf "Name: libgrapheme\nDescription: Unicode string library\nURL: https://libs.suckless.org/libgrapheme/\nVersion: $(VERSION)\nCflags: -I$(INCPREFIX)\nLibs: -L$(LIBPREFIX) -lgrapheme\n" > "$(DESTDIR)$(PCPREFIX)/libgrapheme.pc"; fi

uninstall:
	for m in $(MAN3:=.3); do rm -f "$(DESTDIR)$(MANPREFIX)/man3/`basename $$m`"; done
	for m in $(MAN7:=.7); do rm -f "$(DESTDIR)$(MANPREFIX)/man7/`basename $$m`"; done
	rm -f "$(DESTDIR)$(LIBPREFIX)/$(ANAME)"
	rm -f "$(DESTDIR)$(LIBPREFIX)/$(SONAME)"
	if [ "$(SOSYMLINK)" = "true" ]; then i=0; while [ "$$i" -le $(VERSION_MINOR) ]; do rm -f "$(DESTDIR)$(LIBPREFIX)/libgrapheme.so.$(VERSION_MAJOR).$$i"; i=$$((i+1)); done; fi
	if [ "$(SOSYMLINK)" = "true" ]; then rm -f "$(DESTDIR)$(LIBPREFIX)/libgrapheme.so.$(VERSION_MAJOR)"; fi
	if [ "$(SOSYMLINK)" = "true" ]; then rm -f "$(DESTDIR)$(LIBPREFIX)/libgrapheme.so"; fi
	rm -f "$(DESTDIR)$(INCPREFIX)/grapheme.h"
	if ! [ -z "$(LDCONFIG)" ]; then $(SHELL) -c "$(LDCONFIG)"; fi
	if ! [ -z "$(PCPREFIX)" ]; then rm -f "$(DESTDIR)$(PCPREFIX)/libgrapheme.pc"; fi

clean:
	rm -f $(BENCHMARK:=.o) benchmark/util.o $(BENCHMARK:=$(BINSUFFIX)) $(GEN:=.h) $(GEN:=.o) gen/util.o $(GEN:=$(BINSUFFIX)) $(SRC:=.o) src/util.o $(TEST:=.o) test/util.o $(TEST:=$(BINSUFFIX)) $(ANAME) $(SONAME) $(MAN3:=.3) $(MAN7:=.7)

clean-data:
	find data -mindepth 1 -not -name LICENSE -exec rm -rf {} +
	rm -f UCD.zip

dist:
	rm -rf "libgrapheme-$(VERSION)"
	mkdir "libgrapheme-$(VERSION)"
	for m in benchmark data gen man man/template src test; do mkdir "libgrapheme-$(VERSION)/$$m"; done
	cp config.mk configure grapheme.h LICENSE Makefile README "libgrapheme-$(VERSION)"
	cp $(BENCHMARK:=.c) benchmark/util.c benchmark/util.h "libgrapheme-$(VERSION)/benchmark"
	cp $(DATA) "libgrapheme-$(VERSION)/data"
	cp $(GEN:=.c) gen/util.c gen/types.h gen/util.h "libgrapheme-$(VERSION)/gen"
	cp $(MAN3:=.sh) $(MAN7:=.sh) "libgrapheme-$(VERSION)/man"
	cp $(MAN_TEMPLATE) "libgrapheme-$(VERSION)/man/template"
	cp $(SRC:=.c) src/util.h "libgrapheme-$(VERSION)/src"
	cp $(TEST:=.c) test/util.c test/util.h "libgrapheme-$(VERSION)/test"
	tar -cf - "libgrapheme-$(VERSION)" | gzip -c > "libgrapheme-$(VERSION).tar.gz"
	rm -rf "libgrapheme-$(VERSION)"

format:
	clang-format -i grapheme.h $(BENCHMARK:=.c) benchmark/util.c benchmark/util.h $(GEN:=.c) gen/util.c gen/types.h gen/util.h $(SRC:=.c) src/util.h $(TEST:=.c) test/util.c test/util.h

.PHONY: all benchmark check clean clean-data dist format install test uninstall
