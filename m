Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC29207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbdEFWMn (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:43 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38010 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754442AbdEFWLZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 36B0C280CE;
        Sat,  6 May 2017 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108675;
        bh=Z1sVHj14RI8xN6TWkX3g4Kgx6VTXPZGMHdc8DTExTcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4D++qPEjP12kkd/7KnlsZgx5CxfkEzAqOVhKpDX0BuDGBFgKUYen1dCdcGFjFkrs
         ID8FQ+X/7EZXzCDp/60JfznpTaBWyjADiiDg2VO+BrtjVmBLz4Du0jIyh4blbhEBeX
         9/B9fL5bI5WRURRBJuF/wHH+5VejNUXmv/0dz4BJ+k8u0le6hiiIrs0iVybGLjaroW
         1zgnMXy+jrUE1eBNDHu4Ae7XhAVfUZcri8L2vzMboSbB1NsC4U4X1oDQ9bUSfveQkm
         RAWQJPuNUaWLbQ55nEeC/6Nu74+Wq4sPmFZCJ/WoN565m84DElAVqAJy6TFPUv4qI3
         fES4QXOJGerkYkSXc/vY/CF2W5XS72gDunz6QrTXTw12T2AX+GJKBXdOOic6M1wYhS
         Apeg22gcyJ90c0c7Mm7U35Pg9WnyItzR+nDcsFZMo83PUhm3hmvVPxK84x9j2HE0LV
         0o/TG1IQVQbNkevXtKIMGkka8qLce4MhrFmzEqK74VCzhOB/ubl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 34/53] Convert lookup_tag to struct object_id
Date:   Sat,  6 May 2017 22:10:19 +0000
Message-Id: <20170506221038.296722-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert lookup_tag to take a pointer to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/describe.c     | 6 +++---
 builtin/pack-objects.c | 2 +-
 builtin/replace.c      | 2 +-
 log-tree.c             | 2 +-
 object.c               | 2 +-
 sha1_name.c            | 2 +-
 tag.c                  | 8 ++++----
 tag.h                  | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index f6032f593..893c8789f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -79,13 +79,13 @@ static int replace_name(struct commit_name *e,
 		struct tag *t;
 
 		if (!e->tag) {
-			t = lookup_tag(e->oid.hash);
+			t = lookup_tag(&e->oid);
 			if (!t || parse_tag(t))
 				return 1;
 			e->tag = t;
 		}
 
-		t = lookup_tag(oid->hash);
+		t = lookup_tag(oid);
 		if (!t || parse_tag(t))
 			return 0;
 		*tag = t;
@@ -245,7 +245,7 @@ static unsigned long finish_depth_computation(
 static void display_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
-		n->tag = lookup_tag(n->oid.hash);
+		n->tag = lookup_tag(&n->oid);
 		if (!n->tag || parse_tag(n->tag))
 			die(_("annotated tag %s not available"), n->path);
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d76ff0542..7cebb5a7f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2348,7 +2348,7 @@ static void add_tag_chain(const struct object_id *oid)
 	if (packlist_find(&to_pack, oid->hash, NULL))
 		return;
 
-	tag = lookup_tag(oid->hash);
+	tag = lookup_tag(oid);
 	while (1) {
 		if (!tag || parse_tag(tag) || !tag->tagged)
 			die("unable to pack objects reachable from tag %s",
diff --git a/builtin/replace.c b/builtin/replace.c
index 3c44ef750..c921bc976 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -355,7 +355,7 @@ static void check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_oid.hash);
-	tag = lookup_tag(tag_oid.hash);
+	tag = lookup_tag(&tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
diff --git a/log-tree.c b/log-tree.c
index 169fd039f..6532c892c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -488,7 +488,7 @@ static void show_one_mergetag(struct commit *commit,
 	size_t payload_size, gpg_message_offset;
 
 	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), oid.hash);
-	tag = lookup_tag(oid.hash);
+	tag = lookup_tag(&oid);
 	if (!tag)
 		return; /* error message already given */
 
diff --git a/object.c b/object.c
index d23c5fad3..dd4d3a1ea 100644
--- a/object.c
+++ b/object.c
@@ -220,7 +220,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(sha1);
+		struct tag *tag = lookup_tag(&oid);
 		if (tag) {
 			if (parse_tag_buffer(tag, buffer, size))
 			       return NULL;
diff --git a/sha1_name.c b/sha1_name.c
index 390a09c41..b7e09ac13 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -361,7 +361,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid->hash);
+		struct tag *tag = lookup_tag(oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
diff --git a/tag.c b/tag.c
index 062516b40..571798519 100644
--- a/tag.c
+++ b/tag.c
@@ -89,11 +89,11 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag(const unsigned char *sha1)
+struct tag *lookup_tag(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(sha1, alloc_tag_node());
+		return create_object(oid->hash, alloc_tag_node());
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
@@ -148,7 +148,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = &lookup_commit(&oid)->object;
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = &lookup_tag(oid.hash)->object;
+		item->tagged = &lookup_tag(&oid)->object;
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index a5721b673..8d6fc2814 100644
--- a/tag.h
+++ b/tag.h
@@ -12,7 +12,7 @@ struct tag {
 	unsigned long date;
 };
 
-extern struct tag *lookup_tag(const unsigned char *sha1);
+extern struct tag *lookup_tag(const struct object_id *oid);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
