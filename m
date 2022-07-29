Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16BFC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 14:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiG2OxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiG2OxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 10:53:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01C6D9EE
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:53:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b26so6325462wrc.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HxPpvWcyL06CACQ4e8+gjO79o60AFxajNCW/QF2vzM0=;
        b=UMyU7GdRr2XZW1aFXH9++nPqiRxqo3WlF++asJy2Z0iM7y8b9pmWhh1RM4qHi6kXfd
         HljfZUNh/O2kROlBI8HVaVMrp+0Zuu++mIrg4MtQhU+SA5gyXed/jC4m7gYpccymTdAU
         8eHq2fYzfAf72I29JkKx4qV3ty4hMY+yXzXp1yP2hEPHZEfDKshaqdN+xO9fjCAResA1
         XBeWfThFvf9TnGch4kxxwvVzrp9NydE2kB9zCfP3g4Ew0uCr1mvS38EtKclPO0Mk/U5X
         UT69LmLpBhVBs59ta3Mp82T52LJEQISYOAteniCa3TINGE4k/eQ3m4ltAEmDx6O0Z/K3
         0/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HxPpvWcyL06CACQ4e8+gjO79o60AFxajNCW/QF2vzM0=;
        b=X3bzKRGfd5a8vDadC1vEcVo3KNNV4J5w/MTWYAYE62eLYeCQ+jm+qkHauOaq7TVuoF
         R9U9TxlOt3WEzPtO2sUy0/p6bupNRnbgC71Zgx5cUJi7hZEBCa8l2K6oNtK6rGqd/GUX
         mE7wS/4WBrW6wgLKQk8wLpsB0pkKPcJbmEYGgBztJft6Q0ZczWUsESFJYp2pu5AhYnrM
         1SQcpjgqpS0MxPeBAHB9E36/cw6G9yTGyKG798wr1m3MMB+/MV1wR3GE5TrS52BIePYU
         Chy8xuWf4+YxpXhrWpudBxkwEW4kinWke9igGl6uZvNB2w0DpzL3pT1ug2QzQjZH7bMN
         H32w==
X-Gm-Message-State: ACgBeo0i/l+Xa4tuPuHJjAkFZGs7Um/avF0i76zVKnV9x8MtemhKRukP
        u8jUb4Pq8stC7s3pgIbgo1poMUNFTMY=
X-Google-Smtp-Source: AA6agR6IW73I4puTiayzwXBizbbQGxUFxXr2PddBfJikxRI2wu6K31XwbOu6Xnz4KZoFklhoWPV4hg==
X-Received: by 2002:adf:e312:0:b0:21e:5d66:e0f1 with SMTP id b18-20020adfe312000000b0021e5d66e0f1mr2521245wrj.428.1659106383672;
        Fri, 29 Jul 2022 07:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c03cc00b003a2eacc8179sm4509010wmd.27.2022.07.29.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 07:53:03 -0700 (PDT)
Message-Id: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 14:53:01 +0000
Subject: [PATCH] tests: replace mingw_test_cmp with a helper in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This helper is more performant than running the `mingw_test_cmp` code
with with MSYS2's Bash. And a lot more readable.

To accommodate t1050, which wants to compare files weighing in with 3MB
(falling outside of t1050's malloc limit of 1.5MB), we simply lift the
allocation limit by setting the environment variable GIT_ALLOC_LIMIT to
zero when calling the helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    tests: replace mingw_test_cmp with a helper in C
    
    On the heels of sending a patch to fix a performance regression due to a
    mis-use of test_cmp
    [https://lore.kernel.org/git/b9203ea247776332e4b6f519aa27d541207adc2f.1659097724.git.gitgitgadget@gmail.com/],
    I was curious to see whether Git for Windows had the same issue. And it
    does not
    [https://github.com/git-for-windows/git/runs/7556381815?check_suite_focus=true#step:5:127]:
    it passes t5351 in 22 seconds, even while using test_cmp to compare pack
    files
    [https://github.com/git-for-windows/git/blob/3922f62f0d5991e9fe0a0817ebf89a91339c7705/t/t5351-unpack-large-objects.sh#L90].
    
    The answer is of course that a test helper written in C is much faster
    than writing the same in Bash, especially on Windows. This is especially
    sad when said Bash code is only used on Windows. So I pulled out this
    helper from the years-long effort to let Git for Windows use BusyBox'
    ash to run the test suite. The result is this patch, which has been in
    Git for Windows since June 2018.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1309%2Fdscho%2Fmingw-test-cmp-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1309/dscho/mingw-test-cmp-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1309

 Makefile                |  1 +
 t/helper/test-cmp.c     | 73 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 t/test-lib-functions.sh | 68 +-------------------------------------
 t/test-lib.sh           |  2 +-
 6 files changed, 78 insertions(+), 68 deletions(-)
 create mode 100644 t/helper/test-cmp.c

diff --git a/Makefile b/Makefile
index 1624471badc..45f108e43a1 100644
--- a/Makefile
+++ b/Makefile
@@ -723,6 +723,7 @@ TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
+TEST_BUILTINS_OBJS += test-cmp.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
diff --git a/t/helper/test-cmp.c b/t/helper/test-cmp.c
new file mode 100644
index 00000000000..1c646a54bf6
--- /dev/null
+++ b/t/helper/test-cmp.c
@@ -0,0 +1,73 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "gettext.h"
+#include "parse-options.h"
+#include "run-command.h"
+
+#ifdef WIN32
+#define NO_SUCH_DIR "\\\\.\\GLOBALROOT\\invalid"
+#else
+#define NO_SUCH_DIR "/dev/null"
+#endif
+
+static int run_diff(const char *path1, const char *path2)
+{
+	const char *argv[] = {
+		"diff", "--no-index", NULL, NULL, NULL
+	};
+	const char *env[] = {
+		"GIT_PAGER=cat",
+		"GIT_DIR=" NO_SUCH_DIR,
+		"HOME=" NO_SUCH_DIR,
+		NULL
+	};
+
+	argv[2] = path1;
+	argv[3] = path2;
+	return run_command_v_opt_cd_env(argv,
+					RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
+					NULL, env);
+}
+
+int cmd__cmp(int argc, const char **argv)
+{
+	FILE *f0, *f1;
+	struct strbuf b0 = STRBUF_INIT, b1 = STRBUF_INIT;
+
+	if (argc != 3)
+		die("Require exactly 2 arguments, got %d", argc);
+
+	if (!(f0 = !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
+		return error_errno("could not open '%s'", argv[1]);
+	if (!(f1 = !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
+		fclose(f0);
+		return error_errno("could not open '%s'", argv[2]);
+	}
+
+	for (;;) {
+		int r0 = strbuf_getline(&b0, f0);
+		int r1 = strbuf_getline(&b1, f1);
+
+		if (r0 == EOF) {
+			fclose(f0);
+			fclose(f1);
+			strbuf_release(&b0);
+			strbuf_release(&b1);
+			if (r1 == EOF)
+				return 0;
+cmp_failed:
+			if (!run_diff(argv[1], argv[2]))
+				die("Huh? 'diff --no-index %s %s' succeeded",
+				    argv[1], argv[2]);
+			return 1;
+		}
+		if (r1 == EOF || strbuf_cmp(&b0, &b1)) {
+			fclose(f0);
+			fclose(f1);
+			strbuf_release(&b0);
+			strbuf_release(&b1);
+			goto cmp_failed;
+		}
+	}
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c3..3334de248a1 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -18,6 +18,7 @@ static struct test_cmd cmds[] = {
 	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
 	{ "chmtime", cmd__chmtime },
+	{ "cmp", cmd__cmp },
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
 	{ "csprng", cmd__csprng },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb799271631..e1104898cc3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -8,6 +8,7 @@ int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
+int cmd__cmp(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
 int cmd__csprng(int argc, const char **argv);
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8c44856eaec..28eddbc8e36 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1240,7 +1240,7 @@ test_expect_code () {
 
 test_cmp () {
 	test "$#" -ne 2 && BUG "2 param"
-	eval "$GIT_TEST_CMP" '"$@"'
+	GIT_ALLOC_LIMIT=0 eval "$GIT_TEST_CMP" '"$@"'
 }
 
 # Check that the given config key has the expected value.
@@ -1541,72 +1541,6 @@ test_skip_or_die () {
 	error "$2"
 }
 
-# The following mingw_* functions obey POSIX shell syntax, but are actually
-# bash scripts, and are meant to be used only with bash on Windows.
-
-# A test_cmp function that treats LF and CRLF equal and avoids to fork
-# diff when possible.
-mingw_test_cmp () {
-	# Read text into shell variables and compare them. If the results
-	# are different, use regular diff to report the difference.
-	local test_cmp_a= test_cmp_b=
-
-	# When text came from stdin (one argument is '-') we must feed it
-	# to diff.
-	local stdin_for_diff=
-
-	# Since it is difficult to detect the difference between an
-	# empty input file and a failure to read the files, we go straight
-	# to diff if one of the inputs is empty.
-	if test -s "$1" && test -s "$2"
-	then
-		# regular case: both files non-empty
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-	elif test -s "$1" && test "$2" = -
-	then
-		# read 2nd file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b
-		stdin_for_diff='<<<"$test_cmp_b"'
-	elif test "$1" = - && test -s "$2"
-	then
-		# read 1st file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-		stdin_for_diff='<<<"$test_cmp_a"'
-	fi
-	test -n "$test_cmp_a" &&
-	test -n "$test_cmp_b" &&
-	test "$test_cmp_a" = "$test_cmp_b" ||
-	eval "diff -u \"\$@\" $stdin_for_diff"
-}
-
-# $1 is the name of the shell variable to fill in
-mingw_read_file_strip_cr_ () {
-	# Read line-wise using LF as the line separator
-	# and use IFS to strip CR.
-	local line
-	while :
-	do
-		if IFS=$'\r' read -r -d $'\n' line
-		then
-			# good
-			line=$line$'\n'
-		else
-			# we get here at EOF, but also if the last line
-			# was not terminated by LF; in the latter case,
-			# some text was read
-			if test -z "$line"
-			then
-				# EOF, really
-				break
-			fi
-		fi
-		eval "$1=\$$1\$line"
-	done
-}
-
 # Like "env FOO=BAR some-program", but run inside a subshell, which means
 # it also works for shell functions (though those functions cannot impact
 # the environment outside of the test_env invocation).
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..220c259e796 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1546,7 +1546,7 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	test_set_prereq WINDOWS
-	GIT_TEST_CMP=mingw_test_cmp
+	GIT_TEST_CMP="test-tool cmp"
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM

base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
-- 
gitgitgadget
