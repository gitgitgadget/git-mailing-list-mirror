Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A7C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5F2074B
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhA0IGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhA0IEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:04:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B893C06178A
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 6so905382wri.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XA1+Lc2e4QdsSCNgiFchQFjwSO3Ax99DBxTNz7+IHKY=;
        b=Ai3HOfrSu1BxreIvoaHlA2qD9oqAN8vWaznLgfhHyV+6+lPHwgNrF51diCi6W8XR3g
         A5CzyM0Q8wTEYSRMBXxZ3hbK3tf3rNs7NSkfZN7/baIO4XlIt3k+fMpk7CPAnpbvJOCx
         D/o0m+NZ/jDCu6ccXQO4A79y3IRbksIw93V/itWjTt2N11xXdWnHrGTcGPZiYJVywhAN
         VgTHCMLnVg6oPyRvBD6/7v7jTimbQbvaWxuNejjWZVKKRKMNOa0Qih8zRNWsSwyEn4Yk
         vH9eeZid9P9nR3Trv4PBBYtGHxIcC/23TKiahDM1X5CWfb/K9Ju++I0lLD+j4pj1hOzU
         HCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XA1+Lc2e4QdsSCNgiFchQFjwSO3Ax99DBxTNz7+IHKY=;
        b=G2xlQEI25SH48enLmmXnqzeI2gM33us/XZmuGwHyO9lN6Uyj2RO1FAhg804WT41+sg
         RufOmLBtu2XDoCcTVjoD65D5W/zBvVqtdQzGZb5iJKcAtx/bAC9deSMYJ97LkexToRpw
         AQLg6JmROamcpd9Mpu7OVARroE/aGK7ONMCLg5aSWS7MxCz0dHVS4XJvhoDXV1uuKuYx
         sRvOehNH6LevnWj/BeTwJVoxYRYmtJ9lGfjMTg565KytPXSinWbd9+0Wxs6ER18D9HHR
         tw7zemvCrFko9mpBRPbnZdeYEqgXXpYTTbSkWjHC3Uba/ba56fi6oY02MiuQz5mdOBLi
         eD0Q==
X-Gm-Message-State: AOAM533cm/zX95Nz9yN7TLBv7mETs6Z3JmCa/qXnEct5CcUdCxI/7E/A
        8sZUAeS/mwpfesxViFDlCnrawo+Ri26fbJVF
X-Google-Smtp-Source: ABdhPJxbjAi/stouzrDWZUe80Eb17ep8gD17aZV72r6MucIYewQqEbUoWn1aQGP54xv+4ci0rNJgdw==
X-Received: by 2002:adf:e48b:: with SMTP id i11mr9973308wrm.406.1611734630772;
        Wed, 27 Jan 2021 00:03:50 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:03:50 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v4 2/7] worktree: teach worktree to lazy-load "prunable" reason
Date:   Wed, 27 Jan 2021 09:03:05 +0100
Message-Id: <20210127080310.89639-3-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
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
2.30.0.373.geade8fefe8

