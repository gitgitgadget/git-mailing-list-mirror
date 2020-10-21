Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C874C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB2E2237B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JASoWkci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503767AbgJUSEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405153AbgJUSEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:04:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE50C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so3558408wme.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dA3t47iFl5ZaLrmDO5U3zkECvJQytQsZ6khQMZudOns=;
        b=JASoWkciagPDc8PaXgNpHq8j1bJZqy6KbvQlRKnfEqNp+suf2VJy22/JBZC/AFyiAT
         GHWpg6uY/6e61LwAW3v2146yT1fppSy4xVzZlIPhaiv4RcNRjGjwh44waXManylilO0e
         rf+lsmGCOH1wcCSzGvc7h5jco0l5Rm17rRxLVDsC/68DM6pvciQT2xbj39JTduwzMG6t
         DigVAJYagQkWjd+EnLjNJCpB9XVBrX9zj01hFiegnJ2l7pzytZ3UXh7vmvpDgVjBOT8m
         +3OpO/vP918pkAhlEfMktMXAOBUdOnST97ZuUYhT0nqZQ3iabC4zFbcVC0kkovbtMH3J
         Ujpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dA3t47iFl5ZaLrmDO5U3zkECvJQytQsZ6khQMZudOns=;
        b=caZ5cQouspcSoU/xyj/UVgtknyTU9wmHeKmF08h/wy1C7AhhV8Ofbg8RMVfVMcr4UM
         CI5Xhf2B7fULBFPSWq+UZlCxPgqPdplKiMYxNN4JkWx2OBETw4tYsdT8S34S2OeZdWiV
         dmHtpEiIpyLLqcE7wwGU09bF3BcpVq+XBrqWjxcdeUtHWmxtAeij0cQMQlJMa1YPq4IL
         +If9sh95TK9CT1VkBOf7DP/SgMdlTU8hmD8lS9incH1S8pOltTCGsJEZ+vvejQCdpoW6
         +pB04M2RtyxNY4kmPNz6QTy40/K1wTlr4ja+RC2A0Dg55PHW18VkqIEN2GytKQp5HOE/
         5MoA==
X-Gm-Message-State: AOAM5312Xzs3up2YOw+NXsRpsXp+bYxKBvKSW5Ns1dcTbjXs9U69N+t/
        1Yek/SBnH8eF3x+eM+hztnldIvyktUY=
X-Google-Smtp-Source: ABdhPJwHtE+9QIiYiW+xdWUy5tkIHHtTAeaiNyDdN1fkCY6nte1FjC8b46dWYglioPi2zaYiqO7pvg==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr2100913wmi.133.1603303477206;
        Wed, 21 Oct 2020 11:04:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm4433661wmc.3.2020.10.21.11.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 11:04:36 -0700 (PDT)
Message-Id: <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.767.git.1603303474.gitgitgadget@gmail.com>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 18:04:33 +0000
Subject: [PATCH 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid /
 _invalid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

These were inline'd when they were first introduced, presumably as an
optimization for cases when they were called in tight loops.  This
complicates using these functions, as untracked_cache_invalidate_path
is defined in dir.h.

Leave the inline'ing up to the compiler's decision, for ease of use.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 fsmonitor.c | 19 +++++++++++++++++++
 fsmonitor.h | 18 ++----------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ca031c3abb..e120b3c5a9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -287,6 +287,25 @@ void refresh_fsmonitor(struct index_state *istate)
 	istate->fsmonitor_last_update = strbuf_detach(&last_update_token, NULL);
 }
 
+void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
+{
+	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+		istate->cache_changed = 1;
+		ce->ce_flags |= CE_FSMONITOR_VALID;
+		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
+	}
+}
+
+void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
+{
+	if (core_fsmonitor) {
+		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		untracked_cache_invalidate_path(istate, ce->name, 1);
+		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
+	}
+}
+
+
 void add_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
diff --git a/fsmonitor.h b/fsmonitor.h
index 739318ab6d..6249020692 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -49,14 +49,7 @@ void refresh_fsmonitor(struct index_state *istate);
  * called any time the cache entry has been updated to reflect the
  * current state of the file on disk.
  */
-static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
-{
-	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
-		istate->cache_changed = 1;
-		ce->ce_flags |= CE_FSMONITOR_VALID;
-		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
-	}
-}
+extern void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce);
 
 /*
  * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
@@ -65,13 +58,6 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
  * trigger an lstat() or invalidate the untracked cache for the
  * corresponding directory
  */
-static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
-{
-	if (core_fsmonitor) {
-		ce->ce_flags &= ~CE_FSMONITOR_VALID;
-		untracked_cache_invalidate_path(istate, ce->name, 1);
-		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
-	}
-}
+extern void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce);
 
 #endif
-- 
gitgitgadget

