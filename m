From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 10/13] Add several uses of get_object_hash.
Date: Fri,  9 Oct 2015 01:43:56 +0000
Message-ID: <1444355039-186351-11-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkb-0001bi-JT
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbbJIBpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58062 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755878AbbJIBpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:16 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 366BA280A1;
	Fri,  9 Oct 2015 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355115;
	bh=BlOv40tqGIs3sK+Gr+ZJTy9EJn+zwyRz0m3CdH6Hg9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOsV7MvoDV3RbAnXJAqen4yVsPK9YtkFVj/s/6keI+v/d0buRpoxMeZPk3VX2npDW
	 J5tme8HaCZ2ywF4BqKPFp+BSOIxVix7/nuN9AHuTZKV3+gvAWDpQ7gfy03petgfiJX
	 i8QSZPRg7aAqwtVXLDNEZ2I3mVqn6apaAYR9WfyfP0dZTL0iCx3OJ5UrWI+iTVgO0K
	 6s2PkNY2CvbbRaTrvSvmTFS1amMN5bYI6m12T+i0JxH31j8v3FsRepqZ7Duo9rmfov
	 aVBjxgDutB4xUUh183hO7bCPrkCa7XX0KSw8707maf745q0EUdrKd5g4b/dEJKhL/j
	 RWyAiLcyt8GA6+uDumS/ZXkDqU2Oukl6TIspjiDuT+uT71JK/o2uGWKHUEawfXKPK7
	 ephP7DZ+vn76rLL9dExX4v6AmdL58O5gpGcolIOxMxmyreYlqBli/NWm19/EXu+Bpt
	 4hoIXHOpK1pibiKyRju2jqZZ72fk4/65o3kEF5Sk33zt4OPQ0em
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279289>

Convert most instances where the sha1 member of struct object is
dereferenced to use get_object_hash.  Most instances that are passed to
functions that have versions taking struct object_id, such as
get_sha1_hex/get_oid_hex, or instances that can be trivially converted
to use struct object_id instead, are not converted.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This does not follow a hard and fast rule, but the goal was to keep the
changes down between both this patch and the following.  *Generally*,
things I was going to convert in the next patch I didn't convert here.

 archive.c                |  6 +++---
 bisect.c                 |  6 +++---
 branch.c                 |  2 +-
 builtin/blame.c          | 24 ++++++++++-----------
 builtin/branch.c         |  2 +-
 builtin/checkout.c       | 10 ++++-----
 builtin/clone.c          |  2 +-
 builtin/commit.c         |  8 +++----
 builtin/describe.c       |  6 +++---
 builtin/diff-tree.c      |  8 +++----
 builtin/diff.c           | 12 +++++------
 builtin/fast-export.c    | 12 +++++------
 builtin/fetch.c          |  4 ++--
 builtin/fmt-merge-msg.c  |  4 ++--
 builtin/fsck.c           |  4 ++--
 builtin/grep.c           |  2 +-
 builtin/index-pack.c     |  2 +-
 builtin/log.c            | 18 ++++++++--------
 builtin/merge-tree.c     |  4 ++--
 builtin/merge.c          | 54 ++++++++++++++++++++++++------------------------
 builtin/name-rev.c       |  6 +++---
 builtin/notes.c          |  2 +-
 builtin/pack-objects.c   | 14 ++++++-------
 builtin/reflog.c         |  4 ++--
 builtin/reset.c          |  2 +-
 builtin/rev-list.c       |  4 ++--
 builtin/rev-parse.c      |  4 ++--
 builtin/show-branch.c    |  4 ++--
 builtin/unpack-objects.c |  2 +-
 bundle.c                 |  2 +-
 cache-tree.c             |  2 +-
 combine-diff.c           |  4 ++--
 commit.c                 | 12 +++++------
 decorate.c               |  2 +-
 diff-lib.c               |  2 +-
 fetch-pack.c             |  4 ++--
 fsck.c                   |  6 +++---
 http-push.c              | 20 +++++++++---------
 line-log.c               |  6 +++---
 log-tree.c               | 20 +++++++++---------
 merge-blobs.c            |  4 ++--
 merge-recursive.c        | 16 +++++++-------
 notes-merge.c            | 20 +++++++++---------
 object.c                 |  6 +++---
 pack-bitmap-write.c      | 14 ++++++-------
 pack-bitmap.c            | 26 +++++++++++------------
 patch-ids.c              |  6 +++---
 pretty.c                 |  8 +++----
 ref-filter.c             |  6 +++---
 refs.c                   |  2 +-
 revision.c               | 16 +++++++-------
 sequencer.c              | 18 ++++++++--------
 sha1_name.c              | 16 +++++++-------
 shallow.c                |  2 +-
 submodule.c              |  2 +-
 tag.c                    |  6 +++---
 test-match-trees.c       |  2 +-
 tree.c                   |  4 ++--
 upload-pack.c            | 10 ++++-----
 walker.c                 |  8 +++----
 wt-status.c              |  2 +-
 61 files changed, 253 insertions(+), 253 deletions(-)

diff --git a/archive.c b/archive.c
index 01b0899b..4ff88788 100644
--- a/archive.c
+++ b/archive.c
@@ -240,7 +240,7 @@ int write_archive_entries(struct archiver_args *args,
 			len--;
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
-		err = write_entry(args, args->tree->object.sha1, args->base,
+		err = write_entry(args, get_object_hash(args->tree->object), args->base,
 				  len, 040777);
 		if (err)
 			return err;
@@ -373,7 +373,7 @@ static void parse_treeish_arg(const char **argv,
 
 	commit = lookup_commit_reference_gently(oid.hash, 1);
 	if (commit) {
-		commit_sha1 = commit->object.sha1;
+		commit_sha1 = get_object_hash(commit->object);
 		archive_time = commit->date;
 	} else {
 		commit_sha1 = NULL;
@@ -389,7 +389,7 @@ static void parse_treeish_arg(const char **argv,
 		unsigned int mode;
 		int err;
 
-		err = get_tree_entry(tree->object.sha1, prefix,
+		err = get_tree_entry(get_object_hash(tree->object), prefix,
 				     tree_oid.hash, &mode);
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
diff --git a/bisect.c b/bisect.c
index 053d1a2a..59e86369 100644
--- a/bisect.c
+++ b/bisect.c
@@ -500,7 +500,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
 		struct commit_list *next = list->next;
 		list->next = NULL;
 		if (0 <= sha1_array_lookup(&skipped_revs,
-					   list->item->object.sha1)) {
+					   get_object_hash(list->item->object))) {
 			if (skipped_first && !*skipped_first)
 				*skipped_first = 1;
 			/* Move current to tried list */
@@ -784,7 +784,7 @@ static void check_merge_bases(int no_checkout)
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
 
 	for (; result; result = result->next) {
-		const unsigned char *mb = result->item->object.sha1;
+		const unsigned char *mb = get_object_hash(result->item->object);
 		if (!hashcmp(mb, current_bad_oid->hash)) {
 			handle_bad_merge_base();
 		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
@@ -973,7 +973,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit(4);
 	}
 
-	bisect_rev = revs.commits->item->object.sha1;
+	bisect_rev = get_object_hash(revs.commits->item->object);
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
diff --git a/branch.c b/branch.c
index d013374e..f064614a 100644
--- a/branch.c
+++ b/branch.c
@@ -266,7 +266,7 @@ void create_branch(const char *head,
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
-	hashcpy(sha1, commit->object.sha1);
+	hashcpy(sha1, get_object_hash(commit->object));
 
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
diff --git a/builtin/blame.c b/builtin/blame.c
index 203a981c..ad2db384 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -505,7 +505,7 @@ static int fill_blob_sha1_and_mode(struct origin *origin)
 {
 	if (!is_null_sha1(origin->blob_sha1))
 		return 0;
-	if (get_tree_entry(origin->commit->object.sha1,
+	if (get_tree_entry(get_object_hash(origin->commit->object),
 			   origin->path,
 			   origin->blob_sha1, &origin->mode))
 		goto error_out;
@@ -557,10 +557,10 @@ static struct origin *find_origin(struct scoreboard *sb,
 	diff_setup_done(&diff_opts);
 
 	if (is_null_sha1(origin->commit->object.sha1))
-		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+		do_diff_cache(get_object_hash(parent->tree->object), &diff_opts);
 	else
-		diff_tree_sha1(parent->tree->object.sha1,
-			       origin->commit->tree->object.sha1,
+		diff_tree_sha1(get_object_hash(parent->tree->object),
+			       get_object_hash(origin->commit->tree->object),
 			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
@@ -627,10 +627,10 @@ static struct origin *find_rename(struct scoreboard *sb,
 	diff_setup_done(&diff_opts);
 
 	if (is_null_sha1(origin->commit->object.sha1))
-		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+		do_diff_cache(get_object_hash(parent->tree->object), &diff_opts);
 	else
-		diff_tree_sha1(parent->tree->object.sha1,
-			       origin->commit->tree->object.sha1,
+		diff_tree_sha1(get_object_hash(parent->tree->object),
+			       get_object_hash(origin->commit->tree->object),
 			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
@@ -1275,10 +1275,10 @@ static void find_copy_in_parent(struct scoreboard *sb,
 		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 
 	if (is_null_sha1(target->commit->object.sha1))
-		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+		do_diff_cache(get_object_hash(parent->tree->object), &diff_opts);
 	else
-		diff_tree_sha1(parent->tree->object.sha1,
-			       target->commit->tree->object.sha1,
+		diff_tree_sha1(get_object_hash(parent->tree->object),
+			       get_object_hash(target->commit->tree->object),
 			       "", &diff_opts);
 
 	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
@@ -2076,7 +2076,7 @@ static int read_ancestry(const char *graft_file)
 
 static int update_auto_abbrev(int auto_abbrev, struct origin *suspect)
 {
-	const char *uniq = find_unique_abbrev(suspect->commit->object.sha1,
+	const char *uniq = find_unique_abbrev(get_object_hash(suspect->commit->object),
 					      auto_abbrev);
 	int len = strlen(uniq);
 	if (auto_abbrev < len)
@@ -2215,7 +2215,7 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 	struct commit_list *parents;
 
 	for (parents = work_tree->parents; parents; parents = parents->next) {
-		const unsigned char *commit_sha1 = parents->item->object.sha1;
+		const unsigned char *commit_sha1 = get_object_hash(parents->item->object);
 		unsigned char blob_sha1[20];
 		unsigned mode;
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 3ba4d1bd..85e902ac 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -498,7 +498,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 		fill_tracking_info(&stat, item->name, verbose > 1);
 
 	strbuf_addf(out, " %s %s%s",
-		find_unique_abbrev(item->commit->object.sha1, abbrev),
+		find_unique_abbrev(get_object_hash(item->commit->object), abbrev),
 		stat.buf, sub);
 	strbuf_release(&stat);
 	strbuf_release(&subject);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc703c0f..f6dde8be 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -400,7 +400,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	fprintf(stderr, "%s %s... %s\n", msg,
-		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
+		find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
 }
 
@@ -509,7 +509,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			setup_standard_excludes(topts.dir);
 		}
 		tree = parse_tree_indirect(old->commit ?
-					   old->commit->object.sha1 :
+					   get_object_hash(old->commit->object) :
 					   EMPTY_TREE_SHA1_BIN);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree = parse_tree_indirect(new->commit->object.sha1);
@@ -652,7 +652,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
+		update_ref(msg.buf, "HEAD", get_object_hash(new->commit->object), NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
@@ -703,7 +703,7 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 {
 	strbuf_addstr(sb, "  ");
 	strbuf_addstr(sb,
-		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+		find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV));
 	strbuf_addch(sb, ' ');
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
@@ -761,7 +761,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 			" git branch <new-branch-name> %s\n\n",
 			/* Give ngettext() the count */
 			lost),
-			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+			find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV));
 }
 
 /*
diff --git a/builtin/clone.c b/builtin/clone.c
index 92007b35..bfc6c80a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -650,7 +650,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(our->old_oid.hash);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", c->object.sha1,
+		update_ref(msg, "HEAD", get_object_hash(c->object),
 			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
diff --git a/builtin/commit.c b/builtin/commit.c
index 63772d01..30a96f79 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -299,7 +299,7 @@ static void create_base_index(const struct commit *current_head)
 	opts.dst_index = &the_index;
 
 	opts.fn = oneway_merge;
-	tree = parse_tree_indirect(current_head->object.sha1);
+	tree = parse_tree_indirect(get_object_hash(current_head->object));
 	if (!tree)
 		die(_("failed to unpack HEAD tree object"));
 	parse_tree(tree);
@@ -1766,7 +1766,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
-				   ? current_head->object.sha1 : null_sha1,
+				   ? get_object_hash(current_head->object) : null_sha1,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
@@ -1793,10 +1793,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		cfg = init_copy_notes_for_rewrite("amend");
 		if (cfg) {
 			/* we are amending, so current_head is not NULL */
-			copy_note_for_rewrite(cfg, current_head->object.sha1, sha1);
+			copy_note_for_rewrite(cfg, get_object_hash(current_head->object), sha1);
 			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
 		}
-		run_rewrite_hook(current_head->object.sha1, sha1);
+		run_rewrite_hook(get_object_hash(current_head->object), sha1);
 	}
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
diff --git a/builtin/describe.c b/builtin/describe.c
index 7df55432..c0c373b4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -252,14 +252,14 @@ static void describe(const char *arg, int last_one)
 	if (!cmit)
 		die(_("%s is not a valid '%s' object"), arg, commit_type);
 
-	n = find_commit_name(cmit->object.sha1);
+	n = find_commit_name(get_object_hash(cmit->object));
 	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
 		 */
 		display_name(n);
 		if (longformat)
-			show_suffix(0, n->tag ? n->tag->tagged->sha1 : sha1);
+			show_suffix(0, n->tag ? get_object_hash(*n->tag->tagged) : sha1);
 		if (dirty)
 			printf("%s", dirty);
 		printf("\n");
@@ -380,7 +380,7 @@ static void describe(const char *arg, int last_one)
 
 	display_name(all_matches[0].name);
 	if (abbrev)
-		show_suffix(all_matches[0].depth, cmit->object.sha1);
+		show_suffix(all_matches[0].depth, get_object_hash(cmit->object));
 	if (dirty)
 		printf("%s", dirty);
 	printf("\n");
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 12b683d0..cf7e9604 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -51,7 +51,7 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 		return -1;
 	printf("%s %s\n", sha1_to_hex(tree1->object.sha1),
 			  sha1_to_hex(tree2->object.sha1));
-	diff_tree_sha1(tree1->object.sha1, tree2->object.sha1,
+	diff_tree_sha1(get_object_hash(tree1->object), get_object_hash(tree2->object),
 		       "", &log_tree_opt.diffopt);
 	log_tree_diff_flush(&log_tree_opt);
 	return 0;
@@ -139,7 +139,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		break;
 	case 1:
 		tree1 = opt->pending.objects[0].item;
-		diff_tree_commit_sha1(tree1->sha1);
+		diff_tree_commit_sha1(get_object_hash(*tree1));
 		break;
 	case 2:
 		tree1 = opt->pending.objects[0].item;
@@ -149,8 +149,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			tree2 = tree1;
 			tree1 = tmp;
 		}
-		diff_tree_sha1(tree1->sha1,
-			       tree2->sha1,
+		diff_tree_sha1(get_object_hash(*tree1),
+			       get_object_hash(*tree2),
 			       "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 		break;
diff --git a/builtin/diff.c b/builtin/diff.c
index 4326fa56..1afed8e2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -175,8 +175,8 @@ static int builtin_diff_tree(struct rev_info *revs,
 	 */
 	if (ent1->item->flags & UNINTERESTING)
 		swap = 1;
-	sha1[swap] = ent0->item->sha1;
-	sha1[1 - swap] = ent1->item->sha1;
+	sha1[swap] = get_object_hash(*ent0->item);
+	sha1[1 - swap] = get_object_hash(*ent1->item);
 	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
@@ -196,8 +196,8 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	for (i = 1; i < ents; i++)
-		sha1_array_append(&parents, ent[i].item->sha1);
-	diff_tree_combined(ent[0].item->sha1, &parents,
+		sha1_array_append(&parents, get_object_hash(*ent[i].item));
+	diff_tree_combined(get_object_hash(*ent[0].item), &parents,
 			   revs->dense_combined_merges, revs);
 	sha1_array_clear(&parents);
 	return 0;
@@ -395,7 +395,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		const char *name = entry->name;
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
-			obj = parse_object(obj->sha1);
+			obj = parse_object(get_object_hash(*obj));
 		obj = deref_tag(obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
@@ -408,7 +408,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		} else if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
-			hashcpy(blob[blobs].sha1, obj->sha1);
+			hashcpy(blob[blobs].sha1, get_object_hash(*obj));
 			blob[blobs].name = name;
 			blob[blobs].mode = entry->mode;
 			blobs++;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d23f3beb..30faf248 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -562,11 +562,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	    get_object_mark(&commit->parents->item->object) != 0 &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
-		diff_tree_sha1(commit->parents->item->tree->object.sha1,
-			       commit->tree->object.sha1, "", &rev->diffopt);
+		diff_tree_sha1(get_object_hash(commit->parents->item->tree->object),
+			       get_object_hash(commit->tree->object), "", &rev->diffopt);
 	}
 	else
-		diff_root_tree_sha1(commit->tree->object.sha1,
+		diff_root_tree_sha1(get_object_hash(commit->tree->object),
 				    "", &rev->diffopt);
 
 	/* Export the referenced blobs, and remember the marks. */
@@ -665,7 +665,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		return;
 	}
 
-	buf = read_sha1_file(tag->object.sha1, &type, &size);
+	buf = read_sha1_file(get_object_hash(tag->object), &type, &size);
 	if (!buf)
 		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
 	message = memmem(buf, size, "\n\n", 2);
@@ -777,7 +777,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 		/* handle nested tags */
 		while (tag && tag->object.type == OBJ_TAG) {
-			parse_object(tag->object.sha1);
+			parse_object(get_object_hash(tag->object));
 			string_list_append(&extra_refs, full_name)->util = tag;
 			tag = (struct tag *)tag->tagged;
 		}
@@ -828,7 +828,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		case OBJ_COMMIT:
 			break;
 		case OBJ_BLOB:
-			export_blob(commit->object.sha1);
+			export_blob(get_object_hash(commit->object));
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
 			warning("Tag points to object of unexpected type %s, skipping.",
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a56b271a..643e6a44 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -530,7 +530,7 @@ static int update_local_ref(struct ref *ref,
 	if (in_merge_bases(current, updated)) {
 		char quickref[83];
 		int r;
-		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
+		strcpy(quickref, find_unique_abbrev(get_object_hash(current->object), DEFAULT_ABBREV));
 		strcat(quickref, "..");
 		strcat(quickref, find_unique_abbrev(ref->new_oid.hash, DEFAULT_ABBREV));
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
@@ -546,7 +546,7 @@ static int update_local_ref(struct ref *ref,
 	} else if (force || ref->force) {
 		char quickref[84];
 		int r;
-		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
+		strcpy(quickref, find_unique_abbrev(get_object_hash(current->object), DEFAULT_ABBREV));
 		strcat(quickref, "...");
 		strcat(quickref, find_unique_abbrev(ref->new_oid.hash, DEFAULT_ABBREV));
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4ba7f282..86f3b53c 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -568,7 +568,7 @@ static void find_merge_parents(struct merge_parents *result,
 		if (!parent)
 			continue;
 		commit_list_insert(parent, &parents);
-		add_merge_parent(result, obj->sha1, parent->object.sha1);
+		add_merge_parent(result, get_object_hash(*obj), get_object_hash(parent->object));
 	}
 	head_commit = lookup_commit(head);
 	if (head_commit)
@@ -578,7 +578,7 @@ static void find_merge_parents(struct merge_parents *result,
 	while (parents) {
 		for (i = 0; i < result->nr; i++)
 			if (!hashcmp(result->item[i].commit,
-				     parents->item->object.sha1))
+				     get_object_hash(parents->item->object)))
 				result->item[i].used = 1;
 		next = parents->next;
 		free(parents);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 07947034..c0fa3e9a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -193,7 +193,7 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
-		if (has_sha1_pack(obj->sha1))
+		if (has_sha1_pack(get_object_hash(*obj)))
 			return; /* it is in pack - forget about it */
 		if (connectivity_only && has_sha1_file(obj->sha1))
 			return;
@@ -256,7 +256,7 @@ static void check_unreachable_object(struct object *obj)
 			if (!(f = fopen(filename, "w")))
 				die_errno("Could not open '%s'", filename);
 			if (obj->type == OBJ_BLOB) {
-				if (stream_blob_to_fd(fileno(f), obj->sha1, NULL, 1))
+				if (stream_blob_to_fd(fileno(f), get_object_hash(*obj), NULL, 1))
 					die_errno("Could not write '%s'", filename);
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
diff --git a/builtin/grep.c b/builtin/grep.c
index d04f4400..9c42fc03 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -459,7 +459,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name, const char *path)
 {
 	if (obj->type == OBJ_BLOB)
-		return grep_sha1(opt, obj->sha1, name, 0, path);
+		return grep_sha1(opt, get_object_hash(*obj), name, 0, path);
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3431de23..7ab75a12 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -217,7 +217,7 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = sha1_object_info(obj->sha1, &size);
+		int type = sha1_object_info(get_object_hash(*obj), &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      sha1_to_hex(obj->sha1));
diff --git a/builtin/log.c b/builtin/log.c
index a491d3de..8dd56410 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -552,7 +552,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_blob_object(o->sha1, &rev, name);
+			ret = show_blob_object(get_object_hash(*o), &rev, name);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
@@ -563,11 +563,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			ret = show_tag_object(o->sha1, &rev);
+			ret = show_tag_object(get_object_hash(*o), &rev);
 			rev.shown_one = 1;
 			if (ret)
 				break;
-			o = parse_object(t->tagged->sha1);
+			o = parse_object(get_object_hash(*t->tagged));
 			if (!o)
 				ret = error(_("Could not read object %s"),
 					    sha1_to_hex(t->tagged->sha1));
@@ -831,8 +831,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	o2 = rev->pending.objects[1].item;
 	flags1 = o1->flags;
 	flags2 = o2->flags;
-	c1 = lookup_commit_reference(o1->sha1);
-	c2 = lookup_commit_reference(o2->sha1);
+	c1 = lookup_commit_reference(get_object_hash(*o1));
+	c2 = lookup_commit_reference(get_object_hash(*o2));
 
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
@@ -994,8 +994,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	diff_setup_done(&opts);
 
-	diff_tree_sha1(origin->tree->object.sha1,
-		       head->tree->object.sha1,
+	diff_tree_sha1(get_object_hash(origin->tree->object),
+		       get_object_hash(head->tree->object),
 		       "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
@@ -1613,12 +1613,12 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 {
 	if (!verbose) {
 		printf("%c %s\n", sign,
-		       find_unique_abbrev(commit->object.sha1, abbrev));
+		       find_unique_abbrev(get_object_hash(commit->object), abbrev));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
 		printf("%c %s %s\n", sign,
-		       find_unique_abbrev(commit->object.sha1, abbrev),
+		       find_unique_abbrev(get_object_hash(commit->object), abbrev),
 		       buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 2a4aafec..cf1cee1d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -60,7 +60,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	const char *path = entry->path;
 
 	if (!entry->stage)
-		return read_sha1_file(entry->blob->object.sha1, &type, size);
+		return read_sha1_file(get_object_hash(entry->blob->object), &type, size);
 	base = NULL;
 	if (entry->stage == 1) {
 		base = entry->blob;
@@ -82,7 +82,7 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 	enum object_type type;
 	while (entry) {
 		if (entry->stage == 2)
-			return read_sha1_file(entry->blob->object.sha1, &type, size);
+			return read_sha1_file(get_object_hash(entry->blob->object), &type, size);
 		entry = entry->link;
 	}
 	return NULL;
diff --git a/builtin/merge.c b/builtin/merge.c
index a0edacab..6c496382 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -365,7 +365,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	while ((commit = get_revision(&rev)) != NULL) {
 		strbuf_addch(&out, '\n');
 		strbuf_addf(&out, "commit %s\n",
-			sha1_to_hex(commit->object.sha1));
+			sha1_to_hex(get_object_hash(commit->object)));
 		pretty_print_commit(&ctx, commit, &out);
 	}
 	if (write_in_full(fd, out.buf, out.len) != out.len)
@@ -380,7 +380,7 @@ static void finish(struct commit *head_commit,
 		   const unsigned char *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
-	const unsigned char *head = head_commit->object.sha1;
+	const unsigned char *head = get_object_hash(head_commit->object);
 
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
@@ -497,7 +497,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		if (ref_exists(truname.buf)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
-				    sha1_to_hex(remote_head->object.sha1),
+				    sha1_to_hex(get_object_hash(remote_head->object)),
 				    truname.buf + 11,
 				    (early ? " (early part)" : ""));
 			strbuf_release(&truname);
@@ -511,7 +511,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		desc = merge_remote_util(remote_head);
 		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
 			strbuf_addf(msg, "%s\t\t%s '%s'\n",
-				    sha1_to_hex(desc->obj->sha1),
+				    sha1_to_hex(get_object_hash(*desc->obj)),
 				    typename(desc->obj->type),
 				    remote);
 			goto cleanup;
@@ -519,7 +519,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	}
 
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
-		sha1_to_hex(remote_head->object.sha1), remote);
+		sha1_to_hex(get_object_hash(remote_head->object)), remote);
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&bname);
@@ -892,7 +892,7 @@ static struct commit *is_old_style_invocation(int argc, const char **argv,
 		second_token = lookup_commit_reference_gently(second_sha1, 0);
 		if (!second_token)
 			die(_("'%s' is not a commit"), argv[1]);
-		if (hashcmp(second_token->object.sha1, head))
+		if (hashcmp(get_object_hash(second_token->object), head))
 			return NULL;
 	}
 	return second_token;
@@ -963,7 +963,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 		if (c->util && merge_remote_util(c)->obj) {
 			sha1 = merge_remote_util(c)->obj->sha1;
 		} else {
-			sha1 = c->object.sha1;
+			sha1 = get_object_hash(c->object);
 		}
 		strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
 	}
@@ -1276,8 +1276,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("%s - not something we can merge"), argv[0]);
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
-		read_empty(remote_head->object.sha1, 0);
-		update_ref("initial pull", "HEAD", remote_head->object.sha1,
+		read_empty(get_object_hash(remote_head->object), 0);
+		update_ref("initial pull", "HEAD", get_object_hash(remote_head->object),
 			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	}
@@ -1291,7 +1291,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * additional safety measure to check for it.
 	 */
 	if (!have_message &&
-	    is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
+	    is_old_style_invocation(argc, argv, get_object_hash(head_commit->object))) {
 		warning("old-style 'git merge <msg> HEAD <commit>' is deprecated.");
 		strbuf_addstr(&merge_msg, argv[0]);
 		head_arg = argv[1];
@@ -1325,7 +1325,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 			check_commit_signature(commit, &signature_check);
 
-			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+			strcpy(hex, find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV));
 			switch (signature_check.result) {
 			case 'G':
 				break;
@@ -1355,7 +1355,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	for (p = remoteheads; p; p = p->next) {
 		struct commit *commit = p->item;
 		strbuf_addf(&buf, "GITHEAD_%s",
-			    sha1_to_hex(commit->object.sha1));
+			    sha1_to_hex(get_object_hash(commit->object)));
 		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
 		if (fast_forward != FF_ONLY &&
@@ -1395,7 +1395,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha1,
+	update_ref("updating ORIG_HEAD", "ORIG_HEAD", get_object_hash(head_commit->object),
 		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	if (remoteheads && !common)
@@ -1411,18 +1411,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
-			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
+			!hashcmp(get_object_hash(common->item->object), get_object_hash(head_commit->object))) {
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit;
 		char hex[41];
 
-		strcpy(hex, find_unique_abbrev(head_commit->object.sha1, DEFAULT_ABBREV));
+		strcpy(hex, find_unique_abbrev(get_object_hash(head_commit->object), DEFAULT_ABBREV));
 
 		if (verbosity >= 0)
 			printf(_("Updating %s..%s\n"),
 				hex,
-				find_unique_abbrev(remoteheads->item->object.sha1,
+				find_unique_abbrev(get_object_hash(remoteheads->item->object),
 				DEFAULT_ABBREV));
 		strbuf_addstr(&msg, "Fast-forward");
 		if (have_message)
@@ -1434,14 +1434,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		if (checkout_fast_forward(head_commit->object.sha1,
-					  commit->object.sha1,
+		if (checkout_fast_forward(get_object_hash(head_commit->object),
+					  get_object_hash(commit->object),
 					  overwrite_ignore)) {
 			ret = 1;
 			goto done;
 		}
 
-		finish(head_commit, remoteheads, commit->object.sha1, msg.buf);
+		finish(head_commit, remoteheads, get_object_hash(commit->object), msg.buf);
 		drop_save();
 		goto done;
 	} else if (!remoteheads->next && common->next)
@@ -1460,9 +1460,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
-			if (!read_tree_trivial(common->item->object.sha1,
-					       head_commit->object.sha1,
-					       remoteheads->item->object.sha1)) {
+			if (!read_tree_trivial(get_object_hash(common->item->object),
+					       get_object_hash(head_commit->object),
+					       get_object_hash(remoteheads->item->object))) {
 				ret = merge_trivial(head_commit, remoteheads);
 				goto done;
 			}
@@ -1485,8 +1485,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * HEAD^^" would be missed.
 			 */
 			common_one = get_merge_bases(head_commit, j->item);
-			if (hashcmp(common_one->item->object.sha1,
-				j->item->object.sha1)) {
+			if (hashcmp(get_object_hash(common_one->item->object),
+				get_object_hash(j->item->object))) {
 				up_to_date = 0;
 				break;
 			}
@@ -1522,7 +1522,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		int ret;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
-			restore_state(head_commit->object.sha1, stash);
+			restore_state(get_object_hash(head_commit->object), stash);
 		}
 		if (use_strategies_nr != 1)
 			printf(_("Trying merge strategy %s...\n"),
@@ -1588,7 +1588,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * it up.
 	 */
 	if (!best_strategy) {
-		restore_state(head_commit->object.sha1, stash);
+		restore_state(get_object_hash(head_commit->object), stash);
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
 				_("No merge strategy handled the merge.\n"));
@@ -1601,7 +1601,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		; /* We already have its result in the working tree. */
 	else {
 		printf(_("Rewinding the tree to pristine...\n"));
-		restore_state(head_commit->object.sha1, stash);
+		restore_state(get_object_hash(head_commit->object), stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
 		try_merge_strategy(best_strategy, common, remoteheads,
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 248a3eb2..626c4fd8 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -166,7 +166,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
-		o = parse_object(t->tagged->sha1);
+		o = parse_object(get_object_hash(*t->tagged));
 		deref = 1;
 	}
 	if (o && o->type == OBJ_COMMIT) {
@@ -197,7 +197,7 @@ static const char *get_exact_ref_match(const struct object *o)
 		tip_table.sorted = 1;
 	}
 
-	found = sha1_pos(o->sha1, tip_table.table, tip_table.nr,
+	found = sha1_pos(get_object_hash(*o), tip_table.table, tip_table.nr,
 			 nth_tip_table_ent);
 	if (0 <= found)
 		return tip_table.table[found].refname;
@@ -236,7 +236,7 @@ static void show_name(const struct object *obj,
 		      int always, int allow_undefined, int name_only)
 {
 	const char *name;
-	const unsigned char *sha1 = obj->sha1;
+	const unsigned char *sha1 = get_object_hash(*obj);
 
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : sha1_to_hex(sha1));
diff --git a/builtin/notes.c b/builtin/notes.c
index 3608c647..4c0cfc56 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -707,7 +707,7 @@ static int merge_commit(struct notes_merge_options *o)
 		die("Could not parse commit from NOTES_MERGE_PARTIAL.");
 
 	if (partial->parents)
-		hashcpy(parent_sha1, partial->parents->item->object.sha1);
+		hashcpy(parent_sha1, get_object_hash(partial->parents->item->object));
 	else
 		hashclr(parent_sha1);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1c63f8f2..b2d3e4ea 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2277,7 +2277,7 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, void *data)
 {
-	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
+	add_object_entry(get_object_hash(commit->object), OBJ_COMMIT, NULL, 0);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
@@ -2291,7 +2291,7 @@ static void show_object(struct object *obj,
 	char *name = path_name(path, last);
 
 	add_preferred_base_object(name);
-	add_object_entry(obj->sha1, obj->type, name, 0);
+	add_object_entry(get_object_hash(*obj), obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
 
 	/*
@@ -2303,7 +2303,7 @@ static void show_object(struct object *obj,
 
 static void show_edge(struct commit *commit)
 {
-	add_preferred_base(commit->object.sha1);
+	add_preferred_base(get_object_hash(commit->object));
 }
 
 struct in_pack_object {
@@ -2319,7 +2319,7 @@ struct in_pack {
 
 static void mark_in_pack_object(struct object *object, struct packed_git *p, struct in_pack *in_pack)
 {
-	in_pack->array[in_pack->nr].offset = find_pack_entry_one(object->sha1, p);
+	in_pack->array[in_pack->nr].offset = find_pack_entry_one(get_object_hash(*object), p);
 	in_pack->array[in_pack->nr].object = object;
 	in_pack->nr++;
 }
@@ -2376,7 +2376,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		      ofscmp);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
-			add_object_entry(o->sha1, o->type, "", 0);
+			add_object_entry(get_object_hash(*o), o->type, "", 0);
 		}
 	}
 	free(in_pack.array);
@@ -2484,12 +2484,12 @@ static void record_recent_object(struct object *obj,
 				 const char *last,
 				 void *data)
 {
-	sha1_array_append(&recent_objects, obj->sha1);
+	sha1_array_append(&recent_objects, get_object_hash(*obj));
 }
 
 static void record_recent_commit(struct commit *commit, void *data)
 {
-	sha1_array_append(&recent_objects, commit->object.sha1);
+	sha1_array_append(&recent_objects, get_object_hash(commit->object));
 }
 
 static void get_object_list(int ac, const char **av)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index f96ca2a2..850fec7b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -126,7 +126,7 @@ static int commit_is_complete(struct commit *commit)
 		struct commit_list *parent;
 
 		c = (struct commit *)study.objects[--study.nr].item;
-		if (!c->object.parsed && !parse_object(c->object.sha1))
+		if (!c->object.parsed && !parse_object(get_object_hash(c->object)))
 			c->object.flags |= INCOMPLETE;
 
 		if (c->object.flags & INCOMPLETE) {
@@ -152,7 +152,7 @@ static int commit_is_complete(struct commit *commit)
 		for (i = 0; i < found.nr; i++) {
 			struct commit *c =
 				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(c->tree->object.sha1)) {
+			if (!tree_is_complete(get_object_hash(c->tree->object))) {
 				is_incomplete = 1;
 				c->object.flags |= INCOMPLETE;
 			}
diff --git a/builtin/reset.c b/builtin/reset.c
index c503e75a..9b889881 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -96,7 +96,7 @@ static void print_new_head_line(struct commit *commit)
 	const char *hex, *body;
 	const char *msg;
 
-	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	hex = find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
 	msg = logmsg_reencode(commit, NULL, get_log_output_encoding());
 	body = strstr(msg, "\n\n");
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d80d1ed3..487dba1d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -81,7 +81,7 @@ static void show_commit(struct commit *commit, void *data)
 	if (!revs->graph)
 		fputs(get_revision_mark(revs, commit), stdout);
 	if (revs->abbrev_commit && revs->abbrev)
-		fputs(find_unique_abbrev(commit->object.sha1, revs->abbrev),
+		fputs(find_unique_abbrev(get_object_hash(commit->object), revs->abbrev),
 		      stdout);
 	else
 		fputs(sha1_to_hex(commit->object.sha1), stdout);
@@ -185,7 +185,7 @@ static void finish_object(struct object *obj,
 	if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
 		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
-		parse_object(obj->sha1);
+		parse_object(get_object_hash(*obj));
 }
 
 static void show_object(struct object *obj,
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02d747dc..97075f09 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -283,7 +283,7 @@ static int try_difference(const char *arg)
 			while (exclude) {
 				struct commit_list *n = exclude->next;
 				show_rev(REVERSED,
-					 exclude->item->object.sha1,NULL);
+					 get_object_hash(exclude->item->object),NULL);
 				free(exclude);
 				exclude = n;
 			}
@@ -322,7 +322,7 @@ static int try_parent_shorthands(const char *arg)
 	commit = lookup_commit_reference(sha1);
 	for (parents = commit->parents; parents; parents = parents->next)
 		show_rev(parents_only ? NORMAL : REVERSED,
-				parents->item->object.sha1, arg);
+				get_object_hash(parents->item->object), arg);
 
 	*dotdot = '^';
 	return 1;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 408ce703..ac942fb3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -303,7 +303,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 		}
 		else
 			printf("[%s] ",
-			       find_unique_abbrev(commit->object.sha1,
+			       find_unique_abbrev(get_object_hash(commit->object),
 						  DEFAULT_ABBREV));
 	}
 	puts(pretty_str);
@@ -884,7 +884,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 						  head_len,
 						  ref_name[i],
 						  head_oid.hash,
-						  rev[i]->object.sha1);
+						  get_object_hash(rev[i]->object));
 			if (extra < 0)
 				printf("%c [%s] ",
 				       is_head ? '*' : ' ', ref_name[i]);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7cc086f5..c86ba1ff 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -194,7 +194,7 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 
 	if (!(obj->flags & FLAG_OPEN)) {
 		unsigned long size;
-		int type = sha1_object_info(obj->sha1, &size);
+		int type = sha1_object_info(get_object_hash(*obj), &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
diff --git a/bundle.c b/bundle.c
index b9dacc02..d4f52cfd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -217,7 +217,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	if (revs->max_age == -1 && revs->min_age == -1)
 		goto out;
 
-	buf = read_sha1_file(tag->sha1, &type, &size);
+	buf = read_sha1_file(get_object_hash(*tag), &type, &size);
 	if (!buf)
 		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
diff --git a/cache-tree.c b/cache-tree.c
index feace8bd..6bca415d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -657,7 +657,7 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 	struct name_entry entry;
 	int cnt;
 
-	hashcpy(it->sha1, tree->object.sha1);
+	hashcpy(it->sha1, get_object_hash(tree->object));
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
diff --git a/combine-diff.c b/combine-diff.c
index 0f62f54b..e7e3411d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1540,9 +1540,9 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
 	struct sha1_array parents = SHA1_ARRAY_INIT;
 
 	while (parent) {
-		sha1_array_append(&parents, parent->item->object.sha1);
+		sha1_array_append(&parents, get_object_hash(parent->item->object));
 		parent = parent->next;
 	}
-	diff_tree_combined(commit->object.sha1, &parents, dense, rev);
+	diff_tree_combined(get_object_hash(commit->object), &parents, dense, rev);
 	sha1_array_clear(&parents);
 }
diff --git a/commit.c b/commit.c
index 494615d6..8c29374d 100644
--- a/commit.c
+++ b/commit.c
@@ -38,7 +38,7 @@ struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_n
 	struct commit *c = lookup_commit_reference(sha1);
 	if (!c)
 		die(_("could not parse %s"), ref_name);
-	if (hashcmp(sha1, c->object.sha1)) {
+	if (hashcmp(sha1, get_object_hash(c->object))) {
 		warning(_("%s %s is not a commit!"),
 			ref_name, sha1_to_hex(sha1));
 	}
@@ -262,7 +262,7 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_sha1_file(commit->object.sha1, &type, &size);
+		ret = read_sha1_file(get_object_hash(commit->object), &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    sha1_to_hex(commit->object.sha1));
@@ -335,7 +335,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(item->object.sha1);
+	graft = lookup_commit_graft(get_object_hash(item->object));
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -380,7 +380,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, &type, &size);
+	buffer = read_sha1_file(get_object_hash(item->object), &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
@@ -570,7 +570,7 @@ void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
 
 	for (i = 0; i < a->nr; i++) {
 		object = a->objects[i].item;
-		commit = lookup_commit_reference_gently(object->sha1, 1);
+		commit = lookup_commit_reference_gently(get_object_hash(*object), 1);
 		if (commit)
 			clear_commit_marks(commit, mark);
 	}
@@ -1215,7 +1215,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	desc = merge_remote_util(parent);
 	if (!desc || !desc->obj)
 		return;
-	buf = read_sha1_file(desc->obj->sha1, &type, &size);
+	buf = read_sha1_file(get_object_hash(*desc->obj), &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
 	len = parse_signature(buf, size);
diff --git a/decorate.c b/decorate.c
index b2aac90c..e339a729 100644
--- a/decorate.c
+++ b/decorate.c
@@ -8,7 +8,7 @@
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
-	return sha1hash(obj->sha1) % n;
+	return sha1hash(get_object_hash(*obj)) % n;
 }
 
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
diff --git a/diff-lib.c b/diff-lib.c
index 241a8435..409c8b34 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -493,7 +493,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	struct object_array_entry *ent;
 
 	ent = revs->pending.objects;
-	if (diff_cache(revs, ent->item->sha1, ent->name, cached))
+	if (diff_cache(revs, get_object_hash(*ent->item), ent->name, cached))
 		exit(128);
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
diff --git a/fetch-pack.c b/fetch-pack.c
index ec5a4c70..defbc12e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -169,7 +169,7 @@ static const unsigned char *get_rev(void)
 		}
 	}
 
-	return commit->object.sha1;
+	return get_object_hash(commit->object);
 }
 
 enum ack_type {
@@ -487,7 +487,7 @@ static int mark_complete(const unsigned char *sha1)
 		if (!t->tagged)
 			break; /* broken repository */
 		o->flags |= COMPLETE;
-		o = parse_object(t->tagged->sha1);
+		o = parse_object(get_object_hash(*t->tagged));
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
diff --git a/fsck.c b/fsck.c
index e41e753d..baa7f298 100644
--- a/fsck.c
+++ b/fsck.c
@@ -276,7 +276,7 @@ static int report(struct fsck_options *options, struct object *object,
 		return 0;
 
 	if (options->skiplist && object &&
-			sha1_array_lookup(options->skiplist, object->sha1) >= 0)
+			sha1_array_lookup(options->skiplist, get_object_hash(*object)) >= 0)
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
@@ -630,7 +630,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		buffer += 41;
 		parent_line_count++;
 	}
-	graft = lookup_commit_graft(commit->object.sha1);
+	graft = lookup_commit_graft(get_object_hash(commit->object));
 	parent_count = commit_list_count(commit->parents);
 	if (graft) {
 		if (graft->nr_parent == -1 && !parent_count)
@@ -696,7 +696,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		enum object_type type;
 
 		buffer = to_free =
-			read_sha1_file(tag->object.sha1, &type, &size);
+			read_sha1_file(get_object_hash(tag->object), &type, &size);
 		if (!buffer)
 			return report(options, &tag->object,
 				FSCK_MSG_MISSING_TAG_OBJECT,
diff --git a/http-push.c b/http-push.c
index 0e688a76..35fe7ebc 100644
--- a/http-push.c
+++ b/http-push.c
@@ -250,7 +250,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	struct active_request_slot *slot;
 	struct http_object_request *obj_req;
 
-	obj_req = new_http_object_request(repo->url, request->obj->sha1);
+	obj_req = new_http_object_request(repo->url, get_object_hash(*request->obj));
 	if (obj_req == NULL) {
 		request->state = ABORTED;
 		return;
@@ -303,7 +303,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	struct transfer_request *check_request = request_queue_head;
 	struct http_pack_request *preq;
 
-	target = find_sha1_pack(request->obj->sha1, repo->packs);
+	target = find_sha1_pack(get_object_hash(*request->obj), repo->packs);
 	if (!target) {
 		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", sha1_to_hex(request->obj->sha1));
 		repo->can_update_info_refs = 0;
@@ -360,7 +360,7 @@ static void start_put(struct transfer_request *request)
 	ssize_t size;
 	git_zstream stream;
 
-	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
+	unpacked = read_sha1_file(get_object_hash(*request->obj), &type, &len);
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
@@ -532,7 +532,7 @@ static void finish_request(struct transfer_request *request)
 	if (request->state == RUN_MKCOL) {
 		if (request->curl_result == CURLE_OK ||
 		    request->http_code == 405) {
-			remote_dir_exists[request->obj->sha1[0]] = 1;
+			remote_dir_exists[get_object_hash(*request->obj)[0]] = 1;
 			start_put(request);
 		} else {
 			fprintf(stderr, "MKCOL %s failed, aborting (%d/%ld)\n",
@@ -613,7 +613,7 @@ static int fill_active_slot(void *unused)
 			start_fetch_loose(request);
 			return 1;
 		} else if (pushing && request->state == NEED_PUSH) {
-			if (remote_dir_exists[request->obj->sha1[0]] == 1) {
+			if (remote_dir_exists[get_object_hash(*request->obj)[0]] == 1) {
 				start_put(request);
 			} else {
 				start_mkcol(request);
@@ -637,8 +637,8 @@ static void add_fetch_request(struct object *obj)
 	 * Don't fetch the object if it's known to exist locally
 	 * or is already in the request queue
 	 */
-	if (remote_dir_exists[obj->sha1[0]] == -1)
-		get_remote_object_list(obj->sha1[0]);
+	if (remote_dir_exists[get_object_hash(*obj)[0]] == -1)
+		get_remote_object_list(get_object_hash(*obj)[0]);
 	if (obj->flags & (LOCAL | FETCHING))
 		return;
 
@@ -670,11 +670,11 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	 * Don't push the object if it's known to exist on the remote
 	 * or is already in the request queue
 	 */
-	if (remote_dir_exists[obj->sha1[0]] == -1)
-		get_remote_object_list(obj->sha1[0]);
+	if (remote_dir_exists[get_object_hash(*obj)[0]] == -1)
+		get_remote_object_list(get_object_hash(*obj)[0]);
 	if (obj->flags & (REMOTE | PUSHING))
 		return 0;
-	target = find_sha1_pack(obj->sha1, repo->packs);
+	target = find_sha1_pack(get_object_hash(*obj), repo->packs);
 	if (target) {
 		obj->flags |= REMOTE;
 		return 0;
diff --git a/line-log.c b/line-log.c
index 626b22cc..0d409504 100644
--- a/line-log.c
+++ b/line-log.c
@@ -502,7 +502,7 @@ static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
 	unsigned mode;
 	unsigned char sha1[20];
 
-	if (get_tree_entry(commit->object.sha1, spec->path,
+	if (get_tree_entry(get_object_hash(commit->object), spec->path,
 			   sha1, &mode))
 		die("There is no path %s in the commit", spec->path);
 	fill_filespec(spec, sha1, 1, mode);
@@ -824,8 +824,8 @@ static void queue_diffs(struct line_log_data *range,
 	assert(commit);
 
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree_sha1(parent ? parent->tree->object.sha1 : NULL,
-			commit->tree->object.sha1, "", opt);
+	diff_tree_sha1(parent ? get_object_hash(parent->tree->object) : NULL,
+			get_object_hash(commit->tree->object), "", opt);
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
diff --git a/log-tree.c b/log-tree.c
index 7b1b57aa..947c099f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -133,7 +133,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		if (!obj)
 			break;
 		if (!obj->parsed)
-			parse_object(obj->sha1);
+			parse_object(get_object_hash(*obj));
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
@@ -165,7 +165,7 @@ static void show_parents(struct commit *commit, int abbrev)
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
-		printf(" %s", find_unique_abbrev(parent->object.sha1, abbrev));
+		printf(" %s", find_unique_abbrev(get_object_hash(parent->object), abbrev));
 	}
 }
 
@@ -173,7 +173,7 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 {
 	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
 	for ( ; p; p = p->next) {
-		printf(" %s", find_unique_abbrev(p->item->object.sha1, abbrev));
+		printf(" %s", find_unique_abbrev(get_object_hash(p->item->object), abbrev));
 	}
 }
 
@@ -469,7 +469,7 @@ static int which_parent(const unsigned char *sha1, const struct commit *commit)
 	const struct commit_list *parent;
 
 	for (nth = 0, parent = commit->parents; parent; parent = parent->next) {
-		if (!hashcmp(parent->item->object.sha1, sha1))
+		if (!hashcmp(get_object_hash(parent->item->object), sha1))
 			return nth;
 		nth++;
 	}
@@ -507,9 +507,9 @@ static void show_one_mergetag(struct commit *commit,
 			  commit->parents->next->item->object.sha1))
 		strbuf_addf(&verify_message,
 			    "merged tag '%s'\n", tag->tag);
-	else if ((nth = which_parent(tag->tagged->sha1, commit)) < 0)
+	else if ((nth = which_parent(get_object_hash(*tag->tagged), commit)) < 0)
 		strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
-				    tag->tag, tag->tagged->sha1);
+				    tag->tag, get_object_hash(*tag->tagged));
 	else
 		strbuf_addf(&verify_message,
 			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
@@ -553,7 +553,7 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
+		fputs(find_unique_abbrev(get_object_hash(commit->object), abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (opt->children.name)
@@ -613,7 +613,7 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit),
+		fputs(find_unique_abbrev(get_object_hash(commit->object), abbrev_commit),
 		      stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
@@ -621,7 +621,7 @@ void show_log(struct rev_info *opt)
 			show_children(opt, commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
-			       find_unique_abbrev(parent->object.sha1,
+			       find_unique_abbrev(get_object_hash(parent->object),
 						  abbrev_commit));
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), stdout);
 		show_decorations(opt, commit);
@@ -660,7 +660,7 @@ void show_log(struct rev_info *opt)
 		struct strbuf notebuf = STRBUF_INIT;
 
 		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
-		format_display_notes(commit->object.sha1, &notebuf,
+		format_display_notes(get_object_hash(commit->object), &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = notebuf.len
 			? strbuf_detach(&notebuf, NULL)
diff --git a/merge-blobs.c b/merge-blobs.c
index 7abb894c..0963a482 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -11,7 +11,7 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 	unsigned long size;
 	enum object_type type;
 
-	buf = read_sha1_file(obj->object.sha1, &type, &size);
+	buf = read_sha1_file(get_object_hash(obj->object), &type, &size);
 	if (!buf)
 		return -1;
 	if (type != OBJ_BLOB) {
@@ -100,7 +100,7 @@ void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct
 			return NULL;
 		if (!our)
 			our = their;
-		return read_sha1_file(our->object.sha1, &type, size);
+		return read_sha1_file(get_object_hash(our->object), &type, size);
 	}
 
 	if (fill_mmfile_blob(&f1, our) < 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index 44d85bea..b522157c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -29,9 +29,9 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	unsigned char shifted[20];
 
 	if (!*subtree_shift) {
-		shift_tree(one->object.sha1, two->object.sha1, shifted, 0);
+		shift_tree(get_object_hash(one->object), get_object_hash(two->object), shifted, 0);
 	} else {
-		shift_tree_by(one->object.sha1, two->object.sha1, shifted,
+		shift_tree_by(get_object_hash(one->object), get_object_hash(two->object), shifted,
 			      subtree_shift);
 	}
 	if (!hashcmp(two->object.sha1, shifted))
@@ -184,7 +184,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 	if (commit->util)
 		printf("virtual %s\n", merge_remote_util(commit)->name);
 	else {
-		printf("%s ", find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+		printf("%s ", find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
 			printf(_("(bad commit)\n"));
 		else {
@@ -313,11 +313,11 @@ static struct stage_data *insert_stage_data(const char *path,
 {
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
-	get_tree_entry(o->object.sha1, path,
+	get_tree_entry(get_object_hash(o->object), path,
 			e->stages[1].sha, &e->stages[1].mode);
-	get_tree_entry(a->object.sha1, path,
+	get_tree_entry(get_object_hash(a->object), path,
 			e->stages[2].sha, &e->stages[2].mode);
-	get_tree_entry(b->object.sha1, path,
+	get_tree_entry(get_object_hash(b->object), path,
 			e->stages[3].sha, &e->stages[3].mode);
 	item = string_list_insert(entries, path);
 	item->util = e;
@@ -493,7 +493,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.show_rename_progress = o->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opts);
-	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
+	diff_tree_sha1(get_object_hash(o_tree->object), get_object_hash(tree->object), "", &opts);
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
 		o->needed_rename_limit = opts.needed_rename_limit;
@@ -1809,7 +1809,7 @@ int merge_trees(struct merge_options *o,
 		common = shift_tree_object(head, common, o->subtree_shift);
 	}
 
-	if (sha_eq(common->object.sha1, merge->object.sha1)) {
+	if (sha_eq(get_object_hash(common->object), get_object_hash(merge->object))) {
 		output(o, 0, _("Already up-to-date!"));
 		*result = head;
 		return 1;
diff --git a/notes-merge.c b/notes-merge.c
index b3d1dab5..21e1eb4c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -602,15 +602,15 @@ int notes_merge(struct notes_merge_options *o,
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
-		base_sha1 = bases->item->object.sha1;
-		base_tree_sha1 = bases->item->tree->object.sha1;
+		base_sha1 = get_object_hash(bases->item->object);
+		base_tree_sha1 = get_object_hash(bases->item->tree->object);
 		if (o->verbosity >= 4)
 			printf("One merge base found (%.7s)\n",
 				sha1_to_hex(base_sha1));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
-		base_sha1 = bases->item->object.sha1;
-		base_tree_sha1 = bases->item->tree->object.sha1;
+		base_sha1 = get_object_hash(bases->item->object);
+		base_tree_sha1 = get_object_hash(bases->item->tree->object);
 		if (o->verbosity >= 3)
 			printf("Multiple merge bases found. Using the first "
 				"(%.7s)\n", sha1_to_hex(base_sha1));
@@ -622,23 +622,23 @@ int notes_merge(struct notes_merge_options *o,
 			sha1_to_hex(local->object.sha1),
 			sha1_to_hex(base_sha1));
 
-	if (!hashcmp(remote->object.sha1, base_sha1)) {
+	if (!hashcmp(get_object_hash(remote->object), base_sha1)) {
 		/* Already merged; result == local commit */
 		if (o->verbosity >= 2)
 			printf("Already up-to-date!\n");
-		hashcpy(result_sha1, local->object.sha1);
+		hashcpy(result_sha1, get_object_hash(local->object));
 		goto found_result;
 	}
-	if (!hashcmp(local->object.sha1, base_sha1)) {
+	if (!hashcmp(get_object_hash(local->object), base_sha1)) {
 		/* Fast-forward; result == remote commit */
 		if (o->verbosity >= 2)
 			printf("Fast-forward\n");
-		hashcpy(result_sha1, remote->object.sha1);
+		hashcpy(result_sha1, get_object_hash(remote->object));
 		goto found_result;
 	}
 
-	result = merge_from_diffs(o, base_tree_sha1, local->tree->object.sha1,
-				  remote->tree->object.sha1, local_tree);
+	result = merge_from_diffs(o, base_tree_sha1, get_object_hash(local->tree->object),
+				  get_object_hash(remote->tree->object), local_tree);
 
 	if (result != 0) { /* non-trivial merge (with or without conflicts) */
 		/* Commit (partial) result */
diff --git a/object.c b/object.c
index 980ac5fc..4a0f4138 100644
--- a/object.c
+++ b/object.c
@@ -68,7 +68,7 @@ static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
  */
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	unsigned int j = hash_obj(obj->sha1, size);
+	unsigned int j = hash_obj(get_object_hash(*obj), size);
 
 	while (hash[j]) {
 		j++;
@@ -92,7 +92,7 @@ struct object *lookup_object(const unsigned char *sha1)
 
 	first = i = hash_obj(sha1, obj_hash_size);
 	while ((obj = obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->sha1))
+		if (!hashcmp(sha1, get_object_hash(*obj)))
 			break;
 		i++;
 		if (i == obj_hash_size)
@@ -145,7 +145,7 @@ void *create_object(const unsigned char *sha1, void *o)
 	obj->parsed = 0;
 	obj->used = 0;
 	obj->flags = 0;
-	hashcpy(obj->sha1, sha1);
+	hashcpy(get_object_hash(*obj), sha1);
 
 	if (obj_hash_size - 1 <= nr_objs * 2)
 		grow_object_hash();
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c05d1386..03f19266 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -152,7 +152,7 @@ static void show_object(struct object *object, const struct name_path *path,
 			const char *last, void *data)
 {
 	struct bitmap *base = data;
-	bitmap_set(base, find_object_pos(object->sha1));
+	bitmap_set(base, find_object_pos(get_object_hash(*object)));
 	mark_as_seen(object);
 }
 
@@ -165,12 +165,12 @@ static int
 add_to_include_set(struct bitmap *base, struct commit *commit)
 {
 	khiter_t hash_pos;
-	uint32_t bitmap_pos = find_object_pos(commit->object.sha1);
+	uint32_t bitmap_pos = find_object_pos(get_object_hash(commit->object));
 
 	if (bitmap_get(base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_sha1(writer.bitmaps, commit->object.sha1);
+	hash_pos = kh_get_sha1(writer.bitmaps, get_object_hash(commit->object));
 	if (hash_pos < kh_end(writer.bitmaps)) {
 		struct bitmapped_commit *bc = kh_value(writer.bitmaps, hash_pos);
 		bitmap_or_ewah(base, bc->bitmap);
@@ -308,7 +308,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		if (i >= reuse_after)
 			stored->flags |= BITMAP_FLAG_REUSE;
 
-		hash_pos = kh_put_sha1(writer.bitmaps, object->sha1, &hash_ret);
+		hash_pos = kh_put_sha1(writer.bitmaps, get_object_hash(*object), &hash_ret);
 		if (hash_ret == 0)
 			die("Duplicate entry when writing index: %s",
 			    sha1_to_hex(object->sha1));
@@ -414,14 +414,14 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 		if (next == 0) {
 			chosen = indexed_commits[i];
-			reused_bitmap = find_reused_bitmap(chosen->object.sha1);
+			reused_bitmap = find_reused_bitmap(get_object_hash(chosen->object));
 		} else {
 			chosen = indexed_commits[i + next];
 
 			for (j = 0; j <= next; ++j) {
 				struct commit *cm = indexed_commits[i + j];
 
-				reused_bitmap = find_reused_bitmap(cm->object.sha1);
+				reused_bitmap = find_reused_bitmap(get_object_hash(cm->object));
 				if (reused_bitmap || (cm->object.flags & NEEDS_BITMAP) != 0) {
 					chosen = cm;
 					break;
@@ -474,7 +474,7 @@ static void write_selected_commits_v1(struct sha1file *f,
 		struct bitmapped_commit *stored = &writer.selected[i];
 
 		int commit_pos =
-			sha1_pos(stored->commit->object.sha1, index, index_nr, sha1_access);
+			sha1_pos(get_object_hash(stored->commit->object), index, index_nr, sha1_access);
 
 		if (commit_pos < 0)
 			die("BUG: trying to write commit not in index");
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 637770af..611b455d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -402,7 +402,7 @@ static int ext_index_add_object(struct object *object, const char *name)
 	int hash_ret;
 	int bitmap_pos;
 
-	hash_pos = kh_put_sha1_pos(eindex->positions, object->sha1, &hash_ret);
+	hash_pos = kh_put_sha1_pos(eindex->positions, get_object_hash(*object), &hash_ret);
 	if (hash_ret > 0) {
 		if (eindex->count >= eindex->alloc) {
 			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
@@ -428,7 +428,7 @@ static void show_object(struct object *object, const struct name_path *path,
 	struct bitmap *base = data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(object->sha1);
+	bitmap_pos = bitmap_position(get_object_hash(*object));
 
 	if (bitmap_pos < 0) {
 		char *name = path_name(path, last);
@@ -471,11 +471,11 @@ static int should_include(struct commit *commit, void *_data)
 	struct include_data *data = _data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(commit->object.sha1);
+	bitmap_pos = bitmap_position(get_object_hash(commit->object));
 	if (bitmap_pos < 0)
 		bitmap_pos = ext_index_add_object((struct object *)commit, NULL);
 
-	if (!add_to_include_set(data, commit->object.sha1, bitmap_pos)) {
+	if (!add_to_include_set(data, get_object_hash(commit->object), bitmap_pos)) {
 		struct commit_list *parent = commit->parents;
 
 		while (parent) {
@@ -511,7 +511,7 @@ static struct bitmap *find_objects(struct rev_info *revs,
 		roots = roots->next;
 
 		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_sha1(bitmap_git.bitmaps, object->sha1);
+			khiter_t pos = kh_get_sha1(bitmap_git.bitmaps, get_object_hash(*object));
 
 			if (pos < kh_end(bitmap_git.bitmaps)) {
 				struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
@@ -553,7 +553,7 @@ static struct bitmap *find_objects(struct rev_info *revs,
 		int pos;
 
 		roots = roots->next;
-		pos = bitmap_position(object->sha1);
+		pos = bitmap_position(get_object_hash(*object));
 
 		if (pos < 0 || base == NULL || !bitmap_get(base, pos)) {
 			object->flags &= ~UNINTERESTING;
@@ -598,7 +598,7 @@ static void show_extended_objects(struct bitmap *objects,
 			continue;
 
 		obj = eindex->objects[i];
-		show_reach(obj->sha1, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(get_object_hash(*obj), obj->type, 0, eindex->hashes[i], NULL, 0);
 	}
 }
 
@@ -655,7 +655,7 @@ static int in_bitmapped_pack(struct object_list *roots)
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (find_pack_entry_one(object->sha1, bitmap_git.pack) > 0)
+		if (find_pack_entry_one(get_object_hash(*object), bitmap_git.pack) > 0)
 			return 1;
 	}
 
@@ -685,7 +685,7 @@ int prepare_bitmap_walk(struct rev_info *revs)
 		struct object *object = pending_e[i].item;
 
 		if (object->type == OBJ_NONE)
-			parse_object_or_die(object->sha1, NULL);
+			parse_object_or_die(get_object_hash(*object), NULL);
 
 		while (object->type == OBJ_TAG) {
 			struct tag *tag = (struct tag *) object;
@@ -697,7 +697,7 @@ int prepare_bitmap_walk(struct rev_info *revs)
 
 			if (!tag->tagged)
 				die("bad tag");
-			object = parse_object_or_die(tag->tagged->sha1, NULL);
+			object = parse_object_or_die(get_object_hash(*tag->tagged), NULL);
 		}
 
 		if (object->flags & UNINTERESTING)
@@ -909,7 +909,7 @@ static void test_show_object(struct object *object,
 	struct bitmap_test_data *tdata = data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(object->sha1);
+	bitmap_pos = bitmap_position(get_object_hash(*object));
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", sha1_to_hex(object->sha1));
 
@@ -922,7 +922,7 @@ static void test_show_commit(struct commit *commit, void *data)
 	struct bitmap_test_data *tdata = data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(commit->object.sha1);
+	bitmap_pos = bitmap_position(get_object_hash(commit->object));
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", sha1_to_hex(commit->object.sha1));
 
@@ -948,7 +948,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		bitmap_git.version, bitmap_git.entry_count);
 
 	root = revs->pending.objects[0].item;
-	pos = kh_get_sha1(bitmap_git.bitmaps, root->sha1);
+	pos = kh_get_sha1(bitmap_git.bitmaps, get_object_hash(*root));
 
 	if (pos < kh_end(bitmap_git.bitmaps)) {
 		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
diff --git a/patch-ids.c b/patch-ids.c
index bf81b923..83229a0d 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -8,10 +8,10 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
 	if (commit->parents)
-		diff_tree_sha1(commit->parents->item->object.sha1,
-		               commit->object.sha1, "", options);
+		diff_tree_sha1(get_object_hash(commit->parents->item->object),
+		               get_object_hash(commit->object), "", options);
 	else
-		diff_root_tree_sha1(commit->object.sha1, "", options);
+		diff_root_tree_sha1(get_object_hash(commit->object), "", options);
 	diffcore_std(options);
 	return diff_flush_patch_id(options, sha1);
 }
diff --git a/pretty.c b/pretty.c
index 151c2ae3..fc257ccc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -543,7 +543,7 @@ static void add_merge_info(const struct pretty_print_context *pp,
 		struct commit *p = parent->item;
 		const char *hex = NULL;
 		if (pp->abbrev)
-			hex = find_unique_abbrev(p->object.sha1, pp->abbrev);
+			hex = find_unique_abbrev(get_object_hash(p->object), pp->abbrev);
 		if (!hex)
 			hex = sha1_to_hex(p->object.sha1);
 		parent = parent->next;
@@ -1119,7 +1119,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
-		parse_object(commit->object.sha1);
+		parse_object(get_object_hash(commit->object));
 
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
@@ -1133,7 +1133,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 			return 1;
 		}
-		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
+		strbuf_addstr(sb, find_unique_abbrev(get_object_hash(commit->object),
 						     c->pretty_ctx->abbrev));
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
@@ -1162,7 +1162,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, find_unique_abbrev(
-					p->item->object.sha1,
+					get_object_hash(p->item->object),
 					c->pretty_ctx->abbrev));
 		}
 		c->abbrev_parent_hashes.len = sb->len -
diff --git a/ref-filter.c b/ref-filter.c
index fd839ac4..074aea5d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -376,7 +376,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = s;
 		}
 		else if (deref)
-			grab_objectname(name, obj->sha1, v);
+			grab_objectname(name, get_object_hash(*obj), v);
 	}
 }
 
@@ -1018,7 +1018,7 @@ static void populate_value(struct ref_array_item *ref)
 	 * If it is a tag object, see if we use a value that derefs
 	 * the object, and if we do grab the object it refers to.
 	 */
-	tagged = ((struct tag *)obj)->tagged->sha1;
+	tagged = get_object_hash(*((struct tag *)obj)->tagged);
 
 	/*
 	 * NEEDSWORK: This derefs tag only once, which
@@ -1244,7 +1244,7 @@ static const unsigned char *match_points_at(struct sha1_array *points_at,
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
-		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
+		tagged_sha1 = get_object_hash(*((struct tag *)obj)->tagged);
 	if (tagged_sha1 && sha1_array_lookup(points_at, tagged_sha1) >= 0)
 		return tagged_sha1;
 	return NULL;
diff --git a/refs.c b/refs.c
index dae50c4e..7fb7951e 100644
--- a/refs.c
+++ b/refs.c
@@ -1877,7 +1877,7 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
 	if (!o)
 		return PEEL_INVALID;
 
-	hashcpy(sha1, o->sha1);
+	hashcpy(sha1, get_object_hash(*o));
 	return PEEL_PEELED;
 }
 
diff --git a/revision.c b/revision.c
index af2a18ed..32a43e12 100644
--- a/revision.c
+++ b/revision.c
@@ -285,7 +285,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
-		object = parse_object(tag->tagged->sha1);
+		object = parse_object(get_object_hash(*tag->tagged));
 		if (!object) {
 			if (flags & UNINTERESTING)
 				return NULL;
@@ -513,7 +513,7 @@ static int rev_compare_tree(struct rev_info *revs,
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
+	if (diff_tree_sha1(get_object_hash(t1->object), get_object_hash(t2->object), "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
 	return tree_difference;
@@ -529,7 +529,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	retval = diff_tree_sha1(NULL, t1->object.sha1, "", &revs->pruning);
+	retval = diff_tree_sha1(NULL, get_object_hash(t1->object), "", &revs->pruning);
 
 	return retval >= 0 && (tree_difference == REV_TREE_SAME);
 }
@@ -1385,7 +1385,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 			break;
 		if (!((struct tag*)it)->tagged)
 			return 0;
-		hashcpy(sha1, ((struct tag*)it)->tagged->sha1);
+		hashcpy(sha1, get_object_hash(*((struct tag*)it)->tagged));
 	}
 	if (it->type != OBJ_COMMIT)
 		return 0;
@@ -1562,10 +1562,10 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 				a = (a_obj->type == OBJ_COMMIT
 				     ? (struct commit *)a_obj
-				     : lookup_commit_reference(a_obj->sha1));
+				     : lookup_commit_reference(get_object_hash(*a_obj)));
 				b = (b_obj->type == OBJ_COMMIT
 				     ? (struct commit *)b_obj
-				     : lookup_commit_reference(b_obj->sha1));
+				     : lookup_commit_reference(get_object_hash(*b_obj)));
 				if (!a || !b)
 					goto missing;
 				exclude = get_merge_bases(a, b);
@@ -2951,7 +2951,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (opt->show_notes) {
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(commit->object.sha1, &buf, encoding, 1);
+		format_display_notes(get_object_hash(commit->object), &buf, encoding, 1);
 	}
 
 	/*
@@ -2981,7 +2981,7 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_sha1_pack(commit->object.sha1))
+	if (revs->unpacked && has_sha1_pack(get_object_hash(commit->object)))
 		return commit_ignore;
 	if (revs->show_all)
 		return commit_show;
diff --git a/sequencer.c b/sequencer.c
index a0600aeb..968c1a5b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -346,7 +346,7 @@ static int is_index_unchanged(void)
 		if (cache_tree_update(&the_index, 0))
 			return error(_("Unable to update cache tree\n"));
 
-	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
+	return !hashcmp(active_cache_tree->sha1, get_object_hash(head_commit->tree->object));
 }
 
 /*
@@ -403,12 +403,12 @@ static int is_original_commit_empty(struct commit *commit)
 		if (parse_commit(parent))
 			return error(_("Could not parse parent commit %s\n"),
 				sha1_to_hex(parent->object.sha1));
-		ptree_sha1 = parent->tree->object.sha1;
+		ptree_sha1 = get_object_hash(parent->tree->object);
 	} else {
 		ptree_sha1 = EMPTY_TREE_SHA1_BIN; /* commit is root */
 	}
 
-	return !hashcmp(ptree_sha1, commit->tree->object.sha1);
+	return !hashcmp(ptree_sha1, get_object_hash(commit->tree->object));
 }
 
 /*
@@ -503,9 +503,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		parent = commit->parents->item;
 
 	if (opts->allow_ff &&
-	    ((parent && !hashcmp(parent->object.sha1, head)) ||
+	    ((parent && !hashcmp(get_object_hash(parent->object), head)) ||
 	     (!parent && unborn)))
-		return fast_forward_to(commit->object.sha1, head, unborn, opts);
+		return fast_forward_to(get_object_hash(commit->object), head, unborn, opts);
 
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
@@ -592,17 +592,17 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * write it at all.
 	 */
 	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.sha1, NULL,
+		update_ref(NULL, "CHERRY_PICK_HEAD", get_object_hash(commit->object), NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		update_ref(NULL, "REVERT_HEAD", commit->object.sha1, NULL,
+		update_ref(NULL, "REVERT_HEAD", get_object_hash(commit->object), NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 
 	if (res) {
 		error(opts->action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
-		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+		      find_unique_abbrev(get_object_hash(commit->object), DEFAULT_ABBREV),
 		      msg.subject);
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
@@ -664,7 +664,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		const char *commit_buffer = get_commit_buffer(cur->item, NULL);
-		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
+		sha1_abbrev = find_unique_abbrev(get_object_hash(cur->item->object), DEFAULT_ABBREV);
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
 			subject_len, subject);
diff --git a/sha1_name.c b/sha1_name.c
index da6874c1..5aadd04f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -606,13 +606,13 @@ static int get_parent(const char *name, int len,
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
-		hashcpy(result, commit->object.sha1);
+		hashcpy(result, get_object_hash(commit->object));
 		return 0;
 	}
 	p = commit->parents;
 	while (p) {
 		if (!--idx) {
-			hashcpy(result, p->item->object.sha1);
+			hashcpy(result, get_object_hash(p->item->object));
 			return 0;
 		}
 		p = p->next;
@@ -639,7 +639,7 @@ static int get_nth_ancestor(const char *name, int len,
 			return -1;
 		commit = commit->parents->item;
 	}
-	hashcpy(result, commit->object.sha1);
+	hashcpy(result, get_object_hash(commit->object));
 	return 0;
 }
 
@@ -649,7 +649,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	if (name && !namelen)
 		namelen = strlen(name);
 	while (1) {
-		if (!o || (!o->parsed && !parse_object(o->sha1)))
+		if (!o || (!o->parsed && !parse_object(get_object_hash(*o))))
 			return NULL;
 		if (expected_type == OBJ_ANY || o->type == expected_type)
 			return o;
@@ -726,7 +726,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		return -1;
 	if (!expected_type) {
 		o = deref_tag(o, name, sp - name - 2);
-		if (!o || (!o->parsed && !parse_object(o->sha1)))
+		if (!o || (!o->parsed && !parse_object(get_object_hash(*o))))
 			return -1;
 		hashcpy(sha1, o->sha1);
 		return 0;
@@ -741,7 +741,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	if (!o)
 		return -1;
 
-	hashcpy(sha1, o->sha1);
+	hashcpy(sha1, get_object_hash(*o));
 	if (sp[0] == '/') {
 		/* "$commit^{/foo}" */
 		char *prefix;
@@ -889,7 +889,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(commit->object.sha1))
+		if (!parse_object(get_object_hash(commit->object)))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
@@ -897,7 +897,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
-			hashcpy(sha1, commit->object.sha1);
+			hashcpy(sha1, get_object_hash(commit->object));
 			found = 1;
 			break;
 		}
diff --git a/shallow.c b/shallow.c
index d49a3d6e..55f2db6f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -106,7 +106,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		cur_depth++;
 		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
 		    (is_repository_shallow() && !commit->parents &&
-		     (graft = lookup_commit_graft(commit->object.sha1)) != NULL &&
+		     (graft = lookup_commit_graft(get_object_hash(commit->object))) != NULL &&
 		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
 			commit->object.flags |= shallow_flag;
diff --git a/submodule.c b/submodule.c
index 245ed4df..c56fdc14 100644
--- a/submodule.c
+++ b/submodule.c
@@ -602,7 +602,7 @@ static void calculate_changed_submodule_paths(void)
 			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
 			diff_opts.format_callback = submodule_collect_changed_cb;
 			diff_setup_done(&diff_opts);
-			diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
+			diff_tree_sha1(get_object_hash(parent->item->object), get_object_hash(commit->object), "", &diff_opts);
 			diffcore_std(&diff_opts);
 			diff_flush(&diff_opts);
 			parent = parent->next;
diff --git a/tag.c b/tag.c
index 5b0ac62e..88bc92b0 100644
--- a/tag.c
+++ b/tag.c
@@ -10,7 +10,7 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(((struct tag *)o)->tagged->sha1);
+			o = parse_object(get_object_hash(*((struct tag *)o)->tagged));
 		else
 			o = NULL;
 	if (!o && warn) {
@@ -24,7 +24,7 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 struct object *deref_tag_noverify(struct object *o)
 {
 	while (o && o->type == OBJ_TAG) {
-		o = parse_object(o->sha1);
+		o = parse_object(get_object_hash(*o));
 		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
 			o = ((struct tag *)o)->tagged;
 		else
@@ -127,7 +127,7 @@ int parse_tag(struct tag *item)
 
 	if (item->object.parsed)
 		return 0;
-	data = read_sha1_file(item->object.sha1, &type, &size);
+	data = read_sha1_file(get_object_hash(item->object), &type, &size);
 	if (!data)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
diff --git a/test-match-trees.c b/test-match-trees.c
index 2ef725e5..264c64a2 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -17,7 +17,7 @@ int main(int ac, char **av)
 	if (!two)
 		die("not a tree-ish %s", av[2]);
 
-	shift_tree(one->object.sha1, two->object.sha1, shifted, -1);
+	shift_tree(get_object_hash(one->object), get_object_hash(two->object), shifted, -1);
 	printf("shifted: %s\n", sha1_to_hex(shifted));
 
 	exit(0);
diff --git a/tree.c b/tree.c
index 413a5b1f..0c2f2fdb 100644
--- a/tree.c
+++ b/tree.c
@@ -102,7 +102,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				    sha1_to_hex(entry.sha1),
 				    base->buf, entry.path);
 
-			hashcpy(sha1, commit->tree->object.sha1);
+			hashcpy(sha1, get_object_hash(commit->tree->object));
 		}
 		else
 			continue;
@@ -212,7 +212,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, &type, &size);
+	buffer = read_sha1_file(get_object_hash(item->object), &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
diff --git a/upload-pack.c b/upload-pack.c
index 89e832b6..393c22e8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -326,7 +326,7 @@ static int reachable(struct commit *want)
 			break;
 		}
 		if (!commit->object.parsed)
-			parse_object(commit->object.sha1);
+			parse_object(get_object_hash(commit->object));
 		if (commit->object.flags & REACHABLE)
 			continue;
 		commit->object.flags |= REACHABLE;
@@ -649,7 +649,7 @@ static void receive_needs(void)
 			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
 				packet_write(1, "shallow %s",
 						sha1_to_hex(object->sha1));
-				register_shallow(object->sha1);
+				register_shallow(get_object_hash(*object));
 				shallow_nr++;
 			}
 			result = result->next;
@@ -663,7 +663,7 @@ static void receive_needs(void)
 					sha1_to_hex(object->sha1));
 				object->flags &= ~CLIENT_SHALLOW;
 				/* make sure the real parents are parsed */
-				unregister_shallow(object->sha1);
+				unregister_shallow(get_object_hash(*object));
 				object->parsed = 0;
 				parse_commit_or_die((struct commit *)object);
 				parents = ((struct commit *)object)->parents;
@@ -675,14 +675,14 @@ static void receive_needs(void)
 				add_object_array(object, NULL, &extra_edge_obj);
 			}
 			/* make sure commit traversal conforms to client */
-			register_shallow(object->sha1);
+			register_shallow(get_object_hash(*object));
 		}
 		packet_flush(1);
 	} else
 		if (shallows.nr > 0) {
 			int i;
 			for (i = 0; i < shallows.nr; i++)
-				register_shallow(shallows.objects[i].item->sha1);
+				register_shallow(get_object_hash(*shallows.objects[i].item));
 		}
 
 	shallow_nr += shallows.nr;
diff --git a/walker.c b/walker.c
index 14f71c0c..a080da02 100644
--- a/walker.c
+++ b/walker.c
@@ -79,7 +79,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 	if (commit->object.flags & COMPLETE)
 		return 0;
 
-	hashcpy(current_commit_sha1, commit->object.sha1);
+	hashcpy(current_commit_sha1, get_object_hash(commit->object));
 
 	walker_say(walker, "walk %s\n", sha1_to_hex(commit->object.sha1));
 
@@ -147,7 +147,7 @@ static int process(struct walker *walker, struct object *obj)
 	else {
 		if (obj->flags & COMPLETE)
 			return 0;
-		walker->prefetch(walker, obj->sha1);
+		walker->prefetch(walker, get_object_hash(*obj));
 	}
 
 	object_list_insert(obj, process_queue_end);
@@ -171,13 +171,13 @@ static int loop(struct walker *walker)
 		 * the queue because we needed to fetch it first.
 		 */
 		if (! (obj->flags & TO_SCAN)) {
-			if (walker->fetch(walker, obj->sha1)) {
+			if (walker->fetch(walker, get_object_hash(*obj))) {
 				report_missing(obj);
 				return -1;
 			}
 		}
 		if (!obj->type)
-			parse_object(obj->sha1);
+			parse_object(get_object_hash(*obj));
 		if (process_object(walker, obj))
 			return -1;
 	}
diff --git a/wt-status.c b/wt-status.c
index c327fe81..32f5f3b0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1341,7 +1341,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    (!hashcmp(cb.nsha1, sha1) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
 	     ((commit = lookup_commit_reference_gently(sha1, 1)) != NULL &&
-	      !hashcmp(cb.nsha1, commit->object.sha1)))) {
+	      !hashcmp(cb.nsha1, get_object_hash(commit->object))))) {
 		int ofs;
 		if (starts_with(ref, "refs/tags/"))
 			ofs = strlen("refs/tags/");
-- 
2.6.1
