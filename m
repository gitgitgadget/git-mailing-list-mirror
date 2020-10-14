Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F784C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC5622258
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KanckOGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgJOCAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732489AbgJOB7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB42EC061787
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n18so677731wrs.5
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nxTfWGE7qqzbvBZQTHftEm3e+pT2vbCA7mk0RxtXIjA=;
        b=KanckOGPVxH/LuV7B3i0UrJS64LfdJmuVRvsvO99haMm2Z2lKaGZ/MyUeWU0zuMmyC
         C5IfMOR6ZGaeOewrSGUlefSKBt2Eb6MZ2Yg4eoiD5X2U4J2ta4R5p5Ez1ab08LP6+ElI
         xSbQ5Rr5mxAOxY/H98BWiwr8Xbs0QIPz6/bgHGdSLHivGIciv3Oj6pHdDfeAVqJuqraB
         9CEzrscrhEVPh0cDwx3a7g4nltN09KyOkZ84BZvviJrqQHAq9Zp1yviPSMsiv8kJAaof
         +g8h82rK/bbHTAzPuhlfSFyDaTyk7nHfANhUXm7gWhgY4YeYJlsGUX1T8InKgjIWg1KU
         U7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nxTfWGE7qqzbvBZQTHftEm3e+pT2vbCA7mk0RxtXIjA=;
        b=KqPHVcF7fhDT/XX2sQNp5U7h8M5lCeWiEQqC+YIpxAQiLQwd2EK61s/8w6n3EWLHro
         5u2y2Z0kf+YEaI3veuX6XxPoDidX+f7YhtKr8jeOC6FdM+dNjPLbDA1eAa980FC+d6y1
         ITCUzHSY7hTuOdsV2s6DUYB9TWfMQflEckEJGkgAIIU11vI8biKjI1ER+DkiIhnFGj3x
         ymVAROpIggc0EKeLvnyr3uN71CZtBZjERrGCpIPA3drHdTL+yPAnGvLyGFBYkfGv/9Yq
         s+2TnwfeWhMzDfqydCdty3uIu+gGnEepl97AdWwTWujLxr9qR4M1cCM6/NiB7BXsV+QN
         KdsQ==
X-Gm-Message-State: AOAM531Befaz3VTN3KhjBhQl9FwTcm9B6+wPrCulpGYIQ3UzYnb2Dw69
        Z+gsPF/KZxsvFU5Vjt7IipZYH5v+fAI=
X-Google-Smtp-Source: ABdhPJz5rT3rBsWc66elcoe4feMgrvOqiRxdDzPN72So9wp/rZUd7q00TZSTWUjxA6b7rhtFjs+ChQ==
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr663476wrm.242.1602710027399;
        Wed, 14 Oct 2020 14:13:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm1036228wmb.5.2020.10.14.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:13:46 -0700 (PDT)
Message-Id: <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Oct 2020 21:13:43 +0000
Subject: [PATCH v3 1/3] test-lib: allow selecting tests by substring/glob with
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
 t/README         | 29 +++++++++++++++++++----------
 t/t0000-basic.sh | 41 +++++++++++++++++++++++++----------------
 t/test-lib.sh    | 16 ++++++++++------
 3 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/t/README b/t/README
index 2adaf7c2d2..0a8b60b5c7 100644
--- a/t/README
+++ b/t/README
@@ -258,16 +258,13 @@ For an individual test suite --run could be used to specify that
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
 
 If --run starts with an unprefixed number or range the initial
 set of tests to run is empty. If the first item starts with '!'
@@ -317,6 +314,18 @@ test in the test suite except from 7 up to 11:
 
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
index 923281af93..07105b2078 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
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
index ef31f40037..a040d54a76 100644
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

