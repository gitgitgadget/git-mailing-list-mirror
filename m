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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F09C6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57DC6127C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhGUWRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhGUWRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B34C061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l6so2249104wmq.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtdU5nEPFSFO4vDTc8tv0rUkhERuOnv7sYNyEiZODEU=;
        b=BlZyYYNyWhPTyV4KI7riwVVivSFHehshYJMV53zC8SATXmYh5aWUqUkuV/aXj/zuOt
         tjIjctKf5R1FeacgIXWbbAS6gmpls71cTNEh/xZwvjcRBKPnDvJstw/t6gjibj6eebVA
         2R9YutjKo0ekRHRwYeDpkqnFKh/hAdUhnlZutYm6FeuD6gxaCV5ROMKVXunB10wE7OIy
         smZKruLEjb5FvwZ89FD818R/OBiFuUn+mFOsKAcdw0zWU1C1aA19zdVAetK4krpg0MYr
         PWytIBsT46gAFgbUsNrPKA3CI+7Jo3V1UHmWGB8OKm6+kssgwyyQ0kBbLTdPgrq+ZKNV
         ygXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtdU5nEPFSFO4vDTc8tv0rUkhERuOnv7sYNyEiZODEU=;
        b=Uy01ahN6+5yF/Rhkn5s8nZL0exO9sUn4DfBD2db/QfiewPMVKyLNUzTUTB50/EkVsc
         I5REiVqPtkOFqAy+wEBxyvBbXKcXOVBsD0zeeSgQ74B90+2V8VcH4ZR2WJf7PsweX2Ln
         6oZD5TfD9yM9SmRMmDkr6t2MKTg32YSJzzg4cStExvQcJRAfB1UJU3zjFi5qkmza6Uu2
         Z11n150fT6m4w8BLH1PX+DAaeQv+pZerq5VjvUX3afNNhQl5pLDjBIXEnEFAPWyHOzaP
         YIopYu8meJGodvJXonvz5dDCQvVKDBTT5iB9LGq4qj1xOPhlamaO2I9B0aAMlVxCx2he
         HPnA==
X-Gm-Message-State: AOAM533u42tTyMkKvdI7A9Oe4loC5EiGcuYHjLWs8E7Hc0N7be11xhxJ
        Wkn3uglK50PesyIb8LYuHIMYP1lbR07gGA==
X-Google-Smtp-Source: ABdhPJzKQ2rKNArDuHpWibM8QRD9HORSyQ6Ygc5jzWXlFgu7hNSBvmNPLSUDZD+dFSf14jQRjFm8PQ==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr39540276wmc.14.1626908305295;
        Wed, 21 Jul 2021 15:58:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18sm23129818wmk.37.2021.07.21.15.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:24 -0700 (PDT)
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
Subject: [PATCH v2 1/8] test-lib tests: move "run_sub_test" to a new lib-subtest.sh
Date:   Thu, 22 Jul 2021 00:57:40 +0200
Message-Id: <patch-1.8-7a06ea3a7b7-20210721T225504Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com> <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "check_sub_test_lib_test()" and its sister functions to a new
lib-subtest.sh.

In the future (not in this series) I'd like to test test-lib's output
in a more targeted and smaller test, and I'll need these functions to
do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t0000-basic.sh | 88 +-----------------------------------------------
 2 files changed, 87 insertions(+), 87 deletions(-)
 create mode 100644 t/lib-subtest.sh

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
new file mode 100644
index 00000000000..3cfe09911a2
--- /dev/null
+++ b/t/lib-subtest.sh
@@ -0,0 +1,86 @@
+_run_sub_test_lib_test_common () {
+	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
+	shift 3
+
+	# intercept pseudo-options at the front of the argument list that we
+	# will not pass to child script
+	skip=
+	while test $# -gt 0
+	do
+		case "$1" in
+		--skip=*)
+			skip=${1#--*=}
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+
+	mkdir "$name" &&
+	(
+		# Pretend we're not running under a test harness, whether we
+		# are or not. The test-lib output depends on the setting of
+		# this variable, so we need a stable setting under which to run
+		# the sub-test.
+		sane_unset HARNESS_ACTIVE &&
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
+		cat >>"$name.sh" &&
+		export TEST_DIRECTORY &&
+		# The child test re-sources GIT-BUILD-OPTIONS and may thus
+		# override the test output directory. We thus pass it as an
+		# explicit override to the child.
+		TEST_OUTPUT_DIRECTORY_OVERRIDE=$(pwd) &&
+		export TEST_OUTPUT_DIRECTORY_OVERRIDE &&
+		GIT_SKIP_TESTS=$skip &&
+		export GIT_SKIP_TESTS &&
+		sane_unset GIT_TEST_FAIL_PREREQS &&
+		if test -z "$neg"
+		then
+			./"$name.sh" "$@" >out 2>err
+		else
+			! ./"$name.sh" "$@" >out 2>err
+		fi
+	)
+}
+
+run_sub_test_lib_test () {
+	_run_sub_test_lib_test_common '' "$@"
+}
+
+run_sub_test_lib_test_err () {
+	_run_sub_test_lib_test_common '!' "$@"
+}
+
+check_sub_test_lib_test () {
+	name="$1" # stdin is the expected output from the test
+	(
+		cd "$name" &&
+		test_must_be_empty err &&
+		sed -e 's/^> //' -e 's/Z$//' >expect &&
+		test_cmp expect out
+	)
+}
+
+check_sub_test_lib_test_err () {
+	name="$1" # stdin is the expected output from the test
+	# expected error output is in descriptor 3
+	(
+		cd "$name" &&
+		sed -e 's/^> //' -e 's/Z$//' >expect.out &&
+		test_cmp expect.out out &&
+		sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
+		test_cmp expect.err err
+	)
+}
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cb87768513c..a3865dd77ba 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -19,6 +19,7 @@ modification *should* take notice and update the test vectors here.
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-subtest.sh
 
 try_local_xy () {
 	local x="local" y="alsolocal" &&
@@ -66,93 +67,6 @@ test_expect_success 'success is reported like this' '
 	:
 '
 
-_run_sub_test_lib_test_common () {
-	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
-	shift 3
-
-	# intercept pseudo-options at the front of the argument list that we
-	# will not pass to child script
-	skip=
-	while test $# -gt 0
-	do
-		case "$1" in
-		--skip=*)
-			skip=${1#--*=}
-			shift
-			;;
-		*)
-			break
-			;;
-		esac
-	done
-
-	mkdir "$name" &&
-	(
-		# Pretend we're not running under a test harness, whether we
-		# are or not. The test-lib output depends on the setting of
-		# this variable, so we need a stable setting under which to run
-		# the sub-test.
-		sane_unset HARNESS_ACTIVE &&
-		cd "$name" &&
-		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
-		test_description='$descr (run in sub test-lib)
-
-		This is run in a sub test-lib so that we do not get incorrect
-		passing metrics
-		'
-
-		# Point to the t/test-lib.sh, which isn't in ../ as usual
-		. "\$TEST_DIRECTORY"/test-lib.sh
-		EOF
-		cat >>"$name.sh" &&
-		export TEST_DIRECTORY &&
-		# The child test re-sources GIT-BUILD-OPTIONS and may thus
-		# override the test output directory. We thus pass it as an
-		# explicit override to the child.
-		TEST_OUTPUT_DIRECTORY_OVERRIDE=$(pwd) &&
-		export TEST_OUTPUT_DIRECTORY_OVERRIDE &&
-		GIT_SKIP_TESTS=$skip &&
-		export GIT_SKIP_TESTS &&
-		sane_unset GIT_TEST_FAIL_PREREQS &&
-		if test -z "$neg"
-		then
-			./"$name.sh" "$@" >out 2>err
-		else
-			! ./"$name.sh" "$@" >out 2>err
-		fi
-	)
-}
-
-run_sub_test_lib_test () {
-	_run_sub_test_lib_test_common '' "$@"
-}
-
-run_sub_test_lib_test_err () {
-	_run_sub_test_lib_test_common '!' "$@"
-}
-
-check_sub_test_lib_test () {
-	name="$1" # stdin is the expected output from the test
-	(
-		cd "$name" &&
-		test_must_be_empty err &&
-		sed -e 's/^> //' -e 's/Z$//' >expect &&
-		test_cmp expect out
-	)
-}
-
-check_sub_test_lib_test_err () {
-	name="$1" # stdin is the expected output from the test
-	# expected error output is in descriptor 3
-	(
-		cd "$name" &&
-		sed -e 's/^> //' -e 's/Z$//' >expect.out &&
-		test_cmp expect.out out &&
-		sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
-		test_cmp expect.err err
-	)
-}
-
 test_expect_success 'pretend we have a fully passing test suite' '
 	run_sub_test_lib_test full-pass "3 passing tests" <<-\EOF &&
 	for i in 1 2 3
-- 
2.32.0.955.ge7c5360f7e7

