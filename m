Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB141FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEAVeQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33313 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeEAVeM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id i194-v6so9095818pgd.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UJ1RqoPmfnMjsHJipgukOaNyA2P03JqffByO3bVgmn8=;
        b=FwIAkngVXAVlJ11yyJkJ+L6oO7ABOdOQMVpvoq5N+Y+i43B0opO9ogsX0DnqsB2LTj
         TCpv+03GXlbDKJpRHa08NLt6+J+YEubTGSAGyOzOsep/j12DAe2vVjCJZhlOyjdnZiG+
         i1nXL0QPFwIFpitB4SBi4DMmSFr+FXmi55ttpr15RA0TDk2AeBWzmL2e2fuYCePzGacW
         pj3h8k75U/6pI9At7hqCnLSV86lGcZoAf2I7tXgC7phUnfJGobNDvDLJwtFB1yAE/ap0
         VIJYAaWaQKerzFqiPX/4aTcZ3ji56dTVGgxWgY17rwYc2x+NUNXBwaKNPKzWot14Scf2
         G7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UJ1RqoPmfnMjsHJipgukOaNyA2P03JqffByO3bVgmn8=;
        b=dnxSMWILUDxP/esqTvYOxaZFD/yZ3gBFysu4enGMVUmy1GLMfzwLudyKZGdBFsv7sz
         vzbStc59o1S9f44LiKUVQSwMIbDGvNFkPs9o78OEFrdvoNwazTLi/s9m/Cv/4C1PUhBE
         H8jgqlo4v+oeCtPGIiYp6Ko1kelvR6inNwp0jKVdQxaRMJGOEV5tm5JyvCIfZCB5VZQ3
         UIN1HdfkvRRjRkrj9YL3dbAqID9J0t3Em8REMTQBM/TB8rbjXmD1EubWYA96tJpUHfJ6
         su8UzzR1vRhV5L4R2SetQtfPFxVHuBloCfwifyGF9TuEtCdvT5c3EBUrOf+TPA83L0A0
         m6hQ==
X-Gm-Message-State: ALQs6tDO/j3KCV8WDr/R+rGfrcQ47RfDiPXtMy/Q906TsBbprUG4d/Y1
        4evCTn+b0NxdCyxVJYtSqt+FUXzqbVk=
X-Google-Smtp-Source: AB8JxZrcDCwFS4zNmak76U1T0KDT4kie+7Fldfc0Ttfx7I6AiMfYVuWQjOiR7JHy8BzBQSJyN9tLnw==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr17884357pli.267.1525210450947;
        Tue, 01 May 2018 14:34:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l19-v6sm15819758pgn.44.2018.05.01.14.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/13] object: add repository argument to create_object
Date:   Tue,  1 May 2018 14:33:52 -0700
Message-Id: <20180501213403.14643-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of create_object
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

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
index 503c73e2d1f..933921e35c9 100644
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
index 84380b2b4d5..d1869dbc502 100644
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
2.17.0.441.gb46fe60e1d-goog

