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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C17AC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773B4619A5
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhFNK4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFNKyC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:54:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CBCC061198
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12702961wmh.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KckFsgAJ784WiKcsCjXvcbeAZh2NWCdyNvrwqK6wpd8=;
        b=MFnBn6ZUNego8SlE21XqKLKgrrGdmC1UsG+0bK8O8SiFYyhN/pbsurH2LsW3Z8+odS
         cu9IA+vLGjANlsRm+IxPum4SOU/S1gsu99x9Z42DSUAhU26Agf7/ErwjXKEw7mUi7nmE
         fklIw9K8riC3LZSzBvJ50FOsF8kc/RQYnzOZDOsEGLFcUqMuYdym9sT2aRPJUpmura3k
         eoF6rYiHc5c0qcA5queKwbTXeWquh1j8TfUHwC5JDNckDvaerfZttX96spWHb2LH5VPa
         LLBYCIXLFdk6pUb0mmMRnhMtfz563M+3UCLmFPsAsmo/dSCZBDUhiJs/Nl0kC146gKca
         q4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KckFsgAJ784WiKcsCjXvcbeAZh2NWCdyNvrwqK6wpd8=;
        b=tUKVmoEAZxntgyzcvqTCsOV9D4cUI539CObGqKWP65DGKWeE7DvSc7MI7t1MnK8V95
         tMhXqd/8JmsVahbhRpQzIh72bHnPUYb7ewNgKP6q8WUQ83NtWgI1w6Lvi/ktt71Avly7
         6uieSWetp547BLDgfTwWSOSEQ9NJI46lcacq7lhN/Tt/W3Rv6C6mp5xjv4CBZ8Jb3aCm
         JMIDHhEwXYLwAAYWgX40Pwn7Rh+XBDb6+pCO+YDhga99uNwuvdIrxALdKe1kiufYMVsZ
         RNYniTd/8JILDGKJcoZM7OcnvDlscDY3MwBH9u03Hmw84A8JVBKq9gSd8uKmWkKLJU2X
         hEww==
X-Gm-Message-State: AOAM530+gByF96G8JAjXGmIAc9HEyWSF5fFBbIzda8yJG9oywtyFFSA6
        XsGNSrxm0Finuwio4poqAc8K7MhMDvT25Q==
X-Google-Smtp-Source: ABdhPJz97Bg8XikE/dAaAaMxjMKLdOIvJj8OLVYnsI9/Gl3qZSRNoZGPFVErv4lwoPUuEtrv/pVXwg==
X-Received: by 2002:a05:600c:2dcf:: with SMTP id e15mr32170354wmh.117.1623667700268;
        Mon, 14 Jun 2021 03:48:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:19 -0700 (PDT)
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
Subject: [PATCH 1/8] test-lib tests: move "run_sub_test" to a new lib-subtest.sh
Date:   Mon, 14 Jun 2021 12:48:07 +0200
Message-Id: <patch-1.8-3c0a78530d2-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
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
 t/lib-subtest.sh | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t0000-basic.sh | 66 +-----------------------------------------------
 2 files changed, 65 insertions(+), 65 deletions(-)
 create mode 100644 t/lib-subtest.sh

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
new file mode 100644
index 00000000000..0c613e00da3
--- /dev/null
+++ b/t/lib-subtest.sh
@@ -0,0 +1,64 @@
+_run_sub_test_lib_test_common () {
+	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
+	shift 3
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
+		TEST_OUTPUT_DIRECTORY=$(pwd) &&
+		export TEST_OUTPUT_DIRECTORY &&
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
index 2c6e34b9478..72809477645 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -19,6 +19,7 @@ modification *should* take notice and update the test vectors here.
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-subtest.sh
 
 try_local_xy () {
 	local x="local" y="alsolocal" &&
@@ -66,71 +67,6 @@ test_expect_success 'success is reported like this' '
 	:
 '
 
-_run_sub_test_lib_test_common () {
-	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
-	shift 3
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
-		TEST_OUTPUT_DIRECTORY=$(pwd) &&
-		export TEST_OUTPUT_DIRECTORY &&
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
2.32.0.rc3.434.gd8aed1f08a7

