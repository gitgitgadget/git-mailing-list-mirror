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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E691C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4700C61249
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGUWR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhGUWRy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7BEC0613D5
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w13so2228469wmc.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KpR4DiYOQ8aH6/kIri6SWokPd9pTbyWMmnU2CkHSz8=;
        b=YfoWHPGqmpxJsQDoNXhD4SHpHFLP7HNvNmHL7XEWyiP0CgKGrIEfdqiVqlnJ23LIio
         AL5g9RW+GbyIbGvC6b44/UL/12gdQlZbYxeehZG+fi4MLAJFKlLsfj9MgC2tYIZb6flS
         iVYPL4uBtDIAAq5lkgqI5CBv8clHhYGY6hfkp/Z1FXg50Dk7mWmv5SA/an5NozqCimvz
         uzCXGk6qtBvRLZtU3N2cHRvjYy7TL9r6kWgygmuKVwjhw6Tyfl8NtCDwOIeHlWnE1E69
         6u/UzBgx8X5e6CFNVUwvmVQsj/sBEY+HaI1o6tMM9IK5etWps7nhHTWiNiu3bcZgT7t1
         rYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KpR4DiYOQ8aH6/kIri6SWokPd9pTbyWMmnU2CkHSz8=;
        b=feIQLd/5BhnAu6hXBRszkpMCiQIHDI5JW+E8rx9upSBdQMKllqATiMEU4duVIco7dJ
         F5qQyypKZjDjwgfG5u4DMZIb1bKhY/8WZ4+jkblpgon+28uDepZYQPSB6Fg1+pY4kR3X
         Va+0ktz7U7LgtgxM77gZOr4KakI3Y5RqlBOweWw5Fz2fPAcM8BKKPl3k3EZpooxVZv/G
         vYG9J3qNZKtEm6DQhEn0qKhMPo1fgi0TnagmT7EcPbgLRIDWVl61/r+PeJdlJgFwELmr
         qhdoym7hEfsDgN2YKVl2JSx6u+GkJHMrRmrIBs0LkCUqLzUe3AENxkMMu3F84jRQhPQo
         hUsg==
X-Gm-Message-State: AOAM530th4q887171S7t1L8oC9aLMmqTtlpS2XF9C5XPkxPPoEYT12Hp
        9vyGyXbptOkOF2ddQxFTxynG3Dfdrsk26A==
X-Google-Smtp-Source: ABdhPJw5gBRCXMdTowQPgwsQ03h6qTgdzI8v4AgUecFiNG3wxU4wnj50oQN+ax3d8VknmN4dBoTPRg==
X-Received: by 2002:a05:600c:5106:: with SMTP id o6mr6071551wms.18.1626908308413;
        Wed, 21 Jul 2021 15:58:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18sm23129818wmk.37.2021.07.21.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:27 -0700 (PDT)
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
Subject: [PATCH v2 5/8] test-lib tests: get rid of copy/pasted mock test code
Date:   Thu, 22 Jul 2021 00:57:44 +0200
Message-Id: <patch-5.8-f60190dec6a-20210721T225504Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com> <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
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
 t/t0000-basic.sh | 228 +++++++++++++----------------------------------
 2 files changed, 93 insertions(+), 169 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 7899518abb0..d98390606b8 100644
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
2.32.0.955.ge7c5360f7e7

