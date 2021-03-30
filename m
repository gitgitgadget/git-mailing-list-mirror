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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE18C43459
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A40619F6
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhC3NL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhC3NLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E442C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ap14so11613723ejc.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XMbMRlWDrV8aVVqgf/9ul8+2o5nutHV7Qcnd8W2n8Vg=;
        b=m/1irrU56wjoQIc2X11D1GwZpNuBg9BdZBaufdg62uMJcolqeEuuUpmzzneUhN82kP
         4psVLT8fPCtia/23J9tRKUQZ9pVxNkZYuYh3u2Fo5nFeMEqFLD/0hc4yLCMR+Jsit22T
         tfS5rVWTvOgploM+rOAHkN6xna5pc/q8M5tVKSAGXRlZZa91H0MbSFfVVS4zVGJCJZZ1
         dPvQR+VT1/PJ1HffB7wEzIeHfCzZmhlLfFKgLf8Q1Vy7JahDnDewjIfRtgB5pAVdsovh
         mcbipmTjGbRbdfvd/m8Ldq+ZVIggZYIUB+c1+V4FrF42yrn1x8vcHidnIdnJFZcUe1BI
         hE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XMbMRlWDrV8aVVqgf/9ul8+2o5nutHV7Qcnd8W2n8Vg=;
        b=QFRcWblpTsE+15y3G9ULj103wIF6fMz/9hXbJgWxk33s+p/If7a4LFYcwpMbyMqshA
         Wn9SjZ6w2BbUY0gBJcAxhtfVFJ56hvj3IZ7AMj1iLOcVDAUwtoAJZHI64ziMBxPuBduI
         mAY+Kjc7pq3SEzjM00im48QgDk18IEx8BrCRUEOjQO4eFdtNhYYtxyd9biZxOxYI/7NM
         axI6wJx7AfUZ1PUl8TVATONAHdbLrDeXZCO8KmYAS7APcPTOSHXS8xocBQ3n27F2O3uV
         ufILU4uadlZtTOVSnQ0J1vaxqkbE2y0ddFKC5LZvdiB+ptLQYc1Nc7NFUMamesKtKEO/
         t6Ug==
X-Gm-Message-State: AOAM531WxmQtd+0z+0DrlwuqJD6esLvZnyJsjGh/7fieloLmICHhvgxH
        zipeCR4GTfYUSaO6Fzm2kUUimTkefTw=
X-Google-Smtp-Source: ABdhPJw4AXbwhMnyt2lMcIs33hXWDMPA40TixaebTjG85ZvPc/NdSu6UJESKhq4R3pMBvygL3zVpPA==
X-Received: by 2002:adf:f143:: with SMTP id y3mr26969245wro.198.1617109881153;
        Tue, 30 Mar 2021 06:11:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s83sm3649712wmf.26.2021.03.30.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:20 -0700 (PDT)
Message-Id: <365901809d9d43f1229ac3e81990853b06b8fb35.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:11:02 +0000
Subject: [PATCH v5 19/21] cache-tree: integrate with sparse directory entries
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
index 4c73772c6d6c..95ea17174da3 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -172,7 +172,11 @@ int convert_to_sparse(struct index_state *istate)
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
@@ -273,5 +277,9 @@ void ensure_full_index(struct index_state *istate)
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

