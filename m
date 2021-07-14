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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B69BC11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551AD613B9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhGNNPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbhGNNPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A41C0613DF
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l6so1582178wmq.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rdWXkfQTLvIz7ehzDiOhfTz5BcsQsOXPmLHI2CCiI4k=;
        b=WpujC0ODkzK2hRtXEHi0dmKCAbT31lnSEUm66H88BMtj7N7acP3F542rD/VXoCgAH6
         7/1RRaCRYjhWl2KPGIVdKOMrTUmnivOwpqL3EMUWoijFbLIgqTfVUDx6mSuYMNO9NchG
         lzByHloAFr/+2PwQwrMoYXVVrERfh6sTQpdUKKjYEjDmUKnUXWGn4toXeNgHdeFe2ZVR
         sM8HypNCBA7cjBAwJokRxWaNk5Ak0GzU6jp+ScV4yoMo7jK7rxugNv0/2R3KVRN5Dp6C
         nnf1Us1RzuLbWrSxIL1BZnsLKeMQ0naicg0FgH/9NOkoQD0Fo3TwF3aKZyjhQ3ApRqWg
         pTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rdWXkfQTLvIz7ehzDiOhfTz5BcsQsOXPmLHI2CCiI4k=;
        b=umiuJCpfo8ajgJjZFbVSPnPH7G0/96zcvXUsi5xPfCydJVd36GR4ueZE55WzkLkyJ2
         iZf3Nc8BrTsDK53CNrdOmVJnGZhdtpxbGe6K65msxnw2UEla2od5PaRbLYHfcLwwVbHx
         TTr37/VRvntP780TTOqukJjq+i7asFju0XEp4qzRCIqjH191moxLu8OMIkpA8TeHcuDx
         vjJSGASvfV99ax45K87FtrM86uDeB7+i/arkdiLe6kxFIBDShJLPR16wWqz4xE5OT52v
         c4Lcs104WYvB8nHKkurbPn61kcime/FCUpeuA1lXJeyshv9L20FEDNi9EH7t7tLR5h4O
         g28w==
X-Gm-Message-State: AOAM531W1Kr8R+CWNohFXZPKsqKRT2g0Mb1+En1hiXFzLA86/Fk8C34M
        9c//wnvZ3iLrhtJgApRfwpPIMrfZdK4=
X-Google-Smtp-Source: ABdhPJyVy2mYz21d06CSq6yaXaH6E6y8S3GD4FKz5knlsDUD1Ah/oKcdxRiWp3MbzPlQnET8aksxpA==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr10967284wmm.153.1626268370990;
        Wed, 14 Jul 2021 06:12:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23sm2082599wmc.38.2021.07.14.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:50 -0700 (PDT)
Message-Id: <602525f5d71df71ff5f8071f9d87f6e3a7b7f5c6.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:33 +0000
Subject: [PATCH v9 09/16] unpack-trees: unpack sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During unpack_callback(), index entries are compared against tree
entries. These are matched according to names and types. One goal is to
decide if we should recurse into subtrees or simply operate on one index
entry.

In the case of a sparse-directory entry, we do not want to recurse into
that subtree and instead simply compare the trees. In some cases, we
might want to perform a merge operation on the entry, such as during
'git checkout <commit>' which wants to replace a sparse tree entry with
the tree for that path at the target commit. We extend the logic within
unpack_single_entry() to create a sparse-directory entry in this case,
and then that is sent to call_unpack_fn().

There are some subtleties in this process. For instance, we need to
update find_cache_entry() to allow finding a sparse-directory entry that
exactly matches a given path. Use the new helper method
sparse_dir_matches_path() for this. We also need to ignore conflict
markers in the case that the entries correspond to directories and we
already have a sparse directory entry.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 107 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d26386ce8b2..0a5135ab397 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1052,13 +1052,15 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	const struct name_entry *n,
 	int stage,
 	struct index_state *istate,
-	int is_transient)
+	int is_transient,
+	int is_sparse_directory)
 {
 	size_t len = traverse_path_len(info, tree_entry_len(n));
+	size_t alloc_len = is_sparse_directory ? len + 1 : len;
 	struct cache_entry *ce =
 		is_transient ?
-		make_empty_transient_cache_entry(len, NULL) :
-		make_empty_cache_entry(istate, len);
+		make_empty_transient_cache_entry(alloc_len, NULL) :
+		make_empty_cache_entry(istate, alloc_len);
 
 	ce->ce_mode = create_ce_mode(n->mode);
 	ce->ce_flags = create_ce_flags(stage);
@@ -1067,6 +1069,13 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	/* len+1 because the cache_entry allocates space for NUL */
 	make_traverse_path(ce->name, len + 1, info, n->path, n->pathlen);
 
+	if (is_sparse_directory) {
+		ce->name[len] = '/';
+		ce->name[len + 1] = '\0';
+		ce->ce_namelen++;
+		ce->ce_flags |= CE_SKIP_WORKTREE;
+	}
+
 	return ce;
 }
 
@@ -1085,10 +1094,17 @@ static int unpack_single_entry(int n, unsigned long mask,
 	struct unpack_trees_options *o = info->data;
 	unsigned long conflicts = info->df_conflicts | dirmask;
 
-	/* Do we have *only* directories? Nothing to do */
 	if (mask == dirmask && !src[0])
 		return 0;
 
+	/*
+	 * When we have a sparse directory entry for src[0],
+	 * then this isn't necessarily a directory-file conflict.
+	 */
+	if (mask == dirmask && src[0] &&
+	    S_ISSPARSEDIR(src[0]->ce_mode))
+		conflicts = 0;
+
 	/*
 	 * Ok, we've filled in up to any potential index entry in src[0],
 	 * now do the rest.
@@ -1118,7 +1134,9 @@ static int unpack_single_entry(int n, unsigned long mask,
 		 * not stored in the index.  otherwise construct the
 		 * cache entry from the index aware logic.
 		 */
-		src[i + o->merge] = create_ce_entry(info, names + i, stage, &o->result, o->merge);
+		src[i + o->merge] = create_ce_entry(info, names + i, stage,
+						    &o->result, o->merge,
+						    bit & dirmask);
 	}
 
 	if (o->merge) {
@@ -1222,16 +1240,71 @@ static int find_cache_pos(struct traverse_info *info,
 	return -1;
 }
 
+/*
+ * Given a sparse directory entry 'ce', compare ce->name to
+ * info->name + '/' + p->path + '/' if info->name is non-empty.
+ * Compare ce->name to p->path + '/' otherwise. Note that
+ * ce->name must end in a trailing '/' because it is a sparse
+ * directory entry.
+ */
+static int sparse_dir_matches_path(const struct cache_entry *ce,
+				   struct traverse_info *info,
+				   const struct name_entry *p)
+{
+	assert(S_ISSPARSEDIR(ce->ce_mode));
+	assert(ce->name[ce->ce_namelen - 1] == '/');
+
+	if (info->namelen)
+		return ce->ce_namelen == info->namelen + p->pathlen + 2 &&
+		       ce->name[info->namelen] == '/' &&
+		       !strncmp(ce->name, info->name, info->namelen) &&
+		       !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen);
+	return ce->ce_namelen == p->pathlen + 1 &&
+	       !strncmp(ce->name, p->path, p->pathlen);
+}
+
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
+	struct cache_entry *ce;
 	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
 
 	if (0 <= pos)
 		return o->src_index->cache[pos];
-	else
+
+	/*
+	 * Check for a sparse-directory entry named "path/".
+	 * Due to the input p->path not having a trailing
+	 * slash, the negative 'pos' value overshoots the
+	 * expected position, hence "-2" instead of "-1".
+	 */
+	pos = -pos - 2;
+
+	if (pos < 0 || pos >= o->src_index->cache_nr)
 		return NULL;
+
+	/*
+	 * Due to lexicographic sorting and sparse directory
+	 * entries ending with a trailing slash, our path as a
+	 * sparse directory (e.g "subdir/") and	our path as a
+	 * file (e.g. "subdir") might be separated by other
+	 * paths (e.g. "subdir-").
+	 */
+	while (pos >= 0) {
+		ce = o->src_index->cache[pos];
+
+		if (strncmp(ce->name, p->path, p->pathlen))
+			return NULL;
+
+		if (S_ISSPARSEDIR(ce->ce_mode) &&
+		    sparse_dir_matches_path(ce, info, p))
+			return ce;
+
+		pos--;
+	}
+
+	return NULL;
 }
 
 static void debug_path(struct traverse_info *info)
@@ -1266,6 +1339,21 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
+/*
+ * Returns true if and only if the given cache_entry is a
+ * sparse-directory entry that matches the given name_entry
+ * from the tree walk at the given traverse_info.
+ */
+static int is_sparse_directory_entry(struct cache_entry *ce,
+				     struct name_entry *name,
+				     struct traverse_info *info)
+{
+	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+
+	return sparse_dir_matches_path(ce, info, name);
+}
+
 /*
  * Note that traverse_by_cache_tree() duplicates some logic in this function
  * without actually calling it. If you change the logic here you may need to
@@ -1352,9 +1440,12 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
-					     names, info) < 0)
+		if (!is_sparse_directory_entry(src[0], names, info) &&
+		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+						    names, info) < 0) {
 			return -1;
+		}
+
 		return mask;
 	}
 
-- 
gitgitgadget

