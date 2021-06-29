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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23096C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067C861CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhF2Byc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhF2ByR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B494C061768
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g198so4750827wme.5
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CUntNiF3tA3T57fQ1h5xuY8xT0tmjHBndAZRrek1+qw=;
        b=jhERgwvGwmRinaIjUl46z3uPdqNDEL/eoxsh3ax7ue4YVt/q/OJ2wK5REcj+p+1yH8
         4rN/tDGwrxYU4wTOJfc3iFNfUgmjhvnz9jcVpGzsaOprUx015WbtQsvWaXVXgnd7TYZC
         5+uQuiw4yA9Hku/EVeByrUPmRi5bhMiYteBnyi1Kss7ocp5M17LaVxeZM/YBWMwxSo0T
         VSIru3mvfL9U5+w/yikBM3Gb77GPvFQS0dmxOnE0N7KCQh/Csh0lbHNeUyfXmv+89u87
         Svg/FlUDeKdVnfqDz4+VzZP1G6fUrCXtkZx0ajtsNhXRnthIhiS7F9+xQqss7g/7056x
         JbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CUntNiF3tA3T57fQ1h5xuY8xT0tmjHBndAZRrek1+qw=;
        b=FDSh4wBZYt51XCj8IW35z7fve7FaXtyt2b5eElGL+FQTF3WwDd9Lnk3vO1PBcqg4xD
         kiazuAxhh8YnR/iRXsaJlgMcudp+xLTtVv9Tgy8+Sngo/dZR6kP3/eaKN1128FGI8RYA
         IjvwtJA5X2bK6QdSBh+Gw0X4P5gIWT8lgCAUScVVL47lU7YK9/VvUItUZqC9lHBubTdA
         YNxVuLCmKQoWJTusaJ2jXD1QDItqyC8LUfW1RwAfKtGRxD2QH1QYt1zCn1j+oaV84Vlx
         9UFg45GLoQ52qv1DPZtiZXWmKJb6TAR+HRWstuPXu397sX4WZ96axXu8mvAl4Q8+9qCw
         S4Mg==
X-Gm-Message-State: AOAM532RVVigkx7YokOF511eaIyMshHYQMJIWRlv5RZ7zCSvnGlp1joz
        DOSq0Oc+jLUxsDvt1jbAes3zPYSso8I=
X-Google-Smtp-Source: ABdhPJxmQ6vzbQT1FzirAwTneqVgQpG+YCWGetxSADSvXiVBmqOQZd/dZ76iXxSxDVPx9XtTHPsC4w==
X-Received: by 2002:a05:600c:3650:: with SMTP id y16mr28743543wmq.25.1624931508638;
        Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n29sm1017137wms.34.2021.06.28.18.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
Message-Id: <b676ef4925ba214cffcfd1f4ea8185cdc5e7a0ed.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:36 +0000
Subject: [PATCH v6 08/14] unpack-trees: unpack sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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
unpack_nondirectories() to create a sparse-directory entry in this case,
and then that is sent to call_unpack_fn(). Since the name becomes
confusing by handling directories, rename it to unpack_single_entry()
since it handles a blob entry or a sparse directory entry without using
traverse_trees_recursive().

There are some subtleties in this process. For instance, we need to
update find_cache_entry() to allow finding a sparse-directory entry that
exactly matches a given path. Use the new helper method
sparse_dir_matches_path() for this.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 110 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 14 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7a507ddfe05..d205a15d61f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1051,13 +1051,15 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
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
@@ -1066,6 +1068,13 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
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
 
@@ -1074,20 +1083,28 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
  * without actually calling it. If you change the logic here you may need to
  * check and change there as well.
  */
-static int unpack_nondirectories(int n, unsigned long mask,
-				 unsigned long dirmask,
-				 struct cache_entry **src,
-				 const struct name_entry *names,
-				 const struct traverse_info *info)
+static int unpack_single_entry(int n, unsigned long mask,
+			       unsigned long dirmask,
+			       struct cache_entry **src,
+			       const struct name_entry *names,
+			       const struct traverse_info *info,
+			       int sparse_directory)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
 	unsigned long conflicts = info->df_conflicts | dirmask;
 
-	/* Do we have *only* directories? Nothing to do */
 	if (mask == dirmask && !src[0])
 		return 0;
 
+	/* defer work if our cache entry doesn't match the expectations. */
+	if (sparse_directory) {
+		if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
+			BUG("expected sparse directory entry");
+	} else if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode)) {
+		return 0;
+	}
+
 	/*
 	 * Ok, we've filled in up to any potential index entry in src[0],
 	 * now do the rest.
@@ -1117,7 +1134,9 @@ static int unpack_nondirectories(int n, unsigned long mask,
 		 * not stored in the index.  otherwise construct the
 		 * cache entry from the index aware logic.
 		 */
-		src[i + o->merge] = create_ce_entry(info, names + i, stage, &o->result, o->merge);
+		src[i + o->merge] = create_ce_entry(info, names + i, stage,
+						    &o->result, o->merge,
+						    sparse_directory);
 	}
 
 	if (o->merge) {
@@ -1221,16 +1240,59 @@ static int find_cache_pos(struct traverse_info *info,
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
+	 * expected position by one, hence "-2" here.
+	 */
+	pos = -pos - 2;
+
+	if (pos < 0 || pos >= o->src_index->cache_nr)
 		return NULL;
+
+	ce = o->src_index->cache[pos];
+
+	if (!S_ISSPARSEDIR(ce->ce_mode))
+		return NULL;
+
+	if (sparse_dir_matches_path(ce, info, p))
+		return ce;
+
+	return NULL;
 }
 
 static void debug_path(struct traverse_info *info)
@@ -1265,6 +1327,21 @@ static void debug_unpack_callback(int n,
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
@@ -1321,7 +1398,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info, 0) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1351,9 +1428,14 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
-					     names, info) < 0)
+		if (is_sparse_directory_entry(src[0], names, info)) {
+			if (unpack_single_entry(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
+				return -1;
+		} else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+						    names, info) < 0) {
 			return -1;
+		}
+
 		return mask;
 	}
 
-- 
gitgitgadget

