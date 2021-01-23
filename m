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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA3BC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A5B22D2B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAWT7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbhAWT7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31646C061788
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y187so7312105wmd.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bh8yh3+iaQ4iXXap8pGPFY/q1QZLWVT+vydoYX5XmtQ=;
        b=rIYM8Sj1xmEI9gizswqiR/akQNACjvzbfprhTNdSAnCKn04N90sUhLJfSsxzKbutra
         Aq8s2L3o3K3GGjy7oW/IAxZnR8XxTE98+PU6Ie/exPsqR7i9J4iyLq65UO7q4/StRwjq
         3b7mplEl221IIdInScHZNgKQK6j+j0/sHJQrQFgMotZ+StmgvJHqFfIZDBpVTIWo3Bm/
         rydTfBRix3dKyR6xtQ0HXtjA4tNeiuU3Y3OH4G7auPIpqP9eBoDaqLZqlo+RuboyclL1
         34Dyb7SmWrPbT0VqTbJ8OrW57Dughq0696pxwnEVq/Dn09zGZiUaA3/mYdbUEcyIws5B
         FCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bh8yh3+iaQ4iXXap8pGPFY/q1QZLWVT+vydoYX5XmtQ=;
        b=MkkfAqZIzzVD6SpPSZnWRQt0Gd42WCwnx79tfX53jWrswJjuUBVCc8skXp3CCuELPx
         1UVJQA6ieYd9ygF/CBw3b13OovHmPzRimzGQDoo79Y8yiSM6fFZMOXcZVjRXjl58QuZj
         kpkVBFjA6qgES17h1t6ZP5p/tUxsIv1/wOIW/rL7K8a9DRU3fTYlKCRv2OqhuibHStBs
         hX5tO1B666G/QZtrZDjE7qfyOaqOW9lw3sULW2ypE0q456j5U0Ny3VafWd+8qgnk32xJ
         tIC8W9Vj/JPUyHZLLCU8UrFYOVslqBQ3bI+2N6Zw/5k2nubbQN0/P+5pqDgl8zRpiv1X
         HZ0Q==
X-Gm-Message-State: AOAM531akU9+VlGyaUJUVn80mNC1k7ZVAIv5VfgWEVrCH63qHK5LqwTy
        9PqkiZK8syYbZ/lkRGGiVX14msLGw/o=
X-Google-Smtp-Source: ABdhPJzwd4NPxNGJZ9zqYVteJ9XVjYb3seUEJumdfQIGXICxliN8hXh3SZz3bOBI98K28v/HsEwROQ==
X-Received: by 2002:a1c:b7d6:: with SMTP id h205mr9392825wmf.182.1611431903791;
        Sat, 23 Jan 2021 11:58:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm5691023wmi.14.2021.01.23.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:23 -0800 (PST)
Message-Id: <314b6b34f759c3a0e0d361bc08b254960a4d28e4.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:13 +0000
Subject: [PATCH v3 3/9] cache-tree: extract subtree_pos()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This method will be helpful to use outside of cache-tree.c in a later
feature. The implementation is subtle due to subtree_name_cmp() sorting
by length and then lexicographically.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 6 +++---
 cache-tree.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index acac6d58c37..2fb483d3c08 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -45,7 +45,7 @@ static int subtree_name_cmp(const char *one, int onelen,
 	return memcmp(one, two, onelen);
 }
 
-static int subtree_pos(struct cache_tree *it, const char *path, int pathlen)
+int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen)
 {
 	struct cache_tree_sub **down = it->down;
 	int lo, hi;
@@ -72,7 +72,7 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
 					   int create)
 {
 	struct cache_tree_sub *down;
-	int pos = subtree_pos(it, path, pathlen);
+	int pos = cache_tree_subtree_pos(it, path, pathlen);
 	if (0 <= pos)
 		return it->down[pos];
 	if (!create)
@@ -123,7 +123,7 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
 	it->entry_count = -1;
 	if (!*slash) {
 		int pos;
-		pos = subtree_pos(it, path, namelen);
+		pos = cache_tree_subtree_pos(it, path, namelen);
 		if (0 <= pos) {
 			cache_tree_free(&it->down[pos]->cache_tree);
 			free(it->down[pos]);
diff --git a/cache-tree.h b/cache-tree.h
index 639bfa5340e..8efeccebfc9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -27,6 +27,8 @@ void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
+int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
+
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget

