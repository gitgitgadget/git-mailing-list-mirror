Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAC4E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeBFALl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:11:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46887 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeBFALk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:11:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id s9so128701pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCnm0nJejFZRA+1TAC7YGldbIdyrBid17jln8PyMCjY=;
        b=LiOoBAxo4Dgmu+bh8RlKOmjIeWqwG7fejpsknrUR3pfOgfhF1zX1S2VzN7nSZEPbCd
         N+R23COb/glxUrHUYlfWj2+vMYCeaQiLlVH7N4CgxIpNlbtIOqaC8iRfd7wmpC8mOUZ2
         zN6QnpArUZdtVbdBqT8w2Fl47JejB6HLgyvxQpYQVfAvVizPkGc+rwoCNdbf2xLFWCur
         nC+G3rtPZ5amNgmTvx+e8YecpjnUkLoy9VT6IRkfv6L1vqC6kFS0EJ50hJKpvYUCcrVA
         +ujsSDPFGohwM45H2D+zy+sCAWKiBksDraelPjvsJoWY/2VxgheFQ8BoUpI5cEy1Oiqi
         fTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCnm0nJejFZRA+1TAC7YGldbIdyrBid17jln8PyMCjY=;
        b=DFTX9AoEHJ9sWO+tmnLQlix0WyM6vra3WQTwyPeYsOmryzSOs/PYov2eYIbOGuzzZT
         eb0KwJEC1JUgcpLq/7mg8T0Q5ouSjNRWAIshYWAq0ftKC+HUC6ufShYdNDTIYxPvdnU2
         Lj/QjY7D213jlCNCZmk6fhSGbh29IUEsDs1IqLcYDknthdmfyGqMTZrbjYrrcjZmGpCm
         iXenuAKV1RcyskMTeyN3vKqP9VdP6AufPH6fw7RY0YBZXqADI1y3l7c+k5Gg788MWHwP
         jDFfkUJayzp8KrmQH46KdiZp3y8uKfPdUO9ijep+lkMf1JkPuk8MHiiEC/plCPqS34Fv
         Hdiw==
X-Gm-Message-State: APf1xPCzooIv1bl9kVLtnDYs6zt645knRsIWCTw1Ck9QgRkAXwxLAee7
        zU+XzBvmGlqQiotlL0UQw0eheKeP7zo=
X-Google-Smtp-Source: AH8x22541mumkvAoxHK702H7JQcfbT/abrXz71jDY09YQqXAxebtSWTBrYpTOSAf2sadxK78w4c5rw==
X-Received: by 10.99.114.15 with SMTP id n15mr442354pgc.8.1517875898995;
        Mon, 05 Feb 2018 16:11:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r11sm6320092pgp.45.2018.02.05.16.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:11:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 081/194] object: add repository argument to create_object
Date:   Mon,  5 Feb 2018 15:55:42 -0800
Message-Id: <20180205235735.216710-61-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
 blob.c                                 | 4 +++-
 commit.c                               | 3 ++-
 contrib/coccinelle/object_parser.cocci | 8 ++++++++
 object.c                               | 5 +++--
 object.h                               | 3 ++-
 tag.c                                  | 3 ++-
 tree.c                                 | 3 ++-
 7 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/blob.c b/blob.c
index fa2ab4f7a7..85c2143f29 100644
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
index 742d710c86..e315d5435b 100644
--- a/commit.c
+++ b/commit.c
@@ -52,7 +52,8 @@ struct commit *lookup_commit(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_commit_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_commit_node());
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index a9afe4bf7a..2a554084d1 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -4,3 +4,11 @@ expression E;
  parse_object(
 + the_repository,
  E)
+
+@@
+expression E;
+expression F;
+@@
+ create_object(
++ the_repository,
+ E, F)
diff --git a/object.c b/object.c
index c1154039df..1126c7e278 100644
--- a/object.c
+++ b/object.c
@@ -137,7 +137,7 @@ static void grow_object_hash(void)
 	the_repository->parsed_objects.obj_hash_size = new_hash_size;
 }
 
-void *create_object(const unsigned char *sha1, void *o)
+void *create_object_the_repository(const unsigned char *sha1, void *o)
 {
 	struct object *obj = o;
 
@@ -177,7 +177,8 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		obj = create_object(sha1, alloc_object_node());
+		obj = create_object(the_repository, sha1,
+				    alloc_object_node());
 	return obj;
 }
 
diff --git a/object.h b/object.h
index e5cad09fad..ac12dc3629 100644
--- a/object.h
+++ b/object.h
@@ -100,7 +100,8 @@ extern struct object *get_indexed_object(unsigned int);
  */
 struct object *lookup_object(const unsigned char *sha1);
 
-extern void *create_object(const unsigned char *sha1, void *obj);
+#define create_object(r, s, o) create_object_##r(s, o)
+extern void *create_object_the_repository(const unsigned char *sha1, void *obj);
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
diff --git a/tag.c b/tag.c
index 5207f70885..a9e5af4294 100644
--- a/tag.c
+++ b/tag.c
@@ -96,7 +96,8 @@ struct tag *lookup_tag(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_tag_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_tag_node());
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
diff --git a/tree.c b/tree.c
index 62d78fb4ba..f8e1e6d63d 100644
--- a/tree.c
+++ b/tree.c
@@ -198,7 +198,8 @@ struct tree *lookup_tree(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(oid->hash, alloc_tree_node());
+		return create_object(the_repository, oid->hash,
+				     alloc_tree_node());
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

