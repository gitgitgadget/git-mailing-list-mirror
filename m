Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D8DC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhLQAF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLQAFY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:05:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CCDC06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:05:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j9so996527wrc.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pmqnkmmN2E3Q8ELmJsKCs5qQtMiLiwhYpHKdfFibJA=;
        b=Pt7oehf1KGZ7WFKlsp/PhwCtLA+FQ5nwF5gVA4RoSqw3oB5PQptowT4D9DTzJOYaE+
         +APklb+UmSbvXOEEBrN5tGw7RQ4v9oUHhcNC70b25d3SiuXw2Fk7hIkGLYcBBiwWiurc
         WqsAqhcAPXVwt2uAhCOnxT+VAiCty9WYs0Dx+k1yLlbA9soitCHvJ+Ib64e3XJqNlrNN
         4m4HvaK0Os/tBtGrbiwXbUjy1gt+UcvsWTHV54+til29tC66EuYVJgqP6cR4GmD3C29+
         1khZcfOQ9atRbIwCdSqVJjg5jbBgN2DdnfKAw1TaLlQ274KEJ/REO9K1wW5cEs2I6s6r
         eaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pmqnkmmN2E3Q8ELmJsKCs5qQtMiLiwhYpHKdfFibJA=;
        b=MGEfPxD9mn97RMhQBIAc6Gstyclxl9VGGTntNejbbSr2OYzjilh5AvbKc75rt4UBzG
         KOjyM0kBla8XdgWmaU+ZfIvhlIl/LlQrGV0lcZn6LWWUrH9FT9bT00G4TZ4bLra/flj7
         KRuZVZtmKZyA0lu2CTv6jmTyQWfa4sXfg+b2l+Ey4LZoWlW1pIp82cmYsXtHOLuP0Gj0
         x8kHx8I6QPoyXPvOpW66gBkXqBaTH8nWUs8OA5jEyMxlnziN1+zDQZM27yAT6Ro/lcMe
         oTd42rIrr1NKohJCwevGOTASNJAYGo15+cQJG8M7BN3kR3d2lGZvHGXVxc/2Zc7ilxR8
         uzZw==
X-Gm-Message-State: AOAM530WISmxKR2McM7RKslmF5eoHiDAVjHHszQc1HtuUDjF8V8FgwfR
        eaWJZVdQc1RQi/pIb277qC1wqyrIlWP7SQ==
X-Google-Smtp-Source: ABdhPJyBBk2unS1d+MD6RsqmZs0MCdrZCvbKP0hDe2AuQgYi2Zy2nlSdVCK/z0ueoUr8lgJkwzcuyQ==
X-Received: by 2002:a5d:6dcd:: with SMTP id d13mr296571wrz.584.1639699520444;
        Thu, 16 Dec 2021 16:05:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h19sm6057592wmq.0.2021.12.16.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:05:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CI: remove support for Azure CI
Date:   Fri, 17 Dec 2021 01:04:56 +0100
Message-Id: <patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove various code required to support Azure CI. Recently in
4a6e4b96026 (CI: remove Travis CI support, 2021-11-23) we removed the
Travis CI support, which was last used in June 2021.

The supporting infrastructure for Azure CI was already partially
removed in 6081d3898fe (ci: retire the Azure Pipelines definition,
2020-04-11). As that commit notes:

    We have GitHub Actions now. Running the same builds and tests in Azure
    Pipelines would be redundant, and a waste of energy.

This follow-up removes the relevant Azure Pipelines-only supporting
code. Most of it was added in commits merged as part of
57cbc53d3e0 (Merge branch 'js/vsts-ci', 2019-02-06).

The motivation for this change is wanting to make some test-lib.sh
changes. If we don't remove the Azure-specific JUnit code changing
anything to do with writing the test TAP output will also need to
write out corresponding JUnit. I'd rather not figure out how to patch
dead code, so let's just remove it.

The "BREW_INSTALL_PACKAGES" variable being removed here was added in
b011fabd6e0 (ci/lib.sh: encapsulate Travis-specific things,
2019-01-27), but its last user went away in my 4a6e4b96026 (CI: remove
Travis CI support, 2021-11-23).

I had an RFC proposal to do some of this a while ago by generating the
JUnit via tap2junit[1]. Johannes had an objection to it on the basis
that if we resurrected the JUnit support in some form he'd prefer not
to run Perl on Windows[2] (which tap2junit is implemented in).

I have local WIP patches in C (via a new test-tool helper) to parse
the TAP output. That'll allow us to emit to any arbitrary targets,
including JUnit. So given that this is currently unused I'd prefer to
take this step first. The unsubmitted series to get that TAP parser
working would run into the same chicken & egg problem with needing to
concern itself with the JUnit output.

Note that the code being modified in "t/helper/test-run-command.c"
could also be entirely removed. It has been unused since
4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
job, 2020-06-26). Before that in 6081d3898fe (ci: retire the Azure
Pipelines definition, 2020-04-11) the Azure Pipelines stopped using
it. Per the discussion starting at [3] there are some future plans to
make use of it again, so let's keep it for now.

1. https://lore.kernel.org/git/20210309160219.13779-8-avarab@gmail.com/
2. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103221429200.50@tvgsbejvaqbjf.bet
3. https://lore.kernel.org/git/patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                    |   1 -
 ci/install-dependencies.sh  |   2 -
 ci/lib.sh                   |  24 +-------
 ci/print-test-failures.sh   |   5 --
 t/helper/test-date.c        |  12 ----
 t/helper/test-path-utils.c  |  21 -------
 t/helper/test-run-command.c |   6 +-
 t/helper/test-tool.c        |   1 -
 t/helper/test-tool.h        |   1 -
 t/helper/test-xml-encode.c  |  80 -------------------------
 t/test-lib.sh               | 113 ------------------------------------
 11 files changed, 2 insertions(+), 264 deletions(-)
 delete mode 100644 t/helper/test-xml-encode.c

diff --git a/Makefile b/Makefile
index 9c00a793e47..0c86d8cfbb7 100644
--- a/Makefile
+++ b/Makefile
@@ -756,7 +756,6 @@ TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
-TEST_BUILTINS_OBJS += test-xml-encode.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..1d7bf82fdfb 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,8 +34,6 @@ macos-latest)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	test -z "$BREW_INSTALL_PACKAGES" ||
-	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	brew install --cask --no-quarantine perforce || {
 		# Update the definitions and try again
diff --git a/ci/lib.sh b/ci/lib.sh
index 9d28ab50fb4..6765868fd73 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -91,29 +91,7 @@ export MAKEFLAGS=
 # and installing dependencies.
 set -ex
 
-if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
-then
-	CI_TYPE=azure-pipelines
-	# We are running in Azure Pipelines
-	CI_BRANCH="$BUILD_SOURCEBRANCH"
-	CI_COMMIT="$BUILD_SOURCEVERSION"
-	CI_JOB_ID="$BUILD_BUILDID"
-	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
-	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
-	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
-	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
-	CC="${CC:-gcc}"
-
-	# use a subdirectory of the cache dir (because the file share is shared
-	# among *all* phases)
-	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
-
-	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
-	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
-	test windows_nt != "$CI_OS_NAME" ||
-	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
-elif test true = "$GITHUB_ACTIONS"
+if test true = "$GITHUB_ACTIONS"
 then
 	CI_TYPE=github-actions
 	CI_BRANCH="$GITHUB_REF"
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 57277eefcd0..4582add11d0 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -39,11 +39,6 @@ do
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
 		case "$CI_TYPE" in
-		azure-pipelines)
-			mkdir -p failed-test-artifacts
-			mv "$trash_dir" failed-test-artifacts
-			continue
-			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
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
index 229ed416b0e..2137513c474 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -427,27 +427,6 @@ int cmd__path_utils(int argc, const char **argv)
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
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 913775a14b7..c43670ad464 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -58,7 +58,7 @@ static int task_finished(int result,
 struct testsuite {
 	struct string_list tests, failed;
 	int next;
-	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
+	int quiet, immediate, verbose, verbose_log, trace;
 };
 #define TESTSUITE_INIT { \
 	.tests = STRING_LIST_INIT_DUP, \
@@ -85,8 +85,6 @@ static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		strvec_push(&cp->args, "-V");
 	if (suite->trace)
 		strvec_push(&cp->args, "-x");
-	if (suite->write_junit_xml)
-		strvec_push(&cp->args, "--write-junit-xml");
 
 	strbuf_addf(err, "Output of '%s':\n", test);
 	*task_cb = (void *)test;
@@ -139,8 +137,6 @@ static int testsuite(int argc, const char **argv)
 		OPT_BOOL('V', "verbose-log", &suite.verbose_log,
 			 "be verbose, redirected to a file"),
 		OPT_BOOL('x', "trace", &suite.trace, "trace shell commands"),
-		OPT_BOOL(0, "write-junit-xml", &suite.write_junit_xml,
-			 "write JUnit-style XML files"),
 		OPT_END()
 	};
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 338a57b104d..c4b0d061fd0 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -80,7 +80,6 @@ static struct test_cmd cmds[] = {
 	{ "trace2", cmd__trace2 },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
-	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
 #ifdef GIT_WINDOWS_NATIVE
 	{ "windows-named-pipe", cmd__windows_named_pipe },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 48cee1f4a2d..4763f473aba 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -70,7 +70,6 @@ int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
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
index 0f7a137c7d8..be5452b263c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -165,9 +165,6 @@ parse_option () {
 		verbose_log=t
 		tee=t
 		;;
-	--write-junit-xml)
-		write_junit_xml=t
-		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
@@ -613,7 +610,6 @@ exec 6<&0
 exec 7>&2
 
 _error_exit () {
-	finalize_junit_xml
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -723,35 +719,11 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$*"
-	fi
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
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
 	say_color error "not ok $test_count - $1"
 	shift
@@ -760,19 +732,11 @@ test_failure_ () {
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
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
@@ -1049,10 +1013,6 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	if test -n "$write_junit_xml"
-	then
-		junit_start=$(test-tool date getnanos)
-	fi
 }
 
 test_finish_ () {
@@ -1103,13 +1063,6 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		if test -n "$write_junit_xml"
-		then
-			message="$(xml_attr_encode "$skipped_reason")"
-			write_junit_xml_testcase "$1" \
-				"      <skipped message=\"$message\" />"
-		fi
-
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
@@ -1124,53 +1077,6 @@ test_at_end_hook_ () {
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
@@ -1193,8 +1099,6 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
-
 	if test -z "$HARNESS_ACTIVE"
 	then
 		mkdir -p "$TEST_RESULTS_DIR"
@@ -1484,23 +1388,6 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
 
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
 # A regexp to match 5 and 35 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-- 
2.34.1.1119.g7a3fc8778ee

