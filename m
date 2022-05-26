Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC3C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiEZAbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346498AbiEZAba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:31:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966929C2C4
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:31:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so262107wrc.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhSLr/ARCNLGg3E1XcXPb9ykr7D9tRTMneatbwArKzw=;
        b=RMcWTY2w6VTWkpfHgBEE8jDvTm9ndlUMe7EBnF1DtF/I5R1Qm9oXsVvyOhDYIHYQcj
         3OnEHtl9Q51bBUcelCpTTk5IRfA00RmqliHpoVmueiaDivgn+HRvIpxukf8RaiYzk+rM
         EzAcbCyRz6tvdaGc5eXnhM/QtgoLRTxjqorDyrjJd17R5P4oBDojlrIqZon2RciDoQ/G
         3naogIxXcSL5X6uvH/OS2p/SQfson/MMk4V+Oo/G4FZMf4dW9MFcB0QLhnfi5Mi2mASE
         HmI8EedPU+RLxEl1ruQ7Cjcy+eVrydLh6brDroR1dGZ6mK4HHMYG85x56+qxArdVgli4
         mGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhSLr/ARCNLGg3E1XcXPb9ykr7D9tRTMneatbwArKzw=;
        b=GRbuI0dTVWTDiWIIK6PtLIcFsudV6GPXLjmMg9vMk2jV+YfXtwtOhhBNmYYJgpBB7v
         HJezHwPHYZwvKVQ/WkhnaOB9+usQy5+asIEHXc2kyc1RmracZZgj1qWcCZT7U/IjOZ3r
         Jc+H0GyTEEXaqTqExbLHl3WN6Jn6m0oM/xZPwUHLYBLWEAOU7r513X7+2s7cD3HJ2xGr
         m1kO4oTounEiBjLARxC8o0GaD1aR5df7aI3MNw10LkQjXwJEVbepffHdMTbVUH+vE1/e
         poTim5AhKr1pQ9WrETUosAegl0TDcrWBbeSyKqostVOZ46Dy9MMslAo82ofq3qvsSg+w
         yq1Q==
X-Gm-Message-State: AOAM531deG4FjyqMhLxp8dtS4QYDP4tanYVC3+RygozQ1UUcF4K5psBK
        rnhpmnO675h6hw2kp7x1jPALLvAwkhEetA==
X-Google-Smtp-Source: ABdhPJx/IW4mCHrztI0wO9tapqvKmylvOThaEti9SJumwgayP+Eab9g2+diy9H4T4zLCyKJ8dJd9Bw==
X-Received: by 2002:a05:6000:2ab:b0:210:8ea:ddb0 with SMTP id l11-20020a05600002ab00b0021008eaddb0mr980202wry.257.1653525086856;
        Wed, 25 May 2022 17:31:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003973c54bd69sm3138968wmb.1.2022.05.25.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:31:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
Date:   Thu, 26 May 2022 02:30:42 +0200
Message-Id: <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
In-Reply-To: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the BUG() function invoked be "test-tool" to be the "real" one,
instead of one that avoids producing core files. In
a86303cb5d5 (test-tool: help verifying BUG() code paths, 2018-05-02)
to test the (then recently added) BUG() function we faked up the
abort() in favor of an exit with code 99.

However, in doing so we've been fooling ourselves when it comes to
what trace2 events we log. The events tested for in
0a9dde4a04c (usage: trace2 BUG() invocations, 2021-02-05) are not the
real ones, but those that we emit only from the "test-tool".

Let's just stop faking it, and call abort(). As a86303cb5d5 notes this
will produce core files on some OS's, but as the default behavior for
that is to dump them in the current directory they'll be placed in the
trash directory that we'll shortly me "rm -rf"-ing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

There's a CI problem with the test_must_BUG wrapper here on Windows:
https://github.com/avar/git/runs/6602059183?check_suite_focus=true#step:6:1361

 t/helper/test-tool.c           |  1 -
 t/t0210-trace2-normal.sh       |  4 +---
 t/t1406-submodule-ref-store.sh | 10 +++++-----
 t/test-lib-functions.sh        | 13 +++++++++++++
 usage.c                        |  5 -----
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0424f7adf5d..99a10f294f5 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -110,7 +110,6 @@ int cmd_main(int argc, const char **argv)
 		OPT_END()
 	};
 
-	BUG_exit_code = 99;
 	argc = parse_options(argc, argv, NULL, options, test_tool_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_KEEP_ARGV0);
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 37c359bd5a2..910a6af8058 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -155,15 +155,13 @@ test_expect_success 'normal stream, error event' '
 
 test_expect_success 'BUG messages are written to trace2' '
 	test_when_finished "rm trace.normal actual expect" &&
-	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
+	test_must_BUG env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 007bug
 		cmd_name trace2 (trace2)
 		error the bug message
-		exit elapsed:_TIME_ code:99
-		atexit elapsed:_TIME_ code:99
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index e6a7f7334b6..6f9a16b7355 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -25,15 +25,15 @@ test_expect_success 'pack_refs() not allowed' '
 '
 
 test_expect_success 'create_symref() not allowed' '
-	test_must_fail $RUN create-symref FOO refs/heads/main nothing
+	test_must_BUG $RUN create-symref FOO refs/heads/main nothing
 '
 
 test_expect_success 'delete_refs() not allowed' '
-	test_must_fail $RUN delete-refs 0 nothing FOO refs/tags/new-tag
+	test_must_BUG $RUN delete-refs 0 nothing FOO refs/tags/new-tag
 '
 
 test_expect_success 'rename_refs() not allowed' '
-	test_must_fail $RUN rename-ref refs/heads/main refs/heads/new-main
+	test_must_BUG $RUN rename-ref refs/heads/main refs/heads/new-main
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
@@ -89,11 +89,11 @@ test_expect_success 'reflog_exists(HEAD)' '
 '
 
 test_expect_success 'delete_reflog() not allowed' '
-	test_must_fail $RUN delete-reflog HEAD
+	test_must_BUG $RUN delete-reflog HEAD
 '
 
 test_expect_success 'create-reflog() not allowed' '
-	test_must_fail $RUN create-reflog HEAD
+	test_must_BUG $RUN create-reflog HEAD
 '
 
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 93c03380d44..61f1f03c099 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1167,6 +1167,9 @@ test_must_fail () {
 	then
 		echo >&4 "test_must_fail: command succeeded: $*"
 		return 1
+	elif test_match_signal 6 $exit_code && list_contains "$_test_ok" sigabrt
+	then
+		return 0
 	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
 	then
 		return 0
@@ -1186,6 +1189,16 @@ test_must_fail () {
 	return 0
 } 7>&2 2>&4
 
+# The test_must_BUG() function is a wrapper for test_must_fail which
+# checks that we BUG() out.
+#
+# Currently this checks that we exit with abort(), but in the future
+# we might e.g. check the trace2 logging itself, or otherwise make
+# sure that we used BUG() in particular.
+test_must_BUG () {
+	test_must_fail ok=sigabrt "$@"
+} 7>&2 2>&4
+
 # Similar to test_must_fail, but tolerates success, too.  This is
 # meant to be used in contexts like:
 #
diff --git a/usage.c b/usage.c
index b738dd178b3..bf868b5be1f 100644
--- a/usage.c
+++ b/usage.c
@@ -287,9 +287,6 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
 
-/* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
-int BUG_exit_code;
-
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
 {
 	char prefix[256];
@@ -309,8 +306,6 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 
 	trace2_cmd_error_va(fmt, params_copy);
 
-	if (BUG_exit_code)
-		exit(BUG_exit_code);
 	abort();
 }
 
-- 
2.36.1.1046.g586767a6996

