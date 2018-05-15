Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD061F406
	for <e@80x24.org>; Tue, 15 May 2018 21:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeEOVss (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 17:48:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44790 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeEOVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 17:48:45 -0400
Received: by mail-pg0-f65.google.com with SMTP id x145-v6so610776pgx.11
        for <git@vger.kernel.org>; Tue, 15 May 2018 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d6ikw6JXG6myat8hLr0SVFj6DruFPv3kYpvu+9bOGaY=;
        b=nX3uZ4uGlCtIPEC6snFtqRgZJYIG2WEuFUaweZYE8hVmnTrdhTMjea2m45YQstPWxl
         GLTvfSAvmqZpifZbpRngaf+wSDwDP0YWbM4/5Es3rCr6fIznkAoctT3WMZ/0J0AmYhVN
         zlQRCv2i/lIiWFTNkBeexqKumI1CMIm3T9K4w1D771nf+GrfE3xdOuHgh0kPJcYjl1aV
         2K+AzBHiA5EG/4fl4lHuk9Z0c/7QpHNiLSTbli0PeSDmQVqthdfQG+eV9wDOIQI9+q4+
         vkFAzRll+czshfIdSaR2cLquJUmF1K2a0wEc5bhvyDyPimWLYUn0CHeWxSIkXRc30Bc4
         V6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d6ikw6JXG6myat8hLr0SVFj6DruFPv3kYpvu+9bOGaY=;
        b=AJHEFDAOkLuXYjKCBajYSF1SiOUzS03DbKqcrYc5VNCCXOSe/rzds3MPP6dnWH3RaB
         Uk+DsiI08TeTBd+h7MdvzQlJxYUwNI+NyUczvzDbNLR4djrRZR3xorPjG5Ke7DpJsbWg
         shO3CEknofLtXt+mo+3AgeE/pdY3FoSPlp21ccyTzSvA+dHon6dRCZUSr/tDBdxprfrT
         knrxbTkkDtxnzWDuhyVeVYd+G3irPGcPOnXt2ue29yVk1YSfWFbTmL/5sUoSbM7o3NvI
         w7oowobwL6tmeF9CRrVYRc+PCyI1n2zbpHrGOF+Q+2Boa7G4tsH8NeIRKQfmGLgJ5o7R
         xfyw==
X-Gm-Message-State: ALKqPwdiZVsW4FpSrZo74wK44fM4PTOdvRx0hQ738xom6sZ7HYXDvWV+
        zRUY7dwbdJgN0n6yVcNMflniGw==
X-Google-Smtp-Source: AB8JxZoptkzH52Amp57mfByz0vahsR0aunyh0wQpEk5mVr0yOY/DycA/PRRihRc07YQPcQ0LPF1R8A==
X-Received: by 2002:a62:d508:: with SMTP id d8-v6mr16500019pfg.234.1526420924533;
        Tue, 15 May 2018 14:48:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e5-v6sm1436101pfk.28.2018.05.15.14.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 14:48:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com, sbeller@google.com
Subject: [PATCH] alloc: allow arbitrary repositories for alloc functions
Date:   Tue, 15 May 2018 14:48:42 -0700
Message-Id: <20180515214842.108713-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <CAPig+cTMeYFsn1iTto_wsG0Myik_Euh+UZh3pZwks=AEt8D13Q@mail.gmail.com>
References: <CAPig+cTMeYFsn1iTto_wsG0Myik_Euh+UZh3pZwks=AEt8D13Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to convert all of the alloc functions at once, because alloc_report
uses a funky macro for reporting. It is better for the sake of mechanical
conversion to convert multiple functions at once rather than changing the
structure of the reporting function.

We record all memory allocation in alloc.c, and free them in
clear_alloc_state, which is called for all repositories except
the_repository.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes:

    Eric, I have fixed s/relase/release/


Jonathan,

> This might seem a bit bikesheddy, but I wouldn't call it
> free_tag_buffer(), since what's being freed is not the buffer of the
> object itself, but just a string. If you want such a function, I would
> just call it release_tag_memory() to match release_commit_memory().

So you would replace the last commit with a patch like this?

Thanks,
Stefan

    diff to what is currently queued:

    diff --git c/commit.c w/commit.c
    index 612ccf7b053..5eb4d2f08f8 100644
    --- c/commit.c
    +++ w/commit.c
    @@ -299,9 +299,13 @@ void free_commit_buffer(struct commit *commit)
    
     void release_commit_memory(struct commit *c)
     {
    +	c->tree = NULL;
    +	c->index = 0;
     	free_commit_buffer(c);
     	free_commit_list(c->parents);
     	/* TODO: what about commit->util? */
    +
    +	c->object.parsed = 0;
     }
    
     const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
    diff --git c/object.c w/object.c
    index 9d5b10d5a20..8e29f63bf23 100644
    --- c/object.c
    +++ w/object.c
    @@ -528,7 +528,7 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
     		else if (obj->type == OBJ_COMMIT)
     			release_commit_memory((struct commit*)obj);
     		else if (obj->type == OBJ_TAG)
    -			free_tag_buffer((struct tag*)obj);
    +			release_tag_memory((struct tag*)obj);
     	}
    
     	FREE_AND_NULL(o->obj_hash);
    diff --git c/tag.c w/tag.c
    index 254352c30c6..7c12426b4ea 100644
    --- c/tag.c
    +++ w/tag.c
    @@ -116,9 +116,12 @@ static timestamp_t parse_tag_date(const char *buf, const char *tail)
     	return parse_timestamp(dateptr, NULL, 10);
     }
    
    -void free_tag_buffer(struct tag *t)
    +void release_tag_memory(struct tag *t)
     {
     	free(t->tag);
    +	t->tagged = NULL;
    +	t->object.parsed = 0;
    +	t->date = 0;
     }
    
     int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
    diff --git c/tag.h w/tag.h
    index b241fe67bc5..9057d76a506 100644
    --- c/tag.h
    +++ w/tag.h
    @@ -15,7 +15,7 @@ struct tag {
     extern struct tag *lookup_tag(const struct object_id *oid);
     extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
     extern int parse_tag(struct tag *item);
    -extern void free_tag_buffer(struct tag *t);
    +extern void release_tag_memory(struct tag *t);
     extern struct object *deref_tag(struct object *, const char *, int);
     extern struct object *deref_tag_noverify(struct object *);
     extern int gpg_verify_tag(const struct object_id *oid,

 alloc.c           | 65 ++++++++++++++++++++++++++++++-----------------
 alloc.h           | 19 ++++++++++++++
 blame.c           |  1 +
 blob.c            |  1 +
 cache.h           | 16 ------------
 commit.c          | 12 +++++++++
 commit.h          |  6 +++++
 merge-recursive.c |  1 +
 object.c          | 42 ++++++++++++++++++++++++++++--
 object.h          |  8 ++++++
 tag.c             |  9 +++++++
 tag.h             |  1 +
 tree.c            |  1 +
 13 files changed, 140 insertions(+), 42 deletions(-)
 create mode 100644 alloc.h

diff --git a/alloc.c b/alloc.c
index 277dadd221b..714df633169 100644
--- a/alloc.c
+++ b/alloc.c
@@ -4,8 +4,7 @@
  * Copyright (C) 2006 Linus Torvalds
  *
  * The standard malloc/free wastes too much space for objects, partly because
- * it maintains all the allocation infrastructure (which isn't needed, since
- * we never free an object descriptor anyway), but even more because it ends
+ * it maintains all the allocation infrastructure, but even more because it ends
  * up with maximal alignment because it doesn't know what the object alignment
  * for the new allocation is.
  */
@@ -15,6 +14,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "alloc.h"
 
 #define BLOCKING 1024
 
@@ -30,8 +30,27 @@ struct alloc_state {
 	int count; /* total number of nodes allocated */
 	int nr;    /* number of nodes left in current allocation */
 	void *p;   /* first free node in current allocation */
+
+	/* bookkeeping of allocations */
+	void **slabs;
+	int slab_nr, slab_alloc;
 };
 
+void *allocate_alloc_state(void)
+{
+	return xcalloc(1, sizeof(struct alloc_state));
+}
+
+void clear_alloc_state(struct alloc_state *s)
+{
+	while (s->slab_nr > 0) {
+		s->slab_nr--;
+		free(s->slabs[s->slab_nr]);
+	}
+
+	FREE_AND_NULL(s->slabs);
+}
+
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 {
 	void *ret;
@@ -39,60 +58,57 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	if (!s->nr) {
 		s->nr = BLOCKING;
 		s->p = xmalloc(BLOCKING * node_size);
+
+		ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
+		s->slabs[s->slab_nr++] = s->p;
 	}
 	s->nr--;
 	s->count++;
 	ret = s->p;
 	s->p = (char *)s->p + node_size;
 	memset(ret, 0, node_size);
+
 	return ret;
 }
 
-static struct alloc_state blob_state;
-void *alloc_blob_node_the_repository(void)
+void *alloc_blob_node(struct repository *r)
 {
-	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	struct blob *b = alloc_node(r->parsed_objects->blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
-static struct alloc_state tree_state;
-void *alloc_tree_node_the_repository(void)
+void *alloc_tree_node(struct repository *r)
 {
-	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	struct tree *t = alloc_node(r->parsed_objects->tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
-static struct alloc_state tag_state;
-void *alloc_tag_node_the_repository(void)
+void *alloc_tag_node(struct repository *r)
 {
-	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	struct tag *t = alloc_node(r->parsed_objects->tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
-static struct alloc_state object_state;
-void *alloc_object_node_the_repository(void)
+void *alloc_object_node(struct repository *r)
 {
-	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
+	struct object *obj = alloc_node(r->parsed_objects->object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
 	return obj;
 }
 
-static struct alloc_state commit_state;
-
-unsigned int alloc_commit_index_the_repository(void)
+unsigned int alloc_commit_index(struct repository *r)
 {
-	static unsigned int count;
-	return count++;
+	return r->parsed_objects->commit_count++;
 }
 
-void *alloc_commit_node_the_repository(void)
+void *alloc_commit_node(struct repository *r)
 {
-	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
+	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index(the_repository);
+	c->index = alloc_commit_index(r);
 	return c;
 }
 
@@ -103,9 +119,10 @@ static void report(const char *name, unsigned int count, size_t size)
 }
 
 #define REPORT(name, type)	\
-    report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
+    report(#name, r->parsed_objects->name##_state->count, \
+		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
 
-void alloc_report_the_repository(void)
+void alloc_report(struct repository *r)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/alloc.h b/alloc.h
new file mode 100644
index 00000000000..3e4e828db48
--- /dev/null
+++ b/alloc.h
@@ -0,0 +1,19 @@
+#ifndef ALLOC_H
+#define ALLOC_H
+
+struct tree;
+struct commit;
+struct tag;
+
+void *alloc_blob_node(struct repository *r);
+void *alloc_tree_node(struct repository *r);
+void *alloc_commit_node(struct repository *r);
+void *alloc_tag_node(struct repository *r);
+void *alloc_object_node(struct repository *r);
+void alloc_report(struct repository *r);
+unsigned int alloc_commit_index(struct repository *r);
+
+void *allocate_alloc_state(void);
+void clear_alloc_state(struct alloc_state *s);
+
+#endif
diff --git a/blame.c b/blame.c
index ba9b18e7542..3a11f1ce52b 100644
--- a/blame.c
+++ b/blame.c
@@ -6,6 +6,7 @@
 #include "diffcore.h"
 #include "tag.h"
 #include "blame.h"
+#include "alloc.h"
 
 void blame_origin_decref(struct blame_origin *o)
 {
diff --git a/blob.c b/blob.c
index 9e64f301895..458dafa811e 100644
--- a/blob.c
+++ b/blob.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "repository.h"
+#include "alloc.h"
 
 const char *blob_type = "blob";
 
diff --git a/cache.h b/cache.h
index 0e6c5dd5639..c75559b7d38 100644
--- a/cache.h
+++ b/cache.h
@@ -1763,22 +1763,6 @@ extern const char *excludes_file;
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
-/* alloc.c */
-#define alloc_blob_node(r) alloc_blob_node_##r()
-extern void *alloc_blob_node_the_repository(void);
-#define alloc_tree_node(r) alloc_tree_node_##r()
-extern void *alloc_tree_node_the_repository(void);
-#define alloc_commit_node(r) alloc_commit_node_##r()
-extern void *alloc_commit_node_the_repository(void);
-#define alloc_tag_node(r) alloc_tag_node_##r()
-extern void *alloc_tag_node_the_repository(void);
-#define alloc_object_node(r) alloc_object_node_##r()
-extern void *alloc_object_node_the_repository(void);
-#define alloc_report(r) alloc_report_##r()
-extern void alloc_report_the_repository(void);
-#define alloc_commit_index(r) alloc_commit_index_##r()
-extern unsigned int alloc_commit_index_the_repository(void);
-
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
 
diff --git a/commit.c b/commit.c
index a9a43e79bae..5eb4d2f08f8 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "alloc.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
@@ -296,6 +297,17 @@ void free_commit_buffer(struct commit *commit)
 	}
 }
 
+void release_commit_memory(struct commit *c)
+{
+	c->tree = NULL;
+	c->index = 0;
+	free_commit_buffer(c);
+	free_commit_list(c->parents);
+	/* TODO: what about commit->util? */
+
+	c->object.parsed = 0;
+}
+
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
diff --git a/commit.h b/commit.h
index 0fb8271665c..2d764ab7d8e 100644
--- a/commit.h
+++ b/commit.h
@@ -99,6 +99,12 @@ void unuse_commit_buffer(const struct commit *, const void *buffer);
  */
 void free_commit_buffer(struct commit *);
 
+/*
+ * Release memory related to a commit, including the parent list and
+ * any cached object buffer.
+ */
+void release_commit_memory(struct commit *c);
+
 /*
  * Disassociate any cached object buffer from the commit, but do not free it.
  * The buffer (or NULL, if none) is returned.
diff --git a/merge-recursive.c b/merge-recursive.c
index 6dac8908648..cbded673c28 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -15,6 +15,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tag.h"
+#include "alloc.h"
 #include "unpack-trees.h"
 #include "string-list.h"
 #include "xdiff-interface.h"
diff --git a/object.c b/object.c
index 49b952e9299..8e29f63bf23 100644
--- a/object.c
+++ b/object.c
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "alloc.h"
 #include "object-store.h"
 #include "packfile.h"
 
@@ -455,6 +456,13 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 {
 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
+
+	o->blob_state = allocate_alloc_state();
+	o->tree_state = allocate_alloc_state();
+	o->commit_state = allocate_alloc_state();
+	o->tag_state = allocate_alloc_state();
+	o->object_state = allocate_alloc_state();
+
 	return o;
 }
 
@@ -501,9 +509,39 @@ void raw_object_store_clear(struct raw_object_store *o)
 void parsed_object_pool_clear(struct parsed_object_pool *o)
 {
 	/*
-	 * TOOD free objects in o->obj_hash.
-	 *
 	 * As objects are allocated in slabs (see alloc.c), we do
 	 * not need to free each object, but each slab instead.
+	 *
+	 * Before doing so, we need to free any additional memory
+	 * the objects may hold.
 	 */
+	unsigned i;
+
+	for (i = 0; i < o->obj_hash_size; i++) {
+		struct object *obj = o->obj_hash[i];
+
+		if (!obj)
+			continue;
+
+		if (obj->type == OBJ_TREE)
+			free_tree_buffer((struct tree*)obj);
+		else if (obj->type == OBJ_COMMIT)
+			release_commit_memory((struct commit*)obj);
+		else if (obj->type == OBJ_TAG)
+			release_tag_memory((struct tag*)obj);
+	}
+
+	FREE_AND_NULL(o->obj_hash);
+	o->obj_hash_size = 0;
+
+	clear_alloc_state(o->blob_state);
+	clear_alloc_state(o->tree_state);
+	clear_alloc_state(o->commit_state);
+	clear_alloc_state(o->tag_state);
+	clear_alloc_state(o->object_state);
+	FREE_AND_NULL(o->blob_state);
+	FREE_AND_NULL(o->tree_state);
+	FREE_AND_NULL(o->commit_state);
+	FREE_AND_NULL(o->tag_state);
+	FREE_AND_NULL(o->object_state);
 }
diff --git a/object.h b/object.h
index b41d7a3accb..7916edb4edf 100644
--- a/object.h
+++ b/object.h
@@ -4,6 +4,14 @@
 struct parsed_object_pool {
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
+
+	/* TODO: migrate alloc_states to mem-pool? */
+	struct alloc_state *blob_state;
+	struct alloc_state *tree_state;
+	struct alloc_state *commit_state;
+	struct alloc_state *tag_state;
+	struct alloc_state *object_state;
+	unsigned commit_count;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
diff --git a/tag.c b/tag.c
index 02ef4eaafc0..7c12426b4ea 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "alloc.h"
 #include "gpg-interface.h"
 
 const char *tag_type = "tag";
@@ -115,6 +116,14 @@ static timestamp_t parse_tag_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
+void release_tag_memory(struct tag *t)
+{
+	free(t->tag);
+	t->tagged = NULL;
+	t->object.parsed = 0;
+	t->date = 0;
+}
+
 int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
diff --git a/tag.h b/tag.h
index d469534e82a..9057d76a506 100644
--- a/tag.h
+++ b/tag.h
@@ -15,6 +15,7 @@ struct tag {
 extern struct tag *lookup_tag(const struct object_id *oid);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
+extern void release_tag_memory(struct tag *t);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
diff --git a/tree.c b/tree.c
index 58cf19b4fa8..8f8ef3189af 100644
--- a/tree.c
+++ b/tree.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
+#include "alloc.h"
 #include "tree-walk.h"
 
 const char *tree_type = "tree";
-- 
2.17.0.582.gccdcbd54c44.dirty

