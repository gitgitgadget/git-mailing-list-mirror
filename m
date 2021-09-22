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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D95C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B585A610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhIVLVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbhIVLVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:21:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA7C061766
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q26so5647996wrc.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIO8UOp5RWDnKcsRMcwBLah8EFGlmykg4yPXLK2HrBw=;
        b=CkNWOL0TmpLzLgr+yamRM5IUVJ7QinQV3w5FFtCdeMXPpGwjVrJss81MK3L5ZXA32+
         fwnO30u6VUmaEEA7PuzhROAiG6hdBYHSeJIn6HKgqLgxYdPc0y5apoD/HyOb4sKs/PXH
         SUO6kbBRamWPDnYT9jdSlBie4IIGDxIDlzPsv4w6BJQ0a1Cs+ZggWgP5s3eEb3stnFYD
         CC0vjAJutVCX7EDBIebQGdQXdScIBrtoGAvKiexY3vsN/Q2oxtLv2Oxbxn09RHekcEpX
         LRWg+g6Bre/h44n6j6QNpaRtMT24xgbAQygEyM9C06ufWpDTedtrKstJ7sxZmlpYxw/a
         1ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIO8UOp5RWDnKcsRMcwBLah8EFGlmykg4yPXLK2HrBw=;
        b=Fs+DUR+vrIF5TPNERgPCfOUxRj8582hcg2p45o8XtMCTE9xHF9oCJv6KvMzcQJhF7C
         y9HiaxxfE/jOa5GGOpdBcH3xax0hGuE2Ft7dhDox5o1oBQd+3jFOr0RpK5SlTfoOHynT
         gX+lVxzAm1LAmnnoWOGRgyKH0qzuEMyHMgf8LfXS7XK1VO3NGK5WfV3IUUH1dTh2D1oY
         Eks2CNacT3R8pD89O1iQj/ZRASKgebKbISQMleIopBcNX70S+zCTzNGUVFOrgxSv+Znx
         AfpCOuTkAFfUM076bu/IiF3nXu/80oqiWpTinpJjzMSKcSY/OX8Tvpo3vfvqPbRUGy7r
         fQTA==
X-Gm-Message-State: AOAM5329rcrc70IjyBI1Ag4WLVBKUy5KNzB5snFs8yDnkIotaJR3mQYz
        ID2p+8sBCaTdCPh8/tbb5IlUQGVN0C+E4A==
X-Google-Smtp-Source: ABdhPJzoHlD6p7WhwFx0d1vCJOsQlSjg0Go/ZrAn8W3rpEX2/i4dhfP/Jui/O1K2akM+6D2OrOs7JQ==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr34684540wri.205.1632309603754;
        Wed, 22 Sep 2021 04:20:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d70sm1679165wmd.3.2021.09.22.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:20:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/7] test-lib tests: get rid of copy/pasted mock test code
Date:   Wed, 22 Sep 2021 13:19:53 +0200
Message-Id: <patch-v4-7.7-68f8fabaa1e-20210922T111734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
References: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we've split up the write_sub_test_lib_test*() and
run_sub_test_lib_test*() functions let's fix those tests in
t0000-basic.sh that were verbosely copy/pasting earlier tests.

That we caught all of them was asserted with a follow-up change that's
not part of this series[1], we might add such a duplication check at
some later time, but for now let's just one-off remove the duplicate
boilerplate.

1. https://lore.kernel.org/git/patch-v3-6.9-bc79b29f3c-20210805T103237Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 228 +++++++++++++----------------------------------
 1 file changed, 60 insertions(+), 168 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 6fdd5f43cae..a0b99d83349 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -226,18 +226,13 @@ test_expect_success 'subtest: --verbose option' '
 '
 
 test_expect_success 'subtest: --verbose-only option' '
-	write_and_run_sub_test_lib_test_err \
-		t2345-verbose-only-2 \
-		--verbose-only=2 <<-\EOF &&
-	test_expect_success "passing test" true
-	test_expect_success "test with output" "echo foo"
-	test_expect_success "failing test" false
-	test_done
-	EOF
-	check_sub_test_lib_test t2345-verbose-only-2 <<-\EOF
+	run_sub_test_lib_test_err \
+		t1234-verbose \
+		--verbose-only=2 &&
+	check_sub_test_lib_test t1234-verbose <<-\EOF
 	> ok 1 - passing test
 	> Z
-	> expecting success of 2345.2 '\''test with output'\'': echo foo
+	> expecting success of 1234.2 '\''test with output'\'': echo foo
 	> foo
 	> ok 2 - test with output
 	> Z
@@ -250,15 +245,9 @@ test_expect_success 'subtest: --verbose-only option' '
 
 test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
 	(
-		write_and_run_sub_test_lib_test git-skip-tests-basic \
-			--skip="git.2" <<-\EOF &&
-		for i in 1 2 3
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-basic <<-\EOF
+		run_sub_test_lib_test full-pass \
+			--skip="full.2" &&
+		check_sub_test_lib_test full-pass <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 - passing test #3
@@ -293,15 +282,9 @@ test_expect_success 'subtest: skip several with GIT_SKIP_TESTS' '
 
 test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
 	(
-		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
-			--skip="git.[2-5]" <<-\EOF &&
-		for i in 1 2 3 4 5 6
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\EOF
+		run_sub_test_lib_test git-skip-tests-several \
+			--skip="git.[2-5]" &&
+		check_sub_test_lib_test git-skip-tests-several <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
@@ -316,15 +299,10 @@ test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
 
 test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
 	(
-		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
-			--skip="git" <<-\EOF &&
-		for i in 1 2 3
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-entire-suite <<-\EOF
+		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test git-skip-tests-several \
+			--skip="git" &&
+		check_sub_test_lib_test git-skip-tests-several <<-\EOF
 		> 1..0 # SKIP skip all tests in git
 		EOF
 	)
@@ -332,15 +310,10 @@ test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
 
 test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
-		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
-			--skip="notgit" <<-\EOF &&
-		for i in 1 2 3
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\EOF
+		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test full-pass \
+			--skip="notfull" &&
+		check_sub_test_lib_test full-pass <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 - passing test #2
 		> ok 3 - passing test #3
@@ -351,14 +324,8 @@ test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
 '
 
 test_expect_success 'subtest: --run basic' '
-	write_and_run_sub_test_lib_test run-basic --run="1,3,5" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-basic <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several --run="1,3,5" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 - passing test #3
@@ -371,15 +338,9 @@ test_expect_success 'subtest: --run basic' '
 '
 
 test_expect_success 'subtest: --run with a range' '
-	write_and_run_sub_test_lib_test run-range \
-		--run="1-3" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-range <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="1-3" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 - passing test #3
@@ -392,15 +353,9 @@ test_expect_success 'subtest: --run with a range' '
 '
 
 test_expect_success 'subtest: --run with two ranges' '
-	write_and_run_sub_test_lib_test run-two-ranges \
-		--run="1-2,5-6" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-two-ranges <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="1-2,5-6" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -413,15 +368,9 @@ test_expect_success 'subtest: --run with two ranges' '
 '
 
 test_expect_success 'subtest: --run with a left open range' '
-	write_and_run_sub_test_lib_test run-left-open-range \
-		--run="-3" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-left-open-range <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="-3" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 - passing test #3
@@ -434,15 +383,9 @@ test_expect_success 'subtest: --run with a left open range' '
 '
 
 test_expect_success 'subtest: --run with a right open range' '
-	write_and_run_sub_test_lib_test run-right-open-range \
-		--run="4-" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-right-open-range <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="4-" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 # skip passing test #3 (--run)
@@ -455,15 +398,9 @@ test_expect_success 'subtest: --run with a right open range' '
 '
 
 test_expect_success 'subtest: --run with basic negation' '
-	write_and_run_sub_test_lib_test run-basic-neg \
-		--run="!3" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-basic-neg <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="!3" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -476,15 +413,9 @@ test_expect_success 'subtest: --run with basic negation' '
 '
 
 test_expect_success 'subtest: --run with two negations' '
-	write_and_run_sub_test_lib_test run-two-neg \
-		--run="!3,!6" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-two-neg <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="!3,!6" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -497,15 +428,9 @@ test_expect_success 'subtest: --run with two negations' '
 '
 
 test_expect_success 'subtest: --run a range and negation' '
-	write_and_run_sub_test_lib_test run-range-and-neg \
-		--run="-4,!2" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-range-and-neg <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="-4,!2" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 - passing test #3
@@ -518,15 +443,9 @@ test_expect_success 'subtest: --run a range and negation' '
 '
 
 test_expect_success 'subtest: --run range negation' '
-	write_and_run_sub_test_lib_test run-range-neg \
-		--run="!1-3" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-range-neg <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="!1-3" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 # skip passing test #3 (--run)
@@ -539,15 +458,9 @@ test_expect_success 'subtest: --run range negation' '
 '
 
 test_expect_success 'subtest: --run include, exclude and include' '
-	write_and_run_sub_test_lib_test run-inc-neg-inc \
-		--run="1-5,!1-3,2" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-inc-neg-inc <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="1-5,!1-3,2" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -560,15 +473,9 @@ test_expect_success 'subtest: --run include, exclude and include' '
 '
 
 test_expect_success 'subtest: --run include, exclude and include, comma separated' '
-	write_and_run_sub_test_lib_test run-inc-neg-inc-comma \
-		--run=1-5,!1-3,2 <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-inc-neg-inc-comma <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run=1-5,!1-3,2 &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -581,15 +488,9 @@ test_expect_success 'subtest: --run include, exclude and include, comma separate
 '
 
 test_expect_success 'subtest: --run exclude and include' '
-	write_and_run_sub_test_lib_test run-neg-inc \
-		--run="!3-,5" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-neg-inc <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="!3-,5" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -602,15 +503,9 @@ test_expect_success 'subtest: --run exclude and include' '
 '
 
 test_expect_success 'subtest: --run empty selectors' '
-	write_and_run_sub_test_lib_test run-empty-sel \
-		--run="1,,3,,,5" <<-\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success "passing test #$i" "true"
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test run-empty-sel <<-\EOF
+	run_sub_test_lib_test git-skip-tests-several \
+		--run="1,,3,,,5" &&
+	check_sub_test_lib_test git-skip-tests-several <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 - passing test #3
@@ -660,12 +555,9 @@ test_expect_success 'subtest: --run keyword selection' '
 '
 
 test_expect_success 'subtest: --run invalid range end' '
-	write_and_run_sub_test_lib_test_err run-inv-range-end \
-		--run="1-z" <<-\EOF &&
-	test_expect_success "passing test #1" "true"
-	test_done
-	EOF
-	check_sub_test_lib_test_err run-inv-range-end \
+	run_sub_test_lib_test_err run-inv-range-start \
+		--run="1-z" &&
+	check_sub_test_lib_test_err run-inv-range-start \
 		<<-\EOF_OUT 3<<-EOF_ERR
 	> FATAL: Unexpected exit with code 1
 	EOF_OUT
-- 
2.33.0.1225.g9f062250122

