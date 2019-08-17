Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58421F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHQSmR (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36395 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHQSmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so3834973plo.3
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svTCqw8bhIJBNIHlB2Dx/Hi5zEMw9Nn1HDbpu30uCws=;
        b=oLUQZGSZaEF+tXM99stP1wY+ejoT6a7zLIsbOfarFEDyA1WKz+9cgpc7D4EYrIcZhn
         KRSe1pMxk1YIaIR6c6yaJ0033yxBQMLK4NhXzQQGXj/1DRHUNC5loHe1+kieoDt2Z3Pl
         MG6RU0jguBce7dHwTUuUdsW51DJBy0ud15liOxPg2vY+U4Xqj2Es8o6+m9DGt1UIMraX
         WS7rPNHu3Qvm86V5HFmIuGVug62/APcdA2Bb+g5Zk4mjNnG+WKAyFAUHLeMjRHF6gFnR
         Z7VFPlyhjb7IUx4+gWZFPmReldP39/S/n9tnIgcM03+C59+4oAstF+px4kL/aI05mEHf
         zpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svTCqw8bhIJBNIHlB2Dx/Hi5zEMw9Nn1HDbpu30uCws=;
        b=ok+rLR2sgDmbleQvLUH1OrErzO7AC6EQbiCBQ/v+KoMUvXQnulDSpXPtrq4CAfie6Q
         g82h1VjJLSYs74DVL4aN7wlE1ztxkR2e9vkZ7B8MDi3SouFvrlx4JtzEwjmEFcjesUXo
         k/ppZ/bYQyGNpzh9x62hjkhC3BdPJPrnunTzyeSopSJn0mRgow0TGRIbR8bHf4ltJ4gw
         +aZxkg6asuYl4S3cqs4BLC1ip6qSWnUjspFceM25UjSJT8JYh+z4B2mJcrT5NKprk5rj
         Dx9CdbsqCgl4Hv8TwZ5gfaHKLr/J5kXhY/BWrUZH7ySZG6LZfOdgIohocogTR4h+Lkp8
         baQg==
X-Gm-Message-State: APjAAAVFEjDYJGDQgVoriRDXWKTSLGd9BFlgQ7FCws8frzI46Rzj7o22
        KlwDKGPXaAb2Y2g/b8Uv7zZMfkuN
X-Google-Smtp-Source: APXvYqxqC9iF6sx86mg5ELNwOKCAVty27JHz0myDlUk4jsB7AXEtIAE9GkTciBrvEjYw4chTs8QUmw==
X-Received: by 2002:a17:902:1027:: with SMTP id b36mr14562692pla.203.1566067332132;
        Sat, 17 Aug 2019 11:42:12 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 12/24] cache-tree: share code between functions writing an index as a tree
Date:   Sat, 17 Aug 2019 11:41:32 -0700
Message-Id: <20190817184144.32179-13-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_tree_from_memory() appeared to be a merge-recursive special that
basically duplicated write_index_as_tree().  The two have a different
signature, but the bigger difference was just that write_index_as_tree()
would always unconditionally read the index off of disk instead of
working on the current in-memory index.  So:

  * split out common code into write_index_as_tree_internal()

  * rename write_tree_from_memory() to write_inmemory_index_as_tree(),
    make it call write_index_as_tree_internal(), and move it to
    cache-tree.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c |  2 +-
 cache-tree.c       | 85 +++++++++++++++++++++++++++++++++-------------
 cache-tree.h       |  3 +-
 merge-recursive.c  | 34 ++-----------------
 merge-recursive.h  |  1 -
 5 files changed, 67 insertions(+), 58 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 90e0eaf25e..5e41fc1c01 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -760,7 +760,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_tree_from_memory(&o);
+			work = write_in_core_index_as_tree(the_repository);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 706ffcf188..fbb5252521 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -608,11 +608,66 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	return it;
 }
 
+static int write_index_as_tree_internal(struct object_id *oid,
+					struct index_state *index_state,
+					int cache_tree_valid,
+					int flags,
+					const char *prefix)
+{
+	if (flags & WRITE_TREE_IGNORE_CACHE_TREE) {
+		cache_tree_free(&index_state->cache_tree);
+		cache_tree_valid = 0;
+	}
+
+	if (!index_state->cache_tree)
+		index_state->cache_tree = cache_tree();
+
+	if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
+		return WRITE_TREE_UNMERGED_INDEX;
+
+	if (prefix) {
+		struct cache_tree *subtree;
+		subtree = cache_tree_find(index_state->cache_tree, prefix);
+		if (!subtree)
+			return WRITE_TREE_PREFIX_ERROR;
+		oidcpy(oid, &subtree->oid);
+	}
+	else
+		oidcpy(oid, &index_state->cache_tree->oid);
+
+	return 0;
+}
+
+struct tree* write_in_core_index_as_tree(struct repository *repo) {
+	struct object_id o;
+	int was_valid, ret;
+
+	struct index_state *index_state	= repo->index;
+	was_valid = index_state->cache_tree &&
+		    cache_tree_fully_valid(index_state->cache_tree);
+
+	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
+	if (ret == WRITE_TREE_UNMERGED_INDEX) {
+		int i;
+		fprintf(stderr, "BUG: There are unmerged index entries:\n");
+		for (i = 0; i < index_state->cache_nr; i++) {
+			const struct cache_entry *ce = index_state->cache[i];
+			if (ce_stage(ce))
+				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
+					(int)ce_namelen(ce), ce->name);
+		}
+		BUG("unmerged index entries when writing inmemory index");
+	}
+
+	return lookup_tree(repo, &index_state->cache_tree->oid);
+}
+
+
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid;
 	struct lock_file lock_file = LOCK_INIT;
-	int ret = 0;
+	int ret;
 
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
@@ -621,18 +676,14 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 		ret = WRITE_TREE_UNREADABLE_INDEX;
 		goto out;
 	}
-	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
-		cache_tree_free(&index_state->cache_tree);
 
-	if (!index_state->cache_tree)
-		index_state->cache_tree = cache_tree();
+	was_valid = !(flags & WRITE_TREE_IGNORE_CACHE_TREE) &&
+		    index_state->cache_tree &&
+		    cache_tree_fully_valid(index_state->cache_tree);
 
-	was_valid = cache_tree_fully_valid(index_state->cache_tree);
-	if (!was_valid) {
-		if (cache_tree_update(index_state, flags) < 0) {
-			ret = WRITE_TREE_UNMERGED_INDEX;
-			goto out;
-		}
+	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
+					   prefix);
+	if (!ret && !was_valid) {
 		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
@@ -642,18 +693,6 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 		 */
 	}
 
-	if (prefix) {
-		struct cache_tree *subtree;
-		subtree = cache_tree_find(index_state->cache_tree, prefix);
-		if (!subtree) {
-			ret = WRITE_TREE_PREFIX_ERROR;
-			goto out;
-		}
-		oidcpy(oid, &subtree->oid);
-	}
-	else
-		oidcpy(oid, &index_state->cache_tree->oid);
-
 out:
 	rollback_lock_file(&lock_file);
 	return ret;
diff --git a/cache-tree.h b/cache-tree.h
index 757bbc48bc..639bfa5340 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -34,7 +34,7 @@ int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
 void cache_tree_verify(struct repository *, struct index_state *);
 
-/* bitmasks to write_cache_as_tree flags */
+/* bitmasks to write_index_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
 #define WRITE_TREE_DRY_RUN 4
@@ -46,6 +46,7 @@ void cache_tree_verify(struct repository *, struct index_state *);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
+struct tree* write_in_core_index_as_tree(struct repository *repo);
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index fda67dd371..ae509357f7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -412,37 +412,6 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->unpack_opts);
 }
 
-struct tree *write_tree_from_memory(struct merge_options *opt)
-{
-	struct tree *result = NULL;
-	struct index_state *istate = opt->repo->index;
-
-	if (unmerged_index(istate)) {
-		int i;
-		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < istate->cache_nr; i++) {
-			const struct cache_entry *ce = istate->cache[i];
-			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
-		}
-		BUG("unmerged index entries in merge-recursive.c");
-	}
-
-	if (!istate->cache_tree)
-		istate->cache_tree = cache_tree();
-
-	if (!cache_tree_fully_valid(istate->cache_tree) &&
-	    cache_tree_update(istate, 0) < 0) {
-		err(opt, _("error building trees"));
-		return NULL;
-	}
-
-	result = lookup_tree(opt->repo, &istate->cache_tree->oid);
-
-	return result;
-}
-
 static int save_files_dirs(const struct object_id *oid,
 			   struct strbuf *base, const char *path,
 			   unsigned int mode, int stage, void *context)
@@ -3472,7 +3441,8 @@ static int merge_trees_internal(struct merge_options *opt,
 
 	unpack_trees_finish(opt);
 
-	if (opt->call_depth && !(*result = write_tree_from_memory(opt)))
+	if (opt->call_depth &&
+	    !(*result = write_in_core_index_as_tree(opt->repo)))
 		return -1;
 
 	return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index 18012fff9d..0a3033bdb0 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -113,7 +113,6 @@ int merge_recursive_generic(struct merge_options *o,
 
 void init_merge_options(struct merge_options *o,
 			struct repository *repo);
-struct tree *write_tree_from_memory(struct merge_options *o);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
 
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

