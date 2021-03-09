Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83031C4332E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ADF652AB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhCIQCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCIQCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76854C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo6983579wmq.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKzb+SuJKVT81adlg4UKfVzdnEdJxH2LvVcDB9nZXic=;
        b=Lc7adibd0ekFTJtC+q9FiYu9MxsiAo3H7uhuBqbRYkzdZEK0eoBQErhJKQeNLUdqpx
         xkg31e0ZSWdjPru5d8gJzlo8KIf+k7TgUv6HPWcsAjHCVrpMFlI9EhSr6l99h1pMGzUx
         yAafVeimGM8mM2H1Tqpm+V69aQVXGm4Wlp/b56hHPq0wSLv6+ECr7pySriUki5q6lrz7
         3aY+BjSiRXWsgcEDEsWSCeBKSrQw2uhDCIDFQqxsCvupEje8MAWY0M47YZsW367AlLlW
         JC/F0I3u39PArlnBj7fVOKRCQZfx3XjDZjILc3Np7Izl5mhrBSABV9eeKYozCMJycLJi
         O63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKzb+SuJKVT81adlg4UKfVzdnEdJxH2LvVcDB9nZXic=;
        b=AGg6rkqpyiMvvvvqwExrPMrtaS8f9X3+ZbENNcfYo5J3WYNBRNOyLqNKKaokTroshG
         iRzJT7agTuCL0LZSwg2XMdm9Payx10pypa7TIGGNw3wnv72ijA8eAll/fx3+oJ+jqhwz
         /zR2RlOpwNSKYa5ZbkX82g1P59EgXKSssZzULDje8ppLlAQxfGcm2/8hgMaEzN6Lvspg
         +hPcY8H34gOxYA6+d+U+4f1XeGh5C3tHXf1t3awSQO+ZaibIGrtSYw3/I1i+Cx7E1BEb
         V5FE6FmqKKxQjuMS+4vqJ1SgUCme6hHHXrFVplv3EYSlWuc3w6rvWePIWo+3BTDrZqxi
         Icww==
X-Gm-Message-State: AOAM530S8AbObqT5UMBg77LzRXMaQqvxYa+7bFcOvNUqtXK54JBfK/TV
        KyQxFdQuNjhkJ0/54C5lvW/A6h8MWGgOsA==
X-Google-Smtp-Source: ABdhPJzHR9eSzpDVhgY6Gjsi5DGDySsUSF9Icl/3ainGWVg42dw0abRVUKMQ1N2J2VoeGZJE5gjAJw==
X-Received: by 2002:a1c:e041:: with SMTP id x62mr4708913wmg.95.1615305758617;
        Tue, 09 Mar 2021 08:02:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 7/7] test-lib: generate JUnit output via TAP
Date:   Tue,  9 Mar 2021 17:02:19 +0100
Message-Id: <20210309160219.13779-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite the home-brew JUnit output generation added in
22231908151 (tests: optionally write results as JUnit-style .xml,
2019-01-29) and other subsequent commits to be generated via the TAP
output.

This is now possible that the TAP output emitted with --tee is
guaranteed to be valid TAP, see the preceding commit.

The JUnit output is not bug-for-bug compatible with the previous
output, but it looks better to me.

This also requires installing TAP::Formatter::JUnit[1], perhaps that's
not palatable to the users of the --write-junit-xml option.

In any case, it'll be easy to whip up our own TAP emitter with a
TAP::Parser and TAP::Formatter, both of whom come with perl itself,
which we already rely on for tests.

It should also be significantly faster on Windows, as we can
e.g. write all the *.out files, and only do that conversion at the end
for all files in a batch, as opposed to the current implementation of
shelling out to test-tool in a loop for each test.

1. https://metacpan.org/pod/distribution/TAP-Formatter-JUnit/script/tap2junit

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                   |   1 -
 t/helper/test-date.c       |  12 ----
 t/helper/test-path-utils.c |  21 -------
 t/helper/test-tool.c       |   1 -
 t/helper/test-tool.h       |   1 -
 t/helper/test-xml-encode.c |  80 ------------------------
 t/test-lib.sh              | 123 ++++---------------------------------
 7 files changed, 12 insertions(+), 227 deletions(-)
 delete mode 100644 t/helper/test-xml-encode.c

diff --git a/Makefile b/Makefile
index d26b9d62ee9..fa7c52f7a42 100644
--- a/Makefile
+++ b/Makefile
@@ -748,7 +748,6 @@ TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
-TEST_BUILTINS_OBJS += test-xml-encode.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 099eff4f0fc..ebf133943b3 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -8,7 +8,6 @@ static const char *usage_msg = "\n"
 "  test-tool date parse [date]...\n"
 "  test-tool date approxidate [date]...\n"
 "  test-tool date timestamp [date]...\n"
-"  test-tool date getnanos [start-nanos]\n"
 "  test-tool date is64bit\n"
 "  test-tool date time_t-is64bit\n";
 
@@ -92,15 +91,6 @@ static void parse_approx_timestamp(const char **argv)
 	}
 }
 
-static void getnanos(const char **argv)
-{
-	double seconds = getnanotime() / 1.0e9;
-
-	if (*argv)
-		seconds -= strtod(*argv, NULL);
-	printf("%lf\n", seconds);
-}
-
 int cmd__date(int argc, const char **argv)
 {
 	const char *x;
@@ -120,8 +110,6 @@ int cmd__date(int argc, const char **argv)
 		parse_approxidate(argv+1);
 	else if (!strcmp(*argv, "timestamp"))
 		parse_approx_timestamp(argv+1);
-	else if (!strcmp(*argv, "getnanos"))
-		getnanos(argv+1);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(timestamp_t) == 8 ? 0 : 1;
 	else if (!strcmp(*argv, "time_t-is64bit"))
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 313a153209c..090596ac492 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -407,27 +407,6 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
 
-	if (argc == 4 && !strcmp(argv[1], "skip-n-bytes")) {
-		int fd = open(argv[2], O_RDONLY), offset = atoi(argv[3]);
-		char buffer[65536];
-
-		if (fd < 0)
-			die_errno("could not open '%s'", argv[2]);
-		if (lseek(fd, offset, SEEK_SET) < 0)
-			die_errno("could not skip %d bytes", offset);
-		for (;;) {
-			ssize_t count = read(fd, buffer, sizeof(buffer));
-			if (count < 0)
-				die_errno("could not read '%s'", argv[2]);
-			if (!count)
-				break;
-			if (write(1, buffer, count) < 0)
-				die_errno("could not write to stdout");
-		}
-		close(fd);
-		return 0;
-	}
-
 	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
 		int res = 0;
 		long offset, stride, i;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1876bad8f42..3fa02011b61 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -73,7 +73,6 @@ static struct test_cmd cmds[] = {
 	{ "tee", cmd__tee },
 	{ "trace2", cmd__trace2 },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
-	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
 #ifdef GIT_WINDOWS_NATIVE
 	{ "windows-named-pipe", cmd__windows_named_pipe },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9b3c1f75267..5028730807e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -63,7 +63,6 @@ int cmd__subprocess(int argc, const char **argv);
 int cmd__tee(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
-int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 #ifdef GIT_WINDOWS_NATIVE
 int cmd__windows_named_pipe(int argc, const char **argv);
diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
deleted file mode 100644
index a648bbd961c..00000000000
--- a/t/helper/test-xml-encode.c
+++ /dev/null
@@ -1,80 +0,0 @@
-#include "test-tool.h"
-
-static const char *utf8_replace_character = "&#xfffd;";
-
-/*
- * Encodes (possibly incorrect) UTF-8 on <stdin> to <stdout>, to be embedded
- * in an XML file.
- */
-int cmd__xml_encode(int argc, const char **argv)
-{
-	unsigned char buf[1024], tmp[4], *tmp2 = NULL;
-	ssize_t cur = 0, len = 1, remaining = 0;
-	unsigned char ch;
-
-	for (;;) {
-		if (++cur == len) {
-			len = xread(0, buf, sizeof(buf));
-			if (!len)
-				return 0;
-			if (len < 0)
-				die_errno("Could not read <stdin>");
-			cur = 0;
-		}
-		ch = buf[cur];
-
-		if (tmp2) {
-			if ((ch & 0xc0) != 0x80) {
-				fputs(utf8_replace_character, stdout);
-				tmp2 = NULL;
-				cur--;
-				continue;
-			}
-			*tmp2 = ch;
-			tmp2++;
-			if (--remaining == 0) {
-				fwrite(tmp, tmp2 - tmp, 1, stdout);
-				tmp2 = NULL;
-			}
-			continue;
-		}
-
-		if (!(ch & 0x80)) {
-			/* 0xxxxxxx */
-			if (ch == '&')
-				fputs("&amp;", stdout);
-			else if (ch == '\'')
-				fputs("&apos;", stdout);
-			else if (ch == '"')
-				fputs("&quot;", stdout);
-			else if (ch == '<')
-				fputs("&lt;", stdout);
-			else if (ch == '>')
-				fputs("&gt;", stdout);
-			else if (ch >= 0x20)
-				fputc(ch, stdout);
-			else if (ch == 0x09 || ch == 0x0a || ch == 0x0d)
-				fprintf(stdout, "&#x%02x;", ch);
-			else
-				fputs(utf8_replace_character, stdout);
-		} else if ((ch & 0xe0) == 0xc0) {
-			/* 110XXXXx 10xxxxxx */
-			tmp[0] = ch;
-			remaining = 1;
-			tmp2 = tmp + 1;
-		} else if ((ch & 0xf0) == 0xe0) {
-			/* 1110XXXX 10Xxxxxx 10xxxxxx */
-			tmp[0] = ch;
-			remaining = 2;
-			tmp2 = tmp + 1;
-		} else if ((ch & 0xf8) == 0xf0) {
-			/* 11110XXX 10XXxxxx 10xxxxxx 10xxxxxx */
-			tmp[0] = ch;
-			remaining = 3;
-			tmp2 = tmp + 1;
-		} else
-			fputs(utf8_replace_character, stdout);
-	}
-
-	return 0;
-}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0070d05234b..4dc41eeccc2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -371,6 +371,17 @@ then
 		--escape-stdout ${HARNESS_ACTIVE+--escape-file} \
 		"$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
+	if test -n "$write_junit_xml"
+	then
+		junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
+		mkdir -p "$junit_xml_dir"
+		junit_xml_base=${0##*/}
+		junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
+		junit_attrs="timestamp=\"$(TZ=UTC date +%Y-%m-%dT%H:%M:%S)\""
+		tap2junit --name="$TEST_NAME" - \
+			<"$GIT_TEST_TEE_OUTPUT_FILE" \
+			>"$junit_xml_path"
+	fi
 	exit
 elif test -n "$verbose" -a -n "$HARNESS_ACTIVE"
 then
@@ -588,7 +599,6 @@ export TERM
 
 error () {
 	say_color error "error: $*"
-	finalize_junit_xml
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -672,56 +682,24 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$*"
-	fi
 	test_success=$(($test_success + 1))
 	say_color_tap "${verbose:+pass}" "ok $test_count - $@"
 }
 
 test_failure_ () {
-	if test -n "$write_junit_xml"
-	then
-		junit_insert="<failure message=\"not ok $test_count -"
-		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
-		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-			   then
-				test-tool path-utils skip-n-bytes \
-					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-			   else
-				printf '%s\n' "$@" | sed 1d
-			   fi)")"
-		junit_insert="$junit_insert</failure>"
-		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-		then
-			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
-				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
-		fi
-		write_junit_xml_testcase "$1" "      $junit_insert"
-	fi
 	test_failure=$(($test_failure + 1))
 	say_color_tap error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
-	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
+	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
 }
 
 test_known_broken_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$* (breakage fixed)"
-	fi
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$* (known breakage)"
-	fi
 	test_broken=$(($test_broken+1))
 	say_color_tap warn "not ok $test_count - $@ # TODO known breakage"
 }
@@ -983,10 +961,6 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	if test -n "$write_junit_xml"
-	then
-		junit_start=$(test-tool date getnanos)
-	fi
 }
 
 test_finish_ () {
@@ -1029,13 +1003,6 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		if test -n "$write_junit_xml"
-		then
-			message="$(xml_attr_encode "$skipped_reason")"
-			write_junit_xml_testcase "$1" \
-				"      <skipped message=\"$message\" />"
-		fi
-
 		say_color_tap skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
@@ -1050,53 +1017,6 @@ test_at_end_hook_ () {
 	:
 }
 
-write_junit_xml () {
-	case "$1" in
-	--truncate)
-		>"$junit_xml_path"
-		junit_have_testcase=
-		shift
-		;;
-	esac
-	printf '%s\n' "$@" >>"$junit_xml_path"
-}
-
-xml_attr_encode () {
-	printf '%s\n' "$@" | test-tool xml-encode
-}
-
-write_junit_xml_testcase () {
-	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
-	shift
-	junit_attrs="$junit_attrs classname=\"$this_test\""
-	junit_attrs="$junit_attrs time=\"$(test-tool \
-		date getnanos $junit_start)\""
-	write_junit_xml "$(printf '%s\n' \
-		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
-	junit_have_testcase=t
-}
-
-finalize_junit_xml () {
-	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
-	then
-		test -n "$junit_have_testcase" || {
-			junit_start=$(test-tool date getnanos)
-			write_junit_xml_testcase "all tests skipped"
-		}
-
-		# adjust the overall time
-		junit_time=$(test-tool date getnanos $junit_suite_start)
-		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
-			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
-			-e '/^ *<\/testsuite/d' \
-			<"$junit_xml_path" >"$junit_xml_path.new"
-		mv "$junit_xml_path.new" "$junit_xml_path"
-
-		write_junit_xml "  </testsuite>" "</testsuites>"
-		write_junit_xml=
-	fi
-}
-
 test_atexit_cleanup=:
 test_atexit_handler () {
 	# In a succeeding test script 'test_atexit_handler' is invoked
@@ -1119,8 +1039,6 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
-
 	if test -z "$HARNESS_ACTIVE"
 	then
 		mkdir -p "$TEST_RESULTS_DIR"
@@ -1364,23 +1282,6 @@ then
 	test_done
 fi
 
-if test -n "$write_junit_xml"
-then
-	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
-	mkdir -p "$junit_xml_dir"
-	junit_xml_base=${0##*/}
-	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
-	junit_attrs="name=\"${junit_xml_base%.sh}\""
-	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
-		date +%Y-%m-%dT%H:%M:%S)\""
-	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
-	junit_suite_start=$(test-tool date getnanos)
-	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-	then
-		GIT_TEST_TEE_OFFSET=0
-	fi
-fi
-
 # Convenience
 # A regexp to match 5, 35 and 40 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-- 
2.31.0.rc1.210.g0f8085a843c

