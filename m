Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD4C433FE
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiCRAfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCRAfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0301231939
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so5898671wms.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0uroXwvLwFDNfnRfL3JRvpsqoCFeg89n7g8kFyVFB4=;
        b=bAdZ6/TRSHnY1+l03d/HyPkWLAR13MAFl1mymoWJJ6hx5RkPwAPgBvQO7uFsJV5xhM
         qafg3KiBQCPrqff1C46wY6nggfEteAFHF15RZ8d3p8u+YcyJ2Jan4Be95w7HsQQdHBkH
         cJ4McWvgNo/ZpKEGJv81/mIWksTO4wofb35IPQHv0sSHcCC48nbo99uiBA68+d3RhCvW
         2/MqOFmmJzPSsoYjMja5PHeVPsgCkroBpoZHhLBiXWlnVVtgufseIKnJYAeyICUh8/gB
         oJ/dZWRIv85waaQTAC01ZEJXV/WbRqBwn11KGnN2z51zBNxBpDkXN/SvVQclIHjNJHOm
         sbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0uroXwvLwFDNfnRfL3JRvpsqoCFeg89n7g8kFyVFB4=;
        b=uYvqM2732Ufgz0klz7cmCMWsjQQsf1XxEX2WXjYi/aAcH9zfKolm+TdpCNQaE0q2tT
         2xG5/ik4Wyw4d1ysbubgfZC1lF39Vi/SDTkiVPg+DG1RhhItoLdIVrPknMf0Y1kaIz/g
         CZu46S0y65Y+tgiKPRI8qExltWN6xzmz0mZ/ppAOqdrazzslaecL4Cu6VNQh+ICFN9d4
         9CWvjpeVuPv8HocL++HbZB47ONUA4tKydfQwgH24+K7YecTGnyeSlH+YB2nCs0tSR08w
         O/dXTZgMJuS/P0IZiipvKVBvbpmCSlUY0Ijqa6Tq4cErBce6GAsOmn90TM7hlNhEMf5o
         Ebbw==
X-Gm-Message-State: AOAM531086/oTorrLzddG5QuDv2kESKZ95prtl7dJwvXbZAkH5KxSPJy
        V/7kwRNeuQ78QhZqDs8eDYA7RIu8mzDifw==
X-Google-Smtp-Source: ABdhPJwKkG/GbjFLMYIiBw2AEvIb11TKELC7Wfqrc9ytog4ItRkkpycxrhY0jtUULm68kp/amxZLfA==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id f18-20020a7bcc12000000b0037c01ae100amr13789784wmh.54.1647563650130;
        Thu, 17 Mar 2022 17:34:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to "test_expect_failure"
Date:   Fri, 18 Mar 2022 01:33:56 +0100
Message-Id: <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an alternative to the "test_expect_failure" function. Like
"test_expect_failure" it will marks a test as "not ok ... TODO" in the
TAP output, and thus document that it's a "TODO" test that fails
currently.

Unlike "test_expect_failure" it asserts that the tested code in
exactly one manner, and not any other. We'll thus stop conflating
e.g. segfaults with other sorts of errors, and generally be able to
tell if our "expected to fail" tests start failing in new and
unexpected ways.

In more detail, the these problems of "test_expect_failure" are solved
by this new function.

 * When "test_expect_failure" is used in combination with
   "test_{must,might}_fail" it will hide segfaults or abort()
   failures, such as failures due to LSAN.

   This is because we do do the right thing in those helpers, but they
   themselves are expected to be used within "test_expect_success" and
   return 1. The "test_expect_failure" can't differentiate this from a
   "real" failure.

   We could change "test_{must,might}_fail" to appropriately carry
   forward the status code to work around this specific issue, but
   doing so would be a large semantic change in the current test
   suite.

 * More generally, "test_expect_failure" by design doesn't test what
   does, but just asserts that the test fails in some way.

   For some tests that truly fail in unpredictable ways this behavior
   makes sense, but it's almost never what our tests want. We know we
   e.g. have a revision at HEAD~ instead of HEAD, and would like to
   know conflate that with a potential segfault or other behavior
   change.

In summary, this new function behaves exactly like
"test_expect_success", except that its "success" is then reported as a
"not ok .. TODO".

Let's convert a few "test_expect_failure" uses to the new
"test_expect_todo".

For previous discussion on this topic see [1] and [2], in particular
the points by Junio that it's desired that the "test_expect_failure"
output differentiate the TODO tests from "test_expect_success".

1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/xmqqo824e145.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                     | 20 +++++++++++++++++++-
 t/t0000-basic.sh             | 11 ++++++++---
 t/t1060-object-corruption.sh |  4 ++--
 t/t7815-grep-binary.sh       |  4 ++--
 t/test-lib-functions.sh      | 28 ++++++++++++++++++++++++----
 t/test-lib.sh                | 32 ++++++++++++++++++++++++++++----
 6 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/t/README b/t/README
index f48e0542cdc..e0aa8ebb0eb 100644
--- a/t/README
+++ b/t/README
@@ -805,10 +805,28 @@ see test-lib-functions.sh for the full list and their options.
 	test_expect_success PERL,PYTHON 'yo dawg' \
 	    ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') == "4" '
 
+ - test_expect_todo [<prereq>] <message> <script>
+
+   A "test_expect_success" which on "success" will mark the test as a
+   TODO test, and on failure will emit a real failure.
+
+   This should be used to mark a test whose exact bad behavior is
+   known, but whose outcome isn't preferred, to distinguish it from
+   those tests that use "test_expect_success" to indicate known and
+   preferred behavior.
+
+   Like test_expect_success this function can optionally use a three
+   argument invocation with a prerequisite as the first argument.
+
  - test_expect_failure [<prereq>] <message> <script>
 
    This is NOT the opposite of test_expect_success, but is used
-   to mark a test that demonstrates a known breakage.  Unlike
+   to mark a test that demonstrates a known breakage whose exact failure
+   behavior isn't predictable.
+
+   If the exact breakage is known the "test_expect_todo" function
+   should be used instead. Usethis function if it's hard to pin down
+   the exact nature of the failure. Unlike
    the usual test_expect_success tests, which say "ok" on
    success and "FAIL" on failure, this will say "FIXED" on
    success and "still broken" on failure.  Failures from these
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b007f0efef2..e46638f1f7b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -176,6 +176,8 @@ test_expect_success 'subtest: mixed results: a mixture of all possible results'
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_failure "pretend we have fixed a known breakage" "true"
+	test_expect_todo "pretend we have a known TODO" "true"
+	test_expect_todo "pretend we have a bad TODO" "false"
 	test_done
 	EOF
 	check_sub_test_lib_test mixed-results2 <<-\EOF
@@ -192,10 +194,13 @@ test_expect_success 'subtest: mixed results: a mixture of all possible results'
 	> not ok 8 - pretend we have a known breakage # TODO known breakage
 	> not ok 9 - pretend we have a known breakage # TODO known breakage
 	> ok 10 - pretend we have fixed a known breakage # TODO known breakage vanished
+	> not ok 11 - pretend we have a known TODO # TODO known breakage
+	> not ok 12 - pretend we have a bad TODO (broken '\''test_expect_todo'\''!)
+	> #	false
 	> # 1 known breakage(s) vanished; please update test(s)
-	> # still have 2 known breakage(s)
-	> # failed 3 among remaining 7 test(s)
-	> 1..10
+	> # still have 3 known breakage(s)
+	> # failed 4 among remaining 8 test(s)
+	> 1..12
 	EOF
 '
 
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index bc89371f534..b7023f5644c 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -112,8 +112,8 @@ test_expect_success 'clone --local detects missing objects' '
 	test_must_fail git clone --local missing missing-checkout
 '
 
-test_expect_failure 'clone --local detects misnamed objects' '
-	test_must_fail git clone --local misnamed misnamed-checkout
+test_expect_todo 'clone --local detects misnamed objects' '
+	git clone --local misnamed misnamed-checkout
 '
 
 test_expect_success 'fetch into corrupted repo with index-pack' '
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index ac871287c03..2d17e05036e 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -64,8 +64,8 @@ test_expect_success 'git grep ile a' '
 	git grep ile a
 '
 
-test_expect_failure 'git grep .fi a' '
-	git grep .fi a
+test_expect_todo 'git grep .fi a' '
+	test_must_fail git grep .fi a
 '
 
 test_expect_success 'grep respects binary diff attribute' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..a219b126d93 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -718,11 +718,13 @@ test_verify_prereq () {
 	BUG "'$test_prereq' does not look like a prereq"
 }
 
-test_expect_failure () {
+_test_expect_todo () {
+	local func=$1
+	shift
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
-	BUG "not 2 or 3 parameters to test-expect-failure"
+	BUG "not 2 or 3 parameters to $func"
 	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
@@ -730,14 +732,32 @@ test_expect_failure () {
 		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2" expecting_failure
 		then
-			test_known_broken_ok_ "$1"
+			case "$func" in
+			test_expect_todo) test_known_broken_ok_ "$func" "$1" ;;
+			test_expect_failure) test_known_broken_ok_ "$func" "$1" ;;
+			esac
 		else
-			test_known_broken_failure_ "$1"
+			case "$func" in
+			test_expect_todo)
+				test_title_=$1
+				shift
+				test_failure_ "$test_title_ (broken 'test_expect_todo'!)" "$@"
+				;;
+			test_expect_failure) test_known_broken_failure_ "$func" "$1" ;;
+			esac
 		fi
 	fi
 	test_finish_
 }
 
+test_expect_failure () {
+	_test_expect_todo test_expect_failure "$@"
+}
+
+test_expect_todo () {
+	_test_expect_todo test_expect_todo "$@"
+}
+
 test_expect_success () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9af5fb7674d..fb23a6f6682 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -792,21 +792,45 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
+	local func=$1
+	shift
+
 	if test -n "$write_junit_xml"
 	then
 		write_junit_xml_testcase "$* (breakage fixed)"
 	fi
-	test_fixed=$(($test_fixed+1))
-	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+
+	if test "$func" = "test_expect_todo"
+	then
+		# test_expect_todo
+		test_broken=$(($test_broken+1))
+		say_color warn "not ok $test_count - $@ # TODO known breakage"
+	else
+		# test_expect_failure
+		test_fixed=$(($test_fixed+1))
+		say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	fi
 }
 
 test_known_broken_failure_ () {
+	local func=$1
+	shift
+
 	if test -n "$write_junit_xml"
 	then
 		write_junit_xml_testcase "$* (known breakage)"
 	fi
-	test_broken=$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
+
+	if test "$func" = "test_expect_todo"
+	then
+		# test_expect_todo
+		test_fixed=$(($test_fixed+1))
+		say_color error "not ok $test_count - $@ # TODO a 'known breakage' changed behavior!"
+	else
+		# test_expect_failure
+		test_broken=$(($test_broken+1))
+		say_color warn "not ok $test_count - $@ # TODO known breakage"
+	fi
 }
 
 test_debug () {
-- 
2.35.1.1436.g756b814e59f

