Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448CC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3BC64E4B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhBWUR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhBWUQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:16:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22341C061221
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id x16so3628603wmk.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BoGPNLypv1jFZsrjtQgx7YNSihf0ZNLgOAUzBRIvkho=;
        b=BSB/l/0HTmllrdHXhLmcGIzgdGX76CmNRwomyHgmC2joifQuaF6C5CQNZbXjwqVD65
         SWB7zOyv/ev7k77rfdlsDS5832vx7hLqxlpwiekZVs9+TVVF0RnjxluKfkT9gRnlId7c
         DUYF/PwCTVeI/xruxlQyqmC2nrhsPG+k60+FBWHpVnawH4EbL0kb/2inumOpg1sT9L3d
         g6sHp5r2xShf1XlPVR0srkWe/K3Ydl2cXhV9phD9j8J3qr7iRR9eInQT8e+a4w5A5wUe
         r151jfE0g12tPM8RLwTBzC1Ut4QQOctTO9ueJyBiDNbJry/GVGkQM000nwJ3W3Bpt3oZ
         n7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BoGPNLypv1jFZsrjtQgx7YNSihf0ZNLgOAUzBRIvkho=;
        b=Lg7KFYF6aK6QWTiE3qVGGTH9YQkdd2fQ9qsyiI/WNRtn7TuTsP5eiZ8BMshew5hoFY
         qcgUnEGnIyJOb1kbkwrE70OiAnU4SM1QTZwPWi5MwjKorboxRfcPK5N0H62LgmtDkXk0
         4IfW0Nmzx+nEEXcNARFKCcBcg7ncLaDf/yl9nErI2xHAdrGvJjwDq634bHLQPH6a433J
         ccZjexpkxWozYF2+YCm3yxWHEQh9qTfK49CF7IavtBrnNIV7fCCqxoZ5jWmMgSIVYRwc
         d/x1zftfb8hf4sHi9x4zFJ5+jMgB+XHBSvOYUXjig+J+NYO/pfsmdJKdDKArpJ5P5eWP
         HGqA==
X-Gm-Message-State: AOAM531Ez1PgehQ8X2AQQkUONnm/vv5rSRoy7bbiM2hrU+mLqIVYG3In
        YlJ5910JzZwpKPKzkAnrYCRHmtyGca0=
X-Google-Smtp-Source: ABdhPJwrXUuZTL/IaKZBBrxIjKKtBb+v2AbXk8ouQ/j7cu5MtcK801h3tv+2mzwnSOG3KhZQ11NSvw==
X-Received: by 2002:a1c:1f4d:: with SMTP id f74mr400015wmf.133.1614111281970;
        Tue, 23 Feb 2021 12:14:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm34355972wrx.32.2021.02.23.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:41 -0800 (PST)
Message-Id: <e6afec58674e1bb0ba1634bbf5666ede0eb509d2.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:27 +0000
Subject: [PATCH 18/20] cache-tree: integrate with sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The cache-tree extension was previously disabled with sparse indexes.
However, the cache-tree is an important performance feature for commands
like 'git status' and 'git add'. Integrate it with sparse directory
entries.

When writing a sparse index, completely clear and recalculate the cache
tree. By starting from scratch, the only integration necessary is to
check if we hit a sparse directory entry and create a leaf of the
cache-tree that has an entry_count of one and no subtrees.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c   | 18 ++++++++++++++++++
 sparse-index.c | 10 +++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5f07a39e501e..950a9615db8f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -256,6 +256,24 @@ static int update_one(struct cache_tree *it,
 
 	*skip_count = 0;
 
+	/*
+	 * If the first entry of this region is a sparse directory
+	 * entry corresponding exactly to 'base', then this cache_tree
+	 * struct is a "leaf" in the data structure, pointing to the
+	 * tree OID specified in the entry.
+	 */
+	if (entries > 0) {
+		const struct cache_entry *ce = cache[0];
+
+		if (S_ISSPARSEDIR(ce->ce_mode) &&
+		    ce->ce_namelen == baselen &&
+		    !strncmp(ce->name, base, baselen)) {
+			it->entry_count = 1;
+			oidcpy(&it->oid, &ce->oid);
+			return 1;
+		}
+	}
+
 	if (0 <= it->entry_count && has_object_file(&it->oid))
 		return it->entry_count;
 
diff --git a/sparse-index.c b/sparse-index.c
index a991c5331e9e..e541f251b37a 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -180,7 +180,11 @@ int convert_to_sparse(struct index_state *istate)
 	istate->cache_nr = convert_to_sparse_rec(istate,
 						 0, 0, istate->cache_nr,
 						 "", 0, istate->cache_tree);
-	istate->drop_cache_tree = 1;
+
+	/* Clear and recompute the cache-tree */
+	cache_tree_free(&istate->cache_tree);
+	cache_tree_update(istate, 0);
+
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
@@ -278,5 +282,9 @@ void ensure_full_index(struct index_state *istate)
 
 	free(full);
 
+	/* Clear and recompute the cache-tree */
+	cache_tree_free(&istate->cache_tree);
+	cache_tree_update(istate, 0);
+
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
-- 
gitgitgadget

