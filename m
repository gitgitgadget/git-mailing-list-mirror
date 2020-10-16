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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC243C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD6F20EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTc8QShb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411025AbgJPT25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408086AbgJPT25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:28:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1010C0613D3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:28:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 13so3476418wmf.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MqxKsI6OmBnKwnIq+QoHam6lJvQkykRlVtL274DUJgg=;
        b=tTc8QShbb/FqLBJ1kZF/3TXLBM6cictFswpB1p9WeNzjunc+vBcgqVHDe6BmkvjOa+
         dAxYxpvSkUKuXDR6a4Bs2iGKOZaEC05xNAS5gri/XoOxKts7svgR5t0mGyIlRErmnIsy
         OOxoRefmU4dTFXDiyFR4aBR/1kci1W8UWUU5MgbV4tOgGAJou4VB1Q/EZ+U7SOf7Ftek
         Btc+ZNtG7w5YZjq+ujA64RHnPdOO9IWuWgxYxnlCWCJSb+6mucKk7E5aNNeOwklEMI0K
         ga9n6K8QQV2kuWsB6hnrTZ4uJvWq8+9AaNHOZJ5faAo585oJk9k5s/iu3meG81QgWkpx
         50mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MqxKsI6OmBnKwnIq+QoHam6lJvQkykRlVtL274DUJgg=;
        b=FaBmAetGZ1wmpJ4pSE7N9lDtJhQyn3E+jztUCtYHNcmUS+/mFkCZW+IaFOtHFsqARE
         oYclBTBRrWuvaKoF+CyJcro0udaRuVN2cdxCppKB+jpmr+AQjQrMhFjK61zjDA+pkUvr
         mSJbPg/iuFzxxGmDUNloilVZjTFVsODOyco4uArPLF/18ruqKQG6mFGomumnfHxtcFlb
         DESaB/smK5rX69kek7u79xmxS9ctfZnBOxW+81kv1itGvNeY8RnlnGFGmMWPP3Bne+x8
         2dEItDxd2Hy+6TBD1DBeex+n1Nx3BeYmmqXRDRDq28Cc2xUBFtZVTtWCR0FBGDaa700R
         Ueyw==
X-Gm-Message-State: AOAM530GDUkvOkwUtb6ybZrY69kpDDw4IgPUA3oFl8Nmd9jnnOz4e5mh
        xTZZxFUEi83jYCDHl4Dfft1jObDGeSk=
X-Google-Smtp-Source: ABdhPJw4Ft/CAtZYyD99JgQfVpE7lVKb0PY2K4Ad6Qx48YTdpaKZqTj6Etfwv40AhWmnztdJQzDIfg==
X-Received: by 2002:a7b:cf04:: with SMTP id l4mr5644288wmg.137.1602876534374;
        Fri, 16 Oct 2020 12:28:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3sm5045656wrq.0.2020.10.16.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:28:53 -0700 (PDT)
Message-Id: <8f5d4ad31804e456d134a09f11d82aed14f7141d.1602876532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
References: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
        <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 19:28:50 +0000
Subject: [PATCH v4 1/3] test-lib: allow selecting tests by substring/glob with
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
 t/README         | 37 +++++++++++++++++++++++++++----------
 t/t0000-basic.sh | 41 +++++++++++++++++++++++++----------------
 t/test-lib.sh    | 16 ++++++++++------
 3 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/t/README b/t/README
index 2adaf7c2d2..4594f3ab7b 100644
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
+The argument to --run is split on commas and whitespace into separate
+strings, numbers, and ranges, and picks all tests that match any of
+the individual selection criteria.  If the substring of the
+description text that you want to match includes a comma or space, use
+the glob character '?' instead.  For example --run='unnecessary?update
+timing' would match on all tests that match either the glob
+*unnecessary?update* or the glob *timing*.
 
 If --run starts with an unprefixed number or range the initial
 set of tests to run is empty. If the first item starts with '!'
@@ -317,6 +322,18 @@ test in the test suite except from 7 up to 11:
 
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

