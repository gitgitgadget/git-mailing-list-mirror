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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96115C43603
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738F864FE0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhCJTby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhCJTbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98339C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso11810191wmq.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ieph9Cy+IVymDCLa3+EgUXf0wga7IXS9ysPHMHM15nY=;
        b=T4tyB15s7S6mLgpYNsirUVqeoaQWgMWCbyayNNG1FSiuxiaTSBbTw8cs8UGUmCsi/V
         g29OCFqoF0EW/UGFGkqZYwJq0OJ3L4pmtSUexKUC1UOVFGLJEBq8upiRbBVsrWPFlQUQ
         uuORR031nPrVzquEhJUhoIPLW1tnJlE9lwBTVy3ANK2Z3/f5VwiLItVUAKHqgP390bsY
         cQHJR0XhgKSmT3bLxbHeL+OSQG9am5VpDeP7nk8eBDw0cIBrX4vhFx5uIQyFmVICChAy
         fZOIaV8HCKJfZQ8k6CGfhoIvJ4hp+dLlXa6hlnW8ZZLtHIV5RButxcjByoc9n+pIsHAb
         Ql/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ieph9Cy+IVymDCLa3+EgUXf0wga7IXS9ysPHMHM15nY=;
        b=Wa+tEcf73+Th31kqeyPokExsZ7G4DfazszyofVA9lrCfa+DXo53bvdS82rOybH4wyL
         JN36Ula6n5ECC0e/BN3Jbg6bA+SEB9ydIpgZkneGts0zJsL6LhE9kHdohjek4AsqoTiv
         UUAuwQbLM5mJOTQi2cZ+9va84o4odiodMQP3rgG6szTa9ZvHtLfcKbPANmPWN6FRafa0
         yQ1Me4FM1efFc9KLayt3QXcPJoR1/Qif23KdcoEbvO5FcNQqMTh1Q4ZubhjlqH0PGhEL
         yfihyk6tKb5B8+LOABsJUVCO2CQ4wijaIMrCG4beoiTd6pHANroF/3GsDFiW5o6la9OC
         O1Pg==
X-Gm-Message-State: AOAM531zvY1410Uf/e5Gtmmf1t07zRm/B1VLzbQrUiWvVlKOkm48ZreI
        pltDYkU3baBBF9Za79vg213bm9XUZis=
X-Google-Smtp-Source: ABdhPJykSbKM3n+S/SczBulfjRfxt28qDLFdC/9G6FpZxKsTDy8KxIetwA6SU8zy31Ji8JY1yWaGNA==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr4909289wmb.2.1615404678431;
        Wed, 10 Mar 2021 11:31:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm374061wrp.14.2021.03.10.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:17 -0800 (PST)
Message-Id: <6bb0976a6295e4a98d050ab26a0545af8c9b5ff1.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:31:01 +0000
Subject: [PATCH v2 18/20] cache-tree: integrate with sparse directory entries
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
        Derrick Stolee <derrickstolee@github.com>,
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
index 1c84cac255bf..ea603201a323 100644
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

