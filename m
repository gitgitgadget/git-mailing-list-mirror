Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A471CC43381
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5565664E34
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 10:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhBDKf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhBDKd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 05:33:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626FAC06178C
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 02:33:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u14so2898799wri.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 02:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KHlowqSvJ4o7UR+ifUb98m80DgF8R2DDyIasFRBVVAM=;
        b=Bvjdyo5Qy8GSPHlE24qsjZm0nOw5wt3rKOaxs2zVPZe6HuYRzNQujzCuK+eZPh/Mp1
         9jNkuIUBo19poyVxMrUiHI6NssHlj7Dt7Zd6vGluPLv11Bdv6JhtZ5HiAhDhD6qjfpKq
         zRYKhhAYd5nWTxWSvqTNzVxqBDkulX+buC/K5DCBkDXwxsU95wgELQET93jwK3tZDEds
         hus+7JIDiDsHdGps36EC80hX+yzfEhuSZjuJHBrIOT24/6COggmGWtIpsLGKdedaidyq
         yOj2+ASU9Y1yGo8pG2aoMYgLOJ2m55orU3wGOms+jMK9LOyYXVUTPY4yYPRaEPJeCFLG
         3/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KHlowqSvJ4o7UR+ifUb98m80DgF8R2DDyIasFRBVVAM=;
        b=QPCMoXIObgN3u4ugcQhuYUFqHJY6D+EHRML/1iB2spPE4yqFOPhfRUe+T7kEwesZp0
         JbUk9jq1dtDfQKvLJIcXu/2ncpUVflgcIqJCoeCotvteIUxE7C0MHQNKlYmYZ8ldnZ7O
         YEi1YqikSeqUPdTSGBSvE+/IpQJ0mzdV3lc8QD7+j51hoGnRmAjajEvS76ja8TUS6Eml
         nLtf5X29QbXGJfkAJVuMhQq6Qkvs006M8O9UKe0LJ0ClAGIemhfOv1JkhdvLIJ/xKJqY
         XoGWQ7yTWy4PhOYMpUoFp2vILw3EW0VcDpymc8TTawRa0OfgeeqIFdIdW8BDnGtQodEp
         qZoA==
X-Gm-Message-State: AOAM530Iyxo/kQkMiOVE6JdtcsyOhTykPuUdwqxU5wB7prpdASluAaH3
        XAtYu8UyBv5zv2/BG3xJo2OPaIC6QaM=
X-Google-Smtp-Source: ABdhPJyMPPWswJNBkO5EMkOymtcAq+F6NCm/wsGn1Y7ldEZ3ku1a82tJ5e7guVf/YlD6WAJxYogKGQ==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr8618398wrq.359.1612434794620;
        Thu, 04 Feb 2021 02:33:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm7302662wrt.47.2021.02.04.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 02:33:13 -0800 (PST)
Message-Id: <pull.857.v3.git.1612434793195.gitgitgadget@gmail.com>
In-Reply-To: <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
References: <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 10:33:12 +0000
Subject: [PATCH v3] alloc.h|c: migrate alloc_states to mem-pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In "object.h",I use `mem_pool` to replace the five
"alloc_state *" which used to allocate memory for
different types of object nodes.Now that one `mem_pool`
unified management of the allocation and release of
the memory of multiple nodes.
The advantage of changing to a `mem_pool` is:
1.we can allocate more memory at a time than the original
`alloc_state`,thus reducing the number of system calls to malloc.
2.the user interface is take memory in a memory pool,We no longer
need to take from multiple pools as before.

At the same time, mem_pool may have its disadvantages:
1. There is memory fragmentation
2. It is not conducive to counting or traversing
different types of nodes.
This may require some refinement or disregard.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    object.h: migrate alloc_states to mem-pool
    
    Notice that "mem-pool" api may have similar effort with alloc_state,
    "parsed_object_pool" have five member with alloc_state type, and "TODO"
    usage in "object.h":"migrate alloc_states to mem-pool?", so let us
    change it to mem-pool version.
    
    After I learned the role of the memory pool,I think in the future git
    may be more inclined to use the memory pool instead of the old interface
    "alloc_state".
    
    Thanks.
    
    cc: Junio C Hamano gitster@pobox.com cc: Stefan Beller
    sbeller@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-857%2Fadlternative%2Falloc_states_to_mem_pool-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-857/adlternative/alloc_states_to_mem_pool-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/857

Range-diff vs v2:

 1:  e9c1f9eef428 ! 1:  4b292c037ed2 alloc.h|c: migrate alloc_states to mem-pool
     @@ Metadata
       ## Commit message ##
          alloc.h|c: migrate alloc_states to mem-pool
      
     -    "alloc_state" may have similar effects with "mem_pool".
     -    Using the new memory pool API may be more beneficial
     -    to our memory management in the future.
     -
     -    So I change them in the "struct parsed_object_pool",and
     -    The corresponding interface has also been changed.
     -    functions "alloc_*_node" now change to "mem_pool_alloc_*_node".
     -
     -    At the same time ,I add the member `alloc_count` of
     -    struct mem_pool ,so that we can effective track
     -    node alloc count,and adapt to the original interface `alloc_report`.
     +    In "object.h",I use `mem_pool` to replace the five
     +    "alloc_state *" which used to allocate memory for
     +    different types of object nodes.Now that one `mem_pool`
     +    unified management of the allocation and release of
     +    the memory of multiple nodes.
     +    The advantage of changing to a `mem_pool` is:
     +    1.we can allocate more memory at a time than the original
     +    `alloc_state`,thus reducing the number of system calls to malloc.
     +    2.the user interface is take memory in a memory pool,We no longer
     +    need to take from multiple pools as before.
     +
     +    At the same time, mem_pool may have its disadvantages:
     +    1. There is memory fragmentation
     +    2. It is not conducive to counting or traversing
     +    different types of nodes.
     +    This may require some refinement or disregard.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## alloc.c ##
     -@@ alloc.c: static inline void *alloc_node(struct alloc_state *s, size_t node_size)
     - 	return ret;
     - }
     +@@ alloc.c: struct alloc_state {
     + 	int slab_nr, slab_alloc;
     + };
       
     --void *alloc_blob_node(struct repository *r)
     -+void *mem_pool_alloc_blob_node(struct repository *r)
     +-struct alloc_state *allocate_alloc_state(void)
     +-{
     +-	return xcalloc(1, sizeof(struct alloc_state));
     +-}
     +-
     +-void clear_alloc_state(struct alloc_state *s)
     +-{
     +-	while (s->slab_nr > 0) {
     +-		s->slab_nr--;
     +-		free(s->slabs[s->slab_nr]);
     +-	}
     +-
     +-	FREE_AND_NULL(s->slabs);
     +-}
     +-
     +-static inline void *alloc_node(struct alloc_state *s, size_t node_size)
     +-{
     +-	void *ret;
     +-
     +-	if (!s->nr) {
     +-		s->nr = BLOCKING;
     +-		s->p = xmalloc(BLOCKING * node_size);
     +-
     +-		ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
     +-		s->slabs[s->slab_nr++] = s->p;
     +-	}
     +-	s->nr--;
     +-	s->count++;
     +-	ret = s->p;
     +-	s->p = (char *)s->p + node_size;
     +-	memset(ret, 0, node_size);
     +-
     +-	return ret;
     +-}
     +-
     + void *alloc_blob_node(struct repository *r)
       {
      -	struct blob *b = alloc_node(r->parsed_objects->blob_state, sizeof(struct blob));
     -+	struct blob *b = mem_pool_calloc(r->parsed_objects->blob_pool, 1, sizeof(struct blob));
     ++	struct blob *b = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct blob));
       	b->object.type = OBJ_BLOB;
       	return b;
       }
       
     --void *alloc_tree_node(struct repository *r)
     -+void *mem_pool_alloc_tree_node(struct repository *r)
     + void *alloc_tree_node(struct repository *r)
       {
      -	struct tree *t = alloc_node(r->parsed_objects->tree_state, sizeof(struct tree));
     -+	struct tree *t = mem_pool_calloc(r->parsed_objects->tree_pool, 1, sizeof(struct tree));
     ++	struct tree *t = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct tree));
       	t->object.type = OBJ_TREE;
       	return t;
       }
       
     --void *alloc_tag_node(struct repository *r)
     -+void *mem_pool_alloc_tag_node(struct repository *r)
     + void *alloc_tag_node(struct repository *r)
       {
      -	struct tag *t = alloc_node(r->parsed_objects->tag_state, sizeof(struct tag));
     -+	struct tag *t = mem_pool_calloc(r->parsed_objects->tag_pool, 1, sizeof(struct tag));
     ++	struct tag *t = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct tag));
       	t->object.type = OBJ_TAG;
       	return t;
       }
       
     --void *alloc_object_node(struct repository *r)
     -+void *mem_pool_alloc_object_node(struct repository *r)
     + void *alloc_object_node(struct repository *r)
       {
      -	struct object *obj = alloc_node(r->parsed_objects->object_state, sizeof(union any_object));
     -+	struct object *obj = mem_pool_calloc(r->parsed_objects->object_pool, 1, sizeof(union any_object));
     ++	struct object *obj = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(union any_object));
       	obj->type = OBJ_NONE;
       	return obj;
       }
      @@ alloc.c: void init_commit_node(struct commit *c)
     - 	c->index = alloc_commit_index();
     - }
       
     --void *alloc_commit_node(struct repository *r)
     -+void *mem_pool_alloc_commit_node(struct repository *r)
     + void *alloc_commit_node(struct repository *r)
       {
      -	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
     -+	struct commit *c = mem_pool_calloc(r->parsed_objects->commit_pool, 1, sizeof(struct commit));
     ++	struct commit *c = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct commit));
       	init_commit_node(c);
       	return c;
       }
     -@@ alloc.c: static void report(const char *name, unsigned int count, size_t size)
     - }
     - 
     - #define REPORT(name, type)	\
     +-
     +-static void report(const char *name, unsigned int count, size_t size)
     +-{
     +-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
     +-			name, count, (uintmax_t) size);
     +-}
     +-
     +-#define REPORT(name, type)	\
      -    report(#name, r->parsed_objects->name##_state->count, \
      -		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
     -+    report(#name, r->parsed_objects->name##_pool->alloc_count, \
     -+		  r->parsed_objects->name##_pool->alloc_count * sizeof(type) >> 10)
     - 
     - void alloc_report(struct repository *r)
     - {
     +-
     +-void alloc_report(struct repository *r)
     +-{
     +-	REPORT(blob, struct blob);
     +-	REPORT(tree, struct tree);
     +-	REPORT(commit, struct commit);
     +-	REPORT(tag, struct tag);
     +-	REPORT(object, union any_object);
     +-}
      
       ## alloc.h ##
     -@@ alloc.h: struct commit;
     - struct tag;
     - struct repository;
     - 
     --void *alloc_blob_node(struct repository *r);
     --void *alloc_tree_node(struct repository *r);
     -+void *mem_pool_alloc_blob_node(struct repository *r);
     -+void *mem_pool_alloc_tree_node(struct repository *r);
     - void init_commit_node(struct commit *c);
     --void *alloc_commit_node(struct repository *r);
     --void *alloc_tag_node(struct repository *r);
     --void *alloc_object_node(struct repository *r);
     -+void *mem_pool_alloc_commit_node(struct repository *r);
     -+void *mem_pool_alloc_tag_node(struct repository *r);
     -+void *mem_pool_alloc_object_node(struct repository *r);
     +@@ alloc.h: void *alloc_tag_node(struct repository *r);
     + void *alloc_object_node(struct repository *r);
       void alloc_report(struct repository *r);
       
     - struct alloc_state *allocate_alloc_state(void);
     -
     - ## blame.c ##
     -@@ blame.c: static struct commit *fake_working_tree_commit(struct repository *r,
     - 
     - 	repo_read_index(r);
     - 	time(&now);
     --	commit = alloc_commit_node(r);
     -+	commit = mem_pool_alloc_commit_node(r);
     - 	commit->object.parsed = 1;
     - 	commit->date = now;
     - 	parent_tail = &commit->parents;
     -
     - ## blob.c ##
     -@@ blob.c: struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
     - {
     - 	struct object *obj = lookup_object(r, oid);
     - 	if (!obj)
     --		return create_object(r, oid, alloc_blob_node(r));
     -+		return create_object(r, oid, mem_pool_alloc_blob_node(r));
     - 	return object_as_type(obj, OBJ_BLOB, 0);
     - }
     - 
     -
     - ## commit-graph.c ##
     -@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     - 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
     - 
     - 		graph_commit = lookup_commit(r, &cur_oid);
     --		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
     -+		odb_commit = (struct commit *)create_object(r, &cur_oid, mem_pool_alloc_commit_node(r));
     - 		if (parse_commit_internal(odb_commit, 0, 0)) {
     - 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
     - 				     oid_to_hex(&cur_oid));
     -
     - ## commit.c ##
     -@@ commit.c: struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
     - {
     - 	struct object *obj = lookup_object(r, oid);
     - 	if (!obj)
     --		return create_object(r, oid, alloc_commit_node(r));
     -+		return create_object(r, oid, mem_pool_alloc_commit_node(r));
     - 	return object_as_type(obj, OBJ_COMMIT, 0);
     - }
     - 
     +-struct alloc_state *allocate_alloc_state(void);
     +-void clear_alloc_state(struct alloc_state *s);
     +-
     + #endif
      
       ## mem-pool.c ##
     -@@ mem-pool.c: static struct mp_block *mem_pool_alloc_block(struct mem_pool *pool,
     - 	return p;
     - }
     +@@
     + #include "cache.h"
     + #include "mem-pool.h"
       
     -+struct mem_pool *mem_pool_new(void)
     -+{
     -+	return xmalloc(sizeof(struct mem_pool));
     -+}
     -+
     - void mem_pool_init(struct mem_pool *pool, size_t initial_size)
     - {
     - 	memset(pool, 0, sizeof(*pool));
     +-#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
     + 
     + /*
     +  * Allocate a new mp_block and insert it after the block specified in
      @@ mem-pool.c: void *mem_pool_alloc(struct mem_pool *pool, size_t len)
       	struct mp_block *p = NULL;
       	void *r;
     @@ mem-pool.h: struct mem_pool {
      +	size_t alloc_count;
       };
       
     -+/*
     -+ * Create a new mem_pool.
     -+ */
     -+struct mem_pool *mem_pool_new(void);
     ++#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block)
      +
       /*
        * Initialize mem_pool with specified initial size.
        */
      
     - ## merge-ort.c ##
     -@@ merge-ort.c: static struct commit *make_virtual_commit(struct repository *repo,
     - 					  struct tree *tree,
     - 					  const char *comment)
     - {
     --	struct commit *commit = alloc_commit_node(repo);
     -+	struct commit *commit = mem_pool_alloc_commit_node(repo);
     - 
     - 	set_merge_remote_desc(commit, comment, (struct object *)commit);
     - 	set_commit_tree(commit, tree);
     -
     - ## merge-recursive.c ##
     -@@ merge-recursive.c: static struct commit *make_virtual_commit(struct repository *repo,
     - 					  struct tree *tree,
     - 					  const char *comment)
     - {
     --	struct commit *commit = alloc_commit_node(repo);
     -+	struct commit *commit = mem_pool_alloc_commit_node(repo);
     - 
     - 	set_merge_remote_desc(commit, comment, (struct object *)commit);
     - 	set_commit_tree(commit, tree);
     -
       ## object.c ##
      @@ object.c: struct object *lookup_unknown_object(const struct object_id *oid)
       	struct object *obj = lookup_object(the_repository, oid);
       	if (!obj)
       		obj = create_object(the_repository, oid,
      -				    alloc_object_node(the_repository));
     -+				mem_pool_alloc_object_node(the_repository));
     ++				alloc_object_node(the_repository));
       	return obj;
       }
       
      @@ object.c: struct parsed_object_pool *parsed_object_pool_new(void)
     + {
       	struct parsed_object_pool *o = xmalloc(sizeof(*o));
       	memset(o, 0, sizeof(*o));
     - 
     +-
      -	o->blob_state = allocate_alloc_state();
      -	o->tree_state = allocate_alloc_state();
      -	o->commit_state = allocate_alloc_state();
      -	o->tag_state = allocate_alloc_state();
      -	o->object_state = allocate_alloc_state();
     -+	o->blob_pool = mem_pool_new();
     -+	o->tree_pool = mem_pool_new();
     -+	o->commit_pool = mem_pool_new();
     -+	o->tag_pool = mem_pool_new();
     -+	o->object_pool = mem_pool_new();
     -+	mem_pool_init(o->blob_pool,0);
     -+	mem_pool_init(o->tree_pool,0);
     -+	mem_pool_init(o->commit_pool,0);
     -+	mem_pool_init(o->tag_pool,0);
     -+	mem_pool_init(o->object_pool,0);
     - 
     +-
     ++	mem_pool_init(&o->objects_pool, BLOCK_GROWTH_SIZE);
       	o->is_shallow = -1;
       	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
     + 
      @@ object.c: void parsed_object_pool_clear(struct parsed_object_pool *o)
       	free_commit_buffer_slab(o->buffer_slab);
       	o->buffer_slab = NULL;
     @@ object.c: void parsed_object_pool_clear(struct parsed_object_pool *o)
      -	clear_alloc_state(o->commit_state);
      -	clear_alloc_state(o->tag_state);
      -	clear_alloc_state(o->object_state);
     -+	mem_pool_discard(o->blob_pool,1);
     -+	mem_pool_discard(o->tree_pool,1);
     -+	mem_pool_discard(o->tag_pool,1);
     -+	mem_pool_discard(o->object_pool,1);
     -+	mem_pool_discard(o->commit_pool,1);
     ++	mem_pool_discard(&o->objects_pool,0);
       	stat_validity_clear(o->shallow_stat);
      -	FREE_AND_NULL(o->blob_state);
      -	FREE_AND_NULL(o->tree_state);
      -	FREE_AND_NULL(o->commit_state);
      -	FREE_AND_NULL(o->tag_state);
      -	FREE_AND_NULL(o->object_state);
     -+	FREE_AND_NULL(o->blob_pool);
     -+	FREE_AND_NULL(o->tree_pool);
     -+	FREE_AND_NULL(o->commit_pool);
     -+	FREE_AND_NULL(o->tag_pool);
     -+	FREE_AND_NULL(o->object_pool);
     - 	FREE_AND_NULL(o->shallow_stat);
     +-	FREE_AND_NULL(o->shallow_stat);
       }
      
       ## object.h ##
      @@ object.h: struct parsed_object_pool {
     + 	struct object **obj_hash;
       	int nr_objs, obj_hash_size;
       
     - 	/* TODO: migrate alloc_states to mem-pool? */
     +-	/* TODO: migrate alloc_states to mem-pool? */
      -	struct alloc_state *blob_state;
      -	struct alloc_state *tree_state;
      -	struct alloc_state *commit_state;
      -	struct alloc_state *tag_state;
      -	struct alloc_state *object_state;
     -+	struct mem_pool *blob_pool;
     -+	struct mem_pool *tree_pool;
     -+	struct mem_pool *commit_pool;
     -+	struct mem_pool *tag_pool;
     -+	struct mem_pool *object_pool;
     ++	struct mem_pool objects_pool;
       
       	/* parent substitutions from .git/info/grafts and .git/shallow */
       	struct commit_graft **grafts;
     -
     - ## tag.c ##
     -@@ tag.c: struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
     - {
     - 	struct object *obj = lookup_object(r, oid);
     - 	if (!obj)
     --		return create_object(r, oid, alloc_tag_node(r));
     -+		return create_object(r, oid, mem_pool_alloc_tag_node(r));
     - 	return object_as_type(obj, OBJ_TAG, 0);
     - }
     - 
     -
     - ## tree.c ##
     -@@ tree.c: struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
     - {
     - 	struct object *obj = lookup_object(r, oid);
     - 	if (!obj)
     --		return create_object(r, oid, alloc_tree_node(r));
     -+		return create_object(r, oid, mem_pool_alloc_tree_node(r));
     - 	return object_as_type(obj, OBJ_TREE, 0);
     - }
     - 


 alloc.c    | 64 +++++-------------------------------------------------
 alloc.h    |  3 ---
 mem-pool.c |  2 +-
 mem-pool.h |  5 +++++
 object.c   | 22 +++----------------
 object.h   |  7 +-----
 6 files changed, 15 insertions(+), 88 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af36264..d5e84caa3794 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,65 +36,30 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
 
-struct alloc_state *allocate_alloc_state(void)
-{
-	return xcalloc(1, sizeof(struct alloc_state));
-}
-
-void clear_alloc_state(struct alloc_state *s)
-{
-	while (s->slab_nr > 0) {
-		s->slab_nr--;
-		free(s->slabs[s->slab_nr]);
-	}
-
-	FREE_AND_NULL(s->slabs);
-}
-
-static inline void *alloc_node(struct alloc_state *s, size_t node_size)
-{
-	void *ret;
-
-	if (!s->nr) {
-		s->nr = BLOCKING;
-		s->p = xmalloc(BLOCKING * node_size);
-
-		ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
-		s->slabs[s->slab_nr++] = s->p;
-	}
-	s->nr--;
-	s->count++;
-	ret = s->p;
-	s->p = (char *)s->p + node_size;
-	memset(ret, 0, node_size);
-
-	return ret;
-}
-
 void *alloc_blob_node(struct repository *r)
 {
-	struct blob *b = alloc_node(r->parsed_objects->blob_state, sizeof(struct blob));
+	struct blob *b = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
 void *alloc_tree_node(struct repository *r)
 {
-	struct tree *t = alloc_node(r->parsed_objects->tree_state, sizeof(struct tree));
+	struct tree *t = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
 void *alloc_tag_node(struct repository *r)
 {
-	struct tag *t = alloc_node(r->parsed_objects->tag_state, sizeof(struct tag));
+	struct tag *t = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
 void *alloc_object_node(struct repository *r)
 {
-	struct object *obj = alloc_node(r->parsed_objects->object_state, sizeof(union any_object));
+	struct object *obj = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(union any_object));
 	obj->type = OBJ_NONE;
 	return obj;
 }
@@ -118,26 +83,7 @@ void init_commit_node(struct commit *c)
 
 void *alloc_commit_node(struct repository *r)
 {
-	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
+	struct commit *c = mem_pool_calloc(&r->parsed_objects->objects_pool, 1, sizeof(struct commit));
 	init_commit_node(c);
 	return c;
 }
-
-static void report(const char *name, unsigned int count, size_t size)
-{
-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
-			name, count, (uintmax_t) size);
-}
-
-#define REPORT(name, type)	\
-    report(#name, r->parsed_objects->name##_state->count, \
-		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
-
-void alloc_report(struct repository *r)
-{
-	REPORT(blob, struct blob);
-	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
-	REPORT(tag, struct tag);
-	REPORT(object, union any_object);
-}
diff --git a/alloc.h b/alloc.h
index 371d388b552f..eab035e3d373 100644
--- a/alloc.h
+++ b/alloc.h
@@ -15,7 +15,4 @@ void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 void alloc_report(struct repository *r);
 
-struct alloc_state *allocate_alloc_state(void);
-void clear_alloc_state(struct alloc_state *s);
-
 #endif
diff --git a/mem-pool.c b/mem-pool.c
index 8401761dda0a..09edd51cb40b 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,7 +5,6 @@
 #include "cache.h"
 #include "mem-pool.h"
 
-#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
 
 /*
  * Allocate a new mp_block and insert it after the block specified in
@@ -69,6 +68,7 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 	struct mp_block *p = NULL;
 	void *r;
 
+	pool->alloc_count++;
 	/* round up to a 'uintmax_t' alignment */
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
diff --git a/mem-pool.h b/mem-pool.h
index fe7507f022bb..131fa1511601 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -19,8 +19,13 @@ struct mem_pool {
 
 	/* The total amount of memory allocated by the pool. */
 	size_t pool_alloc;
+
+	/* The count of calling mem_pool_alloc .*/
+	size_t alloc_count;
 };
 
+#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block)
+
 /*
  * Initialize mem_pool with specified initial size.
  */
diff --git a/object.c b/object.c
index 98017bed8efb..75e2305e7cd2 100644
--- a/object.c
+++ b/object.c
@@ -182,7 +182,7 @@ struct object *lookup_unknown_object(const struct object_id *oid)
 	struct object *obj = lookup_object(the_repository, oid);
 	if (!obj)
 		obj = create_object(the_repository, oid,
-				    alloc_object_node(the_repository));
+				alloc_object_node(the_repository));
 	return obj;
 }
 
@@ -470,13 +470,7 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 {
 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
-
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
-
+	mem_pool_init(&o->objects_pool, BLOCK_GROWTH_SIZE);
 	o->is_shallow = -1;
 	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
 
@@ -568,16 +562,6 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	free_commit_buffer_slab(o->buffer_slab);
 	o->buffer_slab = NULL;
 
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	mem_pool_discard(&o->objects_pool,0);
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
-	FREE_AND_NULL(o->shallow_stat);
 }
diff --git a/object.h b/object.h
index 59daadce2145..23e2127f5867 100644
--- a/object.h
+++ b/object.h
@@ -9,12 +9,7 @@ struct parsed_object_pool {
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
 
-	/* TODO: migrate alloc_states to mem-pool? */
-	struct alloc_state *blob_state;
-	struct alloc_state *tree_state;
-	struct alloc_state *commit_state;
-	struct alloc_state *tag_state;
-	struct alloc_state *object_state;
+	struct mem_pool objects_pool;
 
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
