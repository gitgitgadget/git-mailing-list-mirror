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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95602C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C65A22B3F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbhAYR5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbhAYR4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5834EC06121F
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so13808921wrx.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bgdoJjG5Sk7TG4mfT3ECXJqwtfoumNFy7HwY4DtEyH8=;
        b=K64x8U2x1//HycKNHwNliIp8D0duP+G4KVfyWghVPPNEmokKm/sfqT9bXWFiFB6mwO
         gwIPnAsXUS/rWPWSpRuaXym5eeLGG6MybyuQObgC2l9iNnmAT4UbQzCpYz+nwTI+FGHz
         u4UnxHgNEnwIGnuTS8iong2Y9oSvEE1oKtg4uU3p+liE5EI1LFA1uDgMtYuBE44fNpWO
         DcQ5tIdYuSMpRF9ZXhFvmCPZHj2EEE2dsqieUQ9XGlWhVT7QqRyYKQmmZIinTordZE29
         VktIahM53VzT7waOcVFUI5VbaB97pfWgn3RBriRa5XRTg/rUs4uGrpJnQ9rQVRBqQ0GM
         e+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bgdoJjG5Sk7TG4mfT3ECXJqwtfoumNFy7HwY4DtEyH8=;
        b=UysDp83D1sjvcP8lkHktwc0Cx7ziYxwfI0oJqy29neycgWUMuQGaY9jbN/j1ezv0/W
         P9ARCJEKsADMJ2uvQ93Il5MQY5LsqHepJ7xSaA7PpMMC1NFIc6zd4Jh9GdqzRbKBtCSo
         sj8kx8DvrQWCJ5A0IoT4C5OdNA9AcI5taBD7fPaV/Yu6PKghPgud0CG3KKRnEk+unU7I
         IzWAn4HJXUW1zEmlq7go2UxjzH4py5wrhxyRDzr6jjDEZj+Zt2ajqJ2UE6Hp4QQdsrlj
         50d3W3O89y6BkwpZG5lygLJ+L67fMYOQwU0AKz3G4LCHhYKn9GjndTGFQ9oSlRxB46UD
         CS0w==
X-Gm-Message-State: AOAM530mzevyrJO+6C4gCkqrA4tJMHpOwGAkHgVqnb9k8oeScJI1XqUk
        1QPE6UwsJrb08o+52Gfvvn8mwQLlJPg=
X-Google-Smtp-Source: ABdhPJy4Eh/xcxJznGUlmYoifq2Xu7BtErHiUdvmrEUP1M4Z4MyN1NqRFGsICMTyEY9jAIPS3GAJmg==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr2241656wri.77.1611596549946;
        Mon, 25 Jan 2021 09:42:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm2931197wrh.16.2021.01.25.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:29 -0800 (PST)
Message-Id: <45cf57c9c40bebb7383b8aab19c82fc4e41d2cd3.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:02 +0000
Subject: [PATCH 16/27] unpack-trees: make sparse aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As a first step to integrate 'git status' and 'git add' with the sparse
index, we must start integrating unpack_trees() with sparse directory
entries. These changes are currently impossible to trigger because
unpack_trees() calls ensure_full_index() if command_requires_full_index
is true. This is the case for all commands at the moment. As we expand
more commands to be sparse-aware, we might find that more changes are
required to unpack_trees(). The current changes will suffice for
'status' and 'add'.

unpack_trees() calls the traverse_trees() API using unpack_callback()
to decide if we should recurse into a subtree. We must add new abilities
to skip a subtree if it corresponds to a sparse directory entry.

It is important to be careful about the trailing directory separator
that exists in the sparse directory entries but not in the subtree
paths.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.h           |  2 +-
 preload-index.c |  2 ++
 read-cache.c    |  3 +++
 unpack-trees.c  | 24 ++++++++++++++++++++++--
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/dir.h b/dir.h
index facfae47402..300305ec335 100644
--- a/dir.h
+++ b/dir.h
@@ -503,7 +503,7 @@ static inline int ce_path_match(const struct index_state *istate,
 				char *seen)
 {
 	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
-			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
+			      S_ISSPARSEDIR(ce) || S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
 }
 
 static inline int dir_path_match(const struct index_state *istate,
diff --git a/preload-index.c b/preload-index.c
index ed6eaa47388..323fc8c5100 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -54,6 +54,8 @@ static void *preload_thread(void *_data)
 			continue;
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
+		if (S_ISSPARSEDIR(ce))
+			continue;
 		if (ce_uptodate(ce))
 			continue;
 		if (ce_skip_worktree(ce))
diff --git a/read-cache.c b/read-cache.c
index 65679d70d7c..ab0c2b86ec0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1572,6 +1572,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
+		if (istate->sparse_index && S_ISSPARSEDIR(ce))
+			continue;
+
 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index b324eec2a5d..90644856a80 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -583,6 +583,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
+	/*
+	 * If this is a sparse directory, don't advance cache_bottom.
+	 * That will be advanced later using the cache-tree data.
+	 */
+	if (S_ISSPARSEDIR(ce))
+		return;
+
 	if (o->cache_bottom < o->src_index->cache_nr &&
 	    o->src_index->cache[o->cache_bottom] == ce) {
 		int bottom = o->cache_bottom;
@@ -980,6 +987,9 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
+	/* remove directory separator if a sparse directory entry */
+	if (S_ISSPARSEDIR(ce))
+		ce_len--;
 	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
 }
 
@@ -989,6 +999,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/* If ce is a sparse directory, then allow equality here. */
+	if (S_ISSPARSEDIR(ce))
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
@@ -1239,6 +1253,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	unsigned recurse = 1;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1280,12 +1295,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 					}
 				}
 				src[0] = ce;
+
+				if (S_ISSPARSEDIR(ce))
+					recurse = 0;
 			}
 			break;
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (recurse &&
+	    unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1315,7 +1334,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+		if (recurse &&
+		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 					     names, info) < 0)
 			return -1;
 		return mask;
-- 
gitgitgadget

