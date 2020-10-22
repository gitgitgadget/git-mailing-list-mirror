Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948DAC56201
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EACF2417F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV69qKjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507443AbgJVAVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507435AbgJVAVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 20:21:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCAC0613CF
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:21:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 13so160829wmf.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sq/yiqzwdKASIpuUUMLRXrj/Yp3TFOqCGS3UR3MC/d4=;
        b=CV69qKjOce+Mr5S34B2c6xGvv3++mIG8C3ojhuqEKzxDkuE+g/g2oyAqKFYCDAw4ne
         bKiKCrxdl65J3W9i/5H+FtHIyRZPf5QniIVty2SzMDNmdf8TTFaLDkn7/RU7SpRqF+7Q
         SMmzAqR3R7vPFobD2lW9ndqHALw1xNmbIDYMhPCHmW1xSIaDeSPS/EDAbUcCXDh9nBlY
         oPurTuFFgaOvsmytajcB+hWjgr4uDOwNk21AUiz0w9mcTOu4LbGcxriLOwkRFrG4G40/
         +zvrk4zJ4RqfTvwCkyK71behljFBi9E7yIL4qDqn8SFlPYrwqOysJk5BbbiZp2B2L6OX
         lQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sq/yiqzwdKASIpuUUMLRXrj/Yp3TFOqCGS3UR3MC/d4=;
        b=AmbycB7gavvRKBwzT8q6HfRP4hEUI3T+01Otc3MgT/hmh3BDTLMfJNiU3IbVczgXci
         jz1PhbSPG0kP2mAke+URfGq+rXKulf5lmTu2Tk7T0Ti+1HU98y6BCFseCsFDBjwnkihc
         D8AEIdNvKsOBI4De5jTWWVn0XAx/LDjakdRnw5FGw4GQ0nqaGDfSZNp9uRk2fFb7emKm
         WjedElxIMVpcN48bDdHKnCGEYR5nXji9yxX1AffnmhcGwls79KldW5oBPLovgjbzpmlE
         swDJ9tWMRNnlSfLzTbpheq+Hw0OBsZAlWgueyHi0UAiZLaiHaygHnYDd3jpPtPzR0m5q
         FHeg==
X-Gm-Message-State: AOAM530wYd0NFFXXbif9C3YXI6nh1mjR+qkOuF7Nbdnsq73ixUbgVA83
        5vIcBilgs0ZpTmMSkodKD3199JJEWE0=
X-Google-Smtp-Source: ABdhPJyGmqIf+ulYtM4QwNJOFrugnRaQB499XLiOiqlbx2/lIy63cyWA+fQD50Wdo+faGHwGn04jzA==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr3901wmk.43.1603326068601;
        Wed, 21 Oct 2020 17:21:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm94930wmh.23.2020.10.21.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 17:21:08 -0700 (PDT)
Message-Id: <ab9c330ca804eab6061d997bb5f216e48b199876.1603326066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
        <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 00:21:05 +0000
Subject: [PATCH v2 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid /
 _invalid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
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
 fsmonitor.h | 19 ++-----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

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
index 739318ab6d..313a35fdc8 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -2,7 +2,6 @@
 #define FSMONITOR_H
 
 #include "cache.h"
-#include "dir.h"
 
 extern struct trace_key trace_fsmonitor;
 
@@ -49,14 +48,7 @@ void refresh_fsmonitor(struct index_state *istate);
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
@@ -65,13 +57,6 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
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

