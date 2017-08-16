Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377EE1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbdHPURW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:22 -0400
Received: from vie01a-dmta-pe02-2.mx.upcmail.net ([62.179.121.158]:28927 "EHLO
        vie01a-dmta-pe02-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752583AbdHPUQw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:52 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kF-0005Lo-0J
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:51 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGg1v00U5BuuEg01wGhLF; Wed, 16 Aug 2017 22:16:42 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id D82CC45D4512; Wed, 16 Aug 2017 22:16:41 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 07/19] Convert parse_X_buffer to size_t
Date:   Wed, 16 Aug 2017 22:16:19 +0200
Message-Id: <1502914591-26215-8-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 blob.c         | 2 +-
 blob.h         | 2 +-
 builtin/fsck.c | 2 +-
 commit.c       | 2 +-
 commit.h       | 2 +-
 object.c       | 2 +-
 object.h       | 2 +-
 pack-check.c   | 2 +-
 pack.h         | 2 +-
 tag.c          | 4 ++--
 tag.h          | 2 +-
 tree.c         | 2 +-
 tree.h         | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/blob.c b/blob.c
index fa2ab4f..7530624 100644
--- a/blob.c
+++ b/blob.c
@@ -11,7 +11,7 @@ struct blob *lookup_blob(const struct object_id *oid)
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
+int parse_blob_buffer(struct blob *item, void *buffer, size_t size)
 {
 	item->object.parsed = 1;
 	return 0;
diff --git a/blob.h b/blob.h
index 4460616..31e9aa3 100644
--- a/blob.h
+++ b/blob.h
@@ -11,7 +11,7 @@ struct blob {
 
 struct blob *lookup_blob(const struct object_id *oid);
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
+int parse_blob_buffer(struct blob *item, void *buffer, size_t size);
 
 /**
  * Blobs do not contain references to other objects and do not have
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 635902c..e31a52a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -369,7 +369,7 @@ static int fsck_obj(struct object *obj)
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten)
+			   size_t size, void *buffer, int *eaten)
 {
 	/*
 	 * Note, buffer may be NULL if type is OBJ_BLOB. See
diff --git a/commit.c b/commit.c
index 22e66b8..79decc2 100644
--- a/commit.c
+++ b/commit.c
@@ -310,7 +310,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer(struct commit *item, const void *buffer, size_t size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
diff --git a/commit.h b/commit.h
index 6d857f0..82e966e 100644
--- a/commit.h
+++ b/commit.h
@@ -58,7 +58,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
+int parse_commit_buffer(struct commit *item, const void *buffer, size_t size);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/object.c b/object.c
index dff9f52..1a18545 100644
--- a/object.c
+++ b/object.c
@@ -179,7 +179,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
diff --git a/object.h b/object.h
index 0a419ba..8b1bbfd 100644
--- a/object.h
+++ b/object.h
@@ -102,7 +102,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/pack-check.c b/pack-check.c
index a78da5a..da64a91 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -175,7 +175,7 @@ int verify_pack_index(struct packed_git *p)
 
 	/* Verify SHA1 sum of the index file */
 	git_SHA1_Init(&ctx);
-	git_SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
+	git_SHA1_Update(&ctx, index_base, (size_t)(index_size - 20));
 	git_SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, index_base + index_size - 20))
 		err = error("Packfile index for %s SHA1 mismatch",
diff --git a/pack.h b/pack.h
index 8294341..0070927 100644
--- a/pack.h
+++ b/pack.h
@@ -75,7 +75,7 @@ struct pack_idx_entry {
 
 struct progress;
 /* Note, the data argument could be NULL if object type is blob */
-typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
+typedef int (*verify_fn)(const struct object_id *, enum object_type, size_t, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
diff --git a/tag.c b/tag.c
index b6bb5ea..301ee9c 100644
--- a/tag.c
+++ b/tag.c
@@ -7,7 +7,7 @@
 
 const char *tag_type = "tag";
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+static int run_gpg_verify(const char *buf, size_t size, unsigned flags)
 {
 	struct signature_check sigc;
 	size_t payload_size;
@@ -114,7 +114,7 @@ static timestamp_t parse_tag_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct tag *item, const void *data, size_t size)
 {
 	struct object_id oid;
 	char type[20];
diff --git a/tag.h b/tag.h
index d469534..8ed0648 100644
--- a/tag.h
+++ b/tag.h
@@ -13,7 +13,7 @@ struct tag {
 };
 
 extern struct tag *lookup_tag(const struct object_id *oid);
-extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
+extern int parse_tag_buffer(struct tag *item, const void *data, size_t size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
diff --git a/tree.c b/tree.c
index 5e42f83..956d65f 100644
--- a/tree.c
+++ b/tree.c
@@ -200,7 +200,7 @@ struct tree *lookup_tree(const struct object_id *oid)
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
-int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
+int parse_tree_buffer(struct tree *item, void *buffer, size_t size)
 {
 	if (item->object.parsed)
 		return 0;
diff --git a/tree.h b/tree.h
index 744e6dc..1dac7fc 100644
--- a/tree.h
+++ b/tree.h
@@ -14,7 +14,7 @@ struct tree {
 
 struct tree *lookup_tree(const struct object_id *oid);
 
-int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
+int parse_tree_buffer(struct tree *item, void *buffer, size_t size);
 
 int parse_tree_gently(struct tree *tree, int quiet_on_missing);
 static inline int parse_tree(struct tree *tree)
-- 
2.1.4

