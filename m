Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7861F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeBFALN (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:11:13 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40795 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeBFALM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:11:12 -0500
Received: by mail-pl0-f67.google.com with SMTP id g18so109336plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cKJ3OvCI7BMzEVkBpURXP8HGU9Tk8vb2GB6LnBvq7VU=;
        b=UZ9GtuNloTfqttqvRyZ8uF2BPv40vUYA0I6DvR0ZEC4OoqTeZvDt/+kDU5QZ7z10KR
         5jMzke0esBDRiQqnYQUQskm0BCK3JIF4RrWBpc4iRXrZD7aidYEj0PTlbcr1UQjmmFGc
         kpYWG1juipcINZpCQzP4BffGxOD+JlQUv4ZDXNcSCQR8EvcndLxlG05FaM4nFeE3Qyto
         BwotNaMMDfog137ZZJhrXGmGku+0m515upVmoF/YUUOIGVFzA7YBxqMpt3KG2sKw6p60
         xUT+H2lNLoorMwdkUay4EzF1+C6Nnn+xdxSwUNvlw862U2VPfIUKtiifU71choTf0CkV
         tPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cKJ3OvCI7BMzEVkBpURXP8HGU9Tk8vb2GB6LnBvq7VU=;
        b=ZYYDPXeVHwCeDyTt7rAjMcrI4yyUvYqlMpnEsvq9rVZYHu7pEcfRIq2ZqFSfkuSkW6
         w+fxKgYZvfu612p59/ukZRVf26EQSx65eVt6abpKeBOxUFQJ2P7z2ogdZgmP2Tw7yPeJ
         52bYNLIApBXKI9CWWz9ymNPqkWQxq2OLFhkDfgdsBW2bWsE9t9YF/5SLBMfX1sM/1yB2
         Yy4mQ+FcwWmPNhbWB947tfZUbUjollkNQ2pT084R8LC9/5k8bMjvX0uE0HTkP8eAGAhi
         Bl2B/gdWEXwEKR/y3C3exbNJrAKTq7T3IF9+hj0b5s+bPXdan9b9l5so1ery0BSB/gZK
         4Y8Q==
X-Gm-Message-State: APf1xPBFitn195HcycDZCRDPSH60Ai/vW5Zv5Icq7oYtu4WxyiFp1T7d
        ga0n9DmMeM4SaetL728KKl/NLNhCm7s=
X-Google-Smtp-Source: AH8x2259lwHZq3+m643cFcUKx9K8pGrMR4KD90W0toY+eP6b65ma3rXkrepnM/08vfJ7ggWXWmgYXQ==
X-Received: by 2002:a17:902:6006:: with SMTP id r6-v6mr538552plj.78.1517875871271;
        Mon, 05 Feb 2018 16:11:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a24sm16816220pff.160.2018.02.05.16.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:11:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 079/194] repository: introduce object parser field
Date:   Mon,  5 Feb 2018 15:55:40 -0800
Message-Id: <20180205235735.216710-59-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h |  4 ++--
 object.c       | 42 +++++++++++++++++++++---------------------
 object.h       |  7 +++++++
 repository.c   |  2 +-
 repository.h   | 14 ++++++++++++--
 5 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/object-store.h b/object-store.h
index 6930cfef82..d009f952f8 100644
--- a/object-store.h
+++ b/object-store.h
@@ -12,7 +12,7 @@ struct pack_window;
 enum object_type;
 extern int check_replace_refs;
 
-struct object_store {
+struct raw_object_store {
 	struct packed_git *packed_git;
 
 	/*
@@ -57,7 +57,7 @@ struct object_store {
 	 */
 	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT \
+#define RAW_OBJECT_STORE_INIT \
 	{ NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0, 0 }, 0, 0, 0 }
 
 struct packed_git {
diff --git a/object.c b/object.c
index 40f7c7bdab..18ea8cf574 100644
--- a/object.c
+++ b/object.c
@@ -7,17 +7,14 @@
 #include "commit.h"
 #include "tag.h"
 
-static struct object **obj_hash;
-static int nr_objs, obj_hash_size;
-
 unsigned int get_max_object_index(void)
 {
-	return obj_hash_size;
+	return the_repository->parsed_objects.obj_hash_size;
 }
 
 struct object *get_indexed_object(unsigned int idx)
 {
-	return obj_hash[idx];
+	return the_repository->parsed_objects.obj_hash[idx];
 }
 
 static const char *object_type_strings[] = {
@@ -89,15 +86,16 @@ struct object *lookup_object(const unsigned char *sha1)
 	unsigned int i, first;
 	struct object *obj;
 
-	if (!obj_hash)
+	if (!the_repository->parsed_objects.obj_hash)
 		return NULL;
 
-	first = i = hash_obj(sha1, obj_hash_size);
-	while ((obj = obj_hash[i]) != NULL) {
+	first = i = hash_obj(sha1,
+			     the_repository->parsed_objects.obj_hash_size);
+	while ((obj = the_repository->parsed_objects.obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->oid.hash))
 			break;
 		i++;
-		if (i == obj_hash_size)
+		if (i == the_repository->parsed_objects.obj_hash_size)
 			i = 0;
 	}
 	if (obj && i != first) {
@@ -106,7 +104,8 @@ struct object *lookup_object(const unsigned char *sha1)
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
 		 */
-		SWAP(obj_hash[i], obj_hash[first]);
+		SWAP(the_repository->parsed_objects.obj_hash[i],
+		     the_repository->parsed_objects.obj_hash[first]);
 	}
 	return obj;
 }
@@ -123,19 +122,19 @@ static void grow_object_hash(void)
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
 	 */
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = the_repository->parsed_objects.obj_hash_size < 32 ? 32 : 2 * the_repository->parsed_objects.obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+	for (i = 0; i < the_repository->parsed_objects.obj_hash_size; i++) {
+		struct object *obj = the_repository->parsed_objects.obj_hash[i];
 		if (!obj)
 			continue;
 		insert_obj_hash(obj, new_hash, new_hash_size);
 	}
-	free(obj_hash);
-	obj_hash = new_hash;
-	obj_hash_size = new_hash_size;
+	free(the_repository->parsed_objects.obj_hash);
+	the_repository->parsed_objects.obj_hash = new_hash;
+	the_repository->parsed_objects.obj_hash_size = new_hash_size;
 }
 
 void *create_object(const unsigned char *sha1, void *o)
@@ -146,11 +145,12 @@ void *create_object(const unsigned char *sha1, void *o)
 	obj->flags = 0;
 	hashcpy(obj->oid.hash, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
+	if (the_repository->parsed_objects.obj_hash_size - 1 <= the_repository->parsed_objects.nr_objs * 2)
 		grow_object_hash();
 
-	insert_obj_hash(obj, obj_hash, obj_hash_size);
-	nr_objs++;
+	insert_obj_hash(obj, the_repository->parsed_objects.obj_hash,
+			the_repository->parsed_objects.obj_hash_size);
+	the_repository->parsed_objects.nr_objs++;
 	return obj;
 }
 
@@ -430,8 +430,8 @@ void clear_object_flags(unsigned flags)
 {
 	int i;
 
-	for (i=0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+	for (i=0; i < the_repository->parsed_objects.obj_hash_size; i++) {
+		struct object *obj = the_repository->parsed_objects.obj_hash[i];
 		if (obj)
 			obj->flags &= ~flags;
 	}
diff --git a/object.h b/object.h
index fbccb09257..2cff106ff7 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,13 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+struct object_parser {
+	struct object **obj_hash;
+	int nr_objs, obj_hash_size;
+};
+
+#define OBJECT_PARSER_INIT { NULL, 0, 0 }
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/repository.c b/repository.c
index 6f85fade82..af62dfdc09 100644
--- a/repository.c
+++ b/repository.c
@@ -6,7 +6,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, OBJECT_STORE_INIT, NULL,
+	NULL, NULL, NULL, RAW_OBJECT_STORE_INIT, OBJECT_PARSER_INIT, NULL,
 	NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
diff --git a/repository.h b/repository.h
index 727ddcea5b..c8a34d1ac9 100644
--- a/repository.h
+++ b/repository.h
@@ -2,6 +2,7 @@
 #define REPOSITORY_H
 
 #include "object-store.h"
+#include "object.h"
 
 struct config_set;
 struct index_state;
@@ -29,9 +30,18 @@ struct repository {
 	char *objectdir;
 
 	/*
-	 * Holds any information related to the object store.
+	 * Holds any information needed to retrieve the raw content
+	 * of objects. The object_parser uses this to get object
+	 * content which it then parses.
 	 */
-	struct object_store objects;
+	struct raw_object_store objects;
+
+	/*
+	 * State for the object parser. This owns all parsed objects
+	 * (struct object) so callers do not have to manage their
+	 * lifetime.
+	 */
+	struct object_parser parsed_objects;
 
 	/*
 	 * The store in which the refs are hold.
-- 
2.15.1.433.g936d1b9894.dirty

