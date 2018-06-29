Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339EA1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936458AbeF2BWz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:55 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:58569 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936441AbeF2BWq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:46 -0400
Received: by mail-it0-f74.google.com with SMTP id k129-v6so449074itg.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=D9rTpDkhy/vCtqcpBcdHvPiw/XfXsHBQx7BYYpADlbI=;
        b=vCvfcfcwbgUPEZW2Q3twSvIomqjeOBRx4mo21jXKWxIDu92f4KMt+oOe3upI+gKIi1
         Tb+UmjTPRSbYgj2PySCgoGROjs0RlvOzoVGRQCjy/xWxq8L78PS6VbqWlB9mf7gjIJpc
         y92XIzzerT+/1ae0WCPCl4GuKwS/sCNE4BS6x1cBsVCjP3HdAbLLKHMVt3KsfyAEKoxe
         C2TU9C9uzqD5Z1txLeXdbzpt+G8ylERTzshCG0p6Ckg1mINTEz0d/Np+bJcMr3G3nWmT
         fjnzBIioNVM+znTgSbZdC6fwbaesEWcQMJG5Ub2WSiI4yzX+Ku1OgWSzu1CR5165C372
         qmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=D9rTpDkhy/vCtqcpBcdHvPiw/XfXsHBQx7BYYpADlbI=;
        b=rHM7HnS6VVrsgVTihseA67H8HOna8/1d/YR7uNVpMaOhPwQualQU3zL0tiXIFgfj42
         bx9HPVrIPXYAfzoenMJBbPJrD5khLfa962a4xJjb5gyC/g1wLQmWVjBqWh7y9JyLZQC2
         Sn9hwt07FWEqUroLRCacsQaNauGiNEQZ1BQ7YsFWHdS6YIJBL7mWwXD8jktGJYr6nt3F
         zg6T8dsbeK5ZbM/ly6rpBuYuO1zrVudXfydVdAXAY2CDDrKWh4o2nASksCKQbI6R7EJg
         sWpVrvlkxw1H4EFXiXxtHVMpGKCT0Fnm/BowF2COyLohtAF5a+r+J57i4xlRgTksb2mX
         udnQ==
X-Gm-Message-State: APt69E1OT0HecYUpFfZx1T4NLEgwJbcXEr8aGVdSE+0LWmNXk4Blmtbp
        Uz0+GqdD8Yl5tcwuCKxQ4BsgzvALTOjoePUuVltW/2mMrdxOU3JbUflvfQvrYstjakdsH7gpv2v
        XOJD6MGPlgqbgb1tdJo9XXyLbRgjPOKmAtPlp+68CCI07baSmm3tXwR3kmynn
X-Google-Smtp-Source: AAOMgpc2HNV8vN8M3ebhWq7dm1rsNa42m5WTlfrKWT8bdMKBzArccnZUfBc5xw/6g6qkOqWzJh9XqRDURCuC
MIME-Version: 1.0
X-Received: by 2002:a24:228c:: with SMTP id o134-v6mr88926ito.30.1530235366151;
 Thu, 28 Jun 2018 18:22:46 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:56 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-7-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 06/32] tree: add repository argument to lookup_tree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
index 6273ea5195b..72e928cee79 100644
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
index d0421c90e29..7971530b9b3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -386,7 +386,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
index 948002b81ea..5e12c856049 100644
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
index 6b467119960..181d5919f0f 100644
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
index b63a1fc85ea..d1a68f0128f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -344,7 +344,7 @@ static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *
 					   GRAPH_DATA_WIDTH * (c->graph_pos);
 
 	hashcpy(oid.hash, commit_data);
-	c->maybe_tree = lookup_tree(&oid);
+	c->maybe_tree = lookup_tree(the_repository, &oid);
 
 	return c->maybe_tree;
 }
diff --git a/commit.c b/commit.c
index 0d55600e643..2fa4220ac86 100644
--- a/commit.c
+++ b/commit.c
@@ -383,7 +383,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->maybe_tree = lookup_tree(&parent);
+	item->maybe_tree = lookup_tree(the_repository, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/fsck.c b/fsck.c
index ea00f7228df..93459798bcb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -407,7 +407,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = (struct object *)lookup_tree(entry.oid);
+			obj = (struct object *)lookup_tree(the_repository, entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index 191b51cb591..f7b70c4efb1 100644
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
index 04c45f66e88..782c0e189f9 100644
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
index 85694398215..666a3bc22fb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -158,7 +158,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	}
 	if (!oidcmp(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(&shifted);
+	return lookup_tree(the_repository, &shifted);
 }
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
@@ -416,7 +416,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(&active_cache_tree->oid);
+	result = lookup_tree(the_repository, &active_cache_tree->oid);
 
 	return result;
 }
@@ -3427,7 +3427,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(the_hash_algo->empty_tree);
+		tree = lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/object.c b/object.c
index fde816ad952..2acd3a03e39 100644
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
index e3824127567..02e1296e36d 100644
--- a/revision.c
+++ b/revision.c
@@ -63,7 +63,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(entry.oid));
+			mark_tree_uninteresting(lookup_tree(the_repository, entry.oid));
 			break;
 		case OBJ_BLOB:
 			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
@@ -1322,7 +1322,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(&it->oid);
+		struct tree *tree = lookup_tree(the_repository, &it->oid);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
diff --git a/sequencer.c b/sequencer.c
index 0a291c91fe8..4cf7afbab6d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -433,7 +433,7 @@ static int read_oneliner(struct strbuf *buf,
 
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
index f31afb81be0..12b69606ab0 100644
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
index 5b56c72a738..a3a25667611 100644
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
2.18.0.399.gad0ab374a1-goog

