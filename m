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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53DC432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC00610CC
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhHEKhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbhHEKht (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218CC0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so5885502wrm.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45ZJCHAoA8WMIAkk9sQ3qHCRDCj4NfQvBgXUK6pD24Q=;
        b=diUZbzapP54WN0d4Ld+AfiPnP5JxPoOAObhKM8DBMRnHvR8ZiLEBjHc6C9sbcQxQI+
         ESnTZHaRXHt5E/YVoWW8qkXIm7VeLkg6nMKRL7FIHFug055E+2CwKUfYSysjm5ZdNYg1
         8RvSLoVbU64wNHaKtslgKd5PDgQ/y4dtf6YWY0+Y9Q9Epdd4cA5a0j7U9tmX1h1mfq4h
         qbFUg+bRqiZj9Fp673BXkfr3mjjZrNlW4gNC7MznyuZtEnVdyWFpYE6aTucD9lAbEvGl
         czcWZOAAVK5JjEO5NS7WyZEqlkdFfAUjJpH+BZ92/EZ6zpCfBtXvNF+2CvtDoAKRtuPh
         c45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45ZJCHAoA8WMIAkk9sQ3qHCRDCj4NfQvBgXUK6pD24Q=;
        b=lIYqO5IEYipFvng5LwubNIs/o3gnf6O0Qb64aKLF+d0zmth8iH2nN9AfAESh6q6IZ1
         f6ecymVCz9lMS83OpZXGSQBYL+/d46XiUYOJAAOi7JltkIUYXMFz/bzK6iato4f+Uqle
         L87iZm982CUzZhiXPoWj3uFggvbYjV3qXzVIXj4vE+kWZMow5wqXqxkUcwVFt6lO2k7X
         281tjOZQrgA4yuVOjl1TKt2jvWwAUcX68TSHD2ASULmHao4fupBvi5Cd6bIEKoQhq+Gc
         P2wagKHQ7pz6ncz7OSJL/zUnshdYZBnaTo2jdioIBwZGaBSa1sYbYaYhSyOmXmzEKtwu
         YtKg==
X-Gm-Message-State: AOAM533epuL97EGl0XOgZWhkcSQrBXR8JASIQOtAtzJm+Py21FiG0ipd
        m9ODvScgpuBzu8/9Z8Ak9bndrLPn0rTx3g==
X-Google-Smtp-Source: ABdhPJwCcIa9h9H1Rd586dcfbiRudvNLJqSW39kP9ZwTm3PAyOnt3cQmwEQ43zVfa5kune8cD8hplg==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr4470446wrx.83.1628159852964;
        Thu, 05 Aug 2021 03:37:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:32 -0700 (PDT)
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
Subject: [PATCH v3 1/9] test-lib tests: move "run_sub_test" to a new lib-subtest.sh
Date:   Thu,  5 Aug 2021 12:37:20 +0200
Message-Id: <patch-v3-1.9-3f34420a3e-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
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
index 0000000000..3cfe09911a
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
index cb87768513..a3865dd77b 100755
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
2.33.0.rc0.635.g0ab9d6d3b5a

