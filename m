Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E149C1F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935591AbeEJAkb (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35003 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934395AbeEJAka (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id i5-v6so245664plt.2
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IuOacrM6ZbQNNAvG7UzMGzUDLohL6VtYJaiv1mDaKMk=;
        b=FuSkgp0YERMvUogQX3mPyadJt1OiWU+9G0/+qLjDhW7qlKJtyZHWmgT2am/ROtXgp5
         DPItzxYL8nx4uJRM0sn56FV356obeGhKcQ6FE6ahaUBlRZdZ0ZieIj2vnjqb5HIcbRpP
         7rlkEbxEkxcOBwxLAGY6DCLKGJqZzPBQZtesKUC2CKyxlgvwRBc6wgPzgG5zNOd8mHGA
         agF3x1rbFZDvdlQGv5e/b4k6/qVJrAcqtB+BK0uSTX45jNCyZb9VBut0efnIG9FS+56q
         Wh2oHtnhnDvyDiY9seMNBBaZp0Ql0yxHRwRtMKDY2BmHjktoC91nDkcOMhjKhg7Ek+wT
         r17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IuOacrM6ZbQNNAvG7UzMGzUDLohL6VtYJaiv1mDaKMk=;
        b=rw4pLDJM+jJMHczqdcui9xfY51yDWCeBGQp0MS8nqhaCXBcRPLK+e5zhTo6NHSesIF
         gOIOaNVsIG9bs9j7nwelaJKYqVeJKe9oCLw/VfuYxcnaHzzY47b3RW/4cFf7x/rr1jnA
         vGIItgLFSZnPepH3fyN3yVd4VTSB1MZim4gsXfh2gG61qJJRNLHJYwH4X4v0qBY5GaJA
         87I62Nkima9KFPjiWdUzeR/ISqNzziL6TCMrMAvFwzks40qlHOKH513H/gBT7uolhtTl
         YIHje0OdYuMpupg8lgjiaOQZrR0p4KmkbViN0JKL+psmVRPraOmcc7WeDo7EKk42R8Vz
         Zmbw==
X-Gm-Message-State: ALQs6tCD8wtsdHkZUMSzOig2Cwo5rGd5xe9bWeDjrkYafGRI8pPsEYWI
        mrmZrn1x/4Wn8qrMpkd9B0VNb7WfsXY=
X-Google-Smtp-Source: AB8JxZrEdl1iU5C3+RwTn2Q5WyuWdq8oyMCUJ9dJ+DV7ZJENMmYSBoAHqrsCLuggsdwUx3Ure+XpgA==
X-Received: by 2002:a17:902:9686:: with SMTP id n6-v6mr46047468plp.136.1525912829471;
        Wed, 09 May 2018 17:40:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e25sm3475065pfn.88.2018.05.09.17.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 00/13] object store: alloc
Date:   Wed,  9 May 2018 17:40:11 -0700
Message-Id: <20180510004024.93974-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* address the memory issues, an interdiff is below.

v3:

* I used the (soon to be renamed?) branch-diff tool to attach a diff below
  between v2 and v3 
  
* fixed comment in patch 1
* correctly free objects and its hashmap in the last patch.
* drop free'ing the commit->util pointer as we do not know where
  it points to.

v2:
* I decided to stick with alloc.c and not migrate it to the mem-pool for now.
  The reasoning for that is that mem-pool.h would introduce some alignment
  waste, which I really did not want to.
* renamed to struct parsed_object_pool;
* free'd the additional memory of trees and commits.
* do not special case the_repository for allocation purposes
* corrected&polished commit messages
* I used the (soon to be renamed?) branch-diff tool to attach a diff below.
  (I still need to get used to that format, I find an interdiff of the
   branches easier to read, but that would not yield the commit messages)



v1:
This applies on top of sb/oid-object-info and is the logical continuum of
the series that it builds on; this brings the object store into more of
Gits code, removing global state, such that reasoning about the state of
the in-memory representation of the repository is easier.

My original plan was to convert lookup_commit_graft as the next series,
which would be similar to lookup_replace_object, as in sb/object-store-replace.
The grafts and shallow mechanism are very close to each other, such that
they need to be converted at the same time, both depending on the
"parsed object store" that is introduced in this commit.

The next series will then convert code in {object/blob/tree/commit/tag}.c
hopefully finishing the lookup_* functions.

I also debated if it is worth converting alloc.c via this patch series
or if it might make more sense to use the new mem-pool by Jameson[1].

I vaguely wonder about the performance impact, as the object allocation
code seemed to be relevant in the past.

[1] https://public-inbox.org/git/20180430153122.243976-1-jamill@microsoft.com/

Any comments welcome,
Thanks,
Stefan

Jonathan Nieder (1):
  object: add repository argument to grow_object_hash

Stefan Beller (12):
  repository: introduce parsed objects field
  object: add repository argument to create_object
  alloc: add repository argument to alloc_blob_node
  alloc: add repository argument to alloc_tree_node
  alloc: add repository argument to alloc_commit_node
  alloc: add repository argument to alloc_tag_node
  alloc: add repository argument to alloc_object_node
  alloc: add repository argument to alloc_report
  alloc: add repository argument to alloc_commit_index
  object: allow grow_object_hash to handle arbitrary repositories
  object: allow create_object to handle arbitrary repositories
  alloc: allow arbitrary repositories for alloc functions

 alloc.c           |  65 ++++++++++++++++----------
 alloc.h           |  19 ++++++++
 blame.c           |   3 +-
 blob.c            |   5 +-
 cache.h           |   9 ----
 commit.c          |  11 ++++-
 commit.h          |   6 +++
 merge-recursive.c |   3 +-
 object.c          | 113 ++++++++++++++++++++++++++++++++++------------
 object.h          |  18 +++++++-
 repository.c      |   7 +++
 repository.h      |   9 ++++
 tag.c             |   9 +++-
 tag.h             |   1 +
 tree.c            |   4 +-
 15 files changed, 214 insertions(+), 68 deletions(-)
 create mode 100644 alloc.h

-- 
2.17.0.255.g8bfb7c0704

diff --git c/alloc.c w/alloc.c
index 4ecf0f160f4..714df633169 100644
--- c/alloc.c
+++ w/alloc.c
@@ -47,6 +47,8 @@ void clear_alloc_state(struct alloc_state *s)
 		s->slab_nr--;
 		free(s->slabs[s->slab_nr]);
 	}
+
+	FREE_AND_NULL(s->slabs);
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
@@ -110,22 +112,6 @@ void *alloc_commit_node(struct repository *r)
 	return c;
 }
 
-void release_tree_node(struct tree *t)
-{
-	free(t->buffer);
-}
-
-void release_commit_node(struct commit *c)
-{
-	free_commit_list(c->parents);
-	/* TODO: what about commit->util? */
-}
-
-void release_tag_node(struct tag *t)
-{
-	free(t->tag);
-}
-
 static void report(const char *name, unsigned int count, size_t size)
 {
 	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
diff --git c/alloc.h w/alloc.h
index 941d71960fb..3e4e828db48 100644
--- c/alloc.h
+++ w/alloc.h
@@ -16,8 +16,4 @@ unsigned int alloc_commit_index(struct repository *r);
 void *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
 
-void release_tree_node(struct tree *t);
-void release_commit_node(struct commit *c);
-void release_tag_node(struct tag *t);
-
 #endif
diff --git c/commit.c w/commit.c
index c3b400d5930..612ccf7b053 100644
--- c/commit.c
+++ w/commit.c
@@ -297,6 +297,13 @@ void free_commit_buffer(struct commit *commit)
 	}
 }
 
+void release_commit_memory(struct commit *c)
+{
+	free_commit_buffer(c);
+	free_commit_list(c->parents);
+	/* TODO: what about commit->util? */
+}
+
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
diff --git c/commit.h w/commit.h
index 0fb8271665c..2d764ab7d8e 100644
--- c/commit.h
+++ w/commit.h
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
diff --git c/object.c w/object.c
index 803d34ae189..9d5b10d5a20 100644
--- c/object.c
+++ w/object.c
@@ -524,11 +524,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 			continue;
 
 		if (obj->type == OBJ_TREE)
-			release_tree_node((struct tree*)obj);
+			free_tree_buffer((struct tree*)obj);
 		else if (obj->type == OBJ_COMMIT)
-			release_commit_node((struct commit*)obj);
+			release_commit_memory((struct commit*)obj);
 		else if (obj->type == OBJ_TAG)
-			release_tag_node((struct tag*)obj);
+			free_tag_buffer((struct tag*)obj);
 	}
 
 	FREE_AND_NULL(o->obj_hash);
@@ -539,4 +539,9 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	clear_alloc_state(o->commit_state);
 	clear_alloc_state(o->tag_state);
 	clear_alloc_state(o->object_state);
+	FREE_AND_NULL(o->blob_state);
+	FREE_AND_NULL(o->tree_state);
+	FREE_AND_NULL(o->commit_state);
+	FREE_AND_NULL(o->tag_state);
+	FREE_AND_NULL(o->object_state);
 }
diff --git c/tag.c w/tag.c
index af6a0725b6a..254352c30c6 100644
--- c/tag.c
+++ w/tag.c
@@ -116,6 +116,11 @@ static timestamp_t parse_tag_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
+void free_tag_buffer(struct tag *t)
+{
+	free(t->tag);
+}
+
 int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
diff --git c/tag.h w/tag.h
index d469534e82a..b241fe67bc5 100644
--- c/tag.h
+++ w/tag.h
@@ -15,6 +15,7 @@ struct tag {
 extern struct tag *lookup_tag(const struct object_id *oid);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
+extern void free_tag_buffer(struct tag *t);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
