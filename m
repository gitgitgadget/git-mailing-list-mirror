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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCDAC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C112360F02
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHEKhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbhHEKhu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56515C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so3336790wmb.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3Z5UZ5+Jd518Au/Icsmny+d7L2xSSM2fohX4XUMpGY=;
        b=EZFOchmCqASQPGyT/ixlF6mF0fZdV0Dbd8zQlxLHWpoXBPjI5PfwekWBW6jjjQLcxK
         EBepNXcR3V9pwBr6yrUne9faZI7Onw4hYCZSLW6TV+XsWLcyK2mvg9EtzSDZR38HG1PH
         JWDnhVsXW6r4J3nFyqdTqBkliSGkU3nyUVimXj9ppdD/msZnfCP0i5QF6nIpPomv7rOu
         e3tW2Vznyg+WgNE8kpwTWtLyLf6B7o08k3ZFC5ilW9cbFtP2n/OYyHmZj2L2T5gOCAvz
         fWmWHL12Rvt6xlDChobjRCLrt+IsfsFL9b8Do07z5vpNpWF5CO4VWCBmMw0fNPoMQqdN
         sdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3Z5UZ5+Jd518Au/Icsmny+d7L2xSSM2fohX4XUMpGY=;
        b=OWyOHRC7urZhceYPXSdWSJU3pfy6t6F0wd0o/qeMTcu/WSgOW845Z9ECqI5IjVBDbQ
         QL7KrIs7/BtiC65y47eFurWq1d0FqH3BDjtucUK/uNuC0URvrpa5cAiuxkMkb2sBHGz1
         6upYKjTGnyVCEA3LUCU0TX3KoJFPRf5pGyGzhXAPxOc+xe2YUPrytVQxI/EWptxDFWw9
         bzUVU4sl6v1ubDwg36EYqkkyDhxBPdSXa9bo5CzX1xqNJh2jD7j4ghsOEuMXLlsv2yqY
         cvwWoTPDiGnTc92rjcWqDaY37+C0a9OQaDfbZDwru5FgOYOr3q4nyuRdEDwrhkLtc5Nr
         0Xww==
X-Gm-Message-State: AOAM532RTP0JfwS6viMFsDbdAcG/dS5Y1jZ9Ekqdo4+K8dw++CNGczi2
        0h3tdT94KC2ebc1lqEjUF6lZmLomWTu87w==
X-Google-Smtp-Source: ABdhPJy+F0PyGRn52JZCYpX1wMOQthzbMoI+L8UtoRcAOSqEt0mA+o3VcXgWBcLU/EdZgtm9ELSv6A==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr4282893wmb.170.1628159853660;
        Thu, 05 Aug 2021 03:37:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:33 -0700 (PDT)
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
Subject: [PATCH v3 2/9] test-lib tests: split up "write and run" into two functions
Date:   Thu,  5 Aug 2021 12:37:21 +0200
Message-Id: <patch-v3-2.9-c9c16016da-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
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
 t/lib-subtest.sh | 45 +++++++++++++++++++++--------
 t/t0000-basic.sh | 74 ++++++++++++++++++++++++------------------------
 2 files changed, 70 insertions(+), 49 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 3cfe09911a..58ae316ad5 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,3 +1,22 @@
+write_sub_test_lib_test () {
+	name="$1" descr="$2" # stdin is the body of the test code
+	mkdir "$name" &&
+	(
+		cd "$name" &&
+		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
+		test_description='$descr (run in sub test-lib)
+
+		This is run in a sub test-lib so that we do not get incorrect
+		passing metrics
+		'
+
+		# Point to the t/test-lib.sh, which isn't in ../ as usual
+		. "\$TEST_DIRECTORY"/test-lib.sh
+		EOF
+		cat >>"$name.sh"
+	)
+}
+
 _run_sub_test_lib_test_common () {
 	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
 	shift 3
@@ -18,25 +37,15 @@ _run_sub_test_lib_test_common () {
 		esac
 	done
 
-	mkdir "$name" &&
 	(
+		cd "$name" &&
+
 		# Pretend we're not running under a test harness, whether we
 		# are or not. The test-lib output depends on the setting of
 		# this variable, so we need a stable setting under which to run
 		# the sub-test.
 		sane_unset HARNESS_ACTIVE &&
-		cd "$name" &&
-		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
-		test_description='$descr (run in sub test-lib)
 
-		This is run in a sub test-lib so that we do not get incorrect
-		passing metrics
-		'
-
-		# Point to the t/test-lib.sh, which isn't in ../ as usual
-		. "\$TEST_DIRECTORY"/test-lib.sh
-		EOF
-		cat >>"$name.sh" &&
 		export TEST_DIRECTORY &&
 		# The child test re-sources GIT-BUILD-OPTIONS and may thus
 		# override the test output directory. We thus pass it as an
@@ -55,6 +64,18 @@ _run_sub_test_lib_test_common () {
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
index a3865dd77b..a7c5aaacab 100755
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
@@ -255,7 +255,7 @@ test_expect_success 'test --verbose-only' '
 
 test_expect_success 'GIT_SKIP_TESTS' '
 	(
-		run_sub_test_lib_test git-skip-tests-basic \
+		write_and_run_sub_test_lib_test git-skip-tests-basic \
 			"GIT_SKIP_TESTS" \
 			--skip="git.2" <<-\EOF &&
 		for i in 1 2 3
@@ -276,7 +276,7 @@ test_expect_success 'GIT_SKIP_TESTS' '
 
 test_expect_success 'GIT_SKIP_TESTS several tests' '
 	(
-		run_sub_test_lib_test git-skip-tests-several \
+		write_and_run_sub_test_lib_test git-skip-tests-several \
 			"GIT_SKIP_TESTS several tests" \
 			--skip="git.2 git.5" <<-\EOF &&
 		for i in 1 2 3 4 5 6
@@ -300,7 +300,7 @@ test_expect_success 'GIT_SKIP_TESTS several tests' '
 
 test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 	(
-		run_sub_test_lib_test git-skip-tests-sh-pattern \
+		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
 			"GIT_SKIP_TESTS sh pattern" \
 			--skip="git.[2-5]" <<-\EOF &&
 		for i in 1 2 3 4 5 6
@@ -324,7 +324,7 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 
 test_expect_success 'GIT_SKIP_TESTS entire suite' '
 	(
-		run_sub_test_lib_test git-skip-tests-entire-suite \
+		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
 			"GIT_SKIP_TESTS entire suite" \
 			--skip="git" <<-\EOF &&
 		for i in 1 2 3
@@ -341,7 +341,7 @@ test_expect_success 'GIT_SKIP_TESTS entire suite' '
 
 test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
-		run_sub_test_lib_test git-skip-tests-unmatched-suite \
+		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
 			"GIT_SKIP_TESTS does not skip unmatched suite" \
 			--skip="notgit" <<-\EOF &&
 		for i in 1 2 3
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
2.33.0.rc0.635.g0ab9d6d3b5a

