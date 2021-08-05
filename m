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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D72C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B257E610CC
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbhHEKh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbhHEKhw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6AC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so5955067wms.2
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKODqEJEtJYp9aUk2z9L83NdCy97u7BPgi0uYJ93eOM=;
        b=rLh5+I8rz8+GqpEDtXitgZVT6K5vmiFrY10yBfnifydThCkhfku7PpuoE17FbJrwNP
         ZIqe+tQkJRSCOkoZStq36+8cv8m6s9SJqwrkwQJuiupiBQRU6eu5HdVbiPxJJk5aCF9T
         Vg98WoZs0b/gcivaswv+H5oXcZRRld68EbrJcrUTFyn1cVHvbpUsGhZ4OaNXAGA3OWDY
         8QZs7eHJKgTal9jYekQybZHYZxtAPTMT7Dgqjlbt3pdjb0GEgE6omVX0hai9SVJ+Nr7+
         5M2n+jzDZskEgwTN9WRgocec9eoxL1jDcjArrKo3Pnn4e7hj3t852/6eL81VNnx8n8TZ
         +vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKODqEJEtJYp9aUk2z9L83NdCy97u7BPgi0uYJ93eOM=;
        b=YlE9aXRApzDmFbn/3Gc5fV65TSlgt8juaZ85Oe2pmVBtIz8X9/NjxJnzWaEjdFbD2x
         2eJxxT+3SGdbz3TCPX6pQw8MAls4j2m/U0t9PieopUnSeG+vhGyCV22VvyRUa1JLiKTT
         fFOnIEQN0D3xeTSyASvkj4EGfQhlJqyW9eCDT4Qx3RkRlpftFq7gGM/iAbqzAgURut86
         7GQoplRT92+c1v7LYdjh5eQ2ZJf8yjlEQTbhin6GCVHuT4eWedxNUieFZcDZNnP6EJJq
         Ex/QUn64Nd5ohPmDHnxjluGpu7SOCMZWj202N1zhQfBY1FmOOGtaKR5ukbgGMpLtDYtN
         Vj+g==
X-Gm-Message-State: AOAM531GoshEVhFKlN7TJDH/x5PzVwVvN+1IEogKsIqUae1PwPfX2f/d
        f923NC0qxGgtFw1pmuzNp2zGDSxWe6JMiQ==
X-Google-Smtp-Source: ABdhPJx1y0P/FItAw28TML9RiBaa07GwlbLqXOpdOJ1RmcyHFQDse5BNn3FA0oIN9P2oO6dmecDXag==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr14510194wmc.111.1628159855259;
        Thu, 05 Aug 2021 03:37:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] test-lib tests: don't provide a description for the sub-tests
Date:   Thu,  5 Aug 2021 12:37:23 +0200
Message-Id: <patch-v3-4.9-cde015c7dd-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the $test_description provided for the generated subtests to be
constant, since the only purpose of having it is that test-lib.sh will
barf if it isn't supplied.

The other purpose of having it was to effectively split up the test
description between the argument to test_expect_success and the
argument to "write_and_run_sub_test_lib_test". Let's only use one of
the two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh |  12 ++--
 t/t0000-basic.sh | 142 +++++++++++++++++++++--------------------------
 2 files changed, 66 insertions(+), 88 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 21fa570d0b..cdbc2d9332 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,12 +1,8 @@
 write_sub_test_lib_test () {
-	name="$1" descr="$2" # stdin is the body of the test code
+	name="$1" # stdin is the body of the test code
 	mkdir "$name" &&
 	write_script "$name/$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
-	test_description='$descr (run in sub test-lib)
-
-	This is run in a sub test-lib so that we do not get incorrect
-	passing metrics
-	'
+	test_description='A test of test-lib.sh itself'
 
 	# Point to the t/test-lib.sh, which isn't in ../ as usual
 	. "\$TEST_DIRECTORY"/test-lib.sh
@@ -15,8 +11,8 @@ write_sub_test_lib_test () {
 }
 
 _run_sub_test_lib_test_common () {
-	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
-	shift 3
+	neg="$1" name="$2" # stdin is the body of the test code
+	shift 2
 
 	# intercept pseudo-options at the front of the argument list that we
 	# will not pass to child script
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index a7c5aaacab..6fdd5f43ca 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -67,8 +67,8 @@ test_expect_success 'success is reported like this' '
 	:
 '
 
-test_expect_success 'pretend we have a fully passing test suite' '
-	write_and_run_sub_test_lib_test full-pass "3 passing tests" <<-\EOF &&
+test_expect_success 'subtest: 3 passing tests' '
+	write_and_run_sub_test_lib_test full-pass <<-\EOF &&
 	for i in 1 2 3
 	do
 		test_expect_success "passing test #$i" "true"
@@ -84,9 +84,8 @@ test_expect_success 'pretend we have a fully passing test suite' '
 	EOF
 '
 
-test_expect_success 'pretend we have a partially passing test suite' '
-	write_and_run_sub_test_lib_test_err \
-		partial-pass "2/3 tests passing" <<-\EOF &&
+test_expect_success 'subtest: 2/3 tests passing' '
+	write_and_run_sub_test_lib_test_err partial-pass <<-\EOF &&
 	test_expect_success "passing test #1" "true"
 	test_expect_success "failing test #2" "false"
 	test_expect_success "passing test #3" "true"
@@ -102,8 +101,8 @@ test_expect_success 'pretend we have a partially passing test suite' '
 	EOF
 '
 
-test_expect_success 'pretend we have a known breakage' '
-	write_and_run_sub_test_lib_test failing-todo "A failing TODO test" <<-\EOF &&
+test_expect_success 'subtest: a failing TODO test' '
+	write_and_run_sub_test_lib_test failing-todo <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_done
@@ -117,8 +116,8 @@ test_expect_success 'pretend we have a known breakage' '
 	EOF
 '
 
-test_expect_success 'pretend we have fixed a known breakage' '
-	write_and_run_sub_test_lib_test passing-todo "A passing TODO test" <<-\EOF &&
+test_expect_success 'subtest: a passing TODO test' '
+	write_and_run_sub_test_lib_test passing-todo <<-\EOF &&
 	test_expect_failure "pretend we have fixed a known breakage" "true"
 	test_done
 	EOF
@@ -129,9 +128,8 @@ test_expect_success 'pretend we have fixed a known breakage' '
 	EOF
 '
 
-test_expect_success 'pretend we have fixed one of two known breakages (run in sub test-lib)' '
-	write_and_run_sub_test_lib_test partially-passing-todos \
-		"2 TODO tests, one passing" <<-\EOF &&
+test_expect_success 'subtest: 2 TODO tests, one passin' '
+	write_and_run_sub_test_lib_test partially-passing-todos <<-\EOF &&
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_success "pretend we have a passing test" "true"
 	test_expect_failure "pretend we have fixed another known breakage" "true"
@@ -148,9 +146,8 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
 	EOF
 '
 
-test_expect_success 'pretend we have a pass, fail, and known breakage' '
-	write_and_run_sub_test_lib_test_err \
-		mixed-results1 "mixed results #1" <<-\EOF &&
+test_expect_success 'subtest: mixed results: pass, failure and a TODO test' '
+	write_and_run_sub_test_lib_test_err mixed-results1 <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_success "failing test" "false"
 	test_expect_failure "pretend we have a known breakage" "false"
@@ -167,9 +164,8 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' '
 	EOF
 '
 
-test_expect_success 'pretend we have a mix of all possible results' '
-	write_and_run_sub_test_lib_test_err \
-		mixed-results2 "mixed results #2" <<-\EOF &&
+test_expect_success 'subtest: mixed results: a mixture of all possible results' '
+	write_and_run_sub_test_lib_test_err mixed-results2 <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_success "passing test" "true"
 	test_expect_success "passing test" "true"
@@ -203,9 +199,8 @@ test_expect_success 'pretend we have a mix of all possible results' '
 	EOF
 '
 
-test_expect_success 'test --verbose' '
-	write_and_run_sub_test_lib_test_err \
-		t1234-verbose "test verbose" --verbose <<-\EOF &&
+test_expect_success 'subtest: --verbose option' '
+	write_and_run_sub_test_lib_test_err t1234-verbose --verbose <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
 	test_expect_success "failing test" false
@@ -230,9 +225,9 @@ test_expect_success 'test --verbose' '
 	EOF
 '
 
-test_expect_success 'test --verbose-only' '
+test_expect_success 'subtest: --verbose-only option' '
 	write_and_run_sub_test_lib_test_err \
-		t2345-verbose-only-2 "test verbose-only=2" \
+		t2345-verbose-only-2 \
 		--verbose-only=2 <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
@@ -253,10 +248,9 @@ test_expect_success 'test --verbose-only' '
 	EOF
 '
 
-test_expect_success 'GIT_SKIP_TESTS' '
+test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
 	(
 		write_and_run_sub_test_lib_test git-skip-tests-basic \
-			"GIT_SKIP_TESTS" \
 			--skip="git.2" <<-\EOF &&
 		for i in 1 2 3
 		do
@@ -274,10 +268,9 @@ test_expect_success 'GIT_SKIP_TESTS' '
 	)
 '
 
-test_expect_success 'GIT_SKIP_TESTS several tests' '
+test_expect_success 'subtest: skip several with GIT_SKIP_TESTS' '
 	(
 		write_and_run_sub_test_lib_test git-skip-tests-several \
-			"GIT_SKIP_TESTS several tests" \
 			--skip="git.2 git.5" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
@@ -298,10 +291,9 @@ test_expect_success 'GIT_SKIP_TESTS several tests' '
 	)
 '
 
-test_expect_success 'GIT_SKIP_TESTS sh pattern' '
+test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
 	(
 		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
-			"GIT_SKIP_TESTS sh pattern" \
 			--skip="git.[2-5]" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
@@ -322,10 +314,9 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 	)
 '
 
-test_expect_success 'GIT_SKIP_TESTS entire suite' '
+test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
 	(
 		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
-			"GIT_SKIP_TESTS entire suite" \
 			--skip="git" <<-\EOF &&
 		for i in 1 2 3
 		do
@@ -339,10 +330,9 @@ test_expect_success 'GIT_SKIP_TESTS entire suite' '
 	)
 '
 
-test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
+test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
 		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
-			"GIT_SKIP_TESTS does not skip unmatched suite" \
 			--skip="notgit" <<-\EOF &&
 		for i in 1 2 3
 		do
@@ -360,9 +350,8 @@ test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 	)
 '
 
-test_expect_success '--run basic' '
-	write_and_run_sub_test_lib_test run-basic \
-		"--run basic" --run="1,3,5" <<-\EOF &&
+test_expect_success 'subtest: --run basic' '
+	write_and_run_sub_test_lib_test run-basic --run="1,3,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -381,9 +370,9 @@ test_expect_success '--run basic' '
 	EOF
 '
 
-test_expect_success '--run with a range' '
+test_expect_success 'subtest: --run with a range' '
 	write_and_run_sub_test_lib_test run-range \
-		"--run with a range" --run="1-3" <<-\EOF &&
+		--run="1-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -402,9 +391,9 @@ test_expect_success '--run with a range' '
 	EOF
 '
 
-test_expect_success '--run with two ranges' '
+test_expect_success 'subtest: --run with two ranges' '
 	write_and_run_sub_test_lib_test run-two-ranges \
-		"--run with two ranges" --run="1-2,5-6" <<-\EOF &&
+		--run="1-2,5-6" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -423,9 +412,9 @@ test_expect_success '--run with two ranges' '
 	EOF
 '
 
-test_expect_success '--run with a left open range' '
+test_expect_success 'subtest: --run with a left open range' '
 	write_and_run_sub_test_lib_test run-left-open-range \
-		"--run with a left open range" --run="-3" <<-\EOF &&
+		--run="-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -444,9 +433,9 @@ test_expect_success '--run with a left open range' '
 	EOF
 '
 
-test_expect_success '--run with a right open range' '
+test_expect_success 'subtest: --run with a right open range' '
 	write_and_run_sub_test_lib_test run-right-open-range \
-		"--run with a right open range" --run="4-" <<-\EOF &&
+		--run="4-" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -465,9 +454,9 @@ test_expect_success '--run with a right open range' '
 	EOF
 '
 
-test_expect_success '--run with basic negation' '
+test_expect_success 'subtest: --run with basic negation' '
 	write_and_run_sub_test_lib_test run-basic-neg \
-		"--run with basic negation" --run="!3" <<-\EOF &&
+		--run="!3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -486,9 +475,9 @@ test_expect_success '--run with basic negation' '
 	EOF
 '
 
-test_expect_success '--run with two negations' '
+test_expect_success 'subtest: --run with two negations' '
 	write_and_run_sub_test_lib_test run-two-neg \
-		"--run with two negations" --run="!3,!6" <<-\EOF &&
+		--run="!3,!6" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -507,9 +496,9 @@ test_expect_success '--run with two negations' '
 	EOF
 '
 
-test_expect_success '--run a range and negation' '
+test_expect_success 'subtest: --run a range and negation' '
 	write_and_run_sub_test_lib_test run-range-and-neg \
-		"--run a range and negation" --run="-4,!2" <<-\EOF &&
+		--run="-4,!2" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -528,9 +517,9 @@ test_expect_success '--run a range and negation' '
 	EOF
 '
 
-test_expect_success '--run range negation' '
+test_expect_success 'subtest: --run range negation' '
 	write_and_run_sub_test_lib_test run-range-neg \
-		"--run range negation" --run="!1-3" <<-\EOF &&
+		--run="!1-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
 		test_expect_success "passing test #$i" "true"
@@ -549,9 +538,8 @@ test_expect_success '--run range negation' '
 	EOF
 '
 
-test_expect_success '--run include, exclude and include' '
+test_expect_success 'subtest: --run include, exclude and include' '
 	write_and_run_sub_test_lib_test run-inc-neg-inc \
-		"--run include, exclude and include" \
 		--run="1-5,!1-3,2" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -571,9 +559,8 @@ test_expect_success '--run include, exclude and include' '
 	EOF
 '
 
-test_expect_success '--run include, exclude and include, comma separated' '
+test_expect_success 'subtest: --run include, exclude and include, comma separated' '
 	write_and_run_sub_test_lib_test run-inc-neg-inc-comma \
-		"--run include, exclude and include, comma separated" \
 		--run=1-5,!1-3,2 <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -593,9 +580,8 @@ test_expect_success '--run include, exclude and include, comma separated' '
 	EOF
 '
 
-test_expect_success '--run exclude and include' '
+test_expect_success 'subtest: --run exclude and include' '
 	write_and_run_sub_test_lib_test run-neg-inc \
-		"--run exclude and include" \
 		--run="!3-,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -615,9 +601,8 @@ test_expect_success '--run exclude and include' '
 	EOF
 '
 
-test_expect_success '--run empty selectors' '
+test_expect_success 'subtest: --run empty selectors' '
 	write_and_run_sub_test_lib_test run-empty-sel \
-		"--run empty selectors" \
 		--run="1,,3,,,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -637,9 +622,8 @@ test_expect_success '--run empty selectors' '
 	EOF
 '
 
-test_expect_success '--run substring selector' '
+test_expect_success 'subtest: --run substring selector' '
 	write_and_run_sub_test_lib_test run-substring-selector \
-		"--run empty selectors" \
 		--run="relevant" <<-\EOF &&
 	test_expect_success "relevant test" "true"
 	for i in 1 2 3 4 5 6
@@ -661,9 +645,8 @@ test_expect_success '--run substring selector' '
 	EOF
 '
 
-test_expect_success '--run keyword selection' '
+test_expect_success 'subtest: --run keyword selection' '
 	write_and_run_sub_test_lib_test_err run-inv-range-start \
-		"--run invalid range start" \
 		--run="a-5" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
 	test_done
@@ -676,9 +659,8 @@ test_expect_success '--run keyword selection' '
 	EOF_ERR
 '
 
-test_expect_success '--run invalid range end' '
+test_expect_success 'subtest: --run invalid range end' '
 	write_and_run_sub_test_lib_test_err run-inv-range-end \
-		"--run invalid range end" \
 		--run="1-z" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
 	test_done
@@ -691,8 +673,8 @@ test_expect_success '--run invalid range end' '
 	EOF_ERR
 '
 
-test_expect_success 'tests respect prerequisites' '
-	write_and_run_sub_test_lib_test prereqs "tests respect prereqs" <<-\EOF &&
+test_expect_success 'subtest: tests respect prerequisites' '
+	write_and_run_sub_test_lib_test prereqs <<-\EOF &&
 
 	test_set_prereq HAVEIT
 	test_expect_success HAVEIT "prereq is satisfied" "true"
@@ -721,8 +703,8 @@ test_expect_success 'tests respect prerequisites' '
 	EOF
 '
 
-test_expect_success 'tests respect lazy prerequisites' '
-	write_and_run_sub_test_lib_test lazy-prereqs "respect lazy prereqs" <<-\EOF &&
+test_expect_success 'subtest: tests respect lazy prerequisites' '
+	write_and_run_sub_test_lib_test lazy-prereqs <<-\EOF &&
 
 	test_lazy_prereq LAZY_TRUE true
 	test_expect_success LAZY_TRUE "lazy prereq is satisifed" "true"
@@ -745,8 +727,8 @@ test_expect_success 'tests respect lazy prerequisites' '
 	EOF
 '
 
-test_expect_success 'nested lazy prerequisites' '
-	write_and_run_sub_test_lib_test nested-lazy "nested lazy prereqs" <<-\EOF &&
+test_expect_success 'subtest: nested lazy prerequisites' '
+	write_and_run_sub_test_lib_test nested-lazy <<-\EOF &&
 
 	test_lazy_prereq NESTED_INNER "
 		>inner &&
@@ -771,9 +753,9 @@ test_expect_success 'nested lazy prerequisites' '
 	EOF
 '
 
-test_expect_success 'lazy prereqs do not turn off tracing' '
+test_expect_success 'subtest: lazy prereqs do not turn off tracing' '
 	write_and_run_sub_test_lib_test lazy-prereq-and-tracing \
-		"lazy prereqs and -x" -v -x <<-\EOF &&
+		-v -x <<-\EOF &&
 	test_lazy_prereq LAZY true
 
 	test_expect_success lazy "test_have_prereq LAZY && echo trace"
@@ -784,8 +766,8 @@ test_expect_success 'lazy prereqs do not turn off tracing' '
 	grep "echo trace" lazy-prereq-and-tracing/err
 '
 
-test_expect_success 'tests clean up after themselves' '
-	write_and_run_sub_test_lib_test cleanup "test with cleanup" <<-\EOF &&
+test_expect_success 'subtest: tests clean up after themselves' '
+	write_and_run_sub_test_lib_test cleanup <<-\EOF &&
 	clean=no
 	test_expect_success "do cleanup" "
 		test_when_finished clean=yes
@@ -804,9 +786,9 @@ test_expect_success 'tests clean up after themselves' '
 	EOF
 '
 
-test_expect_success 'tests clean up even on failures' '
+test_expect_success 'subtest: tests clean up even on failures' '
 	write_and_run_sub_test_lib_test_err \
-		failing-cleanup "Failing tests with cleanup commands" <<-\EOF &&
+		failing-cleanup <<-\EOF &&
 	test_expect_success "tests clean up even after a failure" "
 		touch clean-after-failure &&
 		test_when_finished rm clean-after-failure &&
@@ -833,9 +815,9 @@ test_expect_success 'tests clean up even on failures' '
 	EOF
 '
 
-test_expect_success 'test_atexit is run' '
+test_expect_success 'subtest: test_atexit is run' '
 	write_and_run_sub_test_lib_test_err \
-		atexit-cleanup "Run atexit commands" -i <<-\EOF &&
+		atexit-cleanup -i <<-\EOF &&
 	test_expect_success "tests clean up even after a failure" "
 		> ../../clean-atexit &&
 		test_atexit rm ../../clean-atexit &&
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

