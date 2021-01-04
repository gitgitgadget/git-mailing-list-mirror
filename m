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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4297BC433E9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B1922473
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbhADQYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbhADQXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC04C06179A
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id q22so37595091eja.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oW39KQP7yO2RUmoP4PcY4iPmMSQ4QaQyHWG+YOGjU+w=;
        b=WGowcHOlqibkLLnHxyN6Gk7NMpEgPHlYS/ImOU/k//htETctpPx9yaskcyV3ksYKwE
         0dSdQFcCoPGAXfTWW6Bx30eVmBSwcVPS5164VFjpePXLApcIixHM84znxgyBN5ZeCHtD
         fJ/jcixYsnZaQXXjEumNo566nvnDxttBX3fnOl060B9++lzjAFDsLUxxFGq4yNMaqIBn
         5yz8NlItcgtLCTc3sxAfM/y1b2kutYWFi28gf2WEaqCciURtIrwBggqkEeM7b5xTDsGT
         G8/XN2d8rlGzm+wPuCU3P72hLH8jHggRcgQFf3XpP3nk1E6CO1wgA4jyAq4YpLwRDAmm
         zOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oW39KQP7yO2RUmoP4PcY4iPmMSQ4QaQyHWG+YOGjU+w=;
        b=IMWw3hz4EaV/zIkcgsbDug8ioAyY5AZMAl+QjuMkIBTe9SAPUSUNG5yayf8i4Vzjag
         rT7Wcnk1oUqpvSb4APQBYED4H5o9h+4IhkzQRvvuLEaHAsBHf3emYN5HXknc1SauHZ/T
         KcOvMMmu87s+jUHRkY46PrsNx1RTrX85IGgTf5nmonfp+PDSTlPM4Sx1Us1xK+h5jpUp
         5+zi1fsXEWsRRrx3me5R2yE/q5h+Hwat6N07HKK/nSw6HiHx/pKTXszyGQ0gn6tYifvZ
         9DX6vM/v8TFuSXlf1k8PVZAz3tJqWo0A2kh+up2LJSAFafQcyMcioByFc7eFVPJd6i8L
         ycCA==
X-Gm-Message-State: AOAM531bH/OajGiSgAOn9Orz/YB36x5W7WnoFDpKvLUtbJqA1X1JZILi
        pIsc7t3cMyyTHRXMmx4nttlai9Qoaj4=
X-Google-Smtp-Source: ABdhPJw18Ccs+muhMNMCp9Q8L1EwfUqRU/CIZFZcDD3Gyws/J9dEQd7TOSJu+X6x9Mkhj2+1cG6d0Q==
X-Received: by 2002:a17:906:a8e:: with SMTP id y14mr66054874ejf.47.1609777336824;
        Mon, 04 Jan 2021 08:22:16 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:16 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 2/7] worktree: implement worktree_prune_reason() wrapper
Date:   Mon,  4 Jan 2021 17:21:23 +0100
Message-Id: <20210104162128.95281-3-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The should_prune_worktree() machinery is used by the "prune" command to
identify whether a worktree is a candidate for pruning. This function
however, is not prepared to work directly with "struct worktree" and
refactoring is required not only on the function itself, but also also
changing get_worktrees() to return non-valid worktrees and address the
changes in all "worktree" sub commands.

Instead let's implement worktree_prune_reason() that accepts
"struct worktree" and uses should_prune_worktree() and returns whether
the given worktree is a candidate for pruning. As the "list" sub command
already uses a list of "struct worktree", this allow to simply check if
the working tree prunable by passing the structure directly without the
others parameters.

Also, let's add prune_reason field to the worktree structure that will
store the reason why the worktree can be pruned that is returned by
should_prune_worktree() when such reason is available.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 worktree.c | 19 +++++++++++++++++++
 worktree.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/worktree.c b/worktree.c
index 5764b0dc7c..ee14db3ab5 100644
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
@@ -245,6 +246,24 @@ const char *worktree_lock_reason(struct worktree *wt)
 	return wt->lock_reason;
 }
 
+const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
+{
+	if (!is_main_worktree(wt)) {
+		char *path;
+		struct strbuf reason = STRBUF_INIT;
+
+		if (should_prune_worktree(wt->id, &reason, &path, expire))
+			wt->prune_reason = strbuf_detach(&reason, NULL);
+		else
+			wt->prune_reason = NULL;
+
+		free(path);
+		strbuf_release(&reason);
+	}
+
+	return wt->prune_reason;
+}
+
 /* convenient wrapper to deal with NULL strbuf */
 static void strbuf_addf_gently(struct strbuf *buf, const char *fmt, ...)
 {
diff --git a/worktree.h b/worktree.h
index e5f4320725..24ded0f3c6 100644
--- a/worktree.h
+++ b/worktree.h
@@ -11,6 +11,7 @@ struct worktree {
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
 	char *lock_reason;	/* private - use worktree_lock_reason */
+	char *prune_reason;     /* private - use worktree_prune_reason */
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
@@ -73,6 +74,12 @@ int is_main_worktree(const struct worktree *wt);
  */
 const char *worktree_lock_reason(struct worktree *wt);
 
+/*
+ * Return the reason string if the given worktree should be pruned
+ * or NULL otherwise.
+ */
+const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire);
+
 /*
  * Return true if worktree entry should be pruned, along with the reason for
  * pruning. Otherwise, return false and the worktree's path, or NULL if it
-- 
2.30.0.391.g469bf2a980

