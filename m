Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C1221F13
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994228; cv=none; b=usgta2nEXBFZoAjcz83/a3l83WZcaZG1wHAn4c5XPYwSs4AgGKxBpn7xhsV+uWVHl6YUJ5WVX2qIBTGcbwhYZtNNgspC0d5Louw7Bt/VxTHfbAnsScM/z9tHP6R/5tZcLld5FvEfm2gTc6nnrlREvQ1nPpdFx/LpmvsiRTwlsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994228; c=relaxed/simple;
	bh=ixnHIaEvqOctiNSdHeW//dT3WlIVBBofDVh/TgJy1kc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYF3a1+dKOK5LPd++OCHFp73p7yQQaruxal8xcGWPh2vos6TekVE3INQsJi5OeyPDHjh3efBzrcxkhVXY//BdCvt/mn0q789qtAaTOj7+GQLRETwY+Z2MdOBI4nTYNYoHo9K8OkaylE1BE8EevjujQl975gicp0tqsueFDaa9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sgQfqfvB; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sgQfqfvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994223; x=1768599023; i=l.s.r@web.de;
	bh=ekf6Hcq15XswymUU63A069Okv3VzI80GeaMQ3vMO28c=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sgQfqfvBe48Q5/FzWqIQTXdt30YxmqVi86e3+QgW5r7uZUSbDdK5fTMFDr6ukrlA
	 C+5YUvCS4eWlXsUWuvBNOI1gf1d0pUO1c1qV8Y9u1RccJyspcXVVsHRwhdTVsoHXw
	 3t6qKSj4vq29uO7TkJ56l+1+1D++aOLGCRenXnRsKUNc4udrvuIWF3ADIeipFNQoB
	 4VE19cOKNZAKEclH3/ticntmQG0HUMloc/noGnEmQH8q8XxH1c/YNugL8IEB8CyZ/
	 IfmUKBNvE406qYVLXbrMJP22+ZxPkTSc+GEU2pA/WWeymg1IUN9P7MF8BiajgKPta
	 dr1Ym4UDYwYn3fTNWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MgRM5-1wLcpc1z71-00oyU3 for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:23
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 10/10] cocci: convert parse_tree functions to repo_ variants
Date: Fri,  9 Jan 2026 22:30:21 +0100
Message-ID: <20260109213021.2546-11-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6QX3HEqXmN/w4mQHIfijlTlOYsW9J6d3EC6WeazVWQXzlI89Rob
 RnFDlp7eEoBVVkd0WAGaLvvs93TF8DuRCoE62b6a14eaJAm9de4O5MEERF+tmYxbEl7idSz
 6MbUlSLezKOKWO646mlV292q1lNcr2idfdgT1GGeSwBOWYwv7V4t3tW3PHKoHZ1DAr+uiu3
 bK3IjAR4O20CC9QoeRNvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uOoelHjut40=;VBVvvuqe+D1hL/HUrv4xfC8FoZJ
 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

Add and apply a semantic patch to convert calls to parse_tree() and
friends to the corresponding variant that takes a repository argument,
to allow the functions that implicitly use the_repository to be retired
once all potential in-flight topics are settled and converted as well.

The changes in .c files were generated by Coccinelle, but I fixed a
whitespace bug it would have introduced to builtin/commit.c.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive.c                               |  2 +-
 builtin/am.c                            | 10 +++++-----
 builtin/checkout.c                      | 12 +++++++-----
 builtin/clone.c                         |  4 ++--
 builtin/commit.c                        |  5 +++--
 builtin/diff-tree.c                     |  2 +-
 builtin/ls-tree.c                       |  2 +-
 builtin/merge-tree.c                    |  9 ++++++---
 builtin/merge.c                         |  8 ++++----
 builtin/read-tree.c                     |  4 ++--
 builtin/reset.c                         |  4 ++--
 builtin/stash.c                         |  8 ++++----
 cache-tree.c                            |  2 +-
 contrib/coccinelle/the_repository.cocci | 10 ++++++++++
 diff-lib.c                              |  2 +-
 fsck.c                                  |  2 +-
 http-push.c                             |  2 +-
 list-objects.c                          |  2 +-
 merge-ort.c                             | 13 +++++++------
 merge.c                                 |  6 +++---
 read-cache.c                            |  2 +-
 reset.c                                 |  2 +-
 revision.c                              |  4 ++--
 sequencer.c                             |  4 ++--
 t/helper/test-cache-tree.c              |  2 +-
 t/helper/test-match-trees.c             |  4 ++--
 walker.c                                |  2 +-
 27 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/archive.c b/archive.c
index 310672b479a..fcd474c682f 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -519,7 +519,7 @@ static void parse_treeish_arg(const char **argv,
 	if (ar_args->mtime_option)
 		archive_time =3D approxidate(ar_args->mtime_option);
=20
-	tree =3D parse_tree_indirect(&oid);
+	tree =3D repo_parse_tree_indirect(the_repository, &oid);
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));
=20
diff --git a/builtin/am.c b/builtin/am.c
index 277c2e7937d..b66a33d8a88 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1998,7 +1998,7 @@ static int fast_forward_to(struct tree *head, struct=
 tree *remote, int reset)
 	struct unpack_trees_options opts;
 	struct tree_desc t[2];
=20
-	if (parse_tree(head) || parse_tree(remote))
+	if (repo_parse_tree(the_repository, head) || repo_parse_tree(the_reposit=
ory, remote))
 		return -1;
=20
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
@@ -2038,7 +2038,7 @@ static int merge_tree(struct tree *tree)
 	struct unpack_trees_options opts;
 	struct tree_desc t[1];
=20
-	if (parse_tree(tree))
+	if (repo_parse_tree(the_repository, tree))
 		return -1;
=20
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
@@ -2071,11 +2071,11 @@ static int clean_index(const struct object_id *hea=
d, const struct object_id *rem
 	struct tree *head_tree, *remote_tree, *index_tree;
 	struct object_id index;
=20
-	head_tree =3D parse_tree_indirect(head);
+	head_tree =3D repo_parse_tree_indirect(the_repository, head);
 	if (!head_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(head));
=20
-	remote_tree =3D parse_tree_indirect(remote);
+	remote_tree =3D repo_parse_tree_indirect(the_repository, remote);
 	if (!remote_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(remote));
=20
@@ -2089,7 +2089,7 @@ static int clean_index(const struct object_id *head,=
 const struct object_id *rem
 				0, NULL))
 		return -1;
=20
-	index_tree =3D parse_tree_indirect(&index);
+	index_tree =3D repo_parse_tree_indirect(the_repository, &index);
 	if (!index_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(&index));
=20
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5f..0ba4f03f2ee 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -724,7 +724,7 @@ static int reset_tree(struct tree *tree, const struct =
checkout_opts *o,
 	init_checkout_metadata(&opts.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : null_oid(the_hash_al=
go),
 			       NULL);
-	if (parse_tree(tree) < 0)
+	if (repo_parse_tree(the_repository, tree) < 0)
 		return 128;
 	init_tree_desc(&tree_desc, &tree->object.oid, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
@@ -803,7 +803,8 @@ static int merge_working_tree(const struct checkout_op=
ts *opts,
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->commit)
 			BUG("'switch --orphan' should never accept a commit as starting point"=
);
-		new_tree =3D parse_tree_indirect(the_hash_algo->empty_tree);
+		new_tree =3D repo_parse_tree_indirect(the_repository,
+						    the_hash_algo->empty_tree);
 		if (!new_tree)
 			BUG("unable to read empty tree");
 	} else {
@@ -841,14 +842,15 @@ static int merge_working_tree(const struct checkout_=
opts *opts,
 		old_commit_oid =3D old_branch_info->commit ?
 			&old_branch_info->commit->object.oid :
 			the_hash_algo->empty_tree;
-		tree =3D parse_tree_indirect(old_commit_oid);
+		tree =3D repo_parse_tree_indirect(the_repository,
+						old_commit_oid);
 		if (!tree)
 			die(_("unable to parse commit %s"),
 				oid_to_hex(old_commit_oid));
=20
 		init_tree_desc(&trees[0], &tree->object.oid,
 			       tree->buffer, tree->size);
-		if (parse_tree(new_tree) < 0)
+		if (repo_parse_tree(the_repository, new_tree) < 0)
 			die(NULL);
 		tree =3D new_tree;
 		init_tree_desc(&trees[1], &tree->object.oid,
@@ -1278,7 +1280,7 @@ static void setup_new_branch_info_and_source_tree(
 	new_branch_info->commit =3D lookup_commit_reference_gently(the_repositor=
y, rev, 1);
 	if (!new_branch_info->commit) {
 		/* not a commit */
-		*source_tree =3D parse_tree_indirect(rev);
+		*source_tree =3D repo_parse_tree_indirect(the_repository, rev);
 		if (!*source_tree)
 			die(_("unable to read tree (%s)"), oid_to_hex(rev));
 	} else {
diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b065..b40cee59680 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -680,10 +680,10 @@ static int checkout(int submodule_progress, int filt=
er_submodules,
 	opts.dst_index =3D the_repository->index;
 	init_checkout_metadata(&opts.meta, head, &oid, NULL);
=20
-	tree =3D parse_tree_indirect(&oid);
+	tree =3D repo_parse_tree_indirect(the_repository, &oid);
 	if (!tree)
 		die(_("unable to parse commit %s"), oid_to_hex(&oid));
-	if (parse_tree(tree) < 0)
+	if (repo_parse_tree(the_repository, tree) < 0)
 		exit(128);
 	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53c..8e901fe8db7 100644
=2D-- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -327,10 +327,11 @@ static void create_base_index(const struct commit *c=
urrent_head)
 	opts.dst_index =3D the_repository->index;
=20
 	opts.fn =3D oneway_merge;
-	tree =3D parse_tree_indirect(&current_head->object.oid);
+	tree =3D repo_parse_tree_indirect(the_repository,
+					&current_head->object.oid);
 	if (!tree)
 		die(_("failed to unpack HEAD tree object"));
-	if (parse_tree(tree) < 0)
+	if (repo_parse_tree(the_repository, tree) < 0)
 		exit(128);
 	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 49dd4d00ebf..740d9a791c9 100644
=2D-- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -52,7 +52,7 @@ static int stdin_diff_trees(struct tree *tree1, const ch=
ar *p)
 	if (!isspace(*p++) || parse_oid_hex(p, &oid, &p) || *p)
 		return error("Need exactly two trees, separated by a space");
 	tree2 =3D lookup_tree(the_repository, &oid);
-	if (!tree2 || parse_tree(tree2))
+	if (!tree2 || repo_parse_tree(the_repository, tree2))
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
 			  oid_to_hex(&tree2->object.oid));
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ec6940fc7c4..113e4a960dc 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -421,7 +421,7 @@ int cmd_ls_tree(int argc,
 	for (i =3D 0; i < options.pathspec.nr; i++)
 		options.pathspec.items[i].nowildcard_len =3D options.pathspec.items[i].=
len;
 	options.pathspec.has_wildcard =3D 0;
-	tree =3D parse_tree_indirect(&oid);
+	tree =3D repo_parse_tree_indirect(the_repository, &oid);
 	if (!tree)
 		die("not a tree object");
 	/*
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 1c063d9a41a..a6e6d5b555f 100644
=2D-- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -447,17 +447,20 @@ static int real_merge(struct merge_tree_options *o,
=20
 		if (repo_get_oid_treeish(the_repository, merge_base, &base_oid))
 			die(_("could not parse as tree '%s'"), merge_base);
-		base_tree =3D parse_tree_indirect(&base_oid);
+		base_tree =3D repo_parse_tree_indirect(the_repository,
+						     &base_oid);
 		if (!base_tree)
 			die(_("unable to read tree (%s)"), oid_to_hex(&base_oid));
 		if (repo_get_oid_treeish(the_repository, branch1, &head_oid))
 			die(_("could not parse as tree '%s'"), branch1);
-		parent1_tree =3D parse_tree_indirect(&head_oid);
+		parent1_tree =3D repo_parse_tree_indirect(the_repository,
+							&head_oid);
 		if (!parent1_tree)
 			die(_("unable to read tree (%s)"), oid_to_hex(&head_oid));
 		if (repo_get_oid_treeish(the_repository, branch2, &merge_oid))
 			die(_("could not parse as tree '%s'"), branch2);
-		parent2_tree =3D parse_tree_indirect(&merge_oid);
+		parent2_tree =3D repo_parse_tree_indirect(the_repository,
+							&merge_oid);
 		if (!parent2_tree)
 			die(_("unable to read tree (%s)"), oid_to_hex(&merge_oid));
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index c421a11b0b6..50001b4c59f 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -756,19 +756,19 @@ static int read_tree_trivial(struct object_id *commo=
n, struct object_id *head,
 	opts.trivial_merges_only =3D 1;
 	opts.merge =3D 1;
 	opts.preserve_ignored =3D 0; /* FIXME: !overwrite_ignore */
-	trees[nr_trees] =3D parse_tree_indirect(common);
+	trees[nr_trees] =3D repo_parse_tree_indirect(the_repository, common);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] =3D parse_tree_indirect(head);
+	trees[nr_trees] =3D repo_parse_tree_indirect(the_repository, head);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] =3D parse_tree_indirect(one);
+	trees[nr_trees] =3D repo_parse_tree_indirect(the_repository, one);
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn =3D threeway_merge;
 	cache_tree_free(&the_repository->index->cache_tree);
 	for (i =3D 0; i < nr_trees; i++) {
-		parse_tree(trees[i]);
+		repo_parse_tree(the_repository, trees[i]);
 		init_tree_desc(t+i, &trees[i]->object.oid,
 			       trees[i]->buffer, trees[i]->size);
 	}
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 34f7a59f38e..460b21e40ac 100644
=2D-- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -32,7 +32,7 @@ static int list_tree(struct object_id *oid)
=20
 	if (nr_trees >=3D MAX_UNPACK_TREES)
 		die("I cannot read more than %d trees", MAX_UNPACK_TREES);
-	tree =3D parse_tree_indirect(oid);
+	tree =3D repo_parse_tree_indirect(the_repository, oid);
 	if (!tree)
 		return -1;
 	trees[nr_trees++] =3D tree;
@@ -268,7 +268,7 @@ int cmd_read_tree(int argc,
 	cache_tree_free(&the_repository->index->cache_tree);
 	for (i =3D 0; i < nr_trees; i++) {
 		struct tree *tree =3D trees[i];
-		if (parse_tree(tree) < 0)
+		if (repo_parse_tree(the_repository, tree) < 0)
 			return 128;
 		init_tree_desc(t+i, &tree->object.oid, tree->buffer, tree->size);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index ed35802af15..c48d9845f84 100644
=2D-- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -118,7 +118,7 @@ static int reset_index(const char *ref, const struct o=
bject_id *oid, int reset_t
 		goto out;
=20
 	if (reset_type =3D=3D MIXED || reset_type =3D=3D HARD) {
-		tree =3D parse_tree_indirect(oid);
+		tree =3D repo_parse_tree_indirect(the_repository, oid);
 		if (!tree) {
 			error(_("unable to read tree (%s)"), oid_to_hex(oid));
 			goto out;
@@ -417,7 +417,7 @@ int cmd_reset(int argc,
 		struct tree *tree;
 		if (repo_get_oid_treeish(the_repository, rev, &oid))
 			die(_("Failed to resolve '%s' as a valid tree."), rev);
-		tree =3D parse_tree_indirect(&oid);
+		tree =3D repo_parse_tree_indirect(the_repository, &oid);
 		if (!tree)
 			die(_("Could not parse object '%s'."), rev);
 		oidcpy(&oid, &tree->object.oid);
diff --git a/builtin/stash.c b/builtin/stash.c
index 948eba06fbc..193e3ea47a1 100644
=2D-- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -347,8 +347,8 @@ static int reset_tree(struct object_id *i_tree, int up=
date, int reset)
=20
 	memset(&opts, 0, sizeof(opts));
=20
-	tree =3D parse_tree_indirect(i_tree);
-	if (parse_tree(tree))
+	tree =3D repo_parse_tree_indirect(the_repository, i_tree);
+	if (repo_parse_tree(the_repository, tree))
 		return -1;
=20
 	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
@@ -940,8 +940,8 @@ static void diff_include_untracked(const struct stash_=
info *info, struct diff_op
 	struct unpack_trees_options unpack_tree_opt =3D { 0 };
=20
 	for (size_t i =3D 0; i < ARRAY_SIZE(oid); i++) {
-		tree[i] =3D parse_tree_indirect(oid[i]);
-		if (parse_tree(tree[i]) < 0)
+		tree[i] =3D repo_parse_tree_indirect(the_repository, oid[i]);
+		if (repo_parse_tree(the_repository, tree[i]) < 0)
 			die(_("failed to parse tree"));
 		init_tree_desc(&tree_desc[i], &tree[i]->object.oid,
 			       tree[i]->buffer, tree[i]->size);
diff --git a/cache-tree.c b/cache-tree.c
index 2d8947b5187..16c3a36b482 100644
=2D-- a/cache-tree.c
+++ b/cache-tree.c
@@ -813,7 +813,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree =3D lookup_tree(r, &entry.oid);
=20
-			if (parse_tree(subtree) < 0)
+			if (repo_parse_tree(the_repository, subtree) < 0)
 				exit(128);
 			sub =3D cache_tree_sub(it, entry.path);
 			sub->cache_tree =3D cache_tree();
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/=
the_repository.cocci
index ea7fe1c8db7..a1f6f5ac06c 100644
=2D-- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -117,6 +117,16 @@
 |
 - init_revisions
 + repo_init_revisions
+// tree.h
+|
+- parse_tree
++ repo_parse_tree
+|
+- parse_tree_gently
++ repo_parse_tree_gently
+|
+- parse_tree_indirect
++ repo_parse_tree_indirect
 )
   (
 + the_repository,
diff --git a/diff-lib.c b/diff-lib.c
index 5307390ff3d..506000761d4 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -552,7 +552,7 @@ static int diff_cache(struct rev_info *revs,
 	struct tree_desc t;
 	struct unpack_trees_options opts;
=20
-	tree =3D parse_tree_indirect(tree_oid);
+	tree =3D repo_parse_tree_indirect(the_repository, tree_oid);
 	if (!tree)
 		return error("bad tree object %s",
 			     tree_name ? tree_name : oid_to_hex(tree_oid));
diff --git a/fsck.c b/fsck.c
index fae18d8561e..5532f5ae9f9 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -360,7 +360,7 @@ static int fsck_walk_tree(struct tree *tree, void *dat=
a, struct fsck_options *op
 	int res =3D 0;
 	const char *name;
=20
-	if (parse_tree(tree))
+	if (repo_parse_tree(the_repository, tree))
 		return -1;
=20
 	name =3D fsck_get_object_name(options, &tree->object.oid);
diff --git a/http-push.c b/http-push.c
index 60a9b756209..cc0f8093461 100644
=2D-- a/http-push.c
+++ b/http-push.c
@@ -1311,7 +1311,7 @@ static struct object_list **process_tree(struct tree=
 *tree,
=20
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
-	if (parse_tree(tree) < 0)
+	if (repo_parse_tree(the_repository, tree) < 0)
 		die("bad tree object %s", oid_to_hex(&obj->oid));
=20
 	obj->flags |=3D SEEN;
diff --git a/list-objects.c b/list-objects.c
index 1279676ddca..91b23e22f71 100644
=2D-- a/list-objects.c
+++ b/list-objects.c
@@ -170,7 +170,7 @@ static void process_tree(struct traversal_context *ctx=
,
 	if (ctx->depth > revs->repo->settings.max_allowed_tree_depth)
 		die("exceeded maximum allowed tree depth");
=20
-	failed_parse =3D parse_tree_gently(tree, 1);
+	failed_parse =3D repo_parse_tree_gently(the_repository, tree, 1);
 	if (failed_parse) {
 		if (revs->ignore_missing_links)
 			return;
diff --git a/merge-ort.c b/merge-ort.c
index 2b837a58c3a..e80e4f735a6 100644
=2D-- a/merge-ort.c
+++ b/merge-ort.c
@@ -1732,9 +1732,9 @@ static int collect_merge_info(struct merge_options *=
opt,
 	info.data =3D opt;
 	info.show_all_errors =3D 1;
=20
-	if (parse_tree(merge_base) < 0 ||
-	    parse_tree(side1) < 0 ||
-	    parse_tree(side2) < 0)
+	if (repo_parse_tree(the_repository, merge_base) < 0 ||
+	    repo_parse_tree(the_repository, side1) < 0 ||
+	    repo_parse_tree(the_repository, side2) < 0)
 		return -1;
 	init_tree_desc(t + 0, &merge_base->object.oid,
 		       merge_base->buffer, merge_base->size);
@@ -4619,10 +4619,10 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update =3D (opt->verbosity > 2);
 	unpack_opts.fn =3D twoway_merge;
 	unpack_opts.preserve_ignored =3D 0; /* FIXME: !opts->overwrite_ignore */
-	if (parse_tree(prev) < 0)
+	if (repo_parse_tree(the_repository, prev) < 0)
 		return -1;
 	init_tree_desc(&trees[0], &prev->object.oid, prev->buffer, prev->size);
-	if (parse_tree(next) < 0)
+	if (repo_parse_tree(the_repository, next) < 0)
 		return -1;
 	init_tree_desc(&trees[1], &next->object.oid, next->buffer, next->size);
=20
@@ -5280,7 +5280,8 @@ static void merge_ort_nonrecursive_internal(struct m=
erge_options *opt,
=20
 	if (result->clean >=3D 0) {
 		if (!opt->mergeability_only) {
-			result->tree =3D parse_tree_indirect(&working_tree_oid);
+			result->tree =3D repo_parse_tree_indirect(the_repository,
+								&working_tree_oid);
 			if (!result->tree)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(&working_tree_oid));
diff --git a/merge.c b/merge.c
index 5ecaf508e4c..0f5e823e63e 100644
=2D-- a/merge.c
+++ b/merge.c
@@ -68,18 +68,18 @@ int checkout_fast_forward(struct repository *r,
 	memset(&trees, 0, sizeof(trees));
 	memset(&t, 0, sizeof(t));
=20
-	trees[nr_trees] =3D parse_tree_indirect(head);
+	trees[nr_trees] =3D repo_parse_tree_indirect(the_repository, head);
 	if (!trees[nr_trees++]) {
 		rollback_lock_file(&lock_file);
 		return -1;
 	}
-	trees[nr_trees] =3D parse_tree_indirect(remote);
+	trees[nr_trees] =3D repo_parse_tree_indirect(the_repository, remote);
 	if (!trees[nr_trees++]) {
 		rollback_lock_file(&lock_file);
 		return -1;
 	}
 	for (i =3D 0; i < nr_trees; i++) {
-		if (parse_tree(trees[i]) < 0) {
+		if (repo_parse_tree(the_repository, trees[i]) < 0) {
 			rollback_lock_file(&lock_file);
 			return -1;
 		}
diff --git a/read-cache.c b/read-cache.c
index 990d4ead0d8..e9c1b23e484 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -3807,7 +3807,7 @@ void overlay_tree_on_index(struct index_state *istat=
e,
=20
 	if (repo_get_oid(the_repository, tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
-	tree =3D parse_tree_indirect(&oid);
+	tree =3D repo_parse_tree_indirect(the_repository, &oid);
 	if (!tree)
 		die("bad tree-ish %s", tree_name);
=20
diff --git a/reset.c b/reset.c
index bb590271811..46e30e63945 100644
=2D-- a/reset.c
+++ b/reset.c
@@ -163,7 +163,7 @@ int reset_head(struct repository *r, const struct rese=
t_head_opts *opts)
 		goto leave_reset_head;
 	}
=20
-	tree =3D parse_tree_indirect(oid);
+	tree =3D repo_parse_tree_indirect(the_repository, oid);
 	if (!tree) {
 		ret =3D error(_("unable to read tree (%s)"), oid_to_hex(oid));
 		goto leave_reset_head;
diff --git a/revision.c b/revision.c
index 5f0850ae5c9..426d19a2c6c 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -72,7 +72,7 @@ static void mark_tree_contents_uninteresting(struct repo=
sitory *r,
 	struct tree_desc desc;
 	struct name_entry entry;
=20
-	if (parse_tree_gently(tree, 1) < 0)
+	if (repo_parse_tree_gently(the_repository, tree, 1) < 0)
 		return;
=20
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
@@ -179,7 +179,7 @@ static void add_children_by_path(struct repository *r,
 	if (!tree)
 		return;
=20
-	if (parse_tree_gently(tree, 1) < 0)
+	if (repo_parse_tree_gently(the_repository, tree, 1) < 0)
 		return;
=20
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
diff --git a/sequencer.c b/sequencer.c
index 71ed31c7740..cccde58bee9 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -767,7 +767,7 @@ static int do_recursive_merge(struct repository *r,
 		o.buffer_output =3D 2;
 	o.show_rename_progress =3D 1;
=20
-	head_tree =3D parse_tree_indirect(head);
+	head_tree =3D repo_parse_tree_indirect(the_repository, head);
 	if (!head_tree)
 		return error(_("unable to read tree (%s)"), oid_to_hex(head));
 	next_tree =3D next ? repo_get_commit_tree(r, next) : empty_tree(r);
@@ -4052,7 +4052,7 @@ static int do_reset(struct repository *r,
 		goto cleanup;
 	}
=20
-	tree =3D parse_tree_indirect(&oid);
+	tree =3D repo_parse_tree_indirect(the_repository, &oid);
 	if (!tree)
 		return error(_("unable to read tree (%s)"), oid_to_hex(&oid));
 	prime_cache_tree(r, r->index, tree);
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 3ae45cec3be..ff61d0ca7e2 100644
=2D-- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -41,7 +41,7 @@ int cmd__cache_tree(int argc, const char **argv)
 		die(_("unable to read index file"));
=20
 	oidcpy(&oid, &the_repository->index->cache_tree->oid);
-	tree =3D parse_tree_indirect(&oid);
+	tree =3D repo_parse_tree_indirect(the_repository, &oid);
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));
=20
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index e0e2048320d..2ed064b9716 100644
=2D-- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -19,10 +19,10 @@ int cmd__match_trees(int ac UNUSED, const char **av)
 		die("cannot parse %s as an object name", av[1]);
 	if (repo_get_oid(the_repository, av[2], &hash2))
 		die("cannot parse %s as an object name", av[2]);
-	one =3D parse_tree_indirect(&hash1);
+	one =3D repo_parse_tree_indirect(the_repository, &hash1);
 	if (!one)
 		die("not a tree-ish %s", av[1]);
-	two =3D parse_tree_indirect(&hash2);
+	two =3D repo_parse_tree_indirect(the_repository, &hash2);
 	if (!two)
 		die("not a tree-ish %s", av[2]);
=20
diff --git a/walker.c b/walker.c
index 2891563b036..91332539d3a 100644
=2D-- a/walker.c
+++ b/walker.c
@@ -45,7 +45,7 @@ static int process_tree(struct walker *walker, struct tr=
ee *tree)
 	struct tree_desc desc;
 	struct name_entry entry;
=20
-	if (parse_tree(tree))
+	if (repo_parse_tree(the_repository, tree))
 		return -1;
=20
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
=2D-=20
2.52.0

