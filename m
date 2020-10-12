Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A19DC43457
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB292087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4gT+zfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgJLX0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgJLX0I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 19:26:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EE0C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b8so8253412wrn.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e1lTOJIEGIKZ3rXWeHtBAWPmr5PZrF/MRc+HH9hevyQ=;
        b=m4gT+zfohOqkfCy/amCQ07Aq3l+OgswrgcIAHHWXigwaRVPal9O1ROE5ohRUR/5zho
         /dYLcU4e22uo1t7rH6snwzaaRVyeQ0KdWeGrx3mhZoTURDyj7VATx/rTV8URrKOETN39
         1SMt8sKYSIRbu4dVYJto7tc+w117iXo2rSUCyywDOw0ZMfvfNZVTyW2IdQeCqxIrmD06
         1j1k6zucdqPOF556dF0xvQx+aqUaf3Cx2MmPrAGatHPm83GDPJ1YHgs/2nqB37kz284Y
         GZd05x09mRkYU2PxPpYl76e9nxGtYWI2yiV1q5vhFqb6TlgyYrXCb+Zz4g+zc2V7kXzt
         VDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e1lTOJIEGIKZ3rXWeHtBAWPmr5PZrF/MRc+HH9hevyQ=;
        b=QEC+h48fn6EhTJpaGElhOr+0G11tGxByzIxMS1W6Ec10W8D0P9pyDapNxhT4KHySSY
         r4TbnRsEdSB4VmC7f7HL9/pexUaAbfkW+h8IDv9sEQ6hDSWN6WEsPU0nDQ8hkHSMRPWO
         o7tfzt+EGrNLfbrGb1OezXeYlqy03mBe5gao2S4sYVUMIc5/tQSfvnbHxlID+zyfZHSr
         0onNbWWMQC3+FF0LkF/YKIRfvTHbXa82Fz115Bh1BJindeVTn3por/tUSBSOjh0lM6ae
         ZJwkUkzuFeLg0G8mNb/D9jboczfOgw9B5iAtVtswQNN0m79zxrHKGap33O0Dshj/lKwQ
         YaYw==
X-Gm-Message-State: AOAM533y8LMuJy6xNFaJH/IgPaknpwpL0M954eIobgzGs3e7BTUvFfCi
        hy17MzWjkhFMVkaDL57WKYQrZPNirTI=
X-Google-Smtp-Source: ABdhPJwOEFF7CqEpZq7dwr0Uh7lT3BcHAnMu/UUVwmqiFQHK6MV0A1eRw/DzLueNNTzmQdoZ24ht4A==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr34838183wrj.201.1602545166382;
        Mon, 12 Oct 2020 16:26:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b25sm21988471wmj.21.2020.10.12.16.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 16:26:06 -0700 (PDT)
Message-Id: <46fce3a844c90b4078578f5aa2058bd6825af1d6.1602545164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 23:26:02 +0000
Subject: [PATCH 1/3] test-lib: allow selecting tests by substring/regex with
 --run
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 t/README         | 26 +++++++++++++++++++-------
 t/t0000-basic.sh | 41 +++++++++++++++++++++++++----------------
 t/test-lib.sh    | 13 +++++++------
 3 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/t/README b/t/README
index 2adaf7c2d2..23639c5bcf 100644
--- a/t/README
+++ b/t/README
@@ -258,13 +258,13 @@ For an individual test suite --run could be used to specify that
 only some tests should be run or that some tests should be
 excluded from a run.
 
-The argument for --run is a list of individual test numbers or
-ranges with an optional negation prefix that define what tests in
-a test suite to include in the run.  A range is two numbers
-separated with a dash and matches a range of tests with both ends
-been included.  You may omit the first or the second number to
-mean "from the first test" or "up to the very last test"
-respectively.
+The argument for --run, <test-selector>, is a list of description
+substrings or regexes or individual test numbers or ranges with an
+optional negation prefix that define what tests in a test suite to
+include in the run.  A range is two numbers separated with a dash and
+matches a range of tests with both ends been included.  You may omit
+the first or the second number to mean "from the first test" or "up to
+the very last test" respectively.
 
 Optional prefix of '!' means that the test or a range of tests
 should be excluded from the run.
@@ -317,6 +317,18 @@ test in the test suite except from 7 up to 11:
 
     $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
 
+Sometimes there may be multiple tests with e.g. "setup" in their name
+that are needed and rather than figuring out the number for all of them
+we can just use "setup" as a substring/regex to match against the test
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
index ef31f40037..2aca398e1e 100644
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
@@ -819,9 +821,8 @@ match_test_selector_list () {
 			*)
 				if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
 				then
-					echo "error: $title: invalid non-numeric in test" \
-						"selector: '$orig_selector'" >&2
-					exit 1
+					echo "$title" | grep -q "$selector" && return
+					continue
 				fi
 		esac
 
@@ -1031,7 +1032,7 @@ test_skip () {
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

