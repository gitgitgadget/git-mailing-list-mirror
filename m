Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B911F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642381AbdEACcX (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:23 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35914 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2992764AbdEACaz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 385FC280CF;
        Mon,  1 May 2017 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605812;
        bh=GhZNAp2ddxQi/HvPjdLVR6UMo0CtmoUokxuTQ/JHOdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHNeNZs7gBmyeekV0MvACZGUdoiwanSjwEXsowdA/SVsnaQ3i6C2ClZivX/BDNlcJ
         JpfEKvof3VsdTNEhHS7gjEBYk+5dHIbJoR2UevK++yniLrB2s8OZEEqStdlOJSuMqP
         pX+vAYiMKWqe7ToZyM3bC4Io/OxJvTNT6yoM6LRW4BoLwm29JPesYUKaMYouxlAP+2
         nLSl4l6MvetHhbFNlHsHcRzUUYyvFIX0Cz/W5P6879Ey9pGSdxKsA7mhSlZhdsnyBu
         gcTAweZ46j6PJBoO76pfJqXRSRqkYWcHrgUBOET/Qbmp57R8gYYh4cItup59EhZ70n
         oGaRJ0CJ8btZWvOxbJFHoGkRe6sYGFlTMHaI8CmNzHYeNhLt6xwacJsmY5XLNYwDmK
         05uZpc7G9v3OqfHd6SEW8sCn7osU4gLM/fZiLMq+uKPpc1ft3bPND9vUAK/aeoPK7p
         EywljCgTwCxmJEEuOtAUJAg04pZhKECXatGqqC05Hn4qGyIzkmg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 32/53] Convert lookup_tree to struct object_id
Date:   Mon,  1 May 2017 02:29:25 +0000
Message-Id: <20170501022946.258735-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the lookup_tree function to take a pointer to struct object_id.

The commit was created with manual changes to tree.c, tree.h, and
object.c, plus the following semantic patch:

@@
@@
- lookup_tree(EMPTY_TREE_SHA1_BIN)
+ lookup_tree(&empty_tree_oid)

@@
expression E1;
@@
- lookup_tree(E1.hash)
+ lookup_tree(&E1)

@@
expression E1;
@@
- lookup_tree(E1->hash)
+ lookup_tree(E1)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c        | 4 ++--
 builtin/diff-tree.c | 2 +-
 builtin/diff.c      | 2 +-
 builtin/reflog.c    | 2 +-
 cache-tree.c        | 2 +-
 commit.c            | 2 +-
 fsck.c              | 2 +-
 http-push.c         | 2 +-
 list-objects.c      | 2 +-
 merge-recursive.c   | 6 +++---
 object.c            | 2 +-
 reachable.c         | 2 +-
 revision.c          | 4 ++--
 sequencer.c         | 2 +-
 tag.c               | 2 +-
 tree.c              | 8 ++++----
 tree.h              | 2 +-
 walker.c            | 2 +-
 18 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 650269ac5..7663f12e6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1453,9 +1453,9 @@ static void write_index_patch(const struct am_state *state)
 	FILE *fp;
 
 	if (!get_sha1_tree("HEAD", head.hash))
-		tree = lookup_tree(head.hash);
+		tree = lookup_tree(&head);
 	else
-		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+		tree = lookup_tree(&empty_tree_oid);
 
 	fp = xfopen(am_path(state, "patch"), "w");
 	init_revisions(&rev_info, NULL);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index e85a449df..95b8d1ba7 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -44,7 +44,7 @@ static int stdin_diff_trees(struct tree *tree1, const char *p)
 	struct tree *tree2;
 	if (!isspace(*p++) || parse_oid_hex(p, &oid, &p) || *p)
 		return error("Need exactly two trees, separated by a space");
-	tree2 = lookup_tree(oid.hash);
+	tree2 = lookup_tree(&oid);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
diff --git a/builtin/diff.c b/builtin/diff.c
index a25b4e4ae..895f92897 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -381,7 +381,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+					tree = lookup_tree(&empty_tree_oid);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7866a0341..7e89e84dc 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -62,7 +62,7 @@ static int tree_is_complete(const struct object_id *oid)
 	int complete;
 	struct tree *tree;
 
-	tree = lookup_tree(oid->hash);
+	tree = lookup_tree(oid);
 	if (!tree)
 		return 0;
 	if (tree->object.flags & SEEN)
diff --git a/cache-tree.c b/cache-tree.c
index 35d507ed7..489241021 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -672,7 +672,7 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(entry.oid->hash);
+			struct tree *subtree = lookup_tree(entry.oid);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
diff --git a/commit.c b/commit.c
index 0f6c9b6bf..8004008bc 100644
--- a/commit.c
+++ b/commit.c
@@ -331,7 +331,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree = lookup_tree(parent.hash);
+	item->tree = lookup_tree(&parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/fsck.c b/fsck.c
index ab3016c0e..ee5224aea 100644
--- a/fsck.c
+++ b/fsck.c
@@ -358,7 +358,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = &lookup_tree(entry.oid->hash)->object;
+			obj = &lookup_tree(entry.oid)->object;
 			if (name)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index 9bb5e0648..7781f4078 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1312,7 +1312,7 @@ static struct object_list **process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			p = process_tree(lookup_tree(entry.oid->hash), p);
+			p = process_tree(lookup_tree(entry.oid), p);
 			break;
 		case OBJ_BLOB:
 			p = process_blob(lookup_blob(entry.oid), p);
diff --git a/list-objects.c b/list-objects.c
index 721e5fb08..b3931fa43 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -110,7 +110,7 @@ static void process_tree(struct rev_info *revs,
 
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
-				     lookup_tree(entry.oid->hash),
+				     lookup_tree(entry.oid),
 				     show, base, entry.path,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
diff --git a/merge-recursive.c b/merge-recursive.c
index 1315a45b9..92e0a63dc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -67,7 +67,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	}
 	if (!oidcmp(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(shifted.hash);
+	return lookup_tree(&shifted);
 }
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
@@ -304,7 +304,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(active_cache_tree->oid.hash);
+	result = lookup_tree(&active_cache_tree->oid);
 
 	return result;
 }
@@ -2042,7 +2042,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+		tree = lookup_tree(&empty_tree_oid);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/object.c b/object.c
index 2c8d1e5d3..d23c5fad3 100644
--- a/object.c
+++ b/object.c
@@ -197,7 +197,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(sha1);
+		struct tree *tree = lookup_tree(&oid);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
diff --git a/reachable.c b/reachable.c
index 8ea0bdd7c..3bbc84417 100644
--- a/reachable.c
+++ b/reachable.c
@@ -85,7 +85,7 @@ static void add_recent_object(const struct object_id *oid,
 		obj = parse_object_or_die(oid->hash, NULL);
 		break;
 	case OBJ_TREE:
-		obj = (struct object *)lookup_tree(oid->hash);
+		obj = (struct object *)lookup_tree(oid);
 		break;
 	case OBJ_BLOB:
 		obj = (struct object *)lookup_blob(oid);
diff --git a/revision.c b/revision.c
index db2de7a7a..c2091b6de 100644
--- a/revision.c
+++ b/revision.c
@@ -59,7 +59,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(entry.oid->hash));
+			mark_tree_uninteresting(lookup_tree(entry.oid));
 			break;
 		case OBJ_BLOB:
 			mark_blob_uninteresting(lookup_blob(entry.oid));
@@ -1249,7 +1249,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(it->oid.hash);
+		struct tree *tree = lookup_tree(&it->oid);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
diff --git a/sequencer.c b/sequencer.c
index e98a896d7..fa35e03b6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -344,7 +344,7 @@ static int read_oneliner(struct strbuf *buf,
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree(EMPTY_TREE_SHA1_BIN);
+	return lookup_tree(&empty_tree_oid);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
diff --git a/tag.c b/tag.c
index dff251673..062516b40 100644
--- a/tag.c
+++ b/tag.c
@@ -144,7 +144,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(&oid)->object;
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = &lookup_tree(oid.hash)->object;
+		item->tagged = &lookup_tree(&oid)->object;
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = &lookup_commit(&oid)->object;
 	} else if (!strcmp(type, tag_type)) {
diff --git a/tree.c b/tree.c
index 21fd80b80..28ce930b9 100644
--- a/tree.c
+++ b/tree.c
@@ -110,7 +110,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(lookup_tree(oid.hash),
+		retval = read_tree_1(lookup_tree(&oid),
 				     base, stage, pathspec,
 				     fn, context);
 		strbuf_setlen(base, oldlen);
@@ -184,11 +184,11 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	return 0;
 }
 
-struct tree *lookup_tree(const unsigned char *sha1)
+struct tree *lookup_tree(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(sha1, alloc_tree_node());
+		return create_object(oid->hash, alloc_tree_node());
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
diff --git a/tree.h b/tree.h
index d24786cba..2b2c8dbbe 100644
--- a/tree.h
+++ b/tree.h
@@ -12,7 +12,7 @@ struct tree {
 	unsigned long size;
 };
 
-struct tree *lookup_tree(const unsigned char *sha1);
+struct tree *lookup_tree(const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
diff --git a/walker.c b/walker.c
index 3d6029c8e..eae9fb974 100644
--- a/walker.c
+++ b/walker.c
@@ -47,7 +47,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(entry.oid->hash);
+			struct tree *tree = lookup_tree(entry.oid);
 			if (tree)
 				obj = &tree->object;
 		}
