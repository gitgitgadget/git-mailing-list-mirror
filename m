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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CAC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B1361987
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhFNKx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:53:29 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:43930 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhFNKv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:51:27 -0400
Received: by mail-wm1-f45.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso12508776wmj.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hfFWnrIrrbnye23rfpaXd/uXBw/QoB2rASfcepf894=;
        b=XdzjTRUweb53zL9gjQ5znkKA29am6yZPjhqBaODTp4Vy358G6syLQGc4dxlMqFqwqc
         zuklMYosmATQrrg2sQdRZnVEFIknzrGp1iu8rrFYrMqFL5X9WgKtxCvNXt8eFAnEURRd
         0QcXRwawQ2zWutIkpooMj+lFsAIdENzA4EOYvnYEmlYKjvYJsIhyoeaDd0f4KQmWag6h
         9Pv3nO/6QdbURQ1+vW+J4Cu5lkkBm7zdfzLLFGJEzwNHd4xay6eiKEApmSbWvH8br6dH
         SGPaMF0Q6BaTGwgkQesKOhDIcs48X32GkD4IfxeMFZVUDA59WcoWLV5AV53I4ziFviw5
         fWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hfFWnrIrrbnye23rfpaXd/uXBw/QoB2rASfcepf894=;
        b=chS8Xj0m1yHoazEt9WQ0VTgMaVFBnA8NWWtEUJksip1jzD67WZvOeAUsZ49f5iSLxQ
         kONxpFi8/6YBGmu6JbIzZlbnZkvgzlBqQx0EXKmzUTcbs9F14kwVt7EcWGJTBiysZiPi
         rYPJ9X3G0+FvTtrsBj0s/hm0Pyp2f6hnI6xFqr84hzaorLhDTykfKPVTlNUd1jMgs5sp
         G2xuJeygHW5ajqx7oGKeYs8wiIOm1KLHCnvjaaiNpJvXsozSx5dYY3YiYO6GwNZ/4DmI
         u1fFdSxBsBUhGzCDRa7VkCQpW4n3CnTVhlyCEv+IQHwDFtre6g9ZnlCMq3DnSO06GcQB
         IdJw==
X-Gm-Message-State: AOAM533gRXwUetfI17thUg7m6/0d2s1blM9ajeneTM0YL1YTbPWllogR
        ZoD2zL8Tp81aP6qRtg8Pi6h7GH/7LlkDSw==
X-Google-Smtp-Source: ABdhPJyLmMhODkmNZSvRu8ifGv1uQP+pqSOrKuh/vUIv98zuOGIjoZT/AghSWRwK4dQRw21/4M+91A==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr15406299wme.40.1623667703691;
        Mon, 14 Jun 2021 03:48:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:23 -0700 (PDT)
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
Subject: [PATCH 5/8] test-lib tests: get rid of copy/pasted mock test code
Date:   Mon, 14 Jun 2021 12:48:11 +0200
Message-Id: <patch-5.8-1909616d9ca-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we've split up the write_sub_test_lib_test*() and
run_sub_test_lib_test*() functions let's fix those tests in
t0000-basic.sh that were verbosely copy/pasting earlier tests.

I'm (ab)using writing a tag object under a ref-name that's
content-addressable from the content of the test script. If we can
update-ref that it's unique, if not we've got a duplicate. The tag
object stores the name of the earlier test for reporting the error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh |  34 ++++++-
 t/t0000-basic.sh | 224 ++++++++++++-----------------------------------
 2 files changed, 88 insertions(+), 170 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 4a50e380506..4834db6c4ca 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,3 +1,34 @@
+_assert_unique_sub_test () {
+	name=$1 &&
+
+	# Alert about the copy/paste programming
+	hash=$(git hash-object -w "$name") &&
+	cat >tag.sig <<-EOF &&
+	object $hash
+	type blob
+	tag $hash
+	tagger . <> 0 +0000
+
+	duplicate script detected!
+
+	This test script was already written as:
+
+	$name
+
+	You can just re-use its test code with your own
+	run_sub_test_lib_test*()
+	EOF
+
+	tag=$(git mktag <tag.sig) &&
+	if ! git update-ref refs/tags/blob-$hash $tag $(test_oid zero) 2>/dev/null
+	then
+		msg=$(git for-each-ref refs/tags/blob-$hash \
+			--format='%(contents)' refs/tags/blob-$hash)
+		error "on write of $name: $msg"
+		return 1
+	fi
+}
+
 write_sub_test_lib_test () {
 	name="$1" # stdin is the body of the test code
 	mkdir "$name" &&
@@ -7,7 +38,8 @@ write_sub_test_lib_test () {
 	# Point to the t/test-lib.sh, which isn't in ../ as usual
 	. "\$TEST_DIRECTORY"/test-lib.sh
 	EOF
-	cat >>"$name/$name.sh"
+	cat >>"$name/$name.sh" &&
+	_assert_unique_sub_test "$name/$name.sh"
 }
 
 _run_sub_test_lib_test_common () {
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b93a8ced7f6..886329d1f8e 100755
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
@@ -250,16 +245,9 @@ test_expect_success 'subtest: --verbose-only option' '
 
 test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
 	(
-		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
-		write_and_run_sub_test_lib_test git-skip-tests-basic \
-			<<-\EOF &&
-		for i in 1 2 3
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-basic <<-\EOF
+		GIT_SKIP_TESTS="full.2" && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test full-pass &&
+		check_sub_test_lib_test full-pass <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 - passing test #3
@@ -296,15 +284,8 @@ test_expect_success 'subtest: skip several with GIT_SKIP_TESTS' '
 test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
 	(
 		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
-		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
-			<<-\EOF &&
-		for i in 1 2 3 4 5 6
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\EOF
+		run_sub_test_lib_test git-skip-tests-several &&
+		check_sub_test_lib_test git-skip-tests-several <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
@@ -320,15 +301,8 @@ test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
 test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
 	(
 		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
-		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
-			<<-\EOF &&
-		for i in 1 2 3
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-entire-suite <<-\EOF
+		run_sub_test_lib_test git-skip-tests-several &&
+		check_sub_test_lib_test git-skip-tests-several <<-\EOF
 		> 1..0 # SKIP skip all tests in git
 		EOF
 	)
@@ -337,15 +311,8 @@ test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
 test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
 		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
-		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
-			<<-\EOF &&
-		for i in 1 2 3
-		do
-			test_expect_success "passing test #$i" "true"
-		done
-		test_done
-		EOF
-		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\EOF
+		run_sub_test_lib_test full-pass &&
+		check_sub_test_lib_test full-pass <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 - passing test #2
 		> ok 3 - passing test #3
@@ -356,14 +323,8 @@ test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
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
@@ -376,15 +337,9 @@ test_expect_success 'subtest: --run basic' '
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
@@ -397,15 +352,9 @@ test_expect_success 'subtest: --run with a range' '
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
@@ -418,15 +367,9 @@ test_expect_success 'subtest: --run with two ranges' '
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
@@ -439,15 +382,9 @@ test_expect_success 'subtest: --run with a left open range' '
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
@@ -460,15 +397,9 @@ test_expect_success 'subtest: --run with a right open range' '
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
@@ -481,15 +412,9 @@ test_expect_success 'subtest: --run with basic negation' '
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
@@ -502,15 +427,9 @@ test_expect_success 'subtest: --run with two negations' '
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
@@ -523,15 +442,9 @@ test_expect_success 'subtest: --run a range and negation' '
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
@@ -544,15 +457,9 @@ test_expect_success 'subtest: --run range negation' '
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
@@ -565,15 +472,9 @@ test_expect_success 'subtest: --run include, exclude and include' '
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
@@ -586,15 +487,9 @@ test_expect_success 'subtest: --run include, exclude and include, comma separate
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
@@ -607,15 +502,9 @@ test_expect_success 'subtest: --run exclude and include' '
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
@@ -665,12 +554,9 @@ test_expect_success 'subtest: --run keyword selection' '
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
2.32.0.rc3.434.gd8aed1f08a7

