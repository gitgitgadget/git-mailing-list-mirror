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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E9C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC83561483
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhFNK5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhFNKyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:54:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB77C0611BC
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y7so14018912wrh.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vaqN14/dIx+z+r/B3AUyC/dZScH5hKlO1jayX68baxM=;
        b=t9O0E1Hz57quVB4JFV8cVl9zhhfNlmU4zCS5eXnIV/ysIKezctYQgIiyMhwTNOcsD6
         oCRcAtdJsPWLs7ObsmDvk7XKRihQIZ3NFM6wE3aw8l4kbZaTntPlIcI1sCjje3Qywzlv
         ZQ7Xka7RDueIrfQSayhpBOrpfAH7Xu8fwSN5ipLTkV4wM3kxx7YsNPSg6M5LNbokUaeH
         3dhoFG+13APA/8i05/aazAffyNQs3mIAEgSo8BLyjdsyrf6bWzidhQj1bIHztR6lfZjE
         gqNJK3F6IFYZV1yeYvRbSpISC5zLGwJv5h2cEJov9Yt17BN78XbPFI2zabdHmw+XG75s
         I0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaqN14/dIx+z+r/B3AUyC/dZScH5hKlO1jayX68baxM=;
        b=cmh7ym1gFvS6fnfD6QW2tzl0ZOaUFG6nkb86f+TqjIdjsGmkYiEICYuQ2XGLM6dXbc
         sBlGYgdhncB8m/Enrh+HT+dzE19ug7iOzmAz3YqiJJSDDWw8Wy8qfzkELsbdZJhX/HA7
         zomVcjfuKilAyO6IDyrFzVf6jlXsy1o26hp4BRIndycC5TQDtY8wZZPpJztCh6ryHwy+
         txo6G8ZzWNlhUcywBAYANcCkltQ9WUnYBAFQnDt6+/jepF9fS8MxIPf1si2GV2XEOfNU
         ozajewmNWp4vSHYgKlUgIyFnD6jcBBbdLW5zSYw2rDXrjCZZVnxKcpZfA8XeA9OK5oVq
         Xqzw==
X-Gm-Message-State: AOAM5330FAUAJQU3QIjJ3GEIBSOUhT+IHYLe3kEXiaHvtnnt/ox96HFb
        obEPaIWGCr1e0TxgmuuvGlGrg8KfGYXf3A==
X-Google-Smtp-Source: ABdhPJyvDy6c9biVRGC+DJMmto+I2LORc1Sxe9fDPq0RMKOONSDfeO5LsY+ksv8ORBKM7Ln3jHstEQ==
X-Received: by 2002:adf:f90e:: with SMTP id b14mr18433923wrr.248.1623667701146;
        Mon, 14 Jun 2021 03:48:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] test-lib tests: split up "write and run" into two functions
Date:   Mon, 14 Jun 2021 12:48:08 +0200
Message-Id: <patch-2.8-9e2715d2e20-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the function to write and run tests of the test-lib.sh output
into two functions.

When this was added back in 565b6fa87bb (tests: refactor mechanics of
testing in a sub test-lib, 2012-12-16) there was no reason to do this,
but since we started supporting test arguments in
517cd55fd51 (test-lib: self-test that --verbose works, 2013-06-23)
we've started to write out duplicate tests simply to test different
arguments, now we'll be able to re-use them.

This change doesn't consolidate any of those tests yet, it just makes
it possible to do so. All the changes in t0000-basic.sh are a simple
search-replacement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 39 +++++++++++++++++++------
 t/t0000-basic.sh | 74 ++++++++++++++++++++++++------------------------
 2 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 0c613e00da3..0ece41c0e5f 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,13 +1,7 @@
-_run_sub_test_lib_test_common () {
-	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
-	shift 3
+write_sub_test_lib_test () {
+	name="$1" descr="$2" # stdin is the body of the test code
 	mkdir "$name" &&
 	(
-		# Pretend we're not running under a test harness, whether we
-		# are or not. The test-lib output depends on the setting of
-		# this variable, so we need a stable setting under which to run
-		# the sub-test.
-		sane_unset HARNESS_ACTIVE &&
 		cd "$name" &&
 		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
 		test_description='$descr (run in sub test-lib)
@@ -19,7 +13,22 @@ _run_sub_test_lib_test_common () {
 		# Point to the t/test-lib.sh, which isn't in ../ as usual
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
-		cat >>"$name.sh" &&
+		cat >>"$name.sh"
+	)
+}
+
+_run_sub_test_lib_test_common () {
+	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
+	shift 3
+	(
+		cd "$name" &&
+
+		# Pretend we're not running under a test harness, whether we
+		# are or not. The test-lib output depends on the setting of
+		# this variable, so we need a stable setting under which to run
+		# the sub-test.
+		sane_unset HARNESS_ACTIVE &&
+
 		export TEST_DIRECTORY &&
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
@@ -33,6 +42,18 @@ _run_sub_test_lib_test_common () {
 	)
 }
 
+write_and_run_sub_test_lib_test () {
+	name="$1" descr="$2" # stdin is the body of the test code
+	write_sub_test_lib_test "$@" || return 1
+	_run_sub_test_lib_test_common '' "$@"
+}
+
+write_and_run_sub_test_lib_test_err () {
+	name="$1" descr="$2" # stdin is the body of the test code
+	write_sub_test_lib_test "$@" || return 1
+	_run_sub_test_lib_test_common '!' "$@"
+}
+
 run_sub_test_lib_test () {
 	_run_sub_test_lib_test_common '' "$@"
 }
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 72809477645..7f6714a5fc5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -68,7 +68,7 @@ test_expect_success 'success is reported like this' '
 '
 
 test_expect_success 'pretend we have a fully passing test suite' '
-	run_sub_test_lib_test full-pass "3 passing tests" <<-\EOF &&
+	write_and_run_sub_test_lib_test full-pass "3 passing tests" <<-\EOF &&
 	for i in 1 2 3
 	do
 		test_expect_success "passing test #$i" "true"
@@ -85,7 +85,7 @@ test_expect_success 'pretend we have a fully passing test suite' '
 '
 
 test_expect_success 'pretend we have a partially passing test suite' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		partial-pass "2/3 tests passing" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
 	test_expect_success "failing test #2" "false"
@@ -103,7 +103,7 @@ test_expect_success 'pretend we have a partially passing test suite' '
 '
 
 test_expect_success 'pretend we have a known breakage' '
-	run_sub_test_lib_test failing-todo "A failing TODO test" <<-\EOF &&
+	write_and_run_sub_test_lib_test failing-todo "A failing TODO test" <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_done
@@ -118,7 +118,7 @@ test_expect_success 'pretend we have a known breakage' '
 '
 
 test_expect_success 'pretend we have fixed a known breakage' '
-	run_sub_test_lib_test passing-todo "A passing TODO test" <<-\EOF &&
+	write_and_run_sub_test_lib_test passing-todo "A passing TODO test" <<-\EOF &&
 	test_expect_failure "pretend we have fixed a known breakage" "true"
 	test_done
 	EOF
@@ -130,7 +130,7 @@ test_expect_success 'pretend we have fixed a known breakage' '
 '
 
 test_expect_success 'pretend we have fixed one of two known breakages (run in sub test-lib)' '
-	run_sub_test_lib_test partially-passing-todos \
+	write_and_run_sub_test_lib_test partially-passing-todos \
 		"2 TODO tests, one passing" <<-\EOF &&
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_success "pretend we have a passing test" "true"
@@ -149,7 +149,7 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
 '
 
 test_expect_success 'pretend we have a pass, fail, and known breakage' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		mixed-results1 "mixed results #1" <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_success "failing test" "false"
@@ -168,7 +168,7 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' '
 '
 
 test_expect_success 'pretend we have a mix of all possible results' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		mixed-results2 "mixed results #2" <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_success "passing test" "true"
@@ -204,7 +204,7 @@ test_expect_success 'pretend we have a mix of all possible results' '
 '
 
 test_expect_success 'test --verbose' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		t1234-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
@@ -231,7 +231,7 @@ test_expect_success 'test --verbose' '
 '
 
 test_expect_success 'test --verbose-only' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		t2345-verbose-only-2 "test verbose-only=2" \
 		--verbose-only=2 <<-\EOF &&
 	test_expect_success "passing test" true
@@ -256,7 +256,7 @@ test_expect_success 'test --verbose-only' '
 test_expect_success 'GIT_SKIP_TESTS' '
 	(
 		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
-		run_sub_test_lib_test git-skip-tests-basic \
+		write_and_run_sub_test_lib_test git-skip-tests-basic \
 			"GIT_SKIP_TESTS" <<-\EOF &&
 		for i in 1 2 3
 		do
@@ -277,7 +277,7 @@ test_expect_success 'GIT_SKIP_TESTS' '
 test_expect_success 'GIT_SKIP_TESTS several tests' '
 	(
 		GIT_SKIP_TESTS="git.2 git.5" && export GIT_SKIP_TESTS &&
-		run_sub_test_lib_test git-skip-tests-several \
+		write_and_run_sub_test_lib_test git-skip-tests-several \
 			"GIT_SKIP_TESTS several tests" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
@@ -301,7 +301,7 @@ test_expect_success 'GIT_SKIP_TESTS several tests' '
 test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 	(
 		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
-		run_sub_test_lib_test git-skip-tests-sh-pattern \
+		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
 			"GIT_SKIP_TESTS sh pattern" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
@@ -325,7 +325,7 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 test_expect_success 'GIT_SKIP_TESTS entire suite' '
 	(
 		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
-		run_sub_test_lib_test git-skip-tests-entire-suite \
+		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
 			"GIT_SKIP_TESTS entire suite" <<-\EOF &&
 		for i in 1 2 3
 		do
@@ -342,7 +342,7 @@ test_expect_success 'GIT_SKIP_TESTS entire suite' '
 test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
 		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
-		run_sub_test_lib_test git-skip-tests-unmatched-suite \
+		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
 			"GIT_SKIP_TESTS does not skip unmatched suite" <<-\EOF &&
 		for i in 1 2 3
 		do
@@ -361,7 +361,7 @@ test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 '
 
 test_expect_success '--run basic' '
-	run_sub_test_lib_test run-basic \
+	write_and_run_sub_test_lib_test run-basic \
 		"--run basic" --run="1,3,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -382,7 +382,7 @@ test_expect_success '--run basic' '
 '
 
 test_expect_success '--run with a range' '
-	run_sub_test_lib_test run-range \
+	write_and_run_sub_test_lib_test run-range \
 		"--run with a range" --run="1-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -403,7 +403,7 @@ test_expect_success '--run with a range' '
 '
 
 test_expect_success '--run with two ranges' '
-	run_sub_test_lib_test run-two-ranges \
+	write_and_run_sub_test_lib_test run-two-ranges \
 		"--run with two ranges" --run="1-2,5-6" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -424,7 +424,7 @@ test_expect_success '--run with two ranges' '
 '
 
 test_expect_success '--run with a left open range' '
-	run_sub_test_lib_test run-left-open-range \
+	write_and_run_sub_test_lib_test run-left-open-range \
 		"--run with a left open range" --run="-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -445,7 +445,7 @@ test_expect_success '--run with a left open range' '
 '
 
 test_expect_success '--run with a right open range' '
-	run_sub_test_lib_test run-right-open-range \
+	write_and_run_sub_test_lib_test run-right-open-range \
 		"--run with a right open range" --run="4-" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -466,7 +466,7 @@ test_expect_success '--run with a right open range' '
 '
 
 test_expect_success '--run with basic negation' '
-	run_sub_test_lib_test run-basic-neg \
+	write_and_run_sub_test_lib_test run-basic-neg \
 		"--run with basic negation" --run="!3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -487,7 +487,7 @@ test_expect_success '--run with basic negation' '
 '
 
 test_expect_success '--run with two negations' '
-	run_sub_test_lib_test run-two-neg \
+	write_and_run_sub_test_lib_test run-two-neg \
 		"--run with two negations" --run="!3,!6" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -508,7 +508,7 @@ test_expect_success '--run with two negations' '
 '
 
 test_expect_success '--run a range and negation' '
-	run_sub_test_lib_test run-range-and-neg \
+	write_and_run_sub_test_lib_test run-range-and-neg \
 		"--run a range and negation" --run="-4,!2" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -529,7 +529,7 @@ test_expect_success '--run a range and negation' '
 '
 
 test_expect_success '--run range negation' '
-	run_sub_test_lib_test run-range-neg \
+	write_and_run_sub_test_lib_test run-range-neg \
 		"--run range negation" --run="!1-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -550,7 +550,7 @@ test_expect_success '--run range negation' '
 '
 
 test_expect_success '--run include, exclude and include' '
-	run_sub_test_lib_test run-inc-neg-inc \
+	write_and_run_sub_test_lib_test run-inc-neg-inc \
 		"--run include, exclude and include" \
 		--run="1-5,!1-3,2" <<-\EOF &&
 	for i in 1 2 3 4 5 6
@@ -572,7 +572,7 @@ test_expect_success '--run include, exclude and include' '
 '
 
 test_expect_success '--run include, exclude and include, comma separated' '
-	run_sub_test_lib_test run-inc-neg-inc-comma \
+	write_and_run_sub_test_lib_test run-inc-neg-inc-comma \
 		"--run include, exclude and include, comma separated" \
 		--run=1-5,!1-3,2 <<-\EOF &&
 	for i in 1 2 3 4 5 6
@@ -594,7 +594,7 @@ test_expect_success '--run include, exclude and include, comma separated' '
 '
 
 test_expect_success '--run exclude and include' '
-	run_sub_test_lib_test run-neg-inc \
+	write_and_run_sub_test_lib_test run-neg-inc \
 		"--run exclude and include" \
 		--run="!3-,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
@@ -616,7 +616,7 @@ test_expect_success '--run exclude and include' '
 '
 
 test_expect_success '--run empty selectors' '
-	run_sub_test_lib_test run-empty-sel \
+	write_and_run_sub_test_lib_test run-empty-sel \
 		"--run empty selectors" \
 		--run="1,,3,,,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
@@ -638,7 +638,7 @@ test_expect_success '--run empty selectors' '
 '
 
 test_expect_success '--run substring selector' '
-	run_sub_test_lib_test run-substring-selector \
+	write_and_run_sub_test_lib_test run-substring-selector \
 		"--run empty selectors" \
 		--run="relevant" <<-\EOF &&
 	test_expect_success "relevant test" "true"
@@ -662,7 +662,7 @@ test_expect_success '--run substring selector' '
 '
 
 test_expect_success '--run keyword selection' '
-	run_sub_test_lib_test_err run-inv-range-start \
+	write_and_run_sub_test_lib_test_err run-inv-range-start \
 		"--run invalid range start" \
 		--run="a-5" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
@@ -677,7 +677,7 @@ test_expect_success '--run keyword selection' '
 '
 
 test_expect_success '--run invalid range end' '
-	run_sub_test_lib_test_err run-inv-range-end \
+	write_and_run_sub_test_lib_test_err run-inv-range-end \
 		"--run invalid range end" \
 		--run="1-z" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
@@ -692,7 +692,7 @@ test_expect_success '--run invalid range end' '
 '
 
 test_expect_success 'tests respect prerequisites' '
-	run_sub_test_lib_test prereqs "tests respect prereqs" <<-\EOF &&
+	write_and_run_sub_test_lib_test prereqs "tests respect prereqs" <<-\EOF &&
 
 	test_set_prereq HAVEIT
 	test_expect_success HAVEIT "prereq is satisfied" "true"
@@ -722,7 +722,7 @@ test_expect_success 'tests respect prerequisites' '
 '
 
 test_expect_success 'tests respect lazy prerequisites' '
-	run_sub_test_lib_test lazy-prereqs "respect lazy prereqs" <<-\EOF &&
+	write_and_run_sub_test_lib_test lazy-prereqs "respect lazy prereqs" <<-\EOF &&
 
 	test_lazy_prereq LAZY_TRUE true
 	test_expect_success LAZY_TRUE "lazy prereq is satisifed" "true"
@@ -746,7 +746,7 @@ test_expect_success 'tests respect lazy prerequisites' '
 '
 
 test_expect_success 'nested lazy prerequisites' '
-	run_sub_test_lib_test nested-lazy "nested lazy prereqs" <<-\EOF &&
+	write_and_run_sub_test_lib_test nested-lazy "nested lazy prereqs" <<-\EOF &&
 
 	test_lazy_prereq NESTED_INNER "
 		>inner &&
@@ -772,7 +772,7 @@ test_expect_success 'nested lazy prerequisites' '
 '
 
 test_expect_success 'lazy prereqs do not turn off tracing' '
-	run_sub_test_lib_test lazy-prereq-and-tracing \
+	write_and_run_sub_test_lib_test lazy-prereq-and-tracing \
 		"lazy prereqs and -x" -v -x <<-\EOF &&
 	test_lazy_prereq LAZY true
 
@@ -785,7 +785,7 @@ test_expect_success 'lazy prereqs do not turn off tracing' '
 '
 
 test_expect_success 'tests clean up after themselves' '
-	run_sub_test_lib_test cleanup "test with cleanup" <<-\EOF &&
+	write_and_run_sub_test_lib_test cleanup "test with cleanup" <<-\EOF &&
 	clean=no
 	test_expect_success "do cleanup" "
 		test_when_finished clean=yes
@@ -805,7 +805,7 @@ test_expect_success 'tests clean up after themselves' '
 '
 
 test_expect_success 'tests clean up even on failures' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		failing-cleanup "Failing tests with cleanup commands" <<-\EOF &&
 	test_expect_success "tests clean up even after a failure" "
 		touch clean-after-failure &&
@@ -834,7 +834,7 @@ test_expect_success 'tests clean up even on failures' '
 '
 
 test_expect_success 'test_atexit is run' '
-	run_sub_test_lib_test_err \
+	write_and_run_sub_test_lib_test_err \
 		atexit-cleanup "Run atexit commands" -i <<-\EOF &&
 	test_expect_success "tests clean up even after a failure" "
 		> ../../clean-atexit &&
-- 
2.32.0.rc3.434.gd8aed1f08a7

