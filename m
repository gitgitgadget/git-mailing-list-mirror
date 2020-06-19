Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA680C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C773F21D82
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+CewBTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgFSXgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbgFSXgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 19:36:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5352BC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:36:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r2so13328527ioo.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFUlW2DGwlqMEA5TmxujyFpJ082NTfsjQJFerZ3MZoc=;
        b=o+CewBTRl7qqPU/3LM8QMf6TXzRKahB1VnPOQAON18LjAu/buIHg8xis0ncU17cl1x
         1AvQ4ie9Ihsq3vGhhz4keSNiFoMOhsLb/P3GE1q1UZoyEdaVpgztjIf/gJdX5N4vWvzV
         Ltjq6ioh/LXPjrpC7TQzASdlo/gXNStJDbwH6MXnV501ZCbcSv0JgDhRWqm1fwDjsRc0
         Q6dA0fq7RoJwv2ydkI2VmWetDf3Eu5o9jWqm3hHf4Mf9m0A6sIjHZTUaq82FAAIA6UG5
         07/ZnKoRwFGd/tBCkj/02N0svkVXt5DvAOJdz8Nkmvz5sjGESzM0BXdX1mRG3tE3Im9Q
         PtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eFUlW2DGwlqMEA5TmxujyFpJ082NTfsjQJFerZ3MZoc=;
        b=EaPeghwiCAzWVOPGWWuu4v6wWiwbl7ZXfU6yyivV81fb+IcWTk8IseYPBhpGjWFiUd
         euIHLe8kkbxr8fayfluAm+ErB2D2ahsJhZcBeD0HboKcOkHAoMUp5p02jzyrTcvr2+PG
         ndGc2l3zi5uvJ5XH/Eb+N+z/JmIEpB9mb8QIoR6F96+WftFjcmtYCe8Fw+VYqfB1TYvX
         rFTgu8yOfRLEfQYWksSAX15i1erGsFVOUoTqpPuTylRnnnjOx6rsJc8eAZRDV2W0OI8v
         NEeL0wHfuJde8JYEzDSA+VBbwyIL1pOu+tPZIa+rZqyarPLVplEp0HVuWspDqXlT0vKv
         HgyQ==
X-Gm-Message-State: AOAM532lCKsi3nwL5Gl7IBSl/aYBp7YFkgCa3uJZK+3MF5qKBYBS6FOm
        tjor4eqtDW3wR/EC9jcqglgQS9kIsyw=
X-Google-Smtp-Source: ABdhPJwgQET2XDFJJiev6tB69IId7IYSXW+u2UmpHmcf4dOOc1J6G1KLRGUWlWF3YtsFsUJYKwumuQ==
X-Received: by 2002:a05:6602:2fcb:: with SMTP id v11mr6925040iow.121.1592609791186;
        Fri, 19 Jun 2020 16:36:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id q5sm3890723ile.37.2020.06.19.16.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 16:36:30 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] worktree: drop get_worktrees() special-purpose sorting option
Date:   Fri, 19 Jun 2020 19:35:43 -0400
Message-Id: <20200619233544.42025-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.221.g4d328a12d9
In-Reply-To: <20200619233544.42025-1-sunshine@sunshineco.com>
References: <20200619233544.42025-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Of all the clients of get_worktrees(), only "git worktree list" wants
the list sorted in a very specific way; other clients simply don't care
about the order. Rather than imbuing get_worktrees() with special
knowledge about how various clients -- now and in the future -- may want
the list sorted, drop the sorting capability altogether and make it the
client's responsibility to sort the list if needed.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 22 +++++++++++++++++++++-
 worktree.c         | 14 --------------
 worktree.h         |  9 ++-------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1238b6bab1..13b94d36d9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -697,6 +697,23 @@ static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 	}
 }
 
+static int pathcmp(const void *a_, const void *b_)
+{
+	const struct worktree *const *a = a_;
+	const struct worktree *const *b = b_;
+	return fspathcmp((*a)->path, (*b)->path);
+}
+
+static void pathsort(struct worktree **wt)
+{
+	int n = 0;
+	struct worktree **p = wt;
+
+	while (*p++)
+		n++;
+	QSORT(wt, n, pathcmp);
+}
+
 static int list(int ac, const char **av, const char *prefix)
 {
 	int porcelain = 0;
@@ -710,9 +727,12 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else {
-		struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
+		struct worktree **worktrees = get_worktrees(0);
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
 
+		/* sort worktrees by path but keep main worktree at top */
+		pathsort(worktrees + 1);
+
 		if (!porcelain)
 			measure_widths(worktrees, &abbrev, &path_maxlen);
 
diff --git a/worktree.c b/worktree.c
index ee82235f26..8f24fbdc1e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -123,13 +123,6 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
-static int compare_worktree(const void *a_, const void *b_)
-{
-	const struct worktree *const *a = a_;
-	const struct worktree *const *b = b_;
-	return fspathcmp((*a)->path, (*b)->path);
-}
-
 struct worktree **get_worktrees(unsigned flags)
 {
 	struct worktree **list = NULL;
@@ -161,13 +154,6 @@ struct worktree **get_worktrees(unsigned flags)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] = NULL;
 
-	if (flags & GWT_SORT_LINKED)
-		/*
-		 * don't sort the first item (main worktree), which will
-		 * always be the first
-		 */
-		QSORT(list + 1, counter - 1, compare_worktree);
-
 	mark_current_worktree(list);
 	return list;
 }
diff --git a/worktree.h b/worktree.h
index d242a6e71c..bd2235abe0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -18,17 +18,12 @@ struct worktree {
 	int lock_reason_valid; /* private */
 };
 
-/* Functions for acting on the information about worktrees. */
-
-#define GWT_SORT_LINKED (1 << 0) /* keeps linked worktrees sorted */
-
 /*
  * Get the worktrees.  The primary worktree will always be the first returned,
- * and linked worktrees will be pointed to by 'next' in each subsequent
- * worktree.  No specific ordering is done on the linked worktrees.
+ * and linked worktrees will follow in no particular order.
  *
  * The caller is responsible for freeing the memory from the returned
- * worktree(s).
+ * worktrees by calling free_worktrees().
  */
 struct worktree **get_worktrees(unsigned flags);
 
-- 
2.27.0.221.g4d328a12d9

