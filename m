Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077321F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936450AbeF2BWr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:47 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:49575 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936446AbeF2BWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:44 -0400
Received: by mail-qk0-f202.google.com with SMTP id z68-v6so7944852qka.16
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=2aYMS1ZG8uGivpujpoHmTVeQGggyey2GJAycwTa5bFo=;
        b=Xq5gWt45oMN7xYOaEfcCdGaWSZrtASlxF1cSYyH4sFNg7Uam9cQ9C/XQm9GzUSZV2U
         Tum+gahvg57WsUxfA7K29c50ICNCrBkxz3cuW4I6Nl0B8hcB4Svk6MJbXIR9KgKD59z+
         BtY8yDp4jYt5GfEpH+ha+IwA2tYUoRJuWAKOiQVOBjouD1S5c87CwBC0tpnHamT9utmC
         XLyWLwScpZ3E3/lZvhO81ckowINFq5ciI6MwecXR5LorI4lkP8u+7ORNKtP/ZBGxMn3c
         /NE0JdSfPHK6ZmVKPgvL8//FsyXGt1bIY72DV4wHRLtEZVe55or5nFgUN8oLfnNg7feO
         yn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=2aYMS1ZG8uGivpujpoHmTVeQGggyey2GJAycwTa5bFo=;
        b=WolEKdDt5vPHqbPyIe6nvaEdn1NbTAnwpTje04KY6hVYQ5ocaYFfTVgj0H1+qtVZ7l
         w/jOm24tAHeQMtc1JbgjpikJZDH7kAOuNzh+gi0OoBd7x8TBWdTp8UX5knBY/PBCqEun
         u20Ekid+Zf7OgZVSpAlSxbwHeaEuHVwm7LIyZd+dFhiWxUsI6J7tP8P59J4CtlKj1bre
         HwdOl1hGLBRhzvkv3RG+TG1myzCR6CW1+QfNB86zpENpg13JO9VlVHTxMkhvHKwWdYa9
         QTX7zlulviOl4hdACT9ohVNV1Lvs95rGB4dCdZVEIymHNfpb9qDnDpPEs4rbLAnns+jP
         0MVQ==
X-Gm-Message-State: APt69E131tQkHaTotffHnBHCRgIvK/aBjSVzkQS5j3aeMG27uYy1zXQa
        IcFcxQ6p2GEfXGlwujMp2bszRtkjdXFkegZwFg2uyvvgEokLJ+KqbN2hBrUNmSw9iXm6a8pkHBV
        FRUbLaUP3VTqLplR7Zw5ayVN0jAIyz8VfQC5W0Vx3ELTLFks4KC1G1o+sm50L
X-Google-Smtp-Source: AAOMgpc+7JzYzsHgXahPj+SZCZ+8gmrYG+7u24Qrd/GfLfVh31WLqhJsGV+jBafWzkT+GX9S/PNE7y9cpKQ3
MIME-Version: 1.0
X-Received: by 2002:a37:ad14:: with SMTP id f20-v6mr6807560qkm.35.1530235363607;
 Thu, 28 Jun 2018 18:22:43 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:55 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-6-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 05/32] blob: add repository argument to lookup_blob
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_blob
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c                   | 2 +-
 blob.h                   | 3 ++-
 builtin/fast-export.c    | 2 +-
 builtin/fsck.c           | 3 ++-
 builtin/index-pack.c     | 2 +-
 builtin/merge-tree.c     | 3 ++-
 builtin/unpack-objects.c | 2 +-
 fsck.c                   | 4 ++--
 http-push.c              | 3 ++-
 list-objects.c           | 2 +-
 object.c                 | 4 ++--
 reachable.c              | 2 +-
 revision.c               | 4 ++--
 tag.c                    | 2 +-
 walker.c                 | 3 ++-
 15 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/blob.c b/blob.c
index dada295698c..17b9314f0a0 100644
--- a/blob.c
+++ b/blob.c
@@ -5,7 +5,7 @@
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob(const struct object_id *oid)
+struct blob *lookup_blob_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
diff --git a/blob.h b/blob.h
index 44606168310..08bc34487a0 100644
--- a/blob.h
+++ b/blob.h
@@ -9,7 +9,8 @@ struct blob {
 	struct object object;
 };
 
-struct blob *lookup_blob(const struct object_id *oid);
+#define lookup_blob(r, o) lookup_blob_##r(o)
+struct blob *lookup_blob_the_repository(const struct object_id *oid);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 03a2e4b79e6..7d6b1d8aea2 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -236,7 +236,7 @@ static void export_blob(const struct object_id *oid)
 
 	if (anonymize) {
 		buf = anonymize_blob(&size);
-		object = (struct object *)lookup_blob(oid);
+		object = (struct object *)lookup_blob(the_repository, oid);
 		eaten = 0;
 	} else {
 		buf = read_object_file(oid, &type, &size);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a906fe4a82b..263191942d4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -810,7 +810,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			mode = active_cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
-			blob = lookup_blob(&active_cache[i]->oid);
+			blob = lookup_blob(the_repository,
+					   &active_cache[i]->oid);
 			if (!blob)
 				continue;
 			obj = &blob->object;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9c08cf3cead..de311febe30 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -832,7 +832,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (strict || do_fsck_object) {
 		read_lock();
 		if (type == OBJ_BLOB) {
-			struct blob *blob = lookup_blob(oid);
+			struct blob *blob = lookup_blob(the_repository, oid);
 			if (blob)
 				blob->object.flags |= FLAG_CHECKED;
 			else
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 8a8d5797520..f8023bae1e2 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "object-store.h"
+#include "repository.h"
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
@@ -170,7 +171,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 	res->stage = stage;
 	res->path = path;
 	res->mode = mode;
-	res->blob = lookup_blob(oid);
+	res->blob = lookup_blob(the_repository, oid);
 	return res;
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 75d1d5ea0b8..716408e3a9d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -254,7 +254,7 @@ static void write_object(unsigned nr, enum object_type type,
 		added_object(nr, type, buf, size);
 		free(buf);
 
-		blob = lookup_blob(&obj_list[nr].oid);
+		blob = lookup_blob(the_repository, &obj_list[nr].oid);
 		if (blob)
 			blob->object.flags |= FLAG_WRITTEN;
 		else
diff --git a/fsck.c b/fsck.c
index bb3d622fb93..ea00f7228df 100644
--- a/fsck.c
+++ b/fsck.c
@@ -414,7 +414,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = (struct object *)lookup_blob(entry.oid);
+			obj = (struct object *)lookup_blob(the_repository, entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s", name,
 					entry.path);
@@ -1070,7 +1070,7 @@ int fsck_finish(struct fsck_options *options)
 		if (oidset_contains(&gitmodules_done, oid))
 			continue;
 
-		blob = lookup_blob(oid);
+		blob = lookup_blob(the_repository, oid);
 		if (!blob) {
 			struct object *obj = lookup_unknown_object(oid->hash);
 			ret |= report(options, obj,
diff --git a/http-push.c b/http-push.c
index d2245cc7380..191b51cb591 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1314,7 +1314,8 @@ static struct object_list **process_tree(struct tree *tree,
 			p = process_tree(lookup_tree(entry.oid), p);
 			break;
 		case OBJ_BLOB:
-			p = process_blob(lookup_blob(entry.oid), p);
+			p = process_blob(lookup_blob(the_repository, entry.oid),
+					 p);
 			break;
 		default:
 			/* Subproject commit - not in this repository */
diff --git a/list-objects.c b/list-objects.c
index 3e5e1992eb0..04c45f66e88 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -167,7 +167,7 @@ static void process_tree(struct rev_info *revs,
 					cb_data);
 		else
 			process_blob(revs,
-				     lookup_blob(entry.oid),
+				     lookup_blob(the_repository, entry.oid),
 				     show, base, entry.path,
 				     cb_data, filter_fn, filter_data);
 	}
diff --git a/object.c b/object.c
index 404919043d4..fde816ad952 100644
--- a/object.c
+++ b/object.c
@@ -193,7 +193,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(oid);
+		struct blob *blob = lookup_blob(the_repository, oid);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
@@ -266,7 +266,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(oid), NULL, 0);
+		parse_blob_buffer(lookup_blob(the_repository, oid), NULL, 0);
 		return lookup_object(the_repository, oid->hash);
 	}
 
diff --git a/reachable.c b/reachable.c
index 2ee55695595..cc25f012e5d 100644
--- a/reachable.c
+++ b/reachable.c
@@ -91,7 +91,7 @@ static void add_recent_object(const struct object_id *oid,
 		obj = (struct object *)lookup_tree(oid);
 		break;
 	case OBJ_BLOB:
-		obj = (struct object *)lookup_blob(oid);
+		obj = (struct object *)lookup_blob(the_repository, oid);
 		break;
 	default:
 		die("unknown object type for %s: %s",
diff --git a/revision.c b/revision.c
index 8a2b2850cad..e3824127567 100644
--- a/revision.c
+++ b/revision.c
@@ -66,7 +66,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 			mark_tree_uninteresting(lookup_tree(entry.oid));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(entry.oid));
+			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
@@ -1348,7 +1348,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		blob = lookup_blob(&ce->oid);
+		blob = lookup_blob(the_repository, &ce->oid);
 		if (!blob)
 			die("unable to add index blob to traversal");
 		add_pending_object_with_path(revs, &blob->object, "",
diff --git a/tag.c b/tag.c
index a14a4f23037..a31ae75e960 100644
--- a/tag.c
+++ b/tag.c
@@ -154,7 +154,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = (struct object *)lookup_blob(&oid);
+		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
 	} else if (!strcmp(type, tree_type)) {
 		item->tagged = (struct object *)lookup_tree(&oid);
 	} else if (!strcmp(type, commit_type)) {
diff --git a/walker.c b/walker.c
index 63002b18875..5b56c72a738 100644
--- a/walker.c
+++ b/walker.c
@@ -54,7 +54,8 @@ static int process_tree(struct walker *walker, struct tree *tree)
 				obj = &tree->object;
 		}
 		else {
-			struct blob *blob = lookup_blob(entry.oid);
+			struct blob *blob = lookup_blob(the_repository,
+							entry.oid);
 			if (blob)
 				obj = &blob->object;
 		}
-- 
2.18.0.399.gad0ab374a1-goog

