Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9023A200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeEGW72 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33284 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeEGW71 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id f20so14200056pfn.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Ahv3GH7CNB7R6zvy4zjC2oj5qg2Q4wou8ZOYLHkdQM=;
        b=dn9n6MNck7mRmlYNMXUFPuawZ6YEIzynJE8pgj2J3BScVY9RwyUejOkbNM+RPv1viW
         OArQjie2fi+FkzThrALTqGiaLEMSSeWUOXepPoQ9V+wBEzaOGsEZI35pHTk1yOhiEnab
         o76OJIy9FDsrru3ltFN7VmCIeUk2hCjxQ68lTr3gq660+vgaFkqH5fy572G4+ezVCcbv
         EoRpZlfd5HDleoHPPu0W4aXQFXapWj8Yr77RwUT99jv26PLvoGVL84XZ8G5tah8mjoho
         hESbf5sFdhlyc44drhQSpc2LhNpIerwXVs/9m90JUEGmyO7181FPPitbSSCgEbIKg/7R
         Xy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Ahv3GH7CNB7R6zvy4zjC2oj5qg2Q4wou8ZOYLHkdQM=;
        b=IhEAYWjzTUxm8/pe3C8esr4hJI9Vlvlk/dcAwCx/a9smkin6MsPoSgODk3p6epNm5P
         eN0I7U+su03GBF6n+m6erc4qSR3lRZectET88igXlUEGDjVQl0IdNlLMnwLrpR38+51o
         sEubLMYNSyJTE/E4TBVh+AtD/ztmFps/bUydpQqMpS+LaW1ziyzpHRqUr8SIF9val+zJ
         rO4cVwEbyiAVlfWQolu3M3H+Tgug5knuHuKm/6lqF6+eu3+DIYRMkTQDDeTYf43wxcCP
         fHYPbyBelDXb96QrlfB9JY8ZMFJ37iI36/2+xhzZ9ff7Im+oS9VLBRyzUiWRJLY3qjz4
         rn5g==
X-Gm-Message-State: ALQs6tARiF5Lj3SUcpiNO/dxAM98LsUf3nXGCRpijgP7a9XMFw9pSZue
        0+E194j9BWB5WneEaBVahyyNKeCQsK8=
X-Google-Smtp-Source: AB8JxZqtDtdCFpHMORE46y5FMKKrk+ZguJACCVJdo4bSjXcr/KX0M4JQ+n0WgjS6M2ER9BErHL05Nw==
X-Received: by 2002:a63:705d:: with SMTP id a29-v6mr31150950pgn.202.1525733965803;
        Mon, 07 May 2018 15:59:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w85sm46168900pfa.35.2018.05.07.15.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 01/13] repository: introduce parsed objects field
Date:   Mon,  7 May 2018 15:59:04 -0700
Message-Id: <20180507225916.155236-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
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
 repository.h | 13 ++++++++++-
 4 files changed, 67 insertions(+), 24 deletions(-)

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
index e6e00f541bd..73389e81afd 100644
--- a/repository.h
+++ b/repository.h
@@ -22,10 +22,21 @@ struct repository {
 	char *commondir;
 
 	/*
-	 * Holds any information related to accessing the raw object content.
+	 * Holds any information needed to retrieve the raw content
+	 * of objects. The object_parser uses this to get object
+	 * content which it then parses.
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

