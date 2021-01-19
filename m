Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A05AC433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1016722D71
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbhASVaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbhASV26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286E1C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so21128487wrb.12
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iizqHUX2jzrwgDtQtta8EOZZSEuSd8m6ozy7F8qnSOo=;
        b=gIJ9EDsgJdrTRbdeGtYhH9rsC1Av8B6hv9k5eLECLsZy+UJQoOIf4Znga6CrUss8lR
         4TCGKZt/77PaUGXkOgMGVy17UYdvcZ0RnO196PxQGKQ9oALGZyH3PXd0hGuq+mtVSXTt
         uq64ezoPwEXXhtxBeX/p4tJCJmLO6nSYmsBbpZhJHpHXfYdKPPQx7/X3sfS/CvE6HP2y
         sWwxqEglzJFYCyNKKGccbc/wsXDwzHpOuqG13mqysPNuP8Gv6exF/aA88aNrEul5pVs/
         X8b/V3k2r9RNvCyWt8HajNKdBxElQs15sPtX9CnYWh+zyZ33ewe6J3C4/NngVpbK6k+S
         LTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iizqHUX2jzrwgDtQtta8EOZZSEuSd8m6ozy7F8qnSOo=;
        b=N81u3nu+1nn6fo03qoL+Rbn74nvtW9ZRbzTOlegkKM8/c+ynwt1jZNZsLLmKzAIJ0J
         9IEs3D+9t6yYTj/rusQ1hT2/B0IrDVtK5xxsojD0StBTyy7FXpsCZ6eBrRO/vaA7rKYW
         9U0gioVGBgpaBCceV+yQ1/hoS8X7fnD0DLPixSMNQ/nfyp1e9GMg1cmVGeAkY22unhPG
         fRP45FludVtE4qL5U5pDuhNEv2pP7fHedYllIAPqhxk2huXC+4mLpehfTySG7vzrnzMr
         kCEpvUaD7scx3cpzqToSWU7FssirQGuqGD+WZRhsQLjN9C+euuxxFhW/zbhc5I13IOlh
         tsHg==
X-Gm-Message-State: AOAM533wDW+0jE1xpH6gYxOpQi0YDIfbxzWuCBKv1KTcG0xzpalfDR5j
        Gqy1y89s3chioMJiz1xD1ixrJvtUm84=
X-Google-Smtp-Source: ABdhPJxJ4TnzRfusda5HGRLqhw6krUgPrBj9G8xqe3Q9CcwYpyQ9rq1thDJrVAEEn0qXt2d2ivtJdA==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr6208470wrr.326.1611091696390;
        Tue, 19 Jan 2021 13:28:16 -0800 (PST)
Received: from localhost.localdomain ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id r2sm39448819wrn.83.2021.01.19.13.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:28:15 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 2/7] worktree: teach worktree to lazy-load "prunable" reason
Date:   Tue, 19 Jan 2021 22:27:34 +0100
Message-Id: <20210119212739.77882-3-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.421.g32f838e276
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
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
index 8ae019af79..fb3e286996 100644
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
+	char *path = NULL;
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
2.30.0.421.g32f838e276

