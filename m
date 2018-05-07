Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A523200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeEGW73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36192 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeEGW72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id v24-v6so1010853plo.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7aNcOHvHyHH5ZXubDFc61Bchef06ozPHMZJQttrJzw=;
        b=HLYBptewZ53+3gNA/95U24mOa6e51ec/2EI7vDLhxiqmpXdmXJy6x6KgQpvr3vKezy
         qCNi3inUohACFeFUgcQLQttC/N+tmCV9hncKnZWOsZ4lyKmMO0nOUuy1tJZw3HqUhbKG
         zBem40u30X+N9p86g6PPZVGmjkf6xONfeFvcwTFd4D5xpcGe8AOPn1rUr0wPx3I736MH
         erqg1fdQ2IWRKlY/W6345T2f8VzZw30j1bYi/sxdX4IppLxapXrP7D1O677pc4kWrzBB
         2k42fttNRZez2900v6sF/+DZ0sjTgHICBC5jXrKt7W4dAkE0D1UszMFmSs5XtKKWOv9E
         ReEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7aNcOHvHyHH5ZXubDFc61Bchef06ozPHMZJQttrJzw=;
        b=dWqtpZke5gaiwK1wJVsBzX4RXIjNUrb8b4od2nYL5nIy3hR6iOIVz12KsDbcWU7wyZ
         u34TWV0MD9MMG4OhDfXCEtAvfH5+sbUgWgdgyqvD8ljURBJZfxDBJl4B66HC3cQ61oia
         Tl9nJbGuM7fnmq3AdeMDedo5kdOGbhtGzzK+1P00Gqcz3209UPAKY4/BJ4OHAap6vyRv
         RiHXeKR5FFNFirZFroT+nDX3qe52P1ML25FAYD8ImNrLWXTpeULu/lbbG9GyGF+xI3UF
         0ohd5qkoPJwqesnRrv830TPMJgkBBmghCQ+wq/OS9pjLSD5A7d6B3i52gSb8uYPk8jKU
         Pgyg==
X-Gm-Message-State: ALQs6tBv7gZ9YavsXKqGnWH2b3SMgsVwA0pbxQqiTArEKb1pFs899wTJ
        eXyt46DY/eiIOn1cCd7s8OgXk0asZYo=
X-Google-Smtp-Source: AB8JxZrucktw6jm8Kcp0bXIi32a2XClRwV7H9beTcdhFQlcJ8aY9h38Y6yEvYo3mufA42dcWctBn9w==
X-Received: by 2002:a17:902:b483:: with SMTP id y3-v6mr38415248plr.157.1525733967207;
        Mon, 07 May 2018 15:59:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i1sm27626605pfi.133.2018.05.07.15.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 02/13] object: add repository argument to create_object
Date:   Mon,  7 May 2018 15:59:05 -0700
Message-Id: <20180507225916.155236-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of create_object
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c   | 4 +++-
 commit.c | 3 ++-
 object.c | 5 +++--
 object.h | 3 ++-
 tag.c    | 3 ++-
 tree.c   | 3 ++-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/blob.c b/blob.c
index fa2ab4f7a74..85c2143f299 100644
--- a/blob.c
+++ b/blob.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "repository.h"
 
 const char *blob_type = "blob";
 
@@ -7,7 +8,8 @@ struct blob *lookup_blob(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_blob_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_blob_node());
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/commit.c b/commit.c
index ca474a7c112..9106acf0aad 100644
--- a/commit.c
+++ b/commit.c
@@ -50,7 +50,8 @@ struct commit *lookup_commit(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_commit_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_commit_node());
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/object.c b/object.c
index f7c624a7ba6..2de029275bc 100644
--- a/object.c
+++ b/object.c
@@ -138,7 +138,7 @@ static void grow_object_hash(void)
 	the_repository->parsed_objects->obj_hash_size = new_hash_size;
 }
 
-void *create_object(const unsigned char *sha1, void *o)
+void *create_object_the_repository(const unsigned char *sha1, void *o)
 {
 	struct object *obj = o;
 
@@ -178,7 +178,8 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		obj = create_object(sha1, alloc_object_node());
+		obj = create_object(the_repository, sha1,
+				    alloc_object_node());
 	return obj;
 }
 
diff --git a/object.h b/object.h
index cecda7da370..2cb0b241083 100644
--- a/object.h
+++ b/object.h
@@ -93,7 +93,8 @@ extern struct object *get_indexed_object(unsigned int);
  */
 struct object *lookup_object(const unsigned char *sha1);
 
-extern void *create_object(const unsigned char *sha1, void *obj);
+#define create_object(r, s, o) create_object_##r(s, o)
+extern void *create_object_the_repository(const unsigned char *sha1, void *obj);
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
diff --git a/tag.c b/tag.c
index 3d37c1bd251..7150b759d66 100644
--- a/tag.c
+++ b/tag.c
@@ -93,7 +93,8 @@ struct tag *lookup_tag(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_tag_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_tag_node());
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
diff --git a/tree.c b/tree.c
index 1c68ea586bd..63730e3fb46 100644
--- a/tree.c
+++ b/tree.c
@@ -196,7 +196,8 @@ struct tree *lookup_tree(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_tree_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_tree_node());
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
-- 
2.17.0.255.g8bfb7c0704

