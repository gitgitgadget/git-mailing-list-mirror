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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC65C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620B8610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhIVLVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhIVLV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:21:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB9C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:19:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d21so5534992wra.12
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRcpz/BsKSq7DKPtDQ71dXzraDde+VEmQTRnXJzcGa0=;
        b=BagWvDsvY6yTiWaEeWGW06sNScyxgnSLUJcQXE9IHdppyueFnmnU5FRrHgZjd42MfZ
         nLtIZjYGm3Vah+8sWKfwsQzPEZY+AWmTCrXQTEd4VqUSRa25Z+PsC7AoL1+AhcHb5/Mh
         wG0cy8MG96CqmNc1W6WIXnUylvycFqfCKIgVKhETc0gn+oR4UgLNKK7qD48b7BEqa+1e
         j8M4SKZK39m6EmRHmtobYI4qwEUfL0ouJPHK5mOFPgdxWWVusjUSOOmQjwYBRgDL6WQq
         7TorPMg43vkYUrGeCClg4NED9Cup6aoAGKLvsDmRY3XxQ2vk2u060dF0YADqCelS4HWr
         Hu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRcpz/BsKSq7DKPtDQ71dXzraDde+VEmQTRnXJzcGa0=;
        b=qOw0FNlT7PSj9RvGcUy3sWjudkdbXgYRZZbqDoM/9ZeToOUTryC8HoW2yqrgAiYKv1
         GQw7OPhxPsXErRp2bKqjz+Tl/qwkPDyE+Ni01DcKY58gRup0DA6lHUD6Jhj+Zd68r7VD
         jPT9DiqG4Uv2GzkZB+bARbk1BSz+/XlrlWXSqG73BblipqFaqboMOjGz6/3tewUM8aY+
         Ag24xVGUngoWj62XllsJXH8ex6NG1UC9pKSuVhpUEyb/mmnQ3V6ac//6Ta2PKVC4RUcM
         Uz3h+mbH2f9x+p3IpCAff0Xz3zalDf235yAJJSxu2gpG+8SVD5hMo4nUe/sWgWzWrDWa
         pDFQ==
X-Gm-Message-State: AOAM531NaEoOJfWIMx/xGW2dFt5qnFwaXo45y1F7A1rg1Rqs2HacCAHS
        HrEEix2JEI+oQlK4OfFfrakjCQ3WkQD/KA==
X-Google-Smtp-Source: ABdhPJyLOKC1/RBqMhSrQnSF9ID6wRfNKw//iVYQr75EVT1Wtiz/4djVLobMsyMrA8yRXElgwEP22w==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr9524837wmj.16.1632309598215;
        Wed, 22 Sep 2021 04:19:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d70sm1679165wmd.3.2021.09.22.04.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:19:57 -0700 (PDT)
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
Subject: [PATCH v4 1/7] test-lib tests: move "run_sub_test" to a new lib-subtest.sh
Date:   Wed, 22 Sep 2021 13:19:47 +0200
Message-Id: <patch-v4-1.7-f915bc2ee77-20210922T111734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
References: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
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
2.33.0.1225.g9f062250122

