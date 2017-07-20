Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880BE20288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbdGTAV5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:21:57 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37305 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdGTAVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:21:54 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so6854641pgy.4
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XUMXVugD6xgqxjOYUHQQpYmzNgfZJs9kHmwS/6etwFg=;
        b=O4E7v3cotIqWjXox8H2BneBOk1HGYm4nlp7St/3T0i594hzF+unl4xJczhW9SQckHc
         RMWtgAMq5hfcV6ZPGAai5h9i7oZlynV/FQ5Kz0amAWgXbabogfJmlK4T0F+Z/05mR+v0
         l9qxBKvpPAOzzor7yGTF2MepCJqFSXcNS8e1pFyBnrZpxKAU5DGRVm/OHm5eI7y3TORl
         T/xLK9G09h0ks8JBCEmQuKEgjgGw4jQm3qylWJfoJnuWs59Aqb1R2xuc5pKbxW6D7P4X
         lqSZ1ZkoFZsOTSZT5WPCL81c7nn6B9RcybKG6Pw6f4NI+B3XD7ERxrhEe0+CAqJcFtsj
         SnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XUMXVugD6xgqxjOYUHQQpYmzNgfZJs9kHmwS/6etwFg=;
        b=oJYNhDoWavQJIVzTiIpnb83kEyXPgo0Ncp5TSawuOU7jbX/Q8nyMOj64wi2uRVYrSZ
         XbOMdjzmOm1eXGo0ATtzjCr/2Rttp4ITPCPb0GN3yrQgkEZzLcP0+JnVn1l/2x6WRS05
         TAH/Nbws57OkXDtdfK2Cvyh+pGMsQHq/6RwRwcveKPVZKsMAU5WIlNH/3zeIriCu9ve+
         OSQinyxe5k1cOoQpuhldGHo90GsHELSqtfjFdWM3y4QRnkf8ZnR2I6XVygMjX2um+KDi
         yVdGUuNqH2gLkd/pUf8O+gfzjJSuy54PKt5rxglbMBU9eZeyIc3e2TYmwhvuPcah9LlH
         AtCg==
X-Gm-Message-State: AIVw110LUXRfYhMePLVEMwFsRCnMHRhDInmW59F6ZwjxDPzadDw87ZUN
        Fg2js03jznfoAiWzLgD8ew==
X-Received: by 10.99.105.70 with SMTP id e67mr1891000pgc.77.1500510113447;
        Wed, 19 Jul 2017 17:21:53 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id n129sm1285891pfn.27.2017.07.19.17.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 17:21:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, git@jeffhostetler.com, peartben@gmail.com,
        philipoakley@iee.org
Subject: [RFC PATCH v2 1/4] object: remove "used" field from struct object
Date:   Wed, 19 Jul 2017 17:21:44 -0700
Message-Id: <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.284.gd933b75aa4-goog
In-Reply-To: <cover.1500508695.git.jonathantanmy@google.com>
References: <cover.1500508695.git.jonathantanmy@google.com>
In-Reply-To: <cover.1500508695.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <cover.1500508695.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "used" field in struct object is only used by builtin/fsck. Remove
that field and modify builtin/fsck to use a flag instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c | 24 ++++++++++++++----------
 object.c       |  1 -
 object.h       |  2 +-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4ba311cda..462b8643b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,8 @@
 #define REACHABLE 0x0001
 #define SEEN      0x0002
 #define HAS_OBJ   0x0004
+/* This flag is set if something points to this object. */
+#define USED      0x0008
 
 static int show_root;
 static int show_tags;
@@ -195,7 +197,7 @@ static int mark_used(struct object *obj, int type, void *data, struct fsck_optio
 {
 	if (!obj)
 		return 1;
-	obj->used = 1;
+	obj->flags |= USED;
 	return 0;
 }
 
@@ -244,7 +246,7 @@ static void check_unreachable_object(struct object *obj)
 	}
 
 	/*
-	 * "!used" means that nothing at all points to it, including
+	 * "!USED" means that nothing at all points to it, including
 	 * other unreachable objects. In other words, it's the "tip"
 	 * of some set of unreachable objects, usually a commit that
 	 * got dropped.
@@ -255,7 +257,7 @@ static void check_unreachable_object(struct object *obj)
 	 * deleted a branch by mistake, this is a prime candidate to
 	 * start looking at, for example.
 	 */
-	if (!obj->used) {
+	if (!(obj->flags & USED)) {
 		if (show_dangling)
 			printf("dangling %s %s\n", printable_type(obj),
 			       describe_object(obj));
@@ -379,7 +381,8 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 		errors_found |= ERROR_OBJECT;
 		return error("%s: object corrupt or missing", oid_to_hex(oid));
 	}
-	obj->flags = HAS_OBJ;
+	obj->flags &= ~(REACHABLE | SEEN);
+	obj->flags |= HAS_OBJ;
 	return fsck_obj(obj);
 }
 
@@ -397,7 +400,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 				add_decoration(fsck_walk_options.object_names,
 					obj,
 					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
-			obj->used = 1;
+			obj->flags |= USED;
 			mark_object_reachable(obj);
 		} else {
 			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
@@ -445,7 +448,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 		errors_found |= ERROR_REFS;
 	}
 	default_refs++;
-	obj->used = 1;
+	obj->flags |= USED;
 	if (name_objects)
 		add_decoration(fsck_walk_options.object_names,
 			obj, xstrdup(refname));
@@ -513,7 +516,8 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 		return 0; /* keep checking other objects */
 	}
 
-	obj->flags = HAS_OBJ;
+	obj->flags &= ~(REACHABLE | SEEN);
+	obj->flags |= HAS_OBJ;
 	if (fsck_obj(obj))
 		errors_found |= ERROR_OBJECT;
 	return 0;
@@ -595,7 +599,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 			errors_found |= ERROR_REFS;
 			return 1;
 		}
-		obj->used = 1;
+		obj->flags |= USED;
 		if (name_objects)
 			add_decoration(fsck_walk_options.object_names,
 				obj, xstrdup(":"));
@@ -737,7 +741,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 
-			obj->used = 1;
+			obj->flags |= USED;
 			if (name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj, xstrdup(arg));
@@ -774,7 +778,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			if (!blob)
 				continue;
 			obj = &blob->object;
-			obj->used = 1;
+			obj->flags |= USED;
 			if (name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj,
diff --git a/object.c b/object.c
index f81877741..321d7e920 100644
--- a/object.c
+++ b/object.c
@@ -141,7 +141,6 @@ void *create_object(const unsigned char *sha1, void *o)
 	struct object *obj = o;
 
 	obj->parsed = 0;
-	obj->used = 0;
 	obj->flags = 0;
 	hashcpy(obj->oid.hash, sha1);
 
diff --git a/object.h b/object.h
index 33e5cc994..0a419ba8d 100644
--- a/object.h
+++ b/object.h
@@ -38,6 +38,7 @@ struct object_array {
  * http-push.c:                            16-----19
  * commit.c:                               16-----19
  * sha1_name.c:                                     20
+ * builtin/fsck.c:  0--3
  */
 #define FLAG_BITS  27
 
@@ -46,7 +47,6 @@ struct object_array {
  */
 struct object {
 	unsigned parsed : 1;
-	unsigned used : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
 	struct object_id oid;
-- 
2.14.0.rc0.284.gd933b75aa4-goog

