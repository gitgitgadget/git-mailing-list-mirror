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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E90C433ED
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A2619CA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCWNpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhCWNoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E6C0613DA
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id 61so20800427wrm.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fCX9Pdv6Q50MZfKlGM7RED1/TN58Z2uHwpjRZk86caE=;
        b=avDub1oN0ETL/JCztmKlbhgbf7Wophmvq/wbOV9xeYv4Nhxud8C7K+Cq3ckqU/X02O
         m/wybwV8CSa8iIM5bgVNXwWfgnH3/jSOjI+5bvqzgplcN/KxIhLQE7jFqwqVpKCtF95b
         J7FzhvSOkZYUW2Uw61fEwVbOF1jRLA8tkHgL4j+Xk/7IVioDNi0k33wSh6OhJm2xfKs1
         4XnjuRpW4P8F3NUHjuq99ENxSlYBMSuaFwAcajm+Oo5S/yig0E3TX/OVOOjH0OHTrla4
         2Eh/3SL8+qTqRoKtZPVI7NThwjLdD04FbT0wvZPDjv4q3nnygO8v+UW9vE0ZAgju856f
         5Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fCX9Pdv6Q50MZfKlGM7RED1/TN58Z2uHwpjRZk86caE=;
        b=UZRWeG9uMg4bjHhMe/G9Ona7Sa6ETPzgbvcucyOf7cSBilGkPnqVIRArZDsDhEXkeb
         TXsXCHtBR1uAkx69ypc/Jg/t72042kk93ey75BPDfExh5qa4yWi89sUpK+omuqrMrAlO
         BB9XYwIscPSiPfVPk/pvEB5i4Gi9PnDYYS6ucd9yeqXUYCowN3RjMSiZoWj7R2kWhIaf
         8PTx3C1KlSc3yhcmlBQ+qqf0YW0rJUULgWCqJpDfjaFsOkHXiT/wvU1T5s16I8N0/IT1
         JikKmvIZdZ1AEcZoCkiB+mUI58vZAiDd0zkMw0dcEYGthuc13ydYbr0jXjXRYHrmLqbd
         OY9w==
X-Gm-Message-State: AOAM531n/vBpZERqt0tq2fHgVEEw3QDeXSIJUexXGQFg0OySY5Xcy8ll
        foMqE3cen5/ho/fprfuSQU8byrgsb2g=
X-Google-Smtp-Source: ABdhPJwdxXAbadN/lLqtXaGCk9lTb3O7R3g5BOXCuTxAF0jbKpv0CSV76ZvcQhOQj8XSBH/5NWieWg==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr4160954wrn.204.1616507085285;
        Tue, 23 Mar 2021 06:44:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm22944966wrw.89.2021.03.23.06.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:44 -0700 (PDT)
Message-Id: <bd94e6b7d089abf720657c7bc116a805f2a2314b.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:26 +0000
Subject: [PATCH v4 18/20] cache-tree: integrate with sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
index 30c1a11fd62d..56313e805d9d 100644
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
@@ -281,5 +285,9 @@ void ensure_full_index(struct index_state *istate)
 	strbuf_release(&base);
 	free(full);
 
+	/* Clear and recompute the cache-tree */
+	cache_tree_free(&istate->cache_tree);
+	cache_tree_update(istate, 0);
+
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
-- 
gitgitgadget

