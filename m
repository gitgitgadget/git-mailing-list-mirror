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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCD0C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84516510B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhCPQo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhCPQnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E1C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso1828356wma.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fCX9Pdv6Q50MZfKlGM7RED1/TN58Z2uHwpjRZk86caE=;
        b=Md8W94th6DCGTUVHc9QAsAcR5lDBRoVlwruJe7V/2EvueLWEs1NLLXV8qDxcf0UntM
         UFJy4JqOXaAHMeaLXAETqd6wCYRhGdBEqnNG8/jFpuQUK4BsO9D8mlc7650EVH09662V
         nxdY/v3gCceRyOCwDRankB2mhMgBfFdD2W5a9cw1XfPlLIdU1Ic/jwjdxkmyqGq6BSB9
         Vd8ktu1ZXIbQD4IwZZtSAL7cJbvS0Mf7uZX4puxXDBdfn9qLy2U4ADB79PYOsuCMLYjr
         7ZiwrUxQn7LNniLTel853ET5ORU1ZJfFQd8dsLr6LeaX+GAJSszDis5yCjiQqmD1t24F
         hgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fCX9Pdv6Q50MZfKlGM7RED1/TN58Z2uHwpjRZk86caE=;
        b=mFrhVrGISTsScXZRcIw2ePQXbiLbtBdvmtVIC8n88EsEyTVnVUUQQ7dRWsWlfRRLV8
         G63QqKpQ8dXgqCd91InC2Dg9um+r3TmGrGs1rfE5TXJntZmt2r710913iUyDgf2kqnrq
         mvWPxt8Mknb5ZVCpcv9aag+RaBheJvyHiuyyOPW+xk9AtQdd3VRA8RYb6ZytbBKAAXO2
         kc8RB6zUMWt0m70lE0s+HFEdBhLfX+EfINgyJXRePOuoyMyVDwUZE8cBCSWZqh06j4W1
         wdi0lvv9ZIGx26qEWAYkADa4pkIqbUOfdlKyMQuXg5qRUtYtYacx0ZjhsOM9c6BItzPB
         p+Ew==
X-Gm-Message-State: AOAM533XMX7oj2e0Vw9Zr1vaIohLhKfqrCsn7IkmZ0kicPXfCcg46S/H
        H/s7A3YXYSBwzHifzeVUqxszVkyXTV8=
X-Google-Smtp-Source: ABdhPJzMi497sLOjVDZHUoxIn9p3czi1eFdadrlqV77tIr8yujv2LbPpVrUm+pybqG8ftgibQbhiHQ==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr497845wmi.92.1615912997976;
        Tue, 16 Mar 2021 09:43:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm8852wmd.42.2021.03.16.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:17 -0700 (PDT)
Message-Id: <c2d0c17db31a283ff9f9a137c4d497d878f13458.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:43:01 +0000
Subject: [PATCH v3 18/20] cache-tree: integrate with sparse directory entries
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

