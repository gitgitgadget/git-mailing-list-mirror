Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3837C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9929A64DD6
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 13:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhA3NAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 08:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhA3NAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 08:00:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67257C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 04:59:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m2so8866147wmm.1
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 04:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2UYxGp4zTSpe+BOqkOPjCkDzO2CpcOBs0GhMGvxtP8s=;
        b=Ds91QHbw3eJdpiR6GXjxQrtJ/TnGsJPuEzHIoD1dlcU/F0vv7BpJvWMJeRGMNijLAJ
         VvNidbUubqsxgNN88VpqWmnol9uz//JfwWB9DBmPXVId47dOGYBP0blS8rYCnD4wsvZe
         w6eR1Sk5sUdsmI6rXmQL/7xVNB0GO16814D7cgG0Y6V/hWiCk6y0uwQRcaUSAd81eeQa
         WDpO9r/m9uJqZr2BRn7qljGfE+CfhUMx7fDmL71qazZKebVdKDDKjsVHU0FRczq48jrC
         7AzJV5GkiykCGfsShkUymZB55brhym30VSWSlgZJQ+HOp2uK4mbMjjdwPyCzY7zRwGS9
         Tuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2UYxGp4zTSpe+BOqkOPjCkDzO2CpcOBs0GhMGvxtP8s=;
        b=BnbrcCHmVH3kCnUD3BI+k8bj24lUGinDEP79jjrrT+ILODaHoeMNYACxpeLf1lV96l
         9nmiJBV27uP3hUAiRYpzeaSb9Tux6WkVzDAhk7+obW8YhwiPZztjzPD+tzp6zca4Asza
         XZtw0MfZKfQfu+2KzNvqbmg8ZGNwZ9e784Ov/L+Sfr8U737XaIcQfX+VhQ8Sahl1yv2i
         0HIFhHakbZL3V06FOmt+ewAlrfc7XW4dVYaYgISxztBiYSp3EAMuQ2tAEVcLj3qT4KeF
         LtmP84YQKt6eKtjCrE3YmUcW5/e9uLA/QPmex6BMBDMkjGWbjgZouOsuu4G5E90w06YA
         4U2A==
X-Gm-Message-State: AOAM532gne/CpENTqeANjWCDP9+cdyBEMqbeKHlaLwPKx1jbz/TCJpJY
        UUMYTIjxdrpMcw3zE+M1oUWPUM68U7o=
X-Google-Smtp-Source: ABdhPJxuy+kw9U2mOyus8shwrxQkkc5RHyjnni1KXbdFosFIL3vqO1Ay9ZFpWuhsibqpLuhVKQrXPw==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr3491099wmj.35.1612011570539;
        Sat, 30 Jan 2021 04:59:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm13744043wmq.45.2021.01.30.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 04:59:30 -0800 (PST)
Message-Id: <pull.857.git.1612011569489.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 30 Jan 2021 12:59:28 +0000
Subject: [PATCH] alloc.h|c: migrate alloc_states to mem-pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

"alloc_state" may have similar effects with "mem_pool".
Using the new memory pool API may be more beneficial
to our memory management in the future.

So I change them in the "struct parsed_object_pool",and
The corresponding interface has also been changed.
functions "alloc_*_node" now change to "mem_pool_alloc_*_node".

At the same time ,I add the member `alloc_count` of
struct mem_pool ,so that we can effective track
node alloc count,and adapt to the original interface `alloc_report`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    alloc.h|c: migrate alloc_states to mem-pool
    
    Notice that "mem-pool" api may have similar effort with alloc_state,
    "parsed_object_pool" have five member with alloc_state type, and "TODO"
    usage in "object.h":"migrate alloc_states to mem-pool?", so let us
    change it to mem-pool version.
    
    After I learned the role of the memory pool,I think in the future git
    may be more inclined to use the memory pool instead of the old interface
    "alloc_state".
    
    Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-857%2Fadlternative%2Falloc_states_to_mem_pool-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-857/adlternative/alloc_states_to_mem_pool-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/857

 alloc.c           | 24 ++++++++++++------------
 alloc.h           | 10 +++++-----
 blame.c           |  2 +-
 blob.c            |  2 +-
 commit-graph.c    |  2 +-
 commit.c          |  2 +-
 mem-pool.c        |  6 ++++++
 mem-pool.h        |  8 ++++++++
 merge-recursive.c |  2 +-
 object.c          | 37 +++++++++++++++++++++----------------
 object.h          | 10 +++++-----
 tag.c             |  2 +-
 tree.c            |  2 +-
 13 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af3626..951ef3e4ed7 100644
--- a/alloc.c
+++ b/alloc.c
@@ -71,30 +71,30 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	return ret;
 }
 
-void *alloc_blob_node(struct repository *r)
+void *mem_pool_alloc_blob_node(struct repository *r)
 {
-	struct blob *b = alloc_node(r->parsed_objects->blob_state, sizeof(struct blob));
+	struct blob *b = mem_pool_calloc(r->parsed_objects->blob_pool, 1, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
-void *alloc_tree_node(struct repository *r)
+void *mem_pool_alloc_tree_node(struct repository *r)
 {
-	struct tree *t = alloc_node(r->parsed_objects->tree_state, sizeof(struct tree));
+	struct tree *t = mem_pool_calloc(r->parsed_objects->tree_pool, 1, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
-void *alloc_tag_node(struct repository *r)
+void *mem_pool_alloc_tag_node(struct repository *r)
 {
-	struct tag *t = alloc_node(r->parsed_objects->tag_state, sizeof(struct tag));
+	struct tag *t = mem_pool_calloc(r->parsed_objects->tag_pool, 1, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
-void *alloc_object_node(struct repository *r)
+void *mem_pool_alloc_object_node(struct repository *r)
 {
-	struct object *obj = alloc_node(r->parsed_objects->object_state, sizeof(union any_object));
+	struct object *obj = mem_pool_calloc(r->parsed_objects->object_pool, 1, sizeof(union any_object));
 	obj->type = OBJ_NONE;
 	return obj;
 }
@@ -116,9 +116,9 @@ void init_commit_node(struct commit *c)
 	c->index = alloc_commit_index();
 }
 
-void *alloc_commit_node(struct repository *r)
+void *mem_pool_alloc_commit_node(struct repository *r)
 {
-	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
+	struct commit *c = mem_pool_calloc(r->parsed_objects->commit_pool, 1, sizeof(struct commit));
 	init_commit_node(c);
 	return c;
 }
@@ -130,8 +130,8 @@ static void report(const char *name, unsigned int count, size_t size)
 }
 
 #define REPORT(name, type)	\
-    report(#name, r->parsed_objects->name##_state->count, \
-		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
+    report(#name, r->parsed_objects->name##_pool->alloc_count, \
+		  r->parsed_objects->name##_pool->alloc_count * sizeof(type) >> 10)
 
 void alloc_report(struct repository *r)
 {
diff --git a/alloc.h b/alloc.h
index 371d388b552..707b28b464e 100644
--- a/alloc.h
+++ b/alloc.h
@@ -7,12 +7,12 @@ struct commit;
 struct tag;
 struct repository;
 
-void *alloc_blob_node(struct repository *r);
-void *alloc_tree_node(struct repository *r);
+void *mem_pool_alloc_blob_node(struct repository *r);
+void *mem_pool_alloc_tree_node(struct repository *r);
 void init_commit_node(struct commit *c);
-void *alloc_commit_node(struct repository *r);
-void *alloc_tag_node(struct repository *r);
-void *alloc_object_node(struct repository *r);
+void *mem_pool_alloc_commit_node(struct repository *r);
+void *mem_pool_alloc_tag_node(struct repository *r);
+void *mem_pool_alloc_object_node(struct repository *r);
 void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
diff --git a/blame.c b/blame.c
index a5044fcfaa6..cbb9d8316c1 100644
--- a/blame.c
+++ b/blame.c
@@ -192,7 +192,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 	repo_read_index(r);
 	time(&now);
-	commit = alloc_commit_node(r);
+	commit = mem_pool_alloc_commit_node(r);
 	commit->object.parsed = 1;
 	commit->date = now;
 	parent_tail = &commit->parents;
diff --git a/blob.c b/blob.c
index 182718aba9f..787c7b2b016 100644
--- a/blob.c
+++ b/blob.c
@@ -9,7 +9,7 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_blob_node(r));
+		return create_object(r, oid, mem_pool_alloc_blob_node(r));
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 06f8dc1d896..edbcfd8a01e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2362,7 +2362,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
+		odb_commit = (struct commit *)create_object(r, &cur_oid, mem_pool_alloc_commit_node(r));
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
 				     oid_to_hex(&cur_oid));
diff --git a/commit.c b/commit.c
index fe1fa3dc41f..96d06737409 100644
--- a/commit.c
+++ b/commit.c
@@ -61,7 +61,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_commit_node(r));
+		return create_object(r, oid, mem_pool_alloc_commit_node(r));
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/mem-pool.c b/mem-pool.c
index 8401761dda0..d7bae84a982 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -35,6 +35,11 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *pool,
 	return p;
 }
 
+struct mem_pool *mem_pool_new(void)
+{
+	return xmalloc(sizeof(struct mem_pool));
+}
+
 void mem_pool_init(struct mem_pool *pool, size_t initial_size)
 {
 	memset(pool, 0, sizeof(*pool));
@@ -69,6 +74,7 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 	struct mp_block *p = NULL;
 	void *r;
 
+	pool->alloc_count++;
 	/* round up to a 'uintmax_t' alignment */
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
diff --git a/mem-pool.h b/mem-pool.h
index fe7507f022b..64529e136cf 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -19,8 +19,16 @@ struct mem_pool {
 
 	/* The total amount of memory allocated by the pool. */
 	size_t pool_alloc;
+
+	/* The count of calling mem_pool_alloc .*/
+	size_t alloc_count;
 };
 
+/*
+ * Create a new mem_pool.
+ */
+struct mem_pool *mem_pool_new(void);
+
 /*
  * Initialize mem_pool with specified initial size.
  */
diff --git a/merge-recursive.c b/merge-recursive.c
index f736a0f6323..62ef4e7b688 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -216,7 +216,7 @@ static struct commit *make_virtual_commit(struct repository *repo,
 					  struct tree *tree,
 					  const char *comment)
 {
-	struct commit *commit = alloc_commit_node(repo);
+	struct commit *commit = mem_pool_alloc_commit_node(repo);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	set_commit_tree(commit, tree);
diff --git a/object.c b/object.c
index 68f80b0b3d8..241933f6c88 100644
--- a/object.c
+++ b/object.c
@@ -182,7 +182,7 @@ struct object *lookup_unknown_object(const struct object_id *oid)
 	struct object *obj = lookup_object(the_repository, oid);
 	if (!obj)
 		obj = create_object(the_repository, oid,
-				    alloc_object_node(the_repository));
+				mem_pool_alloc_object_node(the_repository));
 	return obj;
 }
 
@@ -469,11 +469,16 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
 
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
+	o->blob_pool = mem_pool_new();
+	o->tree_pool = mem_pool_new();
+	o->commit_pool = mem_pool_new();
+	o->tag_pool = mem_pool_new();
+	o->object_pool = mem_pool_new();
+	mem_pool_init(o->blob_pool,0);
+	mem_pool_init(o->tree_pool,0);
+	mem_pool_init(o->commit_pool,0);
+	mem_pool_init(o->tag_pool,0);
+	mem_pool_init(o->object_pool,0);
 
 	o->is_shallow = -1;
 	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
@@ -566,16 +571,16 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	free_commit_buffer_slab(o->buffer_slab);
 	o->buffer_slab = NULL;
 
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	mem_pool_discard(o->blob_pool,1);
+	mem_pool_discard(o->tree_pool,1);
+	mem_pool_discard(o->tag_pool,1);
+	mem_pool_discard(o->object_pool,1);
+	mem_pool_discard(o->commit_pool,1);
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
+	FREE_AND_NULL(o->blob_pool);
+	FREE_AND_NULL(o->tree_pool);
+	FREE_AND_NULL(o->commit_pool);
+	FREE_AND_NULL(o->tag_pool);
+	FREE_AND_NULL(o->object_pool);
 	FREE_AND_NULL(o->shallow_stat);
 }
diff --git a/object.h b/object.h
index 59daadce214..43031d8dc04 100644
--- a/object.h
+++ b/object.h
@@ -10,11 +10,11 @@ struct parsed_object_pool {
 	int nr_objs, obj_hash_size;
 
 	/* TODO: migrate alloc_states to mem-pool? */
-	struct alloc_state *blob_state;
-	struct alloc_state *tree_state;
-	struct alloc_state *commit_state;
-	struct alloc_state *tag_state;
-	struct alloc_state *object_state;
+	struct mem_pool *blob_pool;
+	struct mem_pool *tree_pool;
+	struct mem_pool *commit_pool;
+	struct mem_pool *tag_pool;
+	struct mem_pool *object_pool;
 
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;
diff --git a/tag.c b/tag.c
index 1ed2684e45b..de24b6308b4 100644
--- a/tag.c
+++ b/tag.c
@@ -102,7 +102,7 @@ struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_tag_node(r));
+		return create_object(r, oid, mem_pool_alloc_tag_node(r));
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
diff --git a/tree.c b/tree.c
index e76517f6b18..7d61ae942e6 100644
--- a/tree.c
+++ b/tree.c
@@ -199,7 +199,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_tree_node(r));
+		return create_object(r, oid, mem_pool_alloc_tree_node(r));
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
