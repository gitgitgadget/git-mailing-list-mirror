Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54A41F424
	for <e@80x24.org>; Thu, 10 May 2018 00:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935633AbeEJAkh (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:37 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37580 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935621AbeEJAkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id a13-v6so173939pgu.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7FVrsqMnzAItxNNnJosIsysFz5457IgbmFv9AwoGso=;
        b=lAmH52Dv13rC23/bDAygP0/+VBEkt2hplcXHJPBYJvIYH7BNUEiUrOsaqJaR2bgpPl
         kRY7m2/puCTPMH9UZ72wNBePzrKeAjmLK2yJwhnmH6kIMhEZkaq3Ihj3tK6pWfQc5Db7
         4hAlClXV91h2Fln9V9B96hzRwtWuHIp3kPN087p1qKj2xIzL8nB54OleoKpacjaNW42u
         CGlbv7+9ROKc3advp1WEVy5loaKr9rEfcWjV+Mdd7iIcockWZhtJ4SWHM5+pIz4ET/tp
         psWkmi+LfeLgC4catXKeOefrKGRV+3Ot5Vxqe/rFRx9GVPjWeaNKPVnepg2H/RVKDYyR
         TgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7FVrsqMnzAItxNNnJosIsysFz5457IgbmFv9AwoGso=;
        b=M3Tcal1PK+3ds0LyGbTUGLZuTiBkcw7FnhreEpQyzlUsdzqv+5e+UxvsViUzWX8H0H
         1xWqz6A2zBUl/80ZszHUQcYV6rqMnFP7qXti9sKdkzdvPUUVSMhZAqGQ//TxMh9NRyPV
         8J3kVpUWdojiNwXaOQqLXa+JhBKwDiOm43dJd0fqrGycTww2CZwppOqLfS6BZTQo6lJW
         ax6XcGoL/g7miqjtNA+ZMBCiePaNsIeS7orwTOoVtc+B0hsXQsSzscjsc7si4JcB6g+j
         Khe2EW3PI9CYqBE28DzjbABcOrubkj0JEfN/SIq6vvIVla+tcn14CKULIUyQL8QLvazZ
         A8cA==
X-Gm-Message-State: ALQs6tCYHYzxxIzM8PNN3dfZvQeL1KYYcJu9VoWxIsEg1agDKJoLUFFX
        2O6cRfb2L8BUVDLpGP8JRCgNdC0clJQ=
X-Google-Smtp-Source: AB8JxZrsdAZTBV4WobLKlDJmpIgJZ+wgIBakAm/F7lHGueONC0viX8Aws5e8yHXIr3asWAnaCOOhmA==
X-Received: by 10.167.132.146 with SMTP id u18mr18764117pfn.225.1525912832708;
        Wed, 09 May 2018 17:40:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p84sm31823654pfi.66.2018.05.09.17.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 02/13] object: add repository argument to create_object
Date:   Wed,  9 May 2018 17:40:13 -0700
Message-Id: <20180510004024.93974-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510004024.93974-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
 <20180510004024.93974-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

