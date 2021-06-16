Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914FC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA9B61246
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFPI0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPI0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 04:26:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BEC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:24:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c9so1632892wrt.5
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DLXXsq7Ag9PoE4039xzZIT/4V7LQpNZZXxl/FQncTE=;
        b=Nh/qkUqnDFRJFs/kGLWDctwx4JAfDXO96a+IM9ecNThPf/LNBmXkKNfGpOBafNQG+r
         YVjagUOt8xG7U6m9c4Bzjysz/d58otTnrhUzDSqIF7+3evFdzucOnNceL8PUmpVHzdUD
         9jDpdfnrp1pd92g5PgLfjSHQeNaUKEwhZ4N9xLrycICOjYmxKroUAk3uWQkwGE6So3HH
         QLlmWAA9Usy5flKe+E6srvrFI51WrKQgAGf/t51Mmq+1HInZPkrohuIura89fTTLqnjX
         C/xcrFR6/encr+QpjszdETqstreyCDt7eyO+NIfiw3EcR/AB806XeC3yw/4f6VrQYzwK
         Umcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DLXXsq7Ag9PoE4039xzZIT/4V7LQpNZZXxl/FQncTE=;
        b=jd15qEdg/KxObKmJcRI1jLxKjhHitUclAETHECOTvO+7lq56/O8m8/T5qwmdxmg1xx
         oeqG5kgjPL8m3wKHVK7YRtbj0//RnqTzSPJkXFUAtrswiHfyRmsbKpHQ+EUSagkl2qvH
         PHpNsvk31Q8Xyr2wX+fABbPN5V/5E1UyFvVCA0n1cEZi+v+xn9iS8efCBo/KY7UbJoc5
         Iet10MzkzxAXyOd+M6RaBBssVntE2m9GxASjcwfqI9pSvXEvV4Z7XZ+isFPrj351PN3Y
         UhHc9mu65QtomkyIywfWFt5ZrU1ePRAEQ0r/KluoP8wbuRT+q/6MIwsLj91RnKJk/tZB
         ukAw==
X-Gm-Message-State: AOAM532JcLVhzhO1cw5Zlux50toH1G4SEeR3jfTc8iWXxkxUPntNjGcY
        +fezdjeNhDVms5EnV0E0FTkUwIjDwupHrg==
X-Google-Smtp-Source: ABdhPJwV9uDgUmNQghgKlj5yfUX4ooeMI7pPhHhCqz0HdlDyAP8R2oDLYbUGzhB0wB8SIerptDdTsA==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr3944393wrs.170.1623831855636;
        Wed, 16 Jun 2021 01:24:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x18sm1326785wrw.19.2021.06.16.01.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:24:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: fix "$remove_trash" regression and match_pattern_list() bugs
Date:   Wed, 16 Jun 2021 10:24:13 +0200
Message-Id: <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <xmqqa6nqsd2i.fsf@gitster.g>
References: <xmqqa6nqsd2i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My edc23840b0b (test-lib: bring $remove_trash out of retirement,
2021-05-10) caused a regression where we'd fail to handle
GIT_SKIP_TESTS variable content like 't????', since we were calling
match_pattern_list() from the t/ directory not the trash
directory.

We'd thus glob match in the directory containing our tests, whereas
before we'd do the match in our newly setup (and empty, aside from the
.git) trash directory.

This bug reveals a more general problem though, which I'm attempting
to solve here: We have other users of match_pattern_list() that have
always been broken, namely the --verbose-only=* and --valgrind-only=*
options added in ff09af3fb8f (test-lib: verbose mode for only tests
matching a pattern, 2013-06-23) and 5dfc368f5ec (test-lib: valgrind
for only tests matching a pattern, 2013-06-23).

Those options will try to match an argument like --verbose-only=1*
against a test number like "10", but since we run the match in our own
trash directory an earlier test creating a file like "1one.txt" will
break that option.

We cannot simply quote the $GIT_SKIP_TESTS" being passed to
match_pattern_list(), since we are relying on the $IFS semantics.

Let's instead setup a .test-lib-trash subdirectory under the trash
directory, and an "empty-dir" directory under that. Then let's run the
match_pattern_list() in a sub-shell in that directory.

This fixes the regression in my edc23840b0b, as well as the bugs we've
had in the --{verbose,valgrind}-only=* options. I have tests for this,
but they're a pain to support without my in-flight lib-subtest.sh
changes, I'll submit them once those land.

This has the added benefit of providing a new clean work area for
tests in general, so functions in test-lib-functions.sh can use it for
their own scratch files, instead of potentially tripping up the test
logic itself.

The drawback is that any tests that cares about the complete
cleanliness of its test are might need to be adjusted, as one ls-files
test here does. I think it's still worth it because that'll be one
special case (and a dotfile), as opposed to every test potentially
tripping over the likes of "expected.config" on a glob match of "*".

1. https://lore.kernel.org/git/1d003cac-83fa-0b63-f60e-55513ac45cf9@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Jun 16 2021, Junio C Hamano wrote:

> Interestingly enough, edc23840b0 (test-lib: bring $remove_trash out
> of retirement, 2021-05-10) cleanly reverts without being depended on
> by anything else in the series.

I think reverting edc23840b0 might be the best short-term fix to avoid
dealing with the breakage + get a quick fix down. I can confirm that
nothing else in the series relies on it.

This patch is an attempt at a more general solution to the problem,
which depending on what you think you might want to take instead. It
fixes not only the immediate regression, but as noted other existing
bugs in match_pattern_list() usage.

 t/t3000-ls-files-others.sh |  8 ++++++--
 t/test-lib-functions.sh    |  8 +++++---
 t/test-lib.sh              | 40 +++++++++++++++++++++++---------------
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 740ce56eab5..8c62da502df 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -37,6 +37,7 @@ test_expect_success 'setup: expected output' '
 	cat >expected1 <<-\EOF &&
 	expected1
 	expected2
+	expected2.noempty
 	expected3
 	output
 	path0
@@ -47,7 +48,10 @@ test_expect_success 'setup: expected output' '
 
 	sed -e "s|path2/file2|path2/|" <expected1 >expected2 &&
 	cp expected2 expected3 &&
-	echo path4/ >>expected2
+	echo path4/ >>expected2 &&
+
+	echo .test-lib-trash/ >expected2.noempty &&
+	cat expected2 >>expected2.noempty
 '
 
 test_expect_success 'ls-files --others' '
@@ -57,7 +61,7 @@ test_expect_success 'ls-files --others' '
 
 test_expect_success 'ls-files --others --directory' '
 	git ls-files --others --directory >output &&
-	test_cmp expected2 output
+	test_cmp expected2.noempty output
 '
 
 test_expect_success '--no-empty-directory hides empty directory' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74b..33697b0df81 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1040,10 +1040,12 @@ test_cmp_config () {
 		GD="-C $1" &&
 		shift
 	fi &&
-	printf "%s\n" "$1" >expect.config &&
+	printf "%s\n" "$1" >"$TRASH_DIRECTORY_TEST_LIB"/expect.config &&
 	shift &&
-	git $GD config "$@" >actual.config &&
-	test_cmp expect.config actual.config
+	git $GD config "$@" >"$TRASH_DIRECTORY_TEST_LIB"/actual.config &&
+	test_cmp \
+		"$TRASH_DIRECTORY_TEST_LIB"/expect.config \
+		"$TRASH_DIRECTORY_TEST_LIB"/actual.config
 }
 
 # test_cmp_bin - helper to compare binary files
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c64279..7f284f56b1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -260,6 +260,8 @@ case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
+TRASH_DIRECTORY_TEST_LIB="$TRASH_DIRECTORY/.test-lib-trash"
+TRASH_DIRECTORY_TEST_LIB_EMPTY="$TRASH_DIRECTORY_TEST_LIB/empty-dir"
 
 # If --stress was passed, run this test repeatedly in several parallel loops.
 if test "$GIT_TEST_STRESS_STARTED" = "done"
@@ -848,7 +850,8 @@ maybe_teardown_verbose () {
 last_verbose=t
 maybe_setup_verbose () {
 	test -z "$verbose_only" && return
-	if match_pattern_list $test_count $verbose_only
+	if (cd "$TRASH_DIRECTORY_TEST_LIB_EMPTY" &&
+	    match_pattern_list $test_count $verbose_only)
 	then
 		exec 4>&2 3>&1
 		# Emit a delimiting blank line when going from
@@ -878,7 +881,8 @@ maybe_setup_valgrind () {
 		return
 	fi
 	GIT_VALGRIND_ENABLED=
-	if match_pattern_list $test_count $valgrind_only
+	if (cd "$TRASH_DIRECTORY_TEST_LIB_EMPTY" &&
+	    match_pattern_list $test_count $valgrind_only)
 	then
 		GIT_VALGRIND_ENABLED=t
 	fi
@@ -1006,7 +1010,8 @@ test_finish_ () {
 test_skip () {
 	to_skip=
 	skipped_reason=
-	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
+	if (cd "$TRASH_DIRECTORY_TEST_LIB_EMPTY" &&
+	    match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS)
 	then
 		to_skip=t
 		skipped_reason="GIT_SKIP_TESTS"
@@ -1177,7 +1182,7 @@ test_done () {
 			esac
 		fi
 
-		if test -z "$debug" && test -n "$remove_trash"
+		if test -z "$debug"
 		then
 			test -d "$TRASH_DIRECTORY" ||
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
@@ -1342,11 +1347,22 @@ then
 	exit 1
 fi
 
+# Test repository
+rm -fr "$TRASH_DIRECTORY" || {
+	GIT_EXIT_OK=t
+	echo >&5 "FATAL: Cannot prepare test area"
+	exit 1
+}
+
+# Set up an early work area for the test code itself
+mkdir -p "$TRASH_DIRECTORY_TEST_LIB_EMPTY" >&3 2>&4 ||
+	error "cannot create test-lib.sh trash directory"
+
 # Are we running this test at all?
-remove_trash=
 this_test=${0##*/}
 this_test=${this_test%%-*}
-if match_pattern_list "$this_test" $GIT_SKIP_TESTS
+if (cd "$TRASH_DIRECTORY_TEST_LIB_EMPTY" &&
+    match_pattern_list "$this_test" $GIT_SKIP_TESTS)
 then
 	say_color info >&3 "skipping test $this_test altogether"
 	skip_all="skip all tests in $this_test"
@@ -1358,20 +1374,12 @@ HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME
 
-# Test repository
-rm -fr "$TRASH_DIRECTORY" || {
-	GIT_EXIT_OK=t
-	echo >&5 "FATAL: Cannot prepare test area"
-	exit 1
-}
-
-remove_trash=t
+# "We have the $TRASH_DIRECTORY already, but let's create a
+# $TRASH_DIRECTORY/.git
 if test -z "$TEST_NO_CREATE_REPO"
 then
 	git init "$TRASH_DIRECTORY" >&3 2>&4 ||
 	error "cannot run git init"
-else
-	mkdir -p "$TRASH_DIRECTORY"
 fi
 
 # Use -P to resolve symlinks in our working directory so that the cwd
-- 
2.32.0.555.g0268d380f7b

