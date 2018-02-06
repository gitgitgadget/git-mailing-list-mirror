Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265331F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBFAXu (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:23:50 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44940 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeBFAXs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:23:48 -0500
Received: by mail-pg0-f67.google.com with SMTP id r1so158147pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RRo4ybkpBscfj2dOb4X91gyaQ195irCRTp1ncUbw5io=;
        b=pp8fq1QBEABplbTJqGrtXazoDEpKeOVmQB5r305j8hNEOJI1Cblw1r3DLODdnOjimu
         III2iZJKAvBDlghyfLjJZ+rlt4HrwXapfkLlcbPS7D93K7PvOShfcy7SamBTjYV1kbEI
         89up0CGj+Azi9j6IyXWo4md/MX1a4SDS7Oh0TbVWsxeajASJmm7tUkk0f+ujE6lluED1
         RfOXQTIVsB62hEetbj/HF/iiO0f2BqoOvUlatfgNTUqI07N/EtsRz6NT/+UGf8aP0o/Z
         cB8qe+WmdkONFMUmwmt8jQF+3KJaLNUv6v1OhL8kNPAsQ8iuZobuviPNXtMNlSu811aU
         9PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RRo4ybkpBscfj2dOb4X91gyaQ195irCRTp1ncUbw5io=;
        b=IipxC3mSnahzCZXqfXlaj2TPX4ExcauRty1R2jliyDUA82B8fmbc2hhYP+jg6NH/pb
         2urryM+A4Y/b+HpCilNbF/BHHSgm2s+bh/76jgA13/WQ9+lmzIW8fp5z6I+BurSo5YD9
         WUPjC7v7RnfI0ocGXZgAYYx4qvr34Wsgs0U+Rb2Q/a819XxzrE7iroteUOGDe2tN0AdV
         kH+dKBGI9spmgDvZF4Mr9y6vr9YG4yrTw/y6mErIbhTE/K5WeiKT9KS+kswUJmSabiMC
         XR2rGZgSPScmbpep7OsIgvxFkISEE7XIG8NpwQPtaolziVEPzRw65/NEkWvYa4xVMrzF
         n8SQ==
X-Gm-Message-State: APf1xPAwq77ng1RybUjzptjiUGzFJmCK+kiwy3aJrWRs4w5X5obEOZa8
        Y5SNkJIKtsAG2CI8lpbCv5kM44lP4WU=
X-Google-Smtp-Source: AH8x226xGpy/TYjySvyMnOHhI3EQmn3vvAkuGbHviowWb59VZ7xF2QHR5ToheBvFN0HGxhbwUEuI8w==
X-Received: by 10.99.49.15 with SMTP id x15mr438454pgx.149.1517876627068;
        Mon, 05 Feb 2018 16:23:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r24sm17795805pfl.61.2018.02.05.16.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:23:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 136/194] alloc: allow arbitrary repositories for alloc functions
Date:   Mon,  5 Feb 2018 16:16:51 -0800
Message-Id: <20180206001749.218943-38-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to convert them all at once, because alloc_report uses funky a
macro for reporting. It is better for the sake of mechanical conversion
to convert multiple functions at once rather than changing the structure
of the reporting function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c      | 48 ++++++++++++++++++++++++++----------------------
 cache.h      | 22 ++++++++--------------
 object.h     | 20 +++++++++++++++++++-
 repository.c |  6 ++++++
 4 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/alloc.c b/alloc.c
index 277dadd221..0e11c7766a 100644
--- a/alloc.c
+++ b/alloc.c
@@ -32,6 +32,11 @@ struct alloc_state {
 	void *p;   /* first free node in current allocation */
 };
 
+void *allocate_alloc_state(void)
+{
+	return xcalloc(1, sizeof(struct alloc_state));
+}
+
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 {
 	void *ret;
@@ -48,51 +53,49 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	return ret;
 }
 
-static struct alloc_state blob_state;
-void *alloc_blob_node_the_repository(void)
+struct alloc_state the_repository_blob_state;
+void *alloc_blob_node(struct repository *r)
 {
-	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	struct blob *b = alloc_node(r->parsed_objects.blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
-static struct alloc_state tree_state;
-void *alloc_tree_node_the_repository(void)
+struct alloc_state the_repository_tree_state;
+void *alloc_tree_node(struct repository *r)
 {
-	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	struct tree *t = alloc_node(r->parsed_objects.tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
-static struct alloc_state tag_state;
-void *alloc_tag_node_the_repository(void)
+struct alloc_state the_repository_tag_state;
+void *alloc_tag_node(struct repository *r)
 {
-	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	struct tag *t = alloc_node(r->parsed_objects.tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
-static struct alloc_state object_state;
-void *alloc_object_node_the_repository(void)
+struct alloc_state the_repository_object_state;
+void *alloc_object_node(struct repository *r)
 {
-	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
+	struct object *obj = alloc_node(r->parsed_objects.object_state, sizeof(union any_object));
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
+	return r->parsed_objects.commit_count++;
 }
 
-void *alloc_commit_node_the_repository(void)
+struct alloc_state the_repository_commit_state;
+void *alloc_commit_node(struct repository *r)
 {
-	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
+	struct commit *c = alloc_node(r->parsed_objects.commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index(the_repository);
+	c->index = alloc_commit_index(r);
 	return c;
 }
 
@@ -103,9 +106,10 @@ static void report(const char *name, unsigned int count, size_t size)
 }
 
 #define REPORT(name, type)	\
-    report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
+    report(#name, r->parsed_objects.name##_state->count, \
+		  r->parsed_objects.name##_state->count * sizeof(type) >> 10)
 
-void alloc_report_the_repository(void)
+void alloc_report(struct repository *r)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/cache.h b/cache.h
index 40aa3f25aa..ee01daf130 100644
--- a/cache.h
+++ b/cache.h
@@ -1575,20 +1575,14 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
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
+extern void *alloc_blob_node(struct repository *r);
+extern void *alloc_tree_node(struct repository *r);
+extern void *alloc_commit_node(struct repository *r);
+extern void *alloc_tag_node(struct repository *r);
+extern void *alloc_object_node(struct repository *r);
+extern void alloc_report(struct repository *r);
+extern unsigned int alloc_commit_index(struct repository *r);
+void *allocate_alloc_state(void);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/object.h b/object.h
index a61d965700..587db55dfe 100644
--- a/object.h
+++ b/object.h
@@ -8,9 +8,27 @@ struct object_parser {
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;
 	int grafts_alloc, grafts_nr;
+
+	struct alloc_state *blob_state;
+	struct alloc_state *tree_state;
+	struct alloc_state *commit_state;
+	struct alloc_state *tag_state;
+	struct alloc_state *object_state;
+	unsigned commit_count;
 };
 
-#define OBJECT_PARSER_INIT { NULL, 0, 0, NULL, 0, 0 }
+extern struct alloc_state the_repository_blob_state;
+extern struct alloc_state the_repository_tree_state;
+extern struct alloc_state the_repository_commit_state;
+extern struct alloc_state the_repository_tag_state;
+extern struct alloc_state the_repository_object_state;
+#define OBJECT_PARSER_INIT { NULL, 0, 0, NULL, 0, 0, \
+	&the_repository_blob_state, \
+	&the_repository_tree_state, \
+	&the_repository_commit_state, \
+	&the_repository_tag_state, \
+	&the_repository_object_state, \
+	0 }
 
 struct object_list {
 	struct object *item;
diff --git a/repository.c b/repository.c
index 361e503824..f76f0ddd37 100644
--- a/repository.c
+++ b/repository.c
@@ -175,6 +175,12 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 
 	repo_set_hash_algo(repo, format.hash_algo);
 
+	repo->parsed_objects.blob_state = allocate_alloc_state();
+	repo->parsed_objects.tree_state = allocate_alloc_state();
+	repo->parsed_objects.commit_state = allocate_alloc_state();
+	repo->parsed_objects.tag_state = allocate_alloc_state();
+	repo->parsed_objects.object_state = allocate_alloc_state();
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
-- 
2.15.1.433.g936d1b9894.dirty

