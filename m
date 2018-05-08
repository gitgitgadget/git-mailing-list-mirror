Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19139200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755640AbeEHTiM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45596 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755604AbeEHTiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:38:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi12-v6so2813543plb.12
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oa6nF8E6WO2Fb4vrFNLDvZm+yToIBEMlSrSorl02wBk=;
        b=Ov7rOM6JhGgJqWyvg6eVPqQ+/X3Ao0HZZpY9R4mmeWHVLxtzOSUIhQnZX5jjTD+HpC
         i18NWR5TFKIqnGTGN/d/pxTL6m2mp/aYZb8pGbs4O6eyOLuGWR1Ht2ygidt7Qg5vpKYM
         nswmcFVW7R6B6x7+Tbe5dEjuREOZjqaEljNbGk0+1eRrzsuwa29i9IU8JpBChdeQ+9m0
         LDF3U7+Y+hk0QG6m4Avnch8yNPl6MtA/y7xap0TbpZbVV7kXNM4RRR9FWCJRZ8Z0gKFT
         Eoj/gIptsh8Z6bJbyXBgbHsH6wI+9PBEkprUvqsLqigmdvCprgQ0xohNyW7YZ7F38gUJ
         xJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oa6nF8E6WO2Fb4vrFNLDvZm+yToIBEMlSrSorl02wBk=;
        b=CpDZMwQ+tRzmxoADF2iEOJmOg05Spbouu18O62oBExLcEXXFVcWF7ZZCTPsZFQs0OS
         8kUWY6DH+L9nQGw8BxsiuIEJRg6idHsO+t/Oo2OpN1/7kz1KkcN0v9FyCxF0G1Nm3gFd
         bCzNTMYy4gPiT7Qol6tUyYcPWM03AcqWXuR1Z+N/qeO9eyi4HwKi1RYw9BhKImDndhD+
         NCFqF53mDzV70mYmdLV8MMmEH7OfNAN3E2Jw/+3+jBSQGPBLOfRFadoK5CYBF2Vuerq5
         BKbF4ZZyRIIVOHr6266qQifAk7hWMWNG7svdLA4GD/yjTUBd9Yn3Ink6hQ9cOJRHOo7D
         EAww==
X-Gm-Message-State: ALQs6tA1eM0wmTU3hfrDE06+f//XEyU+M64RJtzqD8qdvHON3QPN9b5j
        qqhuLZ0t+4stmd1mrwz58+yfzg==
X-Google-Smtp-Source: AB8JxZoppvJfOP1WCr72CyKUgARhtHia0jy7t7hKEdPr4qqbFf2R+QT9p+ohM4qYC3XpKCKjuHDjMg==
X-Received: by 2002:a17:902:9a8c:: with SMTP id w12-v6mr43423925plp.333.1525808283540;
        Tue, 08 May 2018 12:38:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l19-v6sm39913056pgn.44.2018.05.08.12.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:38:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc functions
Date:   Tue,  8 May 2018 12:37:36 -0700
Message-Id: <20180508193736.14883-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
 <20180508193736.14883-1-sbeller@google.com>
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
 alloc.c           | 79 +++++++++++++++++++++++++++++++++--------------
 alloc.h           | 23 ++++++++++++++
 blame.c           |  1 +
 blob.c            |  1 +
 cache.h           | 16 ----------
 commit.c          |  1 +
 merge-recursive.c |  1 +
 object.c          | 37 ++++++++++++++++++++--
 object.h          |  8 +++++
 tag.c             |  1 +
 tree.c            |  1 +
 11 files changed, 127 insertions(+), 42 deletions(-)
 create mode 100644 alloc.h

diff --git a/alloc.c b/alloc.c
index 277dadd221b..4ecf0f160f4 100644
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
 
@@ -30,8 +30,25 @@ struct alloc_state {
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
+}
+
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 {
 	void *ret;
@@ -39,63 +56,76 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
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
 
+void release_tree_node(struct tree *t)
+{
+	free(t->buffer);
+}
+
+void release_commit_node(struct commit *c)
+{
+	free_commit_list(c->parents);
+	/* TODO: what about commit->util? */
+}
+
+void release_tag_node(struct tag *t)
+{
+	free(t->tag);
+}
+
 static void report(const char *name, unsigned int count, size_t size)
 {
 	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
@@ -103,9 +133,10 @@ static void report(const char *name, unsigned int count, size_t size)
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
index 00000000000..941d71960fb
--- /dev/null
+++ b/alloc.h
@@ -0,0 +1,23 @@
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
+void release_tree_node(struct tree *t);
+void release_commit_node(struct commit *c);
+void release_tag_node(struct tag *t);
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
index a9a43e79bae..c3b400d5930 100644
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
index 49b952e9299..803d34ae189 100644
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
 
@@ -501,9 +509,34 @@ void raw_object_store_clear(struct raw_object_store *o)
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
+			release_tree_node((struct tree*)obj);
+		else if (obj->type == OBJ_COMMIT)
+			release_commit_node((struct commit*)obj);
+		else if (obj->type == OBJ_TAG)
+			release_tag_node((struct tag*)obj);
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
index 02ef4eaafc0..af6a0725b6a 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "alloc.h"
 #include "gpg-interface.h"
 
 const char *tag_type = "tag";
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
2.17.0.255.g8bfb7c0704

