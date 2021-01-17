Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6382C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A18206ED
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbhAQXsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbhAQXob (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B6C061575
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:49 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id b5so4783571ejv.4
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtB6iP/LBZmHDxVizQ1ttWEhEJWuAx4NqbPPPy1hEP0=;
        b=BTHuaHD92kjmcFOdkPjfVU0fmZlIwP5Ncg5RzoGooyG0qpnoiEhNgIWoawWp60Uy+p
         mQClkFUKtjMHb/nckVJs9MnZnp5b8GLDCMkEt7T8H644CnahkWI2nzBYhVUDPsm0b+ey
         dm8ST0MruvhPa2Rzi05YCO/mha2acRPYa5hesmKm8QVMbfwuer77UrJZsZLIaBfzKvQ7
         xku7OsdEGhzyHz9weDUk+NGoOa78joulu5wfT3jzzbjfuz9q+r0Jms+plYXYsJL1hPMc
         fCkRlbx/w0jgXcOBARb/Zsw9Uo2rsfGGCe1A08mhtjkiKrnUY5PBdUxSD0vQcSW292Rm
         DDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtB6iP/LBZmHDxVizQ1ttWEhEJWuAx4NqbPPPy1hEP0=;
        b=J+mMHgcvjT1+VW4NCHDKBtUAs7RWpt1xVjDUNun5BGN12oZXYNqA7vgm9UCDKK0qpR
         n/5KLlgcQ0bUvh9rJC+HE7nI2r1pWfN+t41qcJxLBJQhIWKfdP07dRoYriXip32Nbxxr
         coJPZiFFWBu0Fi+bRAKibIT/XWwSL6DppvZI/rIvID8XKkDoIz+LsSK0rT7yGZlpXAe+
         /k/1QrxKTu26nGNEaEiWQ7sqjpCLbpwkprkfRKJ0cfP6tRqhoQzVJLhF0dc5xTLUButF
         0Nu0VlLJvDYRcM8X0xczunT4PIaoL2TaUSlJjLenz9aTGarNNh3GUBD0BqOxmir/LdM1
         sONQ==
X-Gm-Message-State: AOAM532czYUE4JZ2oL/pi0wcuuLulrJMHuY30qThwAy0qMLEpq5djt+j
        CDKCoekV8E1ZWH1li5X91CdQrnvAI6c=
X-Google-Smtp-Source: ABdhPJxi+84stFDuTDlc+cDFKVomEPEQ9W07QItsM2Ll6pdO1KBWnCtwQmThQ544gQrrRR3ZF3lkMw==
X-Received: by 2002:a17:906:1288:: with SMTP id k8mr15247454ejb.206.1610927027873;
        Sun, 17 Jan 2021 15:43:47 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:47 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 2/6] worktree: teach worktree to lazy-load "prunable" reason
Date:   Mon, 18 Jan 2021 00:42:40 +0100
Message-Id: <20210117234244.95106-3-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add worktree_prune_reason() to allow a caller to discover whether a
worktree is prunable and the reason that it is, much like
worktree_lock_reason() indicates whether a worktree is locked and the
reason for the lock. As with worktree_lock_reason(), retrieve the
prunable reason lazily and cache it in the `worktree` structure.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 worktree.c | 20 ++++++++++++++++++++
 worktree.h |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/worktree.c b/worktree.c
index 8ae019af79..474ed46562 100644
--- a/worktree.c
+++ b/worktree.c
@@ -15,6 +15,7 @@ void free_worktrees(struct worktree **worktrees)
 		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
 		free(worktrees[i]->lock_reason);
+		free(worktrees[i]->prune_reason);
 		free(worktrees[i]);
 	}
 	free (worktrees);
@@ -245,6 +246,25 @@ const char *worktree_lock_reason(struct worktree *wt)
 	return wt->lock_reason;
 }
 
+const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
+{
+	struct strbuf reason = STRBUF_INIT;
+	char *path;
+
+	if (is_main_worktree(wt))
+		return NULL;
+	if (wt->prune_reason_valid)
+		return wt->prune_reason;
+
+	if (should_prune_worktree(wt->id, &reason, &path, expire))
+		wt->prune_reason = strbuf_detach(&reason, NULL);
+	wt->prune_reason_valid = 1;
+
+	strbuf_release(&reason);
+	free(path);
+	return wt->prune_reason;
+}
+
 /* convenient wrapper to deal with NULL strbuf */
 static void strbuf_addf_gently(struct strbuf *buf, const char *fmt, ...)
 {
diff --git a/worktree.h b/worktree.h
index 818e1491c7..8b7c408132 100644
--- a/worktree.h
+++ b/worktree.h
@@ -11,11 +11,13 @@ struct worktree {
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
 	char *lock_reason;	/* private - use worktree_lock_reason */
+	char *prune_reason;     /* private - use worktree_prune_reason */
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
 	int is_current;
 	int lock_reason_valid; /* private */
+	int prune_reason_valid; /* private */
 };
 
 /*
@@ -73,6 +75,13 @@ int is_main_worktree(const struct worktree *wt);
  */
 const char *worktree_lock_reason(struct worktree *wt);
 
+/*
+ * Return the reason string if the given worktree should be pruned, otherwise
+ * NULL if it should not be pruned. `expire` defines a grace period to prune
+ * the worktree when its path does not exist.
+ */
+const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire);
+
 /*
  * Return true if worktree entry should be pruned, along with the reason for
  * pruning. Otherwise, return false and the worktree's path in `wtpath`, or
-- 
2.30.0.372.gbc7e965391

