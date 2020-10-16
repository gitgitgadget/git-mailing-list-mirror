Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9E5C43457
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2CA22201
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLzogz3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391645AbgJPWvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391474AbgJPWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:50:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768FC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t9so4778481wrq.11
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K6RJdfvqIt7njrZGRD5PtW0g7TjxtkKgM2ef+1gpyFw=;
        b=MLzogz3FzyZgTJqASPzzQ6e1lMIu2wGPd3frE3egjXi9qVmZwehzz66iHSikRrGZ7B
         1ppwrBFZr5c+eO1myaAgStSn6/E+jkjhto/SxUuMEd8bUUzm6x7gYFSB8/XTPN8NHCkv
         LtBBXPAZbXLynw673b77AZnAg7B0+rHk4ggoGKkG8HR5ej2DfM7GApbJBwwhddCDlTCd
         qhw0ak2I48jzPNCIFhSK1BQ5B9s87rx1LoH3IgrAeDNIWKwxo+gAnxnr0rfAQEsGAmin
         jO25QEm97+Wr4+NZLKh40DMcYrYkcDomVyA/7Xv9LyUpFihiKZx1T1HjAcTl+fRtg4bx
         VDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K6RJdfvqIt7njrZGRD5PtW0g7TjxtkKgM2ef+1gpyFw=;
        b=Vv2bkA8awxRlQPtKdkl11wfR+VfIuLe6PT5Gr+qjFj24lQCxEFgEI6lkr8QewJiiA+
         eqN8D/DnydTakTDdOUUpjjOU4vo7Tcz2kSehxNANJ0eOzl4MrNcr/BRTJUbva1ZeNWbH
         7rBhMXDsZPO4BVpDLKL2l9ksQqI13D0VVdHBaa0Yq14gnInWIHVxWY23q6tIwlJ6LSmc
         txB7pFLn8kfadHVr9JMo2rUooCUYR6X7R9sQ+rZjETF7YA7lrOj625A+hBLjPEPx+y6a
         h6gGGp/y9ol59XD+eAmzeUIV+Hye0+x5z3ekiuEeFBvxaBxnQqWN7ok87Un8rpQBkYDR
         G7oQ==
X-Gm-Message-State: AOAM530vXmQtED73f5DZjkIj+CEDaUZ92z7WlB6+dvmvBYDM6gKM+gxP
        BNetw8yi3j7PMBCCsKeY3400UkQOX3A=
X-Google-Smtp-Source: ABdhPJxTzgZPyOEucpFnyDn8C8jOS5+mWh0UAZTFZXFKyl/JVwf9ilDmKA9JpI6Jse8EcRAcdpFd/A==
X-Received: by 2002:adf:9f4c:: with SMTP id f12mr6599913wrg.108.1602888654919;
        Fri, 16 Oct 2020 15:50:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 88sm5961355wrl.76.2020.10.16.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:50:54 -0700 (PDT)
Message-Id: <389c2c171a07b156fe956ac535033a8b67af51a9.1602888652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
References: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
        <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 22:50:50 +0000
Subject: [PATCH v5 1/3] test-lib: allow selecting tests by substring/glob with
 --run
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Many of our test scripts have several "setup" tests.  It's a lot easier
to say

   ./t0050-filesystem.sh --run=setup,9

in order to run all the setup tests as well as test #9, than it is to
track down what all the setup tests are and enter all their numbers in
the list.  Also, I often find myself wanting to run just one or a couple
tests from the test file, but I don't know the numbering of any of the
tests -- to get it I either have to first run the whole test file (or
start counting by hand or figure out some other clever but non-obvious
tricks).  It's really convenient to be able to just look at the test
description(s) and then run

   ./t6416-recursive-corner-cases.sh --run=symlink

or

   ./t6402-merge-rename.sh --run='setup,unnecessary update'

Add such an ability to test selection which relies on merely matching
against the test description.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/README         | 48 +++++++++++++++++++++++++++----------------
 t/t0000-basic.sh | 53 ++++++++++++++++++++++++++++--------------------
 t/test-lib.sh    | 18 +++++++++-------
 3 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/t/README b/t/README
index 2adaf7c2d2..c730a70770 100644
--- a/t/README
+++ b/t/README
@@ -258,16 +258,21 @@ For an individual test suite --run could be used to specify that
 only some tests should be run or that some tests should be
 excluded from a run.
 
-The argument for --run is a list of individual test numbers or
-ranges with an optional negation prefix that define what tests in
-a test suite to include in the run.  A range is two numbers
-separated with a dash and matches a range of tests with both ends
-been included.  You may omit the first or the second number to
-mean "from the first test" or "up to the very last test"
-respectively.
-
-Optional prefix of '!' means that the test or a range of tests
-should be excluded from the run.
+The argument for --run, <test-selector>, is a list of description
+substrings or globs or individual test numbers or ranges with an
+optional negation prefix (of '!') that define what tests in a test
+suite to include (or exclude, if negated) in the run.  A range is two
+numbers separated with a dash and matches a range of tests with both
+ends been included.  You may omit the first or the second number to
+mean "from the first test" or "up to the very last test" respectively.
+
+The argument to --run is split on commas into separate strings,
+numbers, and ranges, and picks all tests that match any of the
+individual selection criteria.  If the substring of the description
+text that you want to match includes a comma, use the glob character
+'?' instead.  For example --run='rebase,merge?cherry-pick' would match
+on all tests that match either the glob *rebase* or the glob
+*merge?cherry-pick*.
 
 If --run starts with an unprefixed number or range the initial
 set of tests to run is empty. If the first item starts with '!'
@@ -275,9 +280,6 @@ all the tests are added to the initial set.  After initial set is
 determined every test number or range is added or excluded from
 the set one by one, from left to right.
 
-Individual numbers or ranges could be separated either by a space
-or a comma.
-
 For example, to run only tests up to a specific test (21), one
 could do this:
 
@@ -290,7 +292,7 @@ or this:
 Common case is to run several setup tests (1, 2, 3) and then a
 specific test (21) that relies on that setup:
 
-    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
+    $ sh ./t9200-git-cvsexport-commit.sh --run='1,2,3,21'
 
 or:
 
@@ -298,17 +300,17 @@ or:
 
 or:
 
-    $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'
+    $ sh ./t9200-git-cvsexport-commit.sh --run='-3,21'
 
 As noted above, the test set is built by going through the items
 from left to right, so this:
 
-    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
+    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4,!3'
 
 will run tests 1, 2, and 4.  Items that come later have higher
 precedence.  It means that this:
 
-    $ sh ./t9200-git-cvsexport-commit.sh --run='!3 1-4'
+    $ sh ./t9200-git-cvsexport-commit.sh --run='!3,1-4'
 
 would just run tests from 1 to 4, including 3.
 
@@ -317,6 +319,18 @@ test in the test suite except from 7 up to 11:
 
     $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
 
+Sometimes there may be multiple tests with e.g. "setup" in their name
+that are needed and rather than figuring out the number for all of them
+we can just use "setup" as a substring/glob to match against the test
+description:
+
+    $ sh ./t0050-filesystem.sh --run=setup,9-11
+
+or one could select both the setup tests and the rename ones (assuming all
+relevant tests had those words in their descriptions):
+
+    $ sh ./t0050-filesystem.sh --run=setup,rename
+
 Some tests in a test suite rely on the previous tests performing
 certain actions, specifically some tests are designated as
 "setup" test, so you cannot _arbitrarily_ disable one test and
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..62a16ed4c8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -430,7 +430,7 @@ test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' "
 
 test_expect_success '--run basic' "
 	run_sub_test_lib_test run-basic \
-		'--run basic' --run='1 3 5' <<-\\EOF &&
+		'--run basic' --run='1,3,5' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success \"passing test #\$i\" 'true'
@@ -472,7 +472,7 @@ test_expect_success '--run with a range' "
 
 test_expect_success '--run with two ranges' "
 	run_sub_test_lib_test run-two-ranges \
-		'--run with two ranges' --run='1-2 5-6' <<-\\EOF &&
+		'--run with two ranges' --run='1-2,5-6' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success \"passing test #\$i\" 'true'
@@ -556,7 +556,7 @@ test_expect_success '--run with basic negation' "
 
 test_expect_success '--run with two negations' "
 	run_sub_test_lib_test run-two-neg \
-		'--run with two negations' --run='"'!3 !6'"' <<-\\EOF &&
+		'--run with two negations' --run='"'!3,!6'"' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success \"passing test #\$i\" 'true'
@@ -577,7 +577,7 @@ test_expect_success '--run with two negations' "
 
 test_expect_success '--run a range and negation' "
 	run_sub_test_lib_test run-range-and-neg \
-		'--run a range and negation' --run='"'-4 !2'"' <<-\\EOF &&
+		'--run a range and negation' --run='"'-4,!2'"' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success \"passing test #\$i\" 'true'
@@ -620,7 +620,7 @@ test_expect_success '--run range negation' "
 test_expect_success '--run include, exclude and include' "
 	run_sub_test_lib_test run-inc-neg-inc \
 		'--run include, exclude and include' \
-		--run='"'1-5 !1-3 2'"' <<-\\EOF &&
+		--run='"'1-5,!1-3,2'"' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success \"passing test #\$i\" 'true'
@@ -664,7 +664,7 @@ test_expect_success '--run include, exclude and include, comma separated' "
 test_expect_success '--run exclude and include' "
 	run_sub_test_lib_test run-neg-inc \
 		'--run exclude and include' \
-		--run='"'!3- 5'"' <<-\\EOF &&
+		--run='"'!3-,5'"' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success \"passing test #\$i\" 'true'
@@ -705,7 +705,31 @@ test_expect_success '--run empty selectors' "
 	EOF
 "
 
-test_expect_success '--run invalid range start' "
+test_expect_success '--run substring selector' "
+	run_sub_test_lib_test run-substring-selector \
+		'--run empty selectors' \
+		--run='relevant' <<-\\EOF &&
+	test_expect_success \"relevant test\" 'true'
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"other test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-substring-selector <<-\\EOF
+	> ok 1 - relevant test
+	> ok 2 # skip other test #1 (--run)
+	> ok 3 # skip other test #2 (--run)
+	> ok 4 # skip other test #3 (--run)
+	> ok 5 # skip other test #4 (--run)
+	> ok 6 # skip other test #5 (--run)
+	> ok 7 # skip other test #6 (--run)
+	> # passed all 7 test(s)
+	> 1..7
+	EOF
+"
+
+test_expect_success '--run keyword selection' "
 	run_sub_test_lib_test_err run-inv-range-start \
 		'--run invalid range start' \
 		--run='a-5' <<-\\EOF &&
@@ -735,21 +759,6 @@ test_expect_success '--run invalid range end' "
 	EOF_ERR
 "
 
-test_expect_success '--run invalid selector' "
-	run_sub_test_lib_test_err run-inv-selector \
-		'--run invalid selector' \
-		--run='1?' <<-\\EOF &&
-	test_expect_success \"passing test #1\" 'true'
-	test_done
-	EOF
-	check_sub_test_lib_test_err run-inv-selector \
-		<<-\\EOF_OUT 3<<-\\EOF_ERR
-	> FATAL: Unexpected exit with code 1
-	EOF_OUT
-	> error: --run: invalid non-numeric in test selector: '1?'
-	EOF_ERR
-"
-
 
 test_set_prereq HAVEIT
 haveit=no
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef31f40037..debfd73fd6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -769,6 +769,8 @@ match_pattern_list () {
 }
 
 match_test_selector_list () {
+	operation="$1"
+	shift
 	title="$1"
 	shift
 	arg="$1"
@@ -777,7 +779,7 @@ match_test_selector_list () {
 
 	# Both commas and whitespace are accepted as separators.
 	OLDIFS=$IFS
-	IFS=' 	,'
+	IFS=','
 	set -- $1
 	IFS=$OLDIFS
 
@@ -805,13 +807,13 @@ match_test_selector_list () {
 			*-*)
 				if expr "z${selector%%-*}" : "z[0-9]*[^0-9]" >/dev/null
 				then
-					echo "error: $title: invalid non-numeric in range" \
+					echo "error: $operation: invalid non-numeric in range" \
 						"start: '$orig_selector'" >&2
 					exit 1
 				fi
 				if expr "z${selector#*-}" : "z[0-9]*[^0-9]" >/dev/null
 				then
-					echo "error: $title: invalid non-numeric in range" \
+					echo "error: $operation: invalid non-numeric in range" \
 						"end: '$orig_selector'" >&2
 					exit 1
 				fi
@@ -819,9 +821,11 @@ match_test_selector_list () {
 			*)
 				if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
 				then
-					echo "error: $title: invalid non-numeric in test" \
-						"selector: '$orig_selector'" >&2
-					exit 1
+					case "$title" in *${selector}*)
+						include=$positive
+						;;
+					esac
+					continue
 				fi
 		esac
 
@@ -1031,7 +1035,7 @@ test_skip () {
 		skipped_reason="GIT_SKIP_TESTS"
 	fi
 	if test -z "$to_skip" && test -n "$run_list" &&
-	   ! match_test_selector_list '--run' $test_count "$run_list"
+	   ! match_test_selector_list '--run' "$1" $test_count "$run_list"
 	then
 		to_skip=t
 		skipped_reason="--run"
-- 
gitgitgadget

