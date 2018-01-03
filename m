Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE681F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeACDFh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:37 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33048 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeACDFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:36 -0500
Received: by mail-pl0-f66.google.com with SMTP id 1so383289plv.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=b3vE9vILgTFMnfdaOsqxsjQokzM1ECLJ19GB0HGJ1OI=;
        b=su7ZqxP5/eFVWDDX1LA5urThO3scyA05aNWkYZhtvUH9Lf/pNRL+wPWRVQuyoLhKJq
         IZfQG0HMvBhWC5puG1ItcQW+REo77r0aNUpxxLWPRAHKOgJi/mE9IPmcmuBb2tVZUZ35
         XO5aSc7Z+ssfCRTZOEGMkZ61TYnFxXlrUL/4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=b3vE9vILgTFMnfdaOsqxsjQokzM1ECLJ19GB0HGJ1OI=;
        b=CQwN8/mMvaPtYHMHVmkPvHQbmlSJm/DXTnPVRFtTAU9KNaclWTW6eqfuU33n++pBXj
         Sd2Rn7gSJ5QWqxGubcCQ6velng2ZzL8z7OYB9LASpzEuVV9k9yAZRrs511yH3RWdA3jo
         Mg3R4+fLod7dpcRtdhw/LH8/32cR0BhMZS6+UnJ/SD0WcbgMLeCbSOhzjb8HoZxWjY+U
         2XHFFZdKxqUVaV727Tnd3WN5EGASZXFsV/Pw5AFv1K3xb3eiyu1qZAmcPCHnYG8X0i0D
         jg/wOxE+E12efSWjOp993/HdT+BG1LAAOGI8oUMnOVwaWnDeuWVKET8w7j8b0iJYaeiH
         eNaA==
X-Gm-Message-State: AKGB3mJGSpTL9+eo+FmTFs9PdxW/8n30RNqJyIFcoObGI/Tpq7Ov45PG
        9UK88lhmL9Jqz31ZtfZE4hw8LGX+Hss=
X-Google-Smtp-Source: ACJfBott6hKc5u4fe46AdVkQkJtmOVIZumrF1TG7mgI47rMD0djVHL+4Bq+SuSfaNJu9bBXuwdwbWg==
X-Received: by 10.84.129.9 with SMTP id 9mr133474plb.138.1514948735140;
        Tue, 02 Jan 2018 19:05:35 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:34 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 2/6] fsmonitor: Stop inline'ing mark_fsmonitor_valid / _invalid
Date:   Tue,  2 Jan 2018 19:04:52 -0800
Message-Id: <9bb36cea369530b980f6542e3e0f24dc142a20a8.1514948078.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
In-Reply-To: <20180103030456.8181-1-alexmv@dropbox.com>
References: <20180103030456.8181-1-alexmv@dropbox.com>
In-Reply-To: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
References: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were inline'd when they were first introduced, presumably as an
optimization for cases when they were called in tight loops.  This
complicates using these functions, as untracked_cache_invalidate_path
is defined in dir.h.

Leave the inline'ing up to the compiler's decision, for ease of use.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 fsmonitor.c | 18 ++++++++++++++++++
 fsmonitor.h | 17 ++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 0af7c4edb..df084235b 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -194,6 +194,24 @@ void refresh_fsmonitor(struct index_state *istate)
 	istate->fsmonitor_last_update = last_update;
 }
 
+void mark_fsmonitor_valid(struct cache_entry *ce)
+{
+	if (core_fsmonitor) {
+		ce->ce_flags |= CE_FSMONITOR_VALID;
+		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
+	}
+}
+
+void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
+{
+	if (core_fsmonitor) {
+		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		untracked_cache_invalidate_path(istate, ce->name);
+		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
+	}
+}
+
+
 void add_fsmonitor(struct index_state *istate)
 {
 	int i;
diff --git a/fsmonitor.h b/fsmonitor.h
index cd3cc0ccf..6328745b2 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -46,13 +46,7 @@ extern void refresh_fsmonitor(struct index_state *istate);
  * called any time the cache entry has been updated to reflect the
  * current state of the file on disk.
  */
-static inline void mark_fsmonitor_valid(struct cache_entry *ce)
-{
-	if (core_fsmonitor) {
-		ce->ce_flags |= CE_FSMONITOR_VALID;
-		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
-	}
-}
+extern void mark_fsmonitor_valid(struct cache_entry *ce);
 
 /*
  * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
@@ -61,13 +55,6 @@ static inline void mark_fsmonitor_valid(struct cache_entry *ce)
  * trigger an lstat() or invalidate the untracked cache for the
  * corresponding directory
  */
-static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
-{
-	if (core_fsmonitor) {
-		ce->ce_flags &= ~CE_FSMONITOR_VALID;
-		untracked_cache_invalidate_path(istate, ce->name);
-		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
-	}
-}
+extern void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce);
 
 #endif
-- 
2.15.1.31.gddce0adfe

