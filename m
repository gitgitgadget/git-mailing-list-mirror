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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77252C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D1664ED0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBAWDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBAWDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FDEC06178A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so18308259wrz.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QaBEdmofcLQH4ouMaDZ+kun2sLA/BizWGuUSgFtOJtI=;
        b=qdg9kpzsfjhTaSpcjdZS/kFr1dIem+6CFwQ5C4si1PThR3t0bFs3OQFX7ti32D9S4q
         bBNWfjTwaGvkVlsV4EJ+yGOb0vwCMMDj0t3HN2IGuhQDczwukyRr3rxL/o7pc9ndfcvl
         9emZxDvXgd4REhVNk2f/Sn+kbhEWpSqtkwpD25V5n3UPH7AMhaRJRnlVVUIJLa0RmsoD
         t3WC1zlqSC48ePzwgDA7lO4yfWlBFPIn2ExpEuZwG1Wv+d6UW9f2NyTEo4CcRGsZzZk8
         icLCz0qHHmFlVSC+hUYi/N0feuE1XgjHUjXXiwWji/PRz4kv+KJeaKTtCDKtO7k3yicy
         YNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QaBEdmofcLQH4ouMaDZ+kun2sLA/BizWGuUSgFtOJtI=;
        b=AWibb48IrM5eqOO4M/1wmLnyMPRzwSJyFsGhvC9prS+BN0+rMGyDoeIcSJVg+0bnWk
         U4K4DC+lL7c7iW72umtmA4ZX+nnPMtYXPJJXO4AFITMXZ2ZMSYgfUjjfB/0uLNVnTnBr
         O9sw3iB1jpCBHt80AjfEOF1KRmgD5uAx71v+PMffNDxyiRISo9lUjCayHzx/aOcSC35T
         DxTMVA7NO1lezHNOBsmn6qXqr+fXpS/Fy/+r7beKROpW0aIIEHcexOmnB30yb0XLlo/X
         rAZ8YfoOatVcYpXfgZkGf07mSU2dkY2FZ2zuVVU+ykDnCvJODaYtaAW68a4+I8V62gOy
         I18g==
X-Gm-Message-State: AOAM533TbTV5qUFCyiAdy8RdhvWIpMFwoL2pGfkJCqcNnLKTlIvvHMBP
        LUAW0NTJ8wRuSDNPvf0K8/z/lc9oG14=
X-Google-Smtp-Source: ABdhPJw5KKotNFRQhTJ3EyIUWqFFbcwIgg9yFCy61Tr1S13yJ8hWKfW5nJ3noEIXusRnd8PhMwf0cw==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr20209855wrq.213.1612216946400;
        Mon, 01 Feb 2021 14:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm28454438wrx.93.2021.02.01.14.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:25 -0800 (PST)
Message-Id: <2af6858716f161a12acda7f07e74b0dfed03101b.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:12 +0000
Subject: [PATCH 03/11] p7519: move watchman cleanup earlier in the test
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

Shutdown Watchman after the Watchman-based tests and before the block of
"no fsmonitor" tests.

This helps ensure that Watchman cannot affect the test results for the
other.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index e5a4b0582fb..45bbba3c92f 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -198,6 +198,11 @@ test_fsmonitor_suite() {
 	'
 }
 
+#
+# Run a full set of perf tests using each Hook-based fsmonitor provider,
+# such as Watchman.
+#
+
 if test -n "$GIT_PERF_7519_FSMONITOR"; then
 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
 		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
@@ -208,14 +213,6 @@ else
 	test_fsmonitor_suite
 fi
 
-test_expect_success "setup without fsmonitor" '
-	unset INTEGRATION_SCRIPT &&
-	git config --unset core.fsmonitor &&
-	git update-index --no-fsmonitor
-'
-
-test_fsmonitor_suite
-
 if test_have_prereq WATCHMAN
 then
 	watchman watch-del "$GIT_WORK_TREE" >/dev/null 2>&1 &&
@@ -225,4 +222,16 @@ then
 	watchman shutdown-server >/dev/null 2>&1
 fi
 
+#
+# Run a full set of perf tests with the fsmonitor feature disabled.
+#
+
+test_expect_success "setup without fsmonitor" '
+	unset INTEGRATION_SCRIPT &&
+	git config --unset core.fsmonitor &&
+	git update-index --no-fsmonitor
+'
+
+test_fsmonitor_suite
+
 test_done
-- 
gitgitgadget

