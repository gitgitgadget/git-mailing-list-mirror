Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C611F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfGZPxP (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42897 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfGZPxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so24952985plb.9
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cr+0X2cCWipVZOQ1XruJ+iMulc8IUJhByrpKZQ1WgHk=;
        b=TSgccGBdye2izW6OzHlzqry15NTl30uegG55AUERxtBXCThewhzJd6+CmxJ6PiUz60
         f+mfhjsLPP+rWHwqQSMAyygszbYjL7PjoATZ+AVpXWzD2dBr99UIoDk164cLeUFL6vX1
         P5Ae5fxDONszRjg9ngQoV2E4S8o5X92gyvFKtVJdEeTMaJPv2dug2dTpeyYLz7waeXNT
         VtAdZZARfJPirQh52y5WvtuYYygdvmnliReTHUw7uFmrpJ4ffG7jVLuk7NQp7yeWALD0
         zj+B+L/25Gpu666QN+ezjr7QtDVaC9NNQ35fnH3fGuxfi3rAN8HpjdmxL2xQoFQnn2hJ
         8scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cr+0X2cCWipVZOQ1XruJ+iMulc8IUJhByrpKZQ1WgHk=;
        b=FiEtzrsrbPt2nmra9uo/xNTu/IwMvLNjvTl17VlULM2P+ICt5E6ObDGPAEBTe5VXxV
         bDi2iODFOX64Mi8SHSyYZrKnWBawNT17l2mID6nSGQGCnt3QI57qV+O5VMyjgrxXIrQx
         W3WjBTlhDBiwSKx01NvGzjPahnQjSe75IJfoIs/V41mC190P/AVqL32ZAasKNfasyLfm
         JwkmFM4m1J+zdxycYst5p10U94N7EOZwmumT2dUTT6pzZKcMBaKW4jcW6a7z3K+j5dJA
         qplyMVCHhAo0eOc1jdE48Ap/1rnXf5BwMchza9PgVKRibdq6CH5OAr7KCGPRmk4Dh/mH
         96+w==
X-Gm-Message-State: APjAAAWAobeC87gXSyhy2h9OKwEr+/Tm2Z5rCnPz4+tqKN05l8pD4cqI
        UQYA/ZKmz9kCp1gwjjk7vqe0GaH3
X-Google-Smtp-Source: APXvYqzr+s5nGbljC0SdR1FP68/O7IRjVTPGNpGyrswdKa8d+k8t22+GlVJdi4b6rqDj62kWzN2rvQ==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr97769328pln.304.1564156392546;
        Fri, 26 Jul 2019 08:53:12 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 07/20] Use write_index_as_tree() in lieu of write_tree_from_memory()
Date:   Fri, 26 Jul 2019 08:52:45 -0700
Message-Id: <20190726155258.28561-8-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_tree_from_memory() appeared to be a merge-recursive special that
basically duplicated write_index_as_tree().  The two had a slightly
different call structure but the big difference was just that
write_index_as_tree() would always unconditionally read the index off of
disk instead of working on the current in-memory index.  Add a flag to
allow using the in-memory index, and then switch over to
write_index_as_tree().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c |  6 +++++-
 cache-tree.c       | 36 +++++++++++++++++++++++-------------
 cache-tree.h       |  3 ++-
 merge-recursive.c  | 42 +++++++++---------------------------------
 merge-recursive.h  |  1 -
 5 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 20e38c5edc..a7b6454061 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -709,6 +709,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * whether the merge flag was used.
 			 */
 			struct tree *work;
+			struct object_id work_oid;
 			struct tree *old_tree;
 			struct merge_options o;
 			struct strbuf sb = STRBUF_INIT;
@@ -759,7 +760,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_tree_from_memory(&o);
+			if (write_index_as_tree(&work_oid, &the_index, NULL,
+					WRITE_TREE_FROM_MEMORY, NULL) ||
+			    !(work = lookup_tree(the_repository, &work_oid)))
+				die(_("error building trees"));
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 706ffcf188..99144b1704 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -613,14 +613,19 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	int entries, was_valid;
 	struct lock_file lock_file = LOCK_INIT;
 	int ret = 0;
+	int access_disk = !(flags & WRITE_TREE_FROM_MEMORY);
 
-	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	if (access_disk) {
+		hold_lock_file_for_update(&lock_file, index_path,
+					  LOCK_DIE_ON_ERROR);
 
-	entries = read_index_from(index_state, index_path, get_git_dir());
-	if (entries < 0) {
-		ret = WRITE_TREE_UNREADABLE_INDEX;
-		goto out;
+		entries = read_index_from(index_state, index_path, get_git_dir());
+		if (entries < 0) {
+			ret = WRITE_TREE_UNREADABLE_INDEX;
+			goto out;
+		}
 	}
+
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
 		cache_tree_free(&index_state->cache_tree);
 
@@ -633,13 +638,16 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 			ret = WRITE_TREE_UNMERGED_INDEX;
 			goto out;
 		}
-		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
-		/* Not being able to write is fine -- we are only interested
-		 * in updating the cache-tree part, and if the next caller
-		 * ends up using the old index with unupdated cache-tree part
-		 * it misses the work we did here, but that is just a
-		 * performance penalty and not a big deal.
-		 */
+		if (access_disk) {
+			write_locked_index(index_state, &lock_file, COMMIT_LOCK);
+			/* Not being able to write is fine -- we are only
+			 * interested in updating the cache-tree part, and if
+			 * the next caller ends up using the old index with
+			 * unupdated cache-tree part it misses the work we
+			 * did here, but that is just a performance penalty
+			 * and not a big deal.
+			 */
+		}
 	}
 
 	if (prefix) {
@@ -655,7 +663,9 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 		oidcpy(oid, &index_state->cache_tree->oid);
 
 out:
-	rollback_lock_file(&lock_file);
+	if (access_disk)
+		rollback_lock_file(&lock_file);
+
 	return ret;
 }
 
diff --git a/cache-tree.h b/cache-tree.h
index 757bbc48bc..481ec45dfa 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -34,12 +34,13 @@ int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
 void cache_tree_verify(struct repository *, struct index_state *);
 
-/* bitmasks to write_cache_as_tree flags */
+/* bitmasks to write_index_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
 #define WRITE_TREE_DRY_RUN 4
 #define WRITE_TREE_SILENT 8
 #define WRITE_TREE_REPAIR 16
+#define WRITE_TREE_FROM_MEMORY 32
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/merge-recursive.c b/merge-recursive.c
index 308e350ff1..6c38c02e3f 100644
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
@@ -3471,8 +3440,15 @@ static int merge_trees_internal(struct merge_options *opt,
 
 	unpack_trees_finish(opt);
 
-	if (opt->call_depth && !(*result = write_tree_from_memory(opt)))
-		return -1;
+	if (opt->call_depth) {
+		struct object_id tree_id;
+		if (write_index_as_tree(&tree_id, opt->repo->index, NULL,
+					WRITE_TREE_FROM_MEMORY, NULL) ||
+		    !(*result = lookup_tree(opt->repo, &tree_id))) {
+			err(opt, _("error building trees"));
+			return -1;
+		}
+	}
 
 	return clean;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 812c456f1b..b3394502c7 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -109,7 +109,6 @@ int merge_recursive_generic(struct merge_options *o,
 
 void init_merge_options(struct merge_options *o,
 			struct repository *repo);
-struct tree *write_tree_from_memory(struct merge_options *o);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
 
-- 
2.22.0.550.g71c37a0928.dirty

