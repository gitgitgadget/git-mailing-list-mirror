Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3090200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbeEHThq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:37:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42430 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEHTho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id p14so13053132pfh.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=509oYv80Fs37qcyYyUzRhIkl0rUSVVSUHtbOMdjfnIo=;
        b=rxHK9K1K16tQte20igj06s7HD6yuVcrwG0k6DRzxTo5ZPZvPR8qoeJxmliJhoOFjET
         /Swg1I5XbvIZIeSkEzn2qfxuiK5wm5L/d0FEdMQnyfgtYuODhdMwo2x42tmvRx3W8kxY
         goGnR84gF4GlS8QVD2iT0RcGw67TYx/c+2RSEBj0Fc+ph/6e/5+LEtaoiK3F+6nU4fZN
         Ckafk+7uU2GuH2PzNbyKol/nlUeryzy36USmBfY+arBSRHoceybAaVPaJnLqQitvj/GC
         yxvM5If8HERdjZ/JqTojXWSlDdiFRrd6P2hXidc+A7f+p+9fzue8NSPBggZRIgKGfd7M
         9jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=509oYv80Fs37qcyYyUzRhIkl0rUSVVSUHtbOMdjfnIo=;
        b=JECBt6EomxRHgSYguxnOcsdysvAZkvwwRuugkYKxPsqUAif2eUSsLJjDgvJDEsRP0e
         NUEzgKYvKBzEnidXWcZhUnKkLAQ/bkh8CIxmrJdzXke9uVHrCuNoYQzpK6Rf0y2naVPT
         i06h4goJn+cjBCBHOlDcnBaq6l3NE5hKQEZ065XMXkPxVTbzcQeu8fe8IZSvMjLaOK4i
         jNK9EBFXmb4BRjDOMw2zRTjFlQIlQ0S+tziCG/D32OLvrfe2FzJlPX7z0Y/ZXcDKbBrV
         7itfiEnu7cEspNVBe5Y3NXTN7ZeGSUVPHqzOffH+Mmb+xfJYPJtH05OY/oYFpKtzxs8R
         /owQ==
X-Gm-Message-State: ALQs6tDeW7NxJI5StcVi5sG1CMVqWmr9hU+Xys+Dp85KQt9EZgYWK99/
        mAhbisp0q2uvdykap9CYWLqPpQ==
X-Google-Smtp-Source: AB8JxZq/MvdkhfNvhHwyTOHqncny+giqUaBPnfHQnovava02/fYU/+9eTe1oD/RVx/CsM983YB+A0w==
X-Received: by 2002:a63:43c6:: with SMTP id q189-v6mr34776225pga.123.1525808263972;
        Tue, 08 May 2018 12:37:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m14-v6sm4676156pgs.72.2018.05.08.12.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 01/13] repository: introduce parsed objects field
Date:   Tue,  8 May 2018 12:37:24 -0700
Message-Id: <20180508193736.14883-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
 <20180508193736.14883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the existing global cache for parsed objects (obj_hash) into
repository-specific parsed object caches. Existing code that uses
obj_hash are modified to use the parsed object cache of
the_repository; future patches will use the parsed object caches of
other repositories.

Another future use case for a pool of objects is ease of memory management
in revision walking: If we can free the rev-list related memory early in
pack-objects (e.g. part of repack operation) then it could lower memory
pressure significantly when running on large repos. While this has been
discussed on the mailing list lately, this series doesn't implement this.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c     | 63 +++++++++++++++++++++++++++++++++-------------------
 object.h     |  8 +++++++
 repository.c |  7 ++++++
 repository.h |  9 ++++++++
 4 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/object.c b/object.c
index 5044d08e96c..f7c624a7ba6 100644
--- a/object.c
+++ b/object.c
@@ -8,17 +8,14 @@
 #include "object-store.h"
 #include "packfile.h"
 
-static struct object **obj_hash;
-static int nr_objs, obj_hash_size;
-
 unsigned int get_max_object_index(void)
 {
-	return obj_hash_size;
+	return the_repository->parsed_objects->obj_hash_size;
 }
 
 struct object *get_indexed_object(unsigned int idx)
 {
-	return obj_hash[idx];
+	return the_repository->parsed_objects->obj_hash[idx];
 }
 
 static const char *object_type_strings[] = {
@@ -90,15 +87,16 @@ struct object *lookup_object(const unsigned char *sha1)
 	unsigned int i, first;
 	struct object *obj;
 
-	if (!obj_hash)
+	if (!the_repository->parsed_objects->obj_hash)
 		return NULL;
 
-	first = i = hash_obj(sha1, obj_hash_size);
-	while ((obj = obj_hash[i]) != NULL) {
+	first = i = hash_obj(sha1,
+			     the_repository->parsed_objects->obj_hash_size);
+	while ((obj = the_repository->parsed_objects->obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->oid.hash))
 			break;
 		i++;
-		if (i == obj_hash_size)
+		if (i == the_repository->parsed_objects->obj_hash_size)
 			i = 0;
 	}
 	if (obj && i != first) {
@@ -107,7 +105,8 @@ struct object *lookup_object(const unsigned char *sha1)
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
 		 */
-		SWAP(obj_hash[i], obj_hash[first]);
+		SWAP(the_repository->parsed_objects->obj_hash[i],
+		     the_repository->parsed_objects->obj_hash[first]);
 	}
 	return obj;
 }
@@ -124,19 +123,19 @@ static void grow_object_hash(void)
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
 	 */
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = the_repository->parsed_objects->obj_hash_size < 32 ? 32 : 2 * the_repository->parsed_objects->obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+	for (i = 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = the_repository->parsed_objects->obj_hash[i];
 		if (!obj)
 			continue;
 		insert_obj_hash(obj, new_hash, new_hash_size);
 	}
-	free(obj_hash);
-	obj_hash = new_hash;
-	obj_hash_size = new_hash_size;
+	free(the_repository->parsed_objects->obj_hash);
+	the_repository->parsed_objects->obj_hash = new_hash;
+	the_repository->parsed_objects->obj_hash_size = new_hash_size;
 }
 
 void *create_object(const unsigned char *sha1, void *o)
@@ -147,11 +146,12 @@ void *create_object(const unsigned char *sha1, void *o)
 	obj->flags = 0;
 	hashcpy(obj->oid.hash, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
+	if (the_repository->parsed_objects->obj_hash_size - 1 <= the_repository->parsed_objects->nr_objs * 2)
 		grow_object_hash();
 
-	insert_obj_hash(obj, obj_hash, obj_hash_size);
-	nr_objs++;
+	insert_obj_hash(obj, the_repository->parsed_objects->obj_hash,
+			the_repository->parsed_objects->obj_hash_size);
+	the_repository->parsed_objects->nr_objs++;
 	return obj;
 }
 
@@ -431,8 +431,8 @@ void clear_object_flags(unsigned flags)
 {
 	int i;
 
-	for (i=0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+	for (i=0; i < the_repository->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = the_repository->parsed_objects->obj_hash[i];
 		if (obj)
 			obj->flags &= ~flags;
 	}
@@ -442,13 +442,20 @@ void clear_commit_marks_all(unsigned int flags)
 {
 	int i;
 
-	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+	for (i = 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = the_repository->parsed_objects->obj_hash[i];
 		if (obj && obj->type == OBJ_COMMIT)
 			obj->flags &= ~flags;
 	}
 }
 
+struct parsed_object_pool *parsed_object_pool_new(void)
+{
+	struct parsed_object_pool *o = xmalloc(sizeof(*o));
+	memset(o, 0, sizeof(*o));
+	return o;
+}
+
 struct raw_object_store *raw_object_store_new(void)
 {
 	struct raw_object_store *o = xmalloc(sizeof(*o));
@@ -488,3 +495,13 @@ void raw_object_store_clear(struct raw_object_store *o)
 	close_all_packs(o);
 	o->packed_git = NULL;
 }
+
+void parsed_object_pool_clear(struct parsed_object_pool *o)
+{
+	/*
+	 * TOOD free objects in o->obj_hash.
+	 *
+	 * As objects are allocated in slabs (see alloc.c), we do
+	 * not need to free each object, but each slab instead.
+	 */
+}
diff --git a/object.h b/object.h
index f13f85b2a94..cecda7da370 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,14 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+struct parsed_object_pool {
+	struct object **obj_hash;
+	int nr_objs, obj_hash_size;
+};
+
+struct parsed_object_pool *parsed_object_pool_new(void);
+void parsed_object_pool_clear(struct parsed_object_pool *o);
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/repository.c b/repository.c
index a4848c1bd05..c23404677eb 100644
--- a/repository.c
+++ b/repository.c
@@ -2,6 +2,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "config.h"
+#include "object.h"
 #include "submodule-config.h"
 
 /* The main repository */
@@ -14,6 +15,8 @@ void initialize_the_repository(void)
 
 	the_repo.index = &the_index;
 	the_repo.objects = raw_object_store_new();
+	the_repo.parsed_objects = parsed_object_pool_new();
+
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
@@ -143,6 +146,7 @@ static int repo_init(struct repository *repo,
 	memset(repo, 0, sizeof(*repo));
 
 	repo->objects = raw_object_store_new();
+	repo->parsed_objects = parsed_object_pool_new();
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
@@ -226,6 +230,9 @@ void repo_clear(struct repository *repo)
 	raw_object_store_clear(repo->objects);
 	FREE_AND_NULL(repo->objects);
 
+	parsed_object_pool_clear(repo->parsed_objects);
+	FREE_AND_NULL(repo->parsed_objects);
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git a/repository.h b/repository.h
index e6e00f541bd..6d199819905 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,15 @@ struct repository {
 	 */
 	struct raw_object_store *objects;
 
+	/*
+	 * All objects in this repository that have been parsed. This structure
+	 * owns all objects it references, so users of "struct object *"
+	 * generally do not need to free them; instead, when a repository is no
+	 * longer used, call parsed_object_pool_clear() on this structure, which
+	 * is called by the repositories repo_clear on its desconstruction.
+	 */
+	struct parsed_object_pool *parsed_objects;
+
 	/* The store in which the refs are held. */
 	struct ref_store *refs;
 
-- 
2.17.0.255.g8bfb7c0704

