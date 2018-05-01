Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930611FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeEAVeM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42096 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEAVeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id p9-v6so6185973pgc.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sHXYPrWhcnmKgzrazNQUeciGeojoMctS13IIk7oo0zw=;
        b=OouZUEY7DyCuorHMQSYHqnTJg18WRHOKiwe4LYvX53QCuAsTGrP1D13fg5Iro7s3S/
         vkyRLu5nmwulACXcRvaA6SS47RI2XYaAFYPw8vQrKeB5v/IrRZPkT8wLNXW2suaUQcJ1
         +eKm43gpKYR/u5kndOOmPNVgJJykgGP3qP2yYeQjz9y2eAzbUipyKlWqpDiCcsgdwDN2
         3HORHNdbEYtJI7NRNbv9r2iJeVtC96bJP7dt+ZvWgG4JlHkuUSLPPAHPlAr1u19dAmh/
         6kl36RyPiL3/aENS1SNOzhFlzWtzD2li0Ur1ClN+RBUnfc/SzRuOsq6p0+ggp1zcgg6E
         dTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sHXYPrWhcnmKgzrazNQUeciGeojoMctS13IIk7oo0zw=;
        b=ObtwftQ7Rlu4fxLCPo4MjPySh3IwsNq60QunW9pOGr30y9pThCJhVNWc9SHxlrpsWh
         K9jHSC2xat+DwwWLYXnyKr3ZC29ZoEWfI/GsUIGqmWVYiRyLUMvdOTY8ySs1fHFAxOAB
         yt6AgZoKgldMffD/okj5dF01cqS3ebEDDv0xSnfvPLlWFELIIsL5o9M8scYCpj7jz5fy
         uR2RD71CjUHeK9vCXcRBg+iHwe6JLU96qYvUS3xn3TKHmzkf4SvUN7FQAzaYNcy9gAJW
         wPAe6qRX80zV0+nYExcEuvKsvOCHk6vDQH7MiXorIkWusnvHTNtmgryFZq05UMVfWr8T
         ln2g==
X-Gm-Message-State: ALQs6tAWWvWlnCL+yCbKXJ8+zZcw2fAwLeBVuCO3EL0DQiB8CdH9ZJn3
        FxFqStYHP3qF4Xwk19e3z5jmwtD9DEk=
X-Google-Smtp-Source: AB8JxZruwIExdMeW8mk0HBnuwszSLcM1Zn07bU8Gj51e22mZvqQNnOTm43ZUkyckMTVk+r+YgRMijw==
X-Received: by 10.98.150.92 with SMTP id c89mr17134570pfe.37.1525210449089;
        Tue, 01 May 2018 14:34:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r30-v6sm17816913pgu.17.2018.05.01.14.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/13] repository: introduce object parser field
Date:   Tue,  1 May 2018 14:33:51 -0700
Message-Id: <20180501213403.14643-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's object access code can be thought of as containing two layers:
the raw object store provides access to raw object content, while the
higher level obj_hash code parses raw objects and keeps track of
parenthood and other object relationships using 'struct object'.
Keeping these layers separate should make it easier to find relevant
functions and to change the implementation of one without having to
touch the other.

Add an object_parser field to 'struct repository' to prepare obj_hash
to be handled per repository.  Callers still only use the_repository
for now --- later patches will adapt them to handle arbitrary
repositories.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c     | 63 +++++++++++++++++++++++++++++++++-------------------
 object.h     |  8 +++++++
 repository.c |  7 ++++++
 repository.h | 11 ++++++++-
 4 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/object.c b/object.c
index 5044d08e96c..503c73e2d1f 100644
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
 
+struct object_parser *object_parser_new(void)
+{
+	struct object_parser *o = xmalloc(sizeof(*o));
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
+void object_parser_clear(struct object_parser *o)
+{
+	/*
+	 * TOOD free objects in o->obj_hash.
+	 *
+	 * As objects are allocated in slabs (see alloc.c), we do
+	 * not need to free each object, but each slab instead.
+	 */
+}
diff --git a/object.h b/object.h
index f13f85b2a94..84380b2b4d5 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,14 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+struct object_parser {
+	struct object **obj_hash;
+	int nr_objs, obj_hash_size;
+};
+
+struct object_parser *object_parser_new(void);
+void object_parser_clear(struct object_parser *o);
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/repository.c b/repository.c
index a4848c1bd05..208ee10071c 100644
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
+	the_repo.parsed_objects = object_parser_new();
+
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
@@ -143,6 +146,7 @@ static int repo_init(struct repository *repo,
 	memset(repo, 0, sizeof(*repo));
 
 	repo->objects = raw_object_store_new();
+	repo->parsed_objects = object_parser_new();
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
@@ -226,6 +230,9 @@ void repo_clear(struct repository *repo)
 	raw_object_store_clear(repo->objects);
 	FREE_AND_NULL(repo->objects);
 
+	object_parser_clear(repo->parsed_objects);
+	FREE_AND_NULL(repo->parsed_objects);
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git a/repository.h b/repository.h
index e6e00f541bd..8d042e0fa11 100644
--- a/repository.h
+++ b/repository.h
@@ -22,10 +22,19 @@ struct repository {
 	char *commondir;
 
 	/*
-	 * Holds any information related to accessing the raw object content.
+	 * Holds any information needed to retrieve the raw content
+	 * of objects. The object_parser uses this to get object
+	 * content which it then parses.
 	 */
 	struct raw_object_store *objects;
 
+	/*
+	 * State for the object parser. This owns all parsed objects
+	 * (struct object) so callers do not have to manage their
+	 * lifetime.
+	 */
+	struct object_parser *parsed_objects;
+
 	/* The store in which the refs are held. */
 	struct ref_store *refs;
 
-- 
2.17.0.441.gb46fe60e1d-goog

