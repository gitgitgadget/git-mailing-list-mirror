Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C8C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84CA61414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhGAOut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhGAOuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635BC0613E2
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u8so8569289wrq.8
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WsvE8w2+xndu9RcmlXA2qQ7mMyfEJgy5keLnSjpuVzY=;
        b=gowvMbnh/cWOg2+lbHdLPJUt85p0erkCwlsWvpPgn9NcUcP+Tm2y8zdL+3hmnneM8K
         b83P+yygTLTklDDxIAQobAve2mChJAH8b0tv7lgCyzrCWoKotZUwLvzLcUimE1rnOAwU
         x8Uaf1LQhGQUL0NJuUq3gGxCjeedzEdP/kE5TEiqz5uGoy3XGF9MZ41Zv+23CSMj7v4c
         IiwbNJTtsDllQXDz4hHS0qxyYLSZLG/65LyM/vkTo/DTMV9neIaiNZ4YxEkqI3U/06RO
         ASH0inqQsc20/rcSSKmnmRAGzmuUmsQvJKsz9k3ztCK4ZgIYm8Q9Lktvi7kSDAiGcgdM
         v00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WsvE8w2+xndu9RcmlXA2qQ7mMyfEJgy5keLnSjpuVzY=;
        b=tQtT8bvCTHTTWCgQ2ipmcgambZdMewsclRyakjLL7E7va9U0yq0GLPl2rROmAvQsko
         nREEZjJyFeq+KgQCiq1z+khIBWSOrNzyWXUQcAONb4BOP7NwZteh2uBYBngMyrLdp97e
         ujV+HZiUMXv5uaiUc/EMjGzXRlWA7U/pUIKkEu4mqnvTQMlGJZGw/1wpuMpdyTTaL9d3
         s8klEQMMWeTX4lqG1VQZrLwKzWfqI+hGZ8RPlFbzwdk72dnWw0z8ycLSG18omhQ0Nh/P
         AsOPvwknPIgiDTXxixRLbbgMQ+gV1z/SZ8Vn57TIKtSR0DQKIMJWPD7/WIg6hxuQtTU7
         giuw==
X-Gm-Message-State: AOAM5328bdpOxGPMh3ZJt0o/2mTkjjjhfIwO16Ov6qHZ95eq1o9Fzz/1
        hNiotyGBUP3FwUk+inrJeoxQeAZ3u0k=
X-Google-Smtp-Source: ABdhPJxOlzL5yCKOFxMbZXTikpjKMD0W6UCyh4eFLyL2M3YwH+HKPgAZz0aO1xWdW8y7FfifBFTezA==
X-Received: by 2002:adf:e384:: with SMTP id e4mr30071538wrm.317.1625150880611;
        Thu, 01 Jul 2021 07:48:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm137186wrs.73.2021.07.01.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:00 -0700 (PDT)
Message-Id: <de517a8259a6eaba353f7e1023cb97c95734d6b2.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:36 +0000
Subject: [PATCH v3 26/34] t/perf/p7519: add fsmonitor--daemon test cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index f74e6014a0a..3a3fc5748ae 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -24,7 +24,8 @@ test_description="Test core.fsmonitor"
 # GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
 # GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor. May be an
 #   absolute path to an integration. May be a space delimited list of
-#   absolute paths to integrations.
+#   absolute paths to integrations.  (This hook or list of hooks does not
+#   include the built-in fsmonitor--daemon.)
 #
 # The big win for using fsmonitor is the elimination of the need to scan the
 # working directory looking for changed and untracked files. If the file
@@ -136,10 +137,16 @@ test_expect_success "one time repo setup" '
 
 setup_for_fsmonitor() {
 	# set INTEGRATION_SCRIPT depending on the environment
-	if test -n "$INTEGRATION_PATH"
+	if test -n "$USE_FSMONITOR_DAEMON"
 	then
+		git config core.useBuiltinFSMonitor true &&
+		INTEGRATION_SCRIPT=false
+	elif test -n "$INTEGRATION_PATH"
+	then
+		git config core.useBuiltinFSMonitor false &&
 		INTEGRATION_SCRIPT="$INTEGRATION_PATH"
 	else
+		git config core.useBuiltinFSMonitor false &&
 		#
 		# Choose integration script based on existence of Watchman.
 		# Fall back to an empty integration script.
@@ -175,7 +182,10 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite() {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -283,4 +293,25 @@ test_expect_success "setup without fsmonitor" '
 test_fsmonitor_suite
 trace_stop
 
+#
+# Run a full set of perf tests using the built-in fsmonitor--daemon.
+# It does not use the Hook API, so it has a different setup.
+# Explicitly start the daemon here and before we start client commands
+# so that we can later add custom tracing.
+#
+if test_have_prereq FSMONITOR_DAEMON
+then
+	USE_FSMONITOR_DAEMON=t
+
+	trace_start fsmonitor--daemon--server
+	git fsmonitor--daemon start
+
+	trace_start fsmonitor--daemon--client
+	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget

