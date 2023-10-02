Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2768AE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjJBClx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjJBCl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096ACC8
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79f9acc857cso518798439f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214460; x=1696819260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctOzb5UNmN2By2/XBixPoWkARfwfWfm6uJO9oRBQccg=;
        b=VmdsiGArT01LgkjHeahwuSgw9qK7PwfrCT4+uScyba02itzpGEsVVKFDmKN+791YUa
         Oe6+mBpoXwE7JuzkrbV9MRhgRPuJTfxdqkNRxayRn5BC32bSDg3q8gmZckpAEXplYAHB
         tvWdJEtpHnkfOzQApcR6o4RJmW1CL7zidCys+1RWnnMn2vrZFYh1xeogFL1BiOm3Tn4g
         O75lmqSS6kCZ4lPoCiy3xE/kxeM45Ui73yszMJ4gjsNHNKuZ8LpdvGnZoWZ7MdCe6pfp
         S3gOYHu6hK8lRjS5HyfAtm3zWQi/KBd1RvX8A5VtCuyRyr53wXG0sLtZt4zcuOYth2Sk
         SB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214460; x=1696819260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctOzb5UNmN2By2/XBixPoWkARfwfWfm6uJO9oRBQccg=;
        b=GWf53ayAmyYHsg5d6Kk4OaIn5fODy2Begl2Bqm1IZ8eQRL9w+bRzu5jwltayu2Dehb
         /iwEq5V+TSlmsr5qSkm2Ow1qhLgpQF1IGTNEf0wV4zFpWL92I50seIvv35SzQ52hBnh8
         aYy1OdGTvv0j1vqv4yXA4Ra2lHd7JJX8eZOiqPYadWBqKgsl18JwW8hfBGivO0sfQuzt
         IGnOKrqRixx4vsNSvE3IbXUXSin/UCUg4LE6e3ANRrR6K8OxZ8PApmObqPiTLeen1Ds6
         ervSg/7mwzIC8cocVPmcXwZ0eur+8NIQHEoTZR4VFSlJcTn0epU8GH3AN5NeHW995aV8
         GTVA==
X-Gm-Message-State: AOJu0YyBsrzpQl9+H/pr9YqHExJ+yBbM+SFlojy4yr3EuHjkFmC+WY1B
        82W7lkiRKz9fCJcKI9EWq3ggPo1v+WGcKA==
X-Google-Smtp-Source: AGHT+IHkMKLg02G14omqTx0bmSq7zioM0mk2Xp2n2OaBDS4qXe5zXnBLcjYAg4Dxt91aGQypWOGIeg==
X-Received: by 2002:a6b:7f42:0:b0:795:16b8:8601 with SMTP id m2-20020a6b7f42000000b0079516b88601mr10674845ioq.0.1696214460204;
        Sun, 01 Oct 2023 19:41:00 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:59 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 24/30] tree-walk: init_tree_desc take an oid to get the hash algorithm
Date:   Sun,  1 Oct 2023 21:40:28 -0500
Message-Id: <20231002024034.2611-24-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

To make it possible for git ls-tree to display the tree encoded
in the hash algorithm of the oid specified to git ls-tree, update
init_tree_desc to take as a parameter the oid of the tree object.

Update all callers of init_tree_desc and init_tree_desc_gently
to pass the oid of the tree object.

Use the oid of the tree object to discover the hash algorithm
of the oid and store that hash algorithm in struct tree_desc.

Use the hash algorithm in decode_tree_entry and
update_tree_entry_internal to handle reading a tree object encoded in
a hash algorithm that differs from the repositories hash algorithm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 archive.c              |  3 ++-
 builtin/am.c           |  6 +++---
 builtin/checkout.c     |  8 +++++---
 builtin/clone.c        |  2 +-
 builtin/commit.c       |  2 +-
 builtin/grep.c         |  8 ++++----
 builtin/merge.c        |  3 ++-
 builtin/pack-objects.c |  6 ++++--
 builtin/read-tree.c    |  2 +-
 builtin/stash.c        |  5 +++--
 cache-tree.c           |  2 +-
 delta-islands.c        |  2 +-
 diff-lib.c             |  2 +-
 fsck.c                 |  6 ++++--
 http-push.c            |  2 +-
 list-objects.c         |  2 +-
 match-trees.c          |  4 ++--
 merge-ort.c            | 11 ++++++-----
 merge-recursive.c      |  2 +-
 merge.c                |  3 ++-
 pack-bitmap-write.c    |  2 +-
 packfile.c             |  3 ++-
 reflog.c               |  2 +-
 revision.c             |  4 ++--
 tree-walk.c            | 36 +++++++++++++++++++++---------------
 tree-walk.h            |  7 +++++--
 tree.c                 |  2 +-
 walker.c               |  2 +-
 28 files changed, 80 insertions(+), 59 deletions(-)

diff --git a/archive.c b/archive.c
index ca11db185b15..b10269aee7be 100644
--- a/archive.c
+++ b/archive.c
@@ -339,7 +339,8 @@ int write_archive_entries(struct archiver_args *args,
 		opts.src_index = args->repo->index;
 		opts.dst_index = args->repo->index;
 		opts.fn = oneway_merge;
-		init_tree_desc(&t, args->tree->buffer, args->tree->size);
+		init_tree_desc(&t, &args->tree->object.oid,
+			       args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
 			return -1;
 		git_attr_set_direction(GIT_ATTR_INDEX);
diff --git a/builtin/am.c b/builtin/am.c
index 8bde034fae68..4dfd714b910e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1991,8 +1991,8 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = twoway_merge;
-	init_tree_desc(&t[0], head->buffer, head->size);
-	init_tree_desc(&t[1], remote->buffer, remote->size);
+	init_tree_desc(&t[0], &head->object.oid, head->buffer, head->size);
+	init_tree_desc(&t[1], &remote->object.oid, remote->buffer, remote->size);
 
 	if (unpack_trees(2, t, &opts)) {
 		rollback_lock_file(&lock_file);
@@ -2026,7 +2026,7 @@ static int merge_tree(struct tree *tree)
 	opts.dst_index = &the_index;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	init_tree_desc(&t[0], tree->buffer, tree->size);
+	init_tree_desc(&t[0], &tree->object.oid, tree->buffer, tree->size);
 
 	if (unpack_trees(1, t, &opts)) {
 		rollback_lock_file(&lock_file);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f53612f46870..03eff73fd031 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -701,7 +701,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 			       info->commit ? &info->commit->object.oid : null_oid(),
 			       NULL);
 	parse_tree(tree);
-	init_tree_desc(&tree_desc, tree->buffer, tree->size);
+	init_tree_desc(&tree_desc, &tree->object.oid, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
 	case -2:
 		*writeout_error = 1;
@@ -815,10 +815,12 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(old_commit_oid));
 
-		init_tree_desc(&trees[0], tree->buffer, tree->size);
+		init_tree_desc(&trees[0], &tree->object.oid,
+			       tree->buffer, tree->size);
 		parse_tree(new_tree);
 		tree = new_tree;
-		init_tree_desc(&trees[1], tree->buffer, tree->size);
+		init_tree_desc(&trees[1], &tree->object.oid,
+			       tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
 		clear_unpack_trees_porcelain(&topts);
diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af94989..79ceefb93995 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -737,7 +737,7 @@ static int checkout(int submodule_progress, int filter_submodules)
 	if (!tree)
 		die(_("unable to parse commit %s"), oid_to_hex(&oid));
 	parse_tree(tree);
-	init_tree_desc(&t, tree->buffer, tree->size);
+	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 7da5f924484d..537319932b65 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -340,7 +340,7 @@ static void create_base_index(const struct commit *current_head)
 	if (!tree)
 		die(_("failed to unpack HEAD tree object"));
 	parse_tree(tree);
-	init_tree_desc(&t, tree->buffer, tree->size);
+	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
 		exit(128); /* We've already reported the error, finish dying */
 }
diff --git a/builtin/grep.c b/builtin/grep.c
index 50e712a18479..0c2b8a376f8e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -530,7 +530,7 @@ static int grep_submodule(struct grep_opt *opt,
 		strbuf_addstr(&base, filename);
 		strbuf_addch(&base, '/');
 
-		init_tree_desc(&tree, data, size);
+		init_tree_desc(&tree, oid, data, size);
 		hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
 				object_type == OBJ_COMMIT);
 		strbuf_release(&base);
@@ -574,7 +574,7 @@ static int grep_cache(struct grep_opt *opt,
 
 			data = repo_read_object_file(the_repository, &ce->oid,
 						     &type, &size);
-			init_tree_desc(&tree, data, size);
+			init_tree_desc(&tree, &ce->oid, data, size);
 
 			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
 			strbuf_setlen(&name, name_base_len);
@@ -670,7 +670,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 				    oid_to_hex(&entry.oid));
 
 			strbuf_addch(base, '/');
-			init_tree_desc(&sub, data, size);
+			init_tree_desc(&sub, &entry.oid, data, size);
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
 					 check_attr);
 			free(data);
@@ -714,7 +714,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 			strbuf_add(&base, name, len);
 			strbuf_addch(&base, ':');
 		}
-		init_tree_desc(&tree, data, size);
+		init_tree_desc(&tree, &obj->oid, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
 				obj->type == OBJ_COMMIT);
 		strbuf_release(&base);
diff --git a/builtin/merge.c b/builtin/merge.c
index de68910177fb..718165d45917 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -704,7 +704,8 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	cache_tree_free(&the_index.cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
-		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+		init_tree_desc(t+i, &trees[i]->object.oid,
+			       trees[i]->buffer, trees[i]->size);
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d2a162d52804..d34902002656 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1756,7 +1756,8 @@ static void add_pbase_object(struct tree_desc *tree,
 			tree = pbase_tree_get(&entry.oid);
 			if (!tree)
 				return;
-			init_tree_desc(&sub, tree->tree_data, tree->tree_size);
+			init_tree_desc(&sub, &tree->oid,
+				       tree->tree_data, tree->tree_size);
 
 			add_pbase_object(&sub, down, downlen, fullname);
 			pbase_tree_put(tree);
@@ -1816,7 +1817,8 @@ static void add_preferred_base_object(const char *name)
 		}
 		else {
 			struct tree_desc tree;
-			init_tree_desc(&tree, it->pcache.tree_data, it->pcache.tree_size);
+			init_tree_desc(&tree, &it->pcache.oid,
+				       it->pcache.tree_data, it->pcache.tree_size);
 			add_pbase_object(&tree, name, cmplen, name);
 		}
 	}
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 1fec702a04fa..24d6d156d3a2 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -264,7 +264,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
-		init_tree_desc(t+i, tree->buffer, tree->size);
+		init_tree_desc(t+i, &tree->object.oid, tree->buffer, tree->size);
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;
diff --git a/builtin/stash.c b/builtin/stash.c
index fe64cde9ce30..9ee52af4d28e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -285,7 +285,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	if (parse_tree(tree))
 		return -1;
 
-	init_tree_desc(t, tree->buffer, tree->size);
+	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
 
 	opts.head_idx = 1;
 	opts.src_index = &the_index;
@@ -871,7 +871,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 		tree[i] = parse_tree_indirect(oid[i]);
 		if (parse_tree(tree[i]) < 0)
 			die(_("failed to parse tree"));
-		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
+		init_tree_desc(&tree_desc[i], &tree[i]->object.oid,
+			       tree[i]->buffer, tree[i]->size);
 	}
 
 	unpack_tree_opt.head_idx = -1;
diff --git a/cache-tree.c b/cache-tree.c
index ddc7d3d86959..334973a01cee 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -770,7 +770,7 @@ static void prime_cache_tree_rec(struct repository *r,
 
 	oidcpy(&it->oid, &tree->object.oid);
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
 		if (!S_ISDIR(entry.mode))
diff --git a/delta-islands.c b/delta-islands.c
index 5de5759f3f13..1ff3506b10f2 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -289,7 +289,7 @@ void resolve_tree_islands(struct repository *r,
 		if (!tree || parse_tree(tree) < 0)
 			die(_("bad tree object %s"), oid_to_hex(&ent->idx.oid));
 
-		init_tree_desc(&desc, tree->buffer, tree->size);
+		init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 		while (tree_entry(&desc, &entry)) {
 			struct object *obj;
 
diff --git a/diff-lib.c b/diff-lib.c
index 6b0c6a7180cc..add323f5628d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -558,7 +558,7 @@ static int diff_cache(struct rev_info *revs,
 	opts.pathspec = &revs->diffopt.pathspec;
 	opts.pathspec->recursive = 1;
 
-	init_tree_desc(&t, tree->buffer, tree->size);
+	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
 }
 
diff --git a/fsck.c b/fsck.c
index 2b1e348005b7..6b492a48da82 100644
--- a/fsck.c
+++ b/fsck.c
@@ -313,7 +313,8 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		return -1;
 
 	name = fsck_get_object_name(options, &tree->object.oid);
-	if (init_tree_desc_gently(&desc, tree->buffer, tree->size, 0))
+	if (init_tree_desc_gently(&desc, &tree->object.oid,
+				  tree->buffer, tree->size, 0))
 		return -1;
 	while (tree_entry_gently(&desc, &entry)) {
 		struct object *obj;
@@ -583,7 +584,8 @@ static int fsck_tree(const struct object_id *tree_oid,
 	const char *o_name;
 	struct name_stack df_dup_candidates = { NULL };
 
-	if (init_tree_desc_gently(&desc, buffer, size, TREE_DESC_RAW_MODES)) {
+	if (init_tree_desc_gently(&desc, tree_oid, buffer, size,
+				  TREE_DESC_RAW_MODES)) {
 		retval += report(options, tree_oid, OBJ_TREE,
 				 FSCK_MSG_BAD_TREE,
 				 "cannot be parsed as a tree");
diff --git a/http-push.c b/http-push.c
index a704f490fdb2..81c35b5e96f7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1308,7 +1308,7 @@ static struct object_list **process_tree(struct tree *tree,
 	obj->flags |= SEEN;
 	p = add_one_object(obj, p);
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
diff --git a/list-objects.c b/list-objects.c
index e60a6cd5b46e..312335c8a7f2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -97,7 +97,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 	enum interesting match = ctx->revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting : entry_not_interesting;
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		if (match != all_entries_interesting) {
diff --git a/match-trees.c b/match-trees.c
index 0885ac681cd5..3412b6a1401d 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -63,7 +63,7 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
 		die("%s is not a tree", oid_to_hex(hash));
-	init_tree_desc(desc, buffer, size);
+	init_tree_desc(desc, hash, buffer, size);
 	return buffer;
 }
 
@@ -194,7 +194,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	buf = repo_read_object_file(the_repository, oid1, &type, &sz);
 	if (!buf)
 		die("cannot read tree %s", oid_to_hex(oid1));
-	init_tree_desc(&desc, buf, sz);
+	init_tree_desc(&desc, oid1, buf, sz);
 
 	rewrite_here = NULL;
 	while (desc.size) {
diff --git a/merge-ort.c b/merge-ort.c
index 8631c997002d..3a5729c91e48 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1679,9 +1679,10 @@ static int collect_merge_info(struct merge_options *opt,
 	parse_tree(merge_base);
 	parse_tree(side1);
 	parse_tree(side2);
-	init_tree_desc(t + 0, merge_base->buffer, merge_base->size);
-	init_tree_desc(t + 1, side1->buffer, side1->size);
-	init_tree_desc(t + 2, side2->buffer, side2->size);
+	init_tree_desc(t + 0, &merge_base->object.oid,
+		       merge_base->buffer, merge_base->size);
+	init_tree_desc(t + 1, &side1->object.oid, side1->buffer, side1->size);
+	init_tree_desc(t + 2, &side2->object.oid, side2->buffer, side2->size);
 
 	trace2_region_enter("merge", "traverse_trees", opt->repo);
 	ret = traverse_trees(NULL, 3, t, &info);
@@ -4400,9 +4401,9 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.fn = twoway_merge;
 	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
 	parse_tree(prev);
-	init_tree_desc(&trees[0], prev->buffer, prev->size);
+	init_tree_desc(&trees[0], &prev->object.oid, prev->buffer, prev->size);
 	parse_tree(next);
-	init_tree_desc(&trees[1], next->buffer, next->size);
+	init_tree_desc(&trees[1], &next->object.oid, next->buffer, next->size);
 
 	ret = unpack_trees(2, trees, &unpack_opts);
 	clear_unpack_trees_porcelain(&unpack_opts);
diff --git a/merge-recursive.c b/merge-recursive.c
index 6a4081bb0f52..93df9eecdd95 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -411,7 +411,7 @@ static inline int merge_detect_rename(struct merge_options *opt)
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 {
 	parse_tree(tree);
-	init_tree_desc(desc, tree->buffer, tree->size);
+	init_tree_desc(desc, &tree->object.oid, tree->buffer, tree->size);
 }
 
 static int unpack_trees_start(struct merge_options *opt,
diff --git a/merge.c b/merge.c
index b60925459c29..86179c34102d 100644
--- a/merge.c
+++ b/merge.c
@@ -81,7 +81,8 @@ int checkout_fast_forward(struct repository *r,
 	}
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
-		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+		init_tree_desc(t+i, &trees[i]->object.oid,
+			       trees[i]->buffer, trees[i]->size);
 	}
 
 	memset(&opts, 0, sizeof(opts));
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f6757c3cbf20..9211e08f0127 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -366,7 +366,7 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 	if (parse_tree(tree) < 0)
 		die("unable to load tree object %s",
 		    oid_to_hex(&tree->object.oid));
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
diff --git a/packfile.c b/packfile.c
index 9cc0a2e37a83..1fae0fcdd9e7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2250,7 +2250,8 @@ static int add_promisor_object(const struct object_id *oid,
 		struct tree *tree = (struct tree *)obj;
 		struct tree_desc desc;
 		struct name_entry entry;
-		if (init_tree_desc_gently(&desc, tree->buffer, tree->size, 0))
+		if (init_tree_desc_gently(&desc, &tree->object.oid,
+					  tree->buffer, tree->size, 0))
 			/*
 			 * Error messages are given when packs are
 			 * verified, so do not print any here.
diff --git a/reflog.c b/reflog.c
index 9ad50e7d93e4..c6992a19268f 100644
--- a/reflog.c
+++ b/reflog.c
@@ -40,7 +40,7 @@ static int tree_is_complete(const struct object_id *oid)
 		tree->buffer = data;
 		tree->size = size;
 	}
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
 		if (!repo_has_object_file(the_repository, &entry.oid) ||
diff --git a/revision.c b/revision.c
index 2f4c53ea207b..a60dfc23a2a5 100644
--- a/revision.c
+++ b/revision.c
@@ -82,7 +82,7 @@ static void mark_tree_contents_uninteresting(struct repository *r,
 	if (parse_tree_gently(tree, 1) < 0)
 		return;
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
@@ -189,7 +189,7 @@ static void add_children_by_path(struct repository *r,
 	if (parse_tree_gently(tree, 1) < 0)
 		return;
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
diff --git a/tree-walk.c b/tree-walk.c
index 3af50a01c2c7..0b44ec7c75ff 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -15,7 +15,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 	const char *path;
 	unsigned int len;
 	uint16_t mode;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = desc->algo->rawsz;
 
 	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
 		strbuf_addstr(err, _("too-short tree object"));
@@ -37,15 +37,19 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 	desc->entry.path = path;
 	desc->entry.mode = (desc->flags & TREE_DESC_RAW_MODES) ? mode : canon_mode(mode);
 	desc->entry.pathlen = len - 1;
-	oidread(&desc->entry.oid, (const unsigned char *)path + len);
+	oidread_algop(&desc->entry.oid, (const unsigned char *)path + len,
+		      desc->algo);
 
 	return 0;
 }
 
-static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer,
-				   unsigned long size, struct strbuf *err,
+static int init_tree_desc_internal(struct tree_desc *desc,
+				   const struct object_id *oid,
+				   const void *buffer, unsigned long size,
+				   struct strbuf *err,
 				   enum tree_desc_flags flags)
 {
+	desc->algo = (oid && oid->algo) ? &hash_algos[oid->algo] : the_hash_algo;
 	desc->buffer = buffer;
 	desc->size = size;
 	desc->flags = flags;
@@ -54,19 +58,21 @@ static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer,
 	return 0;
 }
 
-void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
+void init_tree_desc(struct tree_desc *desc, const struct object_id *tree_oid,
+		    const void *buffer, unsigned long size)
 {
 	struct strbuf err = STRBUF_INIT;
-	if (init_tree_desc_internal(desc, buffer, size, &err, 0))
+	if (init_tree_desc_internal(desc, tree_oid, buffer, size, &err, 0))
 		die("%s", err.buf);
 	strbuf_release(&err);
 }
 
-int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned long size,
+int init_tree_desc_gently(struct tree_desc *desc, const struct object_id *oid,
+			  const void *buffer, unsigned long size,
 			  enum tree_desc_flags flags)
 {
 	struct strbuf err = STRBUF_INIT;
-	int result = init_tree_desc_internal(desc, buffer, size, &err, flags);
+	int result = init_tree_desc_internal(desc, oid, buffer, size, &err, flags);
 	if (result)
 		error("%s", err.buf);
 	strbuf_release(&err);
@@ -85,7 +91,7 @@ void *fill_tree_descriptor(struct repository *r,
 		if (!buf)
 			die("unable to read tree %s", oid_to_hex(oid));
 	}
-	init_tree_desc(desc, buf, size);
+	init_tree_desc(desc, oid, buf, size);
 	return buf;
 }
 
@@ -102,7 +108,7 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
 static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err)
 {
 	const void *buf = desc->buffer;
-	const unsigned char *end = (const unsigned char *)desc->entry.path + desc->entry.pathlen + 1 + the_hash_algo->rawsz;
+	const unsigned char *end = (const unsigned char *)desc->entry.path + desc->entry.pathlen + 1 + desc->algo->rawsz;
 	unsigned long size = desc->size;
 	unsigned long len = end - (const unsigned char *)buf;
 
@@ -611,7 +617,7 @@ int get_tree_entry(struct repository *r,
 		retval = -1;
 	} else {
 		struct tree_desc t;
-		init_tree_desc(&t, tree, size);
+		init_tree_desc(&t, tree_oid, tree, size);
 		retval = find_tree_entry(r, &t, name, oid, mode);
 	}
 	free(tree);
@@ -654,7 +660,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 	struct tree_desc t;
 	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
 
-	init_tree_desc(&t, NULL, 0UL);
+	init_tree_desc(&t, NULL, NULL, 0UL);
 	strbuf_addstr(&namebuf, name);
 	oidcpy(&current_tree_oid, tree_oid);
 
@@ -690,7 +696,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 				goto done;
 
 			/* descend */
-			init_tree_desc(&t, tree, size);
+			init_tree_desc(&t, &current_tree_oid, tree, size);
 		}
 
 		/* Handle symlinks to e.g. a//b by removing leading slashes */
@@ -724,7 +730,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 			free(parent->tree);
 			parents_nr--;
 			parent = &parents[parents_nr - 1];
-			init_tree_desc(&t, parent->tree, parent->size);
+			init_tree_desc(&t, &parent->oid, parent->tree, parent->size);
 			strbuf_remove(&namebuf, 0, remainder ? 3 : 2);
 			continue;
 		}
@@ -804,7 +810,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 			contents_start = contents;
 
 			parent = &parents[parents_nr - 1];
-			init_tree_desc(&t, parent->tree, parent->size);
+			init_tree_desc(&t, &parent->oid, parent->tree, parent->size);
 			strbuf_splice(&namebuf, 0, len,
 				      contents_start, link_len);
 			if (remainder)
diff --git a/tree-walk.h b/tree-walk.h
index 74cdceb3fed2..cf54d01019e9 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -26,6 +26,7 @@ struct name_entry {
  * A semi-opaque data structure used to maintain the current state of the walk.
  */
 struct tree_desc {
+	const struct git_hash_algo *algo;
 	/*
 	 * pointer into the memory representation of the tree. It always
 	 * points at the current entry being visited.
@@ -85,9 +86,11 @@ int update_tree_entry_gently(struct tree_desc *);
  * size parameters are assumed to be the same as the buffer and size
  * members of `struct tree`.
  */
-void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
+void init_tree_desc(struct tree_desc *desc, const struct object_id *tree_oid,
+		    const void *buf, unsigned long size);
 
-int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size,
+int init_tree_desc_gently(struct tree_desc *desc, const struct object_id *oid,
+			  const void *buf, unsigned long size,
 			  enum tree_desc_flags flags);
 
 /*
diff --git a/tree.c b/tree.c
index c745462f968e..44bcf728f10a 100644
--- a/tree.c
+++ b/tree.c
@@ -27,7 +27,7 @@ int read_tree_at(struct repository *r,
 	if (parse_tree(tree))
 		return -1;
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		if (retval != all_entries_interesting) {
diff --git a/walker.c b/walker.c
index 65002a7220ad..c0fd632d921c 100644
--- a/walker.c
+++ b/walker.c
@@ -45,7 +45,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
 	if (parse_tree(tree))
 		return -1;
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj = NULL;
 
-- 
2.41.0

