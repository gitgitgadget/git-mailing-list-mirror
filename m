Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0C11F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968550AbeE3As4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:48:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36763 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968089AbeE3Asc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so2953073pgd.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0r/UxLC3PkrMf2DnOM8Y62McycFTN1y9K8GE2XjNveI=;
        b=hf9tqTLqSCsZlWDvYm2VC/G8Q6rtPVOTSPcwGQ04mJBDmBJ0Mq+OLGXb/h1vgJXLGU
         TCDO+juy8k62cVoF8Awa2YNk4+DggNlRxzbNPTgtjHeWSchEBxh1RafcEfNiGcmMPOhU
         FNQ8m8iog7Qu55jMbA/sjHVaUpedwOrkYdmroIaAmf2dkDwdzus39zaMe1Zx6K/TRo6h
         sQ5AlOozvNN5eHYHr9IThYWnncJCVoZ3WL9YHfV5ya7WMz3YVOr4apOagBX+u74tqWCB
         NvLkkiGnBua7oFjEtBF1Z88IX+KrvvYcaFX328dWztAWXMhpAOZvBQZbiFjAIfdZzr3u
         +OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0r/UxLC3PkrMf2DnOM8Y62McycFTN1y9K8GE2XjNveI=;
        b=PM1yPX3BiBQtmKFZbrOR+iQHAjEOcRuDkwU+mSYXu/y0rBTD+bPALvjdKlX+aXMRaq
         ZuodTKYpB0nuXWSSzBEuh2oUw8ls+Zxgzkr3FmgzIMLfWky+gpKyC7OHidcyfiCZCn7g
         O81nVm5N6vwYeqVpTgcjdPAkk/8p8WmbM6dRK+UddUR6n+SAaJSDQO8tenmCmUatFplJ
         L5K36abPrbh9NbEp8CUKx9xWO5Q+ZL9mRSfsUWrsdFjLoo2tLxQHa0/8885BrikC99aK
         nDIWnkQWizNyMPicntjlyX79e5K+lU7dTO5SNIjUYQJY35hXxglCBGALFS39nrCPYeVc
         mg1A==
X-Gm-Message-State: ALKqPweA6gRP0m1I9C5SBVNQtj62mtuYo6RotKpmqH1kThsbczzNdtKO
        UkWn7WoVXb6rU+ozIiNt5HOzW6hffGc=
X-Google-Smtp-Source: ADUXVKIQjk7OcAG9gtCaXfVADvT+8IVGC4FGxyIH1WKBcEewZMYBe2EyV0PT0YOUQl83FQA+0VVy8g==
X-Received: by 2002:a63:a807:: with SMTP id o7-v6mr465297pgf.83.1527641310851;
        Tue, 29 May 2018 17:48:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a9-v6sm12650838pgt.57.2018.05.29.17.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/35] tree: add repository argument to lookup_tree
Date:   Tue, 29 May 2018 17:47:42 -0700
Message-Id: <20180530004810.30076-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_tree
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c        | 6 ++++--
 builtin/diff-tree.c | 2 +-
 builtin/diff.c      | 3 ++-
 builtin/reflog.c    | 2 +-
 cache-tree.c        | 3 ++-
 commit-graph.c      | 2 +-
 commit.c            | 2 +-
 fsck.c              | 2 +-
 http-push.c         | 3 ++-
 list-objects.c      | 2 +-
 merge-recursive.c   | 6 +++---
 object.c            | 2 +-
 reachable.c         | 2 +-
 revision.c          | 4 ++--
 sequencer.c         | 2 +-
 tag.c               | 2 +-
 tree.c              | 4 ++--
 tree.h              | 3 ++-
 walker.c            | 3 ++-
 19 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d834f9e62b6..f4b510bcc5f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -32,6 +32,7 @@
 #include "apply.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "repository.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1400,9 +1401,10 @@ static void write_index_patch(const struct am_state *state)
 	FILE *fp;
 
 	if (!get_oid_tree("HEAD", &head))
-		tree = lookup_tree(&head);
+		tree = lookup_tree(the_repository, &head);
 	else
-		tree = lookup_tree(the_hash_algo->empty_tree);
+		tree = lookup_tree(the_repository,
+				   the_repository->hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
 	init_revisions(&rev_info, NULL);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index d8db8f682f0..29901515a13 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -46,7 +46,7 @@ static int stdin_diff_trees(struct tree *tree1, const char *p)
 	struct tree *tree2;
 	if (!isspace(*p++) || parse_oid_hex(p, &oid, &p) || *p)
 		return error("Need exactly two trees, separated by a space");
-	tree2 = lookup_tree(&oid);
+	tree2 = lookup_tree(the_repository, &oid);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
diff --git a/builtin/diff.c b/builtin/diff.c
index ed6092ef1a3..0b7d0d612dd 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -379,7 +379,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree(the_hash_algo->empty_tree);
+					tree = lookup_tree(the_repository,
+							   the_repository->hash_algo->empty_tree);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3a751fbaa60..93dabd7ce31 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -66,7 +66,7 @@ static int tree_is_complete(const struct object_id *oid)
 	int complete;
 	struct tree *tree;
 
-	tree = lookup_tree(oid);
+	tree = lookup_tree(the_repository, oid);
 	if (!tree)
 		return 0;
 	if (tree->object.flags & SEEN)
diff --git a/cache-tree.c b/cache-tree.c
index 1c338c41f3a..69b214613dd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -671,7 +671,8 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(entry.oid);
+			struct tree *subtree = lookup_tree(the_repository,
+							   entry.oid);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
diff --git a/commit-graph.c b/commit-graph.c
index 71125d7cbb6..88a4b0d2a47 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -261,7 +261,7 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	item->graph_pos = pos;
 
 	hashcpy(oid.hash, commit_data);
-	item->tree = lookup_tree(&oid);
+	item->tree = lookup_tree(the_repository, &oid);
 
 	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low = get_be32(commit_data + g->hash_len + 12);
diff --git a/commit.c b/commit.c
index d76d64d4dfc..755b8b9d94f 100644
--- a/commit.c
+++ b/commit.c
@@ -354,7 +354,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree = lookup_tree(&parent);
+	item->tree = lookup_tree(the_repository, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/fsck.c b/fsck.c
index 2d372f2a3f3..b07abb9796c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -360,7 +360,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = (struct object *)lookup_tree(entry.oid);
+			obj = (struct object *)lookup_tree(the_repository, entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index 730e9cd0667..f27026daf8f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1311,7 +1311,8 @@ static struct object_list **process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			p = process_tree(lookup_tree(entry.oid), p);
+			p = process_tree(lookup_tree(the_repository, entry.oid),
+					 p);
 			break;
 		case OBJ_BLOB:
 			p = process_blob(lookup_blob(the_repository, entry.oid),
diff --git a/list-objects.c b/list-objects.c
index 56682c2a441..b9159c24671 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -158,7 +158,7 @@ static void process_tree(struct rev_info *revs,
 
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
-				     lookup_tree(entry.oid),
+				     lookup_tree(the_repository, entry.oid),
 				     show, base, entry.path,
 				     cb_data, filter_fn, filter_data);
 		else if (S_ISGITLINK(entry.mode))
diff --git a/merge-recursive.c b/merge-recursive.c
index 8ddedf79c0b..1b06f25b38c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -96,7 +96,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	}
 	if (!oidcmp(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(&shifted);
+	return lookup_tree(the_repository, &shifted);
 }
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
@@ -335,7 +335,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(&active_cache_tree->oid);
+	result = lookup_tree(the_repository, &active_cache_tree->oid);
 
 	return result;
 }
@@ -2123,7 +2123,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(the_hash_algo->empty_tree);
+		tree = lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/object.c b/object.c
index 80a8e44832f..3fa7722d673 100644
--- a/object.c
+++ b/object.c
@@ -200,7 +200,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(oid);
+		struct tree *tree = lookup_tree(the_repository, oid);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
diff --git a/reachable.c b/reachable.c
index cc25f012e5d..6e9b810d2a5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -88,7 +88,7 @@ static void add_recent_object(const struct object_id *oid,
 		obj = parse_object_or_die(oid, NULL);
 		break;
 	case OBJ_TREE:
-		obj = (struct object *)lookup_tree(oid);
+		obj = (struct object *)lookup_tree(the_repository, oid);
 		break;
 	case OBJ_BLOB:
 		obj = (struct object *)lookup_blob(the_repository, oid);
diff --git a/revision.c b/revision.c
index aeccbf5fe24..79f228b1586 100644
--- a/revision.c
+++ b/revision.c
@@ -66,7 +66,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(entry.oid));
+			mark_tree_uninteresting(lookup_tree(the_repository, entry.oid));
 			break;
 		case OBJ_BLOB:
 			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
@@ -1312,7 +1312,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(&it->oid);
+		struct tree *tree = lookup_tree(the_repository, &it->oid);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
diff --git a/sequencer.c b/sequencer.c
index d715c877501..bf5620dff0c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -397,7 +397,7 @@ static int read_oneliner(struct strbuf *buf,
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree(the_hash_algo->empty_tree);
+	return lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
diff --git a/tag.c b/tag.c
index a31ae75e960..310102150ab 100644
--- a/tag.c
+++ b/tag.c
@@ -156,7 +156,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	if (!strcmp(type, blob_type)) {
 		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = (struct object *)lookup_tree(&oid);
+		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = (struct object *)lookup_commit(&oid);
 	} else if (!strcmp(type, tag_type)) {
diff --git a/tree.c b/tree.c
index bd74ed66e23..fbc8d4bc653 100644
--- a/tree.c
+++ b/tree.c
@@ -120,7 +120,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(lookup_tree(&oid),
+		retval = read_tree_1(lookup_tree(the_repository, &oid),
 				     base, stage, pathspec,
 				     fn, context);
 		strbuf_setlen(base, oldlen);
@@ -195,7 +195,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
 	return 0;
 }
 
-struct tree *lookup_tree(const struct object_id *oid)
+struct tree *lookup_tree_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
diff --git a/tree.h b/tree.h
index e2a80be4ef8..2ea21ed174b 100644
--- a/tree.h
+++ b/tree.h
@@ -12,7 +12,8 @@ struct tree {
 	unsigned long size;
 };
 
-struct tree *lookup_tree(const struct object_id *oid);
+#define lookup_tree(r, oid) lookup_tree_##r(oid)
+struct tree *lookup_tree_the_repository(const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
diff --git a/walker.c b/walker.c
index a36f53f37be..288006d52d5 100644
--- a/walker.c
+++ b/walker.c
@@ -49,7 +49,8 @@ static int process_tree(struct walker *walker, struct tree *tree)
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(entry.oid);
+			struct tree *tree = lookup_tree(the_repository,
+							entry.oid);
 			if (tree)
 				obj = &tree->object;
 		}
-- 
2.17.0.582.gccdcbd54c44.dirty

