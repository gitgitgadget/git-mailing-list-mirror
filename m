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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B648C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217B064F5D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhBCPi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhBCPga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:36:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C0C061793
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so2992263wri.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uXeiDFAzN5lHNKXhs/cPKyCyGEjIOX0UeKbHlVFvS6U=;
        b=BZHA7l4OwGze3QNT+R6iBYyOP6teTBC40PMk0cB3Ac+cWPOurJ7dEu5n8sbdWnageb
         3/EjjLCm6iyrd3Nveev20SuSPVetsaZuHmGbb9BubTjuVcnhv4gbIFHU+7RuvxnQiYqF
         jY+oOCqkylJtttf9N3F1pHPpygo3zx/WEFb+lUXlHv/RgzxIKDhAna98vcM8hVrW+4dt
         kGQ0KPLeC2/qPfISCJzaPZzFJ+M6ya+iOf7LceZXdhOaLmbYvjo23jNvLc9H5Q/HGMtX
         efO0UNkQJd81gOVEAWCIDoHbhyrsZNJV6yb7vbV0rlW+EwU0sWspEahfaTy1OJRiXZPk
         UT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uXeiDFAzN5lHNKXhs/cPKyCyGEjIOX0UeKbHlVFvS6U=;
        b=IZEKgpnDjvcTNoX0KDwvl33SSh1Cy66urwWRZQJBZ7+QIgtBJH51aG+Pt0EVsTTueN
         PDhJbQVWguufSWqRcO0cBpcs1E/pERKw07EjZodr6p3d9NNh2bWzTb7OkoxReMgioE6V
         ico6svBF7dIhViK0YoF4yNPgsYF+b6wjuHXOJ7t0+kwlpsoRbNUigvRZ39ufFYiSvYsM
         4V2Wo9dPTsjT5o04w9vyeYefZzdqxPgZzWQht9zFFD+O9K1Ir+w/BnXTXckd05KumHO8
         D3WcBPPMtCY7U4DuR4F1nCPIM0mMtu62LUONfO2/yNoLG7FkQmROeMDZnFVU4dsDcJ5O
         u5pw==
X-Gm-Message-State: AOAM530GHAH0Wlnub9KUFfoyyPktPRD7nLtT30sLy2+yYpR9zb9SG7jI
        StcAi+oWaYoAY76F5jhVib+plOklt7Q=
X-Google-Smtp-Source: ABdhPJzWqomelP+AQcBFGGZ85x/Yo9wP1GSglARYaFfVzFUyVYx/GpwQr85GBPkaOTDnEKLOS9PEcw==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr4237825wrq.425.1612366496790;
        Wed, 03 Feb 2021 07:34:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16sm3244070wmi.5.2021.02.03.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:56 -0800 (PST)
Message-Id: <f6ea0a51f50e95d943a33156c3013af97ddda470.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:43 +0000
Subject: [PATCH v2 04/11] p7519: add trace logging during perf test
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
index 78e7d2c03f5..aa0ea0e2ec8 100755
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
@@ -213,6 +241,7 @@ test_fsmonitor_suite() {
 # such as Watchman.
 #
 
+trace_start fsmonitor-watchman
 if test -n "$GIT_PERF_7519_FSMONITOR"; then
 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
 		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
@@ -231,11 +260,13 @@ then
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
@@ -243,5 +274,6 @@ test_expect_success "setup without fsmonitor" '
 '
 
 test_fsmonitor_suite
+trace_stop
 
 test_done
-- 
gitgitgadget

