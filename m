Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DDAC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB63464E2C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBAWDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhBAWDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:36 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20ABC06178B
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 6so18285357wri.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qDQXfUw79WQ7Mw00tvloo6yvrULHW0pLb4QJBzNWryw=;
        b=hIeWy0f/9E/01GJEPEts5iR7e1AdERKpXI6d7C4Go6QUloubMrNVW5ZuHBC7P2WGB1
         93BODEKLNPDcBMnK22G4lhUncy/SNeTvnjfBssMYWJ8VU7/pboag8OD/sTLNU8pvghtr
         T67OGXeMSmnabwkkGeWZ3A/IPdZOLLX1yG3wT0TlfG9EafLx4Q0bJHRcF0vD/xQDDZjW
         fR3lYJOt2uU9aDAQeDjMffQKLuqvA87e0Njq/cD06ctHpKIyRXY9JZ+84Fgz6e3piR3j
         EzB+7EoCBU9lOBpIB0Vj4Kdr117EBS6WGv/XiiLbOqopt9VP+rD7HVeYbxEE8Er9e/Ep
         vlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qDQXfUw79WQ7Mw00tvloo6yvrULHW0pLb4QJBzNWryw=;
        b=LttKEkjR9ajjjnxxq5pd0UhFjB8guoN7We0LDYmq7sT4z6y35zcJojbCqiRy5bta8f
         tTUI2TGzcncXGfhcjSqCsJX/rVuoybE3QWP3cpAXq3sXL3zgZ4ZfbABpNza5hYYE+8G9
         IKnNKTd0jUkJvRbjgtPWvQATClbaV8ZKXPQ5PmTamnL5f7IdiL4m1Di6dljh91NhOkDy
         mva376Qidim5nnnUqagrJUeZzMXuElBz5wfJLT6lUzcxCfw2V1ShSj7jwEz3khJ90QuJ
         IcULN+ZybNQCCPJdNIJOL5eH8Q02eP+LhGU+NhXCH7Dyedkf8Rc1GR9WAELdtZzb82do
         1dAA==
X-Gm-Message-State: AOAM532FZvrebanymoFwHOZA0/lYAL9B2cyEdX5Q9jmB2Yjt2rIPSkB7
        RwfFmwyRuyqnSE/a/c5cvGW8i70A4rI=
X-Google-Smtp-Source: ABdhPJyahUumIiYlQ3MVrcNl9040vVX9f5LsDnXtbfbt+YloBwl+3PHazoBEJVBR+9xnryUU5CQVsA==
X-Received: by 2002:adf:814f:: with SMTP id 73mr20270174wrm.368.1612216947323;
        Mon, 01 Feb 2021 14:02:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm621335wmh.9.2021.02.01.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:26 -0800 (PST)
Message-Id: <8de9985a706675ff41a3549ce00dd42a9dc92c88.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:13 +0000
Subject: [PATCH 04/11] p7519: add trace logging during perf test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add optional trace logging to allow us to better compare performance of
various fsmonitor providers and compare results with non-fsmonitor runs.

Currently, this includes Trace2 logging, but may be extended to include
other trace targets, such as GIT_TRACE_FSMONITOR if desired.

Using this logging helped me explain an odd behavior on MacOS where the
kernel was dropping events and causing the hook to Watchman to timeout.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/.gitignore         |  1 +
 t/perf/Makefile           |  4 ++--
 t/perf/p7519-fsmonitor.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/t/perf/.gitignore b/t/perf/.gitignore
index 982eb8e3a94..72f5d0d3148 100644
--- a/t/perf/.gitignore
+++ b/t/perf/.gitignore
@@ -1,3 +1,4 @@
 /build/
 /test-results/
+/test-trace/
 /trash directory*/
diff --git a/t/perf/Makefile b/t/perf/Makefile
index fcb0e8865e4..2465770a782 100644
--- a/t/perf/Makefile
+++ b/t/perf/Makefile
@@ -7,10 +7,10 @@ perf: pre-clean
 	./run
 
 pre-clean:
-	rm -rf test-results
+	rm -rf test-results test-trace
 
 clean:
-	rm -rf build "trash directory".* test-results
+	rm -rf build "trash directory".* test-results test-trace
 
 test-lint:
 	$(MAKE) -C .. test-lint
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 45bbba3c92f..e6724d3604b 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -32,6 +32,8 @@ test_description="Test core.fsmonitor"
 #
 # GIT_PERF_7519_DROP_CACHE: if set, the OS caches are dropped between tests
 #
+# GIT_PERF_7519_TRACE: if set, enable trace logging during the test.
+#   Trace logs will be grouped by fsmonitor provider.
 
 test_perf_large_repo
 test_checkout_worktree
@@ -70,6 +72,32 @@ then
 	fi
 fi
 
+trace_start() {
+	if test -n "$GIT_PERF_7519_TRACE"
+	then
+		name="$1"
+		TEST_TRACE_DIR="$TEST_OUTPUT_DIRECTORY/test-trace/p7519/"
+		echo "Writing trace logging to $TEST_TRACE_DIR"
+
+		mkdir -p "$TEST_TRACE_DIR"
+
+		# Start Trace2 logging and any other GIT_TRACE_* logs that you
+		# want for this named test case.
+
+		GIT_TRACE2_PERF="$TEST_TRACE_DIR/$name.trace2perf"
+		export GIT_TRACE2_PERF
+
+		>"$GIT_TRACE2_PERF"
+	fi
+}
+
+trace_stop() {
+	if test -n "$GIT_PERF_7519_TRACE"
+	then
+		unset GIT_TRACE2_PERF
+	fi
+}
+
 test_expect_success "one time repo setup" '
 	# set untrackedCache depending on the environment
 	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
@@ -203,6 +231,7 @@ test_fsmonitor_suite() {
 # such as Watchman.
 #
 
+trace_start fsmonitor-watchman
 if test -n "$GIT_PERF_7519_FSMONITOR"; then
 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
 		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
@@ -221,11 +250,13 @@ then
 	# preventing the removal of the trash directory
 	watchman shutdown-server >/dev/null 2>&1
 fi
+trace_stop
 
 #
 # Run a full set of perf tests with the fsmonitor feature disabled.
 #
 
+trace_start fsmonitor-disabled
 test_expect_success "setup without fsmonitor" '
 	unset INTEGRATION_SCRIPT &&
 	git config --unset core.fsmonitor &&
@@ -233,5 +264,6 @@ test_expect_success "setup without fsmonitor" '
 '
 
 test_fsmonitor_suite
+trace_stop
 
 test_done
-- 
gitgitgadget

