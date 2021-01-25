Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7E4C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEA222583
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbhAYR7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbhAYR4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FB2C0611BC
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:40 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i9so98215wmq.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fa2VGXxgeW6ECn5Gef1CpeYWB+LFL3W38AsWWJYtajw=;
        b=X3GoqgaJL7DdFAA+d2ZvnfXKfUaRCsdfxAUom4QLLtGLu9LY5BvIC5jmA4tWFV/pmE
         5JbEwmMFA+uhGsaPCap4+MxSVJWPtmXQCYrykSj91230MRChD2n2J4FkFS/LrkSlYBpd
         smmvWDtpWN7FbiRM2Sce+SSzCqmYz7ixxvAF+8zHGXk/4s0ajDDXdlmk1NmDDOhdG+O5
         bGfATGrys1VhT+qNNyDX662nNcY6Pwdiw5QUfSAq0dzShhh7U3zuS3RMPrMq/03bDVa5
         OELQkqd3XyAE7W+5YXFCSofVCkIGa9P/C8i15Pmxnhkk1vqTyIVgBz2wO2YbLzFfdQii
         y4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fa2VGXxgeW6ECn5Gef1CpeYWB+LFL3W38AsWWJYtajw=;
        b=a+oWG34cTbFCPTvYjxd/ndqDLaJJv3SblaKcgNlZUBgnp/2gDM3LK7OWWPtBoywDAw
         KF4QsKJnmQjVVzZkdPUTpZh/3UzZzvMu8dawzbLjqS2722kHmrRC+spInWes3cNMQBpe
         W4VWUcZ7s9MsWVbZAo7HHJX23qrT7fK/emR0rWRvzcDOj1nwG2OzYJ2NxqXj26OPxNvJ
         lHBum2xLL0QxacAn1LlLdpoHiw0CZnS9b16yraBKzVby5YlArJo5IxhnnhwyY/hoJxnO
         QbVlfLE2SzU/19x66j7oWTaVkzPp55k3qEa5BndyFC2p2puP0ifyM9SGQXSAjW67lggk
         S8uA==
X-Gm-Message-State: AOAM530O9vI3240onYM2syHGjmTtZttOsqOfBIkf6P3oeE6/Qgt4e17H
        zPldPlYLJ+eae3CNyWyjEECakCHMeFg=
X-Google-Smtp-Source: ABdhPJy0jX299CnDb5QM+itdl49FcmOU54UED7ZXM8+oT6PK8wTer3Bns6uPBQxshWSPO2DWcKH/0w==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr1250119wml.28.1611596559190;
        Mon, 25 Jan 2021 09:42:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6sm5270940wrw.43.2021.01.25.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:38 -0800 (PST)
Message-Id: <05e7548b780da6b2bf2342d91d8757568df0a6b8.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:13 +0000
Subject: [PATCH 27/27] cache-tree: integrate with sparse directory entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
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

Once the cache-tree exists within a sparse index, we finally get
improved performance. I test the sparse index performance using a
private monorepo with over 2.1 million files at HEAD, but with a
sparse-checkout definition that has only 68,000 paths in the populated
cone. The sparse index has about 2,000 sparse directory entries. I
compare three scenarios:

 1. Use the full index. The index size is ~186 MB.
 2. Use the sparse index. The index size is ~5.5 MB.
 3. Use a commit where HEAD matches the populated set. The full index
    size is ~5.3MB.

The third benchmark is included as a theoretical optimium for a
repository of the same object database.

First, a clean 'git status' improves from 3.1s to 240ms.

Benchmark #1: full index (git status)
  Time (mean ± σ):      3.167 s ±  0.036 s    [User: 2.006 s, System: 1.078 s]
  Range (min … max):    3.100 s …  3.208 s    10 runs

Benchmark #2: sparse index (git status)
  Time (mean ± σ):     239.5 ms ±   8.1 ms    [User: 189.4 ms, System: 226.8 ms]
  Range (min … max):   226.0 ms … 251.9 ms    13 runs

Benchmark #3: small tree (git status)
  Time (mean ± σ):     195.3 ms ±   4.5 ms    [User: 116.5 ms, System: 84.4 ms]
  Range (min … max):   188.8 ms … 202.8 ms    15 runs

The optimimum is still 45ms faster. This is due in part to the 2,000+
sparse directory entries, but there might be other optimizations to make
in the sparse-index case. In particular, I find that this performance
difference disappears when I disable FS Monitor, which is somewhat
disabled in the sparse-index case, but might still be adding overhead.

The performance numbers for 'git add .' are much closer to optimal:

Benchmark #1: full index (git add .)
  Time (mean ± σ):      3.076 s ±  0.022 s    [User: 2.065 s, System: 0.943 s]
  Range (min … max):    3.044 s …  3.116 s    10 runs

Benchmark #2: sparse index (git add .)
  Time (mean ± σ):     218.0 ms ±   6.6 ms    [User: 195.7 ms, System: 206.6 ms]
  Range (min … max):   209.8 ms … 228.2 ms    13 runs

Benchmark #3: small tree (git add .)
  Time (mean ± σ):     217.6 ms ±   5.4 ms    [User: 131.9 ms, System: 86.7 ms]
  Range (min … max):   212.1 ms … 228.4 ms    14 runs

In this test, I also used "echo >>README.md" to append a line to the
README.md file, so the 'git add .' command is doing _something_ other
than a no-op. Without this edit (and FS Monitor enabled) the small
tree case again gains about 30ms on the sparse index case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c   | 18 ++++++++++++++++++
 sparse-index.c | 10 +++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5f07a39e501..9da6a4394e0 100644
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
+		if (S_ISSPARSEDIR(ce) &&
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
index a201f3b905c..9ea3b321400 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -181,7 +181,11 @@ int convert_to_sparse(struct index_state *istate)
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
@@ -278,6 +282,10 @@ void ensure_full_index(struct index_state *istate)
 
 	free(full);
 
+	/* Clear and recompute the cache-tree */
+	cache_tree_free(&istate->cache_tree);
+	cache_tree_update(istate, 0);
+
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
 
-- 
gitgitgadget
