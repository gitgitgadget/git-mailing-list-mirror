From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 10/12] Convert struct object to object_id
Date: Tue, 10 Nov 2015 02:22:28 +0000
Message-ID: <1447122150-672570-11-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvyaZ-00014e-NA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbKJCXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:23:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58428 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322AbbKJCXC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:23:02 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C114728097;
	Tue, 10 Nov 2015 02:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122181;
	bh=UxZc33inzrbh46MgeJzCmrZ39OH/K4hKRI0NouGUKeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4SRRIGZ+PM10STGLW7QCL6kUZXNw62ICZ3chE4IyXTaH0mdImIqPGTYveKLP8R5k
	 rDHPA3bTrN3TRA2oUIrUeJfM5ipy7ifyXP1DySyUM2elqD3rELuEJHgBnVzdty9R5m
	 E9DFuR2/fVkSoQN6NCVfMECquvWgj9emd6wR0HmiTvj1IVxvh07C6JhVvOAKCNfkLf
	 W2213SopjMi7tlNUaKRpMfnamu8XhDE2QIZru1UoNB+di/h4S39ASWHCesQMK+8KHM
	 ToR8bcCjM8lzBeVc2RDziXUly2sFsioZ5sxQJgNHie4oMcM9Iu9GPnPKQ6DBS0AQng
	 orSbcyu21M2JJeauHRG3c9s/NY0ct88lDAyA63Sk9jtnJVnH65Fj445QCkC3YALrCD
	 YpsAlAw7rbI+iQVlDcl7WpiZgLLDn/1En6/npYVX8PVqohw4wuYqflLaOD5qz9aSPC
	 X65D15SSN0uYaQUGXqTATNrhCX/jeZlOxTfRY2g2mwEgUngdFB4
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281095>

struct object is one of the major data structures dealing with object
IDs.  Convert it to use struct object_id instead of an unsigned char
array.  Convert get_object_hash to refer to the new member as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c                 |  4 ++--
 builtin/am.c             |  2 +-
 builtin/blame.c          | 32 ++++++++++++++++----------------
 builtin/checkout.c       | 12 ++++++------
 builtin/commit-tree.c    |  4 ++--
 builtin/describe.c       | 14 +++++++-------
 builtin/diff-tree.c      |  4 ++--
 builtin/fast-export.c    | 22 +++++++++++-----------
 builtin/fmt-merge-msg.c  |  2 +-
 builtin/fsck.c           | 32 ++++++++++++++++----------------
 builtin/grep.c           |  4 ++--
 builtin/index-pack.c     |  8 ++++----
 builtin/log.c            | 18 +++++++++---------
 builtin/merge-base.c     |  8 ++++----
 builtin/merge-tree.c     |  2 +-
 builtin/merge.c          | 10 +++++-----
 builtin/name-rev.c       |  8 ++++----
 builtin/pack-objects.c   |  2 +-
 builtin/pull.c           |  2 +-
 builtin/replace.c        |  6 +++---
 builtin/reset.c          | 28 ++++++++++++++--------------
 builtin/rev-list.c       | 14 +++++++-------
 builtin/shortlog.c       |  2 +-
 builtin/show-branch.c    |  4 ++--
 builtin/unpack-objects.c |  8 ++++----
 builtin/worktree.c       |  2 +-
 bundle.c                 | 18 +++++++++---------
 commit.c                 | 20 ++++++++++----------
 fetch-pack.c             |  2 +-
 fsck.c                   |  8 ++++----
 http-backend.c           |  2 +-
 http-push.c              | 22 +++++++++++-----------
 list-objects.c           |  4 ++--
 log-tree.c               | 20 ++++++++++----------
 merge-recursive.c        | 14 +++++++-------
 merge.c                  |  2 +-
 notes-merge.c            |  4 ++--
 object.c                 |  2 +-
 object.h                 |  4 ++--
 pack-bitmap-write.c      |  2 +-
 pack-bitmap.c            |  8 ++++----
 pretty.c                 | 10 +++++-----
 ref-filter.c             |  8 ++++----
 remote.c                 |  4 ++--
 revision.c               | 32 ++++++++++++++++----------------
 sequencer.c              | 22 +++++++++++-----------
 server-info.c            |  2 +-
 sha1_name.c              |  4 ++--
 shallow.c                |  4 ++--
 submodule.c              |  6 +++---
 tag.c                    |  4 ++--
 tree.c                   |  6 +++---
 upload-pack.c            | 16 ++++++++--------
 walker.c                 |  8 ++++----
 54 files changed, 256 insertions(+), 256 deletions(-)

diff --git a/bisect.c b/bisect.c
index 59e86369..54166f00 100644
--- a/bisect.c
+++ b/bisect.c
@@ -193,7 +193,7 @@ static int compare_commit_dist(const void *a_, const void *b_)
 	b = (struct commit_dist *)b_;
 	if (a->distance != b->distance)
 		return b->distance - a->distance; /* desc sort */
-	return hashcmp(a->commit->object.sha1, b->commit->object.sha1);
+	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
 }
 
 static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
@@ -575,7 +575,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
-			if (hashcmp(cur->item->object.sha1, current_bad_oid->hash))
+			if (oidcmp(&cur->item->object.oid, current_bad_oid))
 				return cur;
 			if (previous)
 				return previous;
diff --git a/builtin/am.c b/builtin/am.c
index f1a25ab6..9fb42fdd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1441,7 +1441,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	assert(!state->msg);
 	msg = strstr(buffer, "\n\n");
 	if (!msg)
-		die(_("unable to parse commit %s"), sha1_to_hex(commit->object.sha1));
+		die(_("unable to parse commit %s"), oid_to_hex(&commit->object.oid));
 	state->msg = xstrdup(msg + 2);
 	state->msg_len = strlen(state->msg);
 }
diff --git a/builtin/blame.c b/builtin/blame.c
index c6ea9774..28c48bd4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -557,7 +557,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 		       PATHSPEC_LITERAL_PATH, "", paths);
 	diff_setup_done(&diff_opts);
 
-	if (is_null_sha1(origin->commit->object.sha1))
+	if (is_null_oid(&origin->commit->object.oid))
 		do_diff_cache(get_object_hash(parent->tree->object), &diff_opts);
 	else
 		diff_tree_sha1(get_object_hash(parent->tree->object),
@@ -627,7 +627,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 	diff_opts.single_follow = origin->path;
 	diff_setup_done(&diff_opts);
 
-	if (is_null_sha1(origin->commit->object.sha1))
+	if (is_null_oid(&origin->commit->object.oid))
 		do_diff_cache(get_object_hash(parent->tree->object), &diff_opts);
 	else
 		diff_tree_sha1(get_object_hash(parent->tree->object),
@@ -977,8 +977,8 @@ static void pass_blame_to_parent(struct scoreboard *sb,
 
 	if (diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d))
 		die("unable to generate diff (%s -> %s)",
-		    sha1_to_hex(parent->commit->object.sha1),
-		    sha1_to_hex(target->commit->object.sha1));
+		    oid_to_hex(&parent->commit->object.oid),
+		    oid_to_hex(&target->commit->object.oid));
 	/* The rest are the same as the parent */
 	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
 	*d.dstq = NULL;
@@ -1126,7 +1126,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	memset(split, 0, sizeof(struct blame_entry [3]));
 	if (diff_hunks(file_p, &file_o, 1, handle_split_cb, &d))
 		die("unable to generate diff (%s)",
-		    sha1_to_hex(parent->commit->object.sha1));
+		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
 	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
@@ -1275,7 +1275,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 		&& (!porigin || strcmp(target->path, porigin->path))))
 		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 
-	if (is_null_sha1(target->commit->object.sha1))
+	if (is_null_oid(&target->commit->object.oid))
 		do_diff_cache(get_object_hash(parent->tree->object), &diff_opts);
 	else
 		diff_tree_sha1(get_object_hash(parent->tree->object),
@@ -1690,7 +1690,7 @@ static void get_commit_info(struct commit *commit,
 	if (len)
 		strbuf_add(&ret->summary, subject, len);
 	else
-		strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));
+		strbuf_addf(&ret->summary, "(%s)", oid_to_hex(&commit->object.oid));
 
 	unuse_commit_buffer(commit, message);
 }
@@ -1733,7 +1733,7 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 		printf("boundary\n");
 	if (suspect->previous) {
 		struct origin *prev = suspect->previous;
-		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
+		printf("previous %s ", oid_to_hex(&prev->commit->object.oid));
 		write_name_quoted(prev->path, stdout, '\n');
 	}
 
@@ -1752,7 +1752,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 		struct origin *suspect = ent->suspect;
 
 		printf("%s %d %d %d\n",
-		       sha1_to_hex(suspect->commit->object.sha1),
+		       oid_to_hex(&suspect->commit->object.oid),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
 		emit_one_suspect_detail(suspect, 0);
 		write_filename_info(suspect->path);
@@ -1882,7 +1882,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	struct origin *suspect = ent->suspect;
 	char hex[GIT_SHA1_HEXSZ + 1];
 
-	sha1_to_hex_r(hex, suspect->commit->object.sha1);
+	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
 	printf("%s %d %d %d\n",
 	       hex,
 	       ent->s_lno + 1,
@@ -1922,7 +1922,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 
 	get_commit_info(suspect->commit, &ci, 1);
-	sha1_to_hex_r(hex, suspect->commit->object.sha1);
+	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
 
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
@@ -2153,7 +2153,7 @@ static void sanity_check_refcnt(struct scoreboard *sb)
 		if (ent->suspect->refcnt <= 0) {
 			fprintf(stderr, "%s in %s has negative refcnt %d\n",
 				ent->suspect->path,
-				sha1_to_hex(ent->suspect->commit->object.sha1),
+				oid_to_hex(&ent->suspect->commit->object.oid),
 				ent->suspect->refcnt);
 			baa = 1;
 		}
@@ -2310,7 +2310,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
 	for (parent = commit->parents; parent; parent = parent->next)
 		strbuf_addf(&msg, "parent %s\n",
-			    sha1_to_hex(parent->item->object.sha1));
+			    oid_to_hex(&parent->item->object.oid));
 	strbuf_addf(&msg,
 		    "author %s\n"
 		    "committer %s\n\n"
@@ -2740,7 +2740,7 @@ parse_done:
 
 		sb.revs->children.name = "children";
 		while (c->parents &&
-		       hashcmp(c->object.sha1, sb.final->object.sha1)) {
+		       oidcmp(&c->object.oid, &sb.final->object.oid)) {
 			struct commit_list *l = xcalloc(1, sizeof(*l));
 
 			l->item = c;
@@ -2750,11 +2750,11 @@ parse_done:
 			c = c->parents->item;
 		}
 
-		if (hashcmp(c->object.sha1, sb.final->object.sha1))
+		if (oidcmp(&c->object.oid, &sb.final->object.oid))
 			die("--reverse --first-parent together require range along first-parent chain");
 	}
 
-	if (is_null_sha1(sb.final->object.sha1)) {
+	if (is_null_oid(&sb.final->object.oid)) {
 		o = sb.final->util;
 		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
 		sb.final_buf_size = o->file.size;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bca3a04c..50fd893f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -56,8 +56,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
 	return run_hook_le(NULL, "post-checkout",
-			   sha1_to_hex(old ? old->object.sha1 : null_sha1),
-			   sha1_to_hex(new ? new->object.sha1 : null_sha1),
+			   sha1_to_hex(old ? old->object.oid.hash : null_sha1),
+			   sha1_to_hex(new ? new->object.oid.hash : null_sha1),
 			   changed ? "1" : "0", NULL);
 	/* "new" can be NULL when checking out from the index before
 	   a commit exists. */
@@ -513,7 +513,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   get_object_hash(old->commit->object) :
 					   EMPTY_TREE_SHA1_BIN);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(new->commit->object.sha1);
+		tree = parse_tree_indirect(new->commit->object.oid.hash);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
@@ -641,7 +641,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 	old_desc = old->name;
 	if (!old_desc && old->commit)
-		old_desc = sha1_to_hex(old->commit->object.sha1);
+		old_desc = oid_to_hex(&old->commit->object.oid);
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
@@ -780,10 +780,10 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	setup_revisions(0, NULL, &revs, NULL);
 
 	object->flags &= ~UNINTERESTING;
-	add_pending_object(&revs, object, sha1_to_hex(object->sha1));
+	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
-	add_pending_sha1(&revs, "HEAD", new->object.sha1, UNINTERESTING);
+	add_pending_sha1(&revs, "HEAD", new->object.oid.hash, UNINTERESTING);
 
 	refs = revs.pending;
 	revs.leak_pending = 1;
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 8747c0f2..3feeffea 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -16,11 +16,11 @@ static const char *sign_commit;
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
-	unsigned char *sha1 = parent->object.sha1;
+	struct object_id *oid = &parent->object.oid;
 	struct commit_list *parents;
 	for (parents = *parents_p; parents; parents = parents->next) {
 		if (parents->item == parent) {
-			error("duplicate parent %s ignored", sha1_to_hex(sha1));
+			error("duplicate parent %s ignored", oid_to_hex(oid));
 			return;
 		}
 		parents_p = &parents->next;
diff --git a/builtin/describe.c b/builtin/describe.c
index c0c373b4..11f7300a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -267,7 +267,7 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!max_candidates)
-		die(_("no tag exactly matches '%s'"), sha1_to_hex(cmit->object.sha1));
+		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
 		fprintf(stderr, _("searching to describe %s\n"), arg);
 
@@ -317,7 +317,7 @@ static void describe(const char *arg, int last_one)
 		if (annotated_cnt && !list) {
 			if (debug)
 				fprintf(stderr, _("finished search at %s\n"),
-					sha1_to_hex(c->object.sha1));
+					oid_to_hex(&c->object.oid));
 			break;
 		}
 		while (parents) {
@@ -334,9 +334,9 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!match_cnt) {
-		const unsigned char *sha1 = cmit->object.sha1;
+		struct object_id *oid = &cmit->object.oid;
 		if (always) {
-			printf("%s", find_unique_abbrev(sha1, abbrev));
+			printf("%s", find_unique_abbrev(oid->hash, abbrev));
 			if (dirty)
 				printf("%s", dirty);
 			printf("\n");
@@ -345,11 +345,11 @@ static void describe(const char *arg, int last_one)
 		if (unannotated_cnt)
 			die(_("No annotated tags can describe '%s'.\n"
 			    "However, there were unannotated tags: try --tags."),
-			    sha1_to_hex(sha1));
+			    oid_to_hex(oid));
 		else
 			die(_("No tags can describe '%s'.\n"
 			    "Try --always, or create some tags."),
-			    sha1_to_hex(sha1));
+			    oid_to_hex(oid));
 	}
 
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
@@ -374,7 +374,7 @@ static void describe(const char *arg, int last_one)
 				_("more than %i tags found; listed %i most recent\n"
 				"gave up search at %s\n"),
 				max_candidates, max_candidates,
-				sha1_to_hex(gave_up_on->object.sha1));
+				oid_to_hex(&gave_up_on->object.oid));
 		}
 	}
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index cf7e9604..6fef266e 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -49,8 +49,8 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 	tree2 = lookup_tree(sha1);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
-	printf("%s %s\n", sha1_to_hex(tree1->object.sha1),
-			  sha1_to_hex(tree2->object.sha1));
+	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
+			  oid_to_hex(&tree2->object.oid));
 	diff_tree_sha1(get_object_hash(tree1->object), get_object_hash(tree2->object),
 		       "", &log_tree_opt.diffopt);
 	log_tree_diff_flush(&log_tree_opt);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 30faf248..1337a238 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -544,13 +544,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
 		die ("Could not find author in commit %s",
-		     sha1_to_hex(commit->object.sha1));
+		     oid_to_hex(&commit->object.oid));
 	author++;
 	author_end = strchrnul(author, '\n');
 	committer = strstr(author_end, "\ncommitter ");
 	if (!committer)
 		die ("Could not find committer in commit %s",
-		     sha1_to_hex(commit->object.sha1));
+		     oid_to_hex(&commit->object.oid));
 	committer++;
 	committer_end = strchrnul(committer, '\n');
 	message = strstr(committer_end, "\n\n");
@@ -661,13 +661,13 @@ static void handle_tag(const char *name, struct tag *tag)
 	}
 	if (tagged->type == OBJ_TREE) {
 		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
-			sha1_to_hex(tag->object.sha1));
+			oid_to_hex(&tag->object.oid));
 		return;
 	}
 
 	buf = read_sha1_file(get_object_hash(tag->object), &type, &size);
 	if (!buf)
-		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
+		die ("Could not read tag %s", oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -706,16 +706,16 @@ static void handle_tag(const char *name, struct tag *tag)
 			case ABORT:
 				die ("Encountered signed tag %s; use "
 				     "--signed-tags=<mode> to handle it.",
-				     sha1_to_hex(tag->object.sha1));
+				     oid_to_hex(&tag->object.oid));
 			case WARN:
 				warning ("Exporting signed tag %s",
-					 sha1_to_hex(tag->object.sha1));
+					 oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case VERBATIM:
 				break;
 			case WARN_STRIP:
 				warning ("Stripping signature from tag %s",
-					 sha1_to_hex(tag->object.sha1));
+					 oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case STRIP:
 				message_size = signature + 1 - message;
@@ -731,14 +731,14 @@ static void handle_tag(const char *name, struct tag *tag)
 		case ABORT:
 			die ("Tag %s tags unexported object; use "
 			     "--tag-of-filtered-object=<mode> to handle it.",
-			     sha1_to_hex(tag->object.sha1));
+			     oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
 				die ("Tag %s tags unexported %s!",
-				     sha1_to_hex(tag->object.sha1),
+				     oid_to_hex(&tag->object.oid),
 				     typename(tagged->type));
 			}
 			p = (struct commit *)tagged;
@@ -751,7 +751,7 @@ static void handle_tag(const char *name, struct tag *tag)
 					break;
 				if (!p->parents)
 					die ("Can't find replacement commit for tag %s\n",
-					     sha1_to_hex(tag->object.sha1));
+					     oid_to_hex(&tag->object.oid));
 				p = p->parents->item;
 			}
 			tagged_mark = get_object_mark(&p->object);
@@ -888,7 +888,7 @@ static void export_marks(char *file)
 		if (deco->base && deco->base->type == 1) {
 			mark = ptr_to_mark(deco->decoration);
 			if (fprintf(f, ":%"PRIu32" %s\n", mark,
-				sha1_to_hex(deco->base->sha1)) < 0) {
+				oid_to_hex(&deco->base->oid)) < 0) {
 			    e = 1;
 			    break;
 			}
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a1505002..12aba984 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -378,7 +378,7 @@ static void shortlog(const char *name,
 
 		if (!sb.len)
 			string_list_append(&subjects,
-					   sha1_to_hex(commit->object.sha1));
+					   oid_to_hex(&commit->object.oid));
 		else
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 40206696..7bfb4938 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -67,7 +67,7 @@ static void objreport(struct object *obj, const char *msg_type,
 			const char *err)
 {
 	fprintf(stderr, "%s in %s %s: %s\n",
-		msg_type, typename(obj->type), sha1_to_hex(obj->sha1), err);
+		msg_type, typename(obj->type), oid_to_hex(&obj->oid), err);
 }
 
 static int objerror(struct object *obj, const char *err)
@@ -97,7 +97,7 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf("broken link from %7s %s\n",
-			   typename(parent->type), sha1_to_hex(parent->sha1));
+			   typename(parent->type), oid_to_hex(&parent->oid));
 		printf("broken link from %7s %s\n",
 			   (type == OBJ_ANY ? "unknown" : typename(type)), "unknown");
 		errors_found |= ERROR_REACHABLE;
@@ -112,11 +112,11 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		return 0;
 	obj->flags |= REACHABLE;
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !has_sha1_file(obj->sha1)) {
+		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
-				 typename(parent->type), sha1_to_hex(parent->sha1));
+				 typename(parent->type), oid_to_hex(&parent->oid));
 			printf("              to %7s %s\n",
-				 typename(obj->type), sha1_to_hex(obj->sha1));
+				 typename(obj->type), oid_to_hex(&obj->oid));
 			errors_found |= ERROR_REACHABLE;
 		}
 		return 1;
@@ -188,9 +188,9 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(get_object_hash(*obj)))
 			return; /* it is in pack - forget about it */
-		if (connectivity_only && has_sha1_file(obj->sha1))
+		if (connectivity_only && has_object_file(&obj->oid))
 			return;
-		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
+		printf("missing %s %s\n", typename(obj->type), oid_to_hex(&obj->oid));
 		errors_found |= ERROR_REACHABLE;
 		return;
 	}
@@ -215,7 +215,7 @@ static void check_unreachable_object(struct object *obj)
 	 * since this is something that is prunable.
 	 */
 	if (show_unreachable) {
-		printf("unreachable %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
+		printf("unreachable %s %s\n", typename(obj->type), oid_to_hex(&obj->oid));
 		return;
 	}
 
@@ -234,11 +234,11 @@ static void check_unreachable_object(struct object *obj)
 	if (!obj->used) {
 		if (show_dangling)
 			printf("dangling %s %s\n", typename(obj->type),
-			       sha1_to_hex(obj->sha1));
+			       oid_to_hex(&obj->oid));
 		if (write_lost_and_found) {
 			char *filename = git_pathdup("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
-				sha1_to_hex(obj->sha1));
+				oid_to_hex(&obj->oid));
 			FILE *f;
 
 			if (safe_create_leading_directories_const(filename)) {
@@ -252,7 +252,7 @@ static void check_unreachable_object(struct object *obj)
 				if (stream_blob_to_fd(fileno(f), get_object_hash(*obj), NULL, 1))
 					die_errno("Could not write '%s'", filename);
 			} else
-				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
+				fprintf(f, "%s\n", oid_to_hex(&obj->oid));
 			if (fclose(f))
 				die_errno("Could not finish '%s'",
 					  filename);
@@ -271,7 +271,7 @@ static void check_unreachable_object(struct object *obj)
 static void check_object(struct object *obj)
 {
 	if (verbose)
-		fprintf(stderr, "Checking %s\n", sha1_to_hex(obj->sha1));
+		fprintf(stderr, "Checking %s\n", oid_to_hex(&obj->oid));
 
 	if (obj->flags & REACHABLE)
 		check_reachable_object(obj);
@@ -307,7 +307,7 @@ static int fsck_obj(struct object *obj)
 
 	if (verbose)
 		fprintf(stderr, "Checking %s %s\n",
-			typename(obj->type), sha1_to_hex(obj->sha1));
+			typename(obj->type), oid_to_hex(&obj->oid));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, "broken links");
@@ -326,15 +326,15 @@ static int fsck_obj(struct object *obj)
 		free_commit_buffer(commit);
 
 		if (!commit->parents && show_root)
-			printf("root %s\n", sha1_to_hex(commit->object.sha1));
+			printf("root %s\n", oid_to_hex(&commit->object.oid));
 	}
 
 	if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
 
 		if (show_tags && tag->tagged) {
-			printf("tagged %s %s", typename(tag->tagged->type), sha1_to_hex(tag->tagged->sha1));
-			printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
+			printf("tagged %s %s", typename(tag->tagged->type), oid_to_hex(&tag->tagged->oid));
+			printf(" (%s) in %s\n", tag->tag, oid_to_hex(&tag->object.oid));
 		}
 	}
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 9c42fc03..ca3ceea4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -468,12 +468,12 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		int hit, len;
 
 		grep_read_lock();
-		data = read_object_with_reference(obj->sha1, tree_type,
+		data = read_object_with_reference(obj->oid.hash, tree_type,
 						  &size, NULL);
 		grep_read_unlock();
 
 		if (!data)
-			die(_("unable to read tree (%s)"), sha1_to_hex(obj->sha1));
+			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
 
 		len = name ? strlen(name) : 0;
 		strbuf_init(&base, PATH_MAX + len + 1);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b01a8c0e..48b470dd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -199,7 +199,7 @@ static int mark_link(struct object *obj, int type, void *data, struct fsck_optio
 		return -1;
 
 	if (type != OBJ_ANY && obj->type != type)
-		die(_("object type mismatch at %s"), sha1_to_hex(obj->sha1));
+		die(_("object type mismatch at %s"), oid_to_hex(&obj->oid));
 
 	obj->flags |= FLAG_LINK;
 	return 0;
@@ -220,10 +220,10 @@ static unsigned check_object(struct object *obj)
 		int type = sha1_object_info(get_object_hash(*obj), &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
-			      sha1_to_hex(obj->sha1));
+			      oid_to_hex(&obj->oid));
 		if (type != obj->type)
 			die(_("object %s: expected type %s, found %s"),
-			    sha1_to_hex(obj->sha1),
+			    oid_to_hex(&obj->oid),
 			    typename(obj->type), typename(type));
 		obj->flags |= FLAG_CHECKED;
 		return 1;
@@ -842,7 +842,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			    fsck_object(obj, buf, size, &fsck_options))
 				die(_("Error in object"));
 			if (fsck_walk(obj, NULL, &fsck_options))
-				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
+				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
 
 			if (obj->type == OBJ_TREE) {
 				struct tree *item = (struct tree *) obj;
diff --git a/builtin/log.c b/builtin/log.c
index 0977c824..a16ec324 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -570,7 +570,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			o = parse_object(get_object_hash(*t->tagged));
 			if (!o)
 				ret = error(_("Could not read object %s"),
-					    sha1_to_hex(t->tagged->sha1));
+					    oid_to_hex(&t->tagged->oid));
 			objects[i].item = o;
 			i--;
 			break;
@@ -896,8 +896,8 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
 static char *find_branch_name(struct rev_info *rev)
 {
 	int i, positive = -1;
-	unsigned char branch_sha1[20];
-	const unsigned char *tip_sha1;
+	struct object_id branch_oid;
+	const struct object_id *tip_oid;
 	const char *ref, *v;
 	char *full_ref, *branch = NULL;
 
@@ -912,10 +912,10 @@ static char *find_branch_name(struct rev_info *rev)
 	if (positive < 0)
 		return NULL;
 	ref = rev->cmdline.rev[positive].name;
-	tip_sha1 = rev->cmdline.rev[positive].item->sha1;
-	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
+	tip_oid = &rev->cmdline.rev[positive].item->oid;
+	if (dwim_ref(ref, strlen(ref), branch_oid.hash, &full_ref) &&
 	    skip_prefix(full_ref, "refs/heads/", &v) &&
-	    !hashcmp(tip_sha1, branch_sha1))
+	    !oidcmp(tip_oid, &branch_oid))
 		branch = xstrdup(v);
 	free(full_ref);
 	return branch;
@@ -1443,7 +1443,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* Don't say anything if head and upstream are the same. */
 		if (rev.pending.nr == 2) {
 			struct object_array_entry *o = rev.pending.objects;
-			if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
+			if (oidcmp(&o[0].item->oid, &o[1].item->oid) == 0)
 				return 0;
 		}
 		get_patch_ids(&rev, &ids);
@@ -1550,7 +1550,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 					string_list_append(rev.ref_message_ids,
 							   rev.message_id);
 			}
-			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
+			gen_message_id(&rev, oid_to_hex(&commit->object.oid));
 		}
 
 		if (!use_stdout &&
@@ -1675,7 +1675,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	/* Don't say anything if head and upstream are the same. */
 	if (revs.pending.nr == 2) {
 		struct object_array_entry *o = revs.pending.objects;
-		if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
+		if (oidcmp(&o[0].item->oid, &o[1].item->oid) == 0)
 			return 0;
 	}
 
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08a82178..a8911626 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -16,7 +16,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 		return 1;
 
 	while (result) {
-		printf("%s\n", sha1_to_hex(result->item->object.sha1));
+		printf("%s\n", oid_to_hex(&result->item->object.oid));
 		if (!show_all)
 			return 0;
 		result = result->next;
@@ -62,7 +62,7 @@ static int handle_independent(int count, const char **args)
 		return 1;
 
 	while (result) {
-		printf("%s\n", sha1_to_hex(result->item->object.sha1));
+		printf("%s\n", oid_to_hex(&result->item->object.oid));
 		result = result->next;
 	}
 	return 0;
@@ -83,7 +83,7 @@ static int handle_octopus(int count, const char **args, int show_all)
 		return 1;
 
 	while (result) {
-		printf("%s\n", sha1_to_hex(result->item->object.sha1));
+		printf("%s\n", oid_to_hex(&result->item->object.oid));
 		if (!show_all)
 			return 0;
 		result = result->next;
@@ -196,7 +196,7 @@ static int handle_fork_point(int argc, const char **argv)
 		goto cleanup_return;
 	}
 
-	printf("%s\n", sha1_to_hex(bases->item->object.sha1));
+	printf("%s\n", oid_to_hex(&bases->item->object.oid));
 
 cleanup_return:
 	free_commit_list(bases);
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cf1cee1d..e124886e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -130,7 +130,7 @@ static void show_result_list(struct merge_list *entry)
 	do {
 		struct merge_list *link = entry->link;
 		static const char *desc[4] = { "result", "base", "our", "their" };
-		printf("  %-6s %o %s %s\n", desc[entry->stage], entry->mode, sha1_to_hex(entry->blob->object.sha1), entry->path);
+		printf("  %-6s %o %s %s\n", desc[entry->stage], entry->mode, oid_to_hex(&entry->blob->object.oid), entry->path);
 		entry = link;
 	} while (entry);
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index a6e598d9..c804218f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -365,7 +365,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	while ((commit = get_revision(&rev)) != NULL) {
 		strbuf_addch(&out, '\n');
 		strbuf_addf(&out, "commit %s\n",
-			sha1_to_hex(get_object_hash(commit->object)));
+			oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&ctx, commit, &out);
 	}
 	if (write_in_full(fd, out.buf, out.len) != out.len)
@@ -958,14 +958,14 @@ static void write_merge_state(struct commit_list *remoteheads)
 	struct strbuf buf = STRBUF_INIT;
 
 	for (j = remoteheads; j; j = j->next) {
-		unsigned const char *sha1;
+		struct object_id *oid;
 		struct commit *c = j->item;
 		if (c->util && merge_remote_util(c)->obj) {
-			sha1 = merge_remote_util(c)->obj->sha1;
+			oid = &merge_remote_util(c)->obj->oid;
 		} else {
-			sha1 = get_object_hash(c->object);
+			oid = &c->object.oid;
 		}
-		strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
 	filename = git_path_merge_head();
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cac66a58..49e6e91b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -232,19 +232,19 @@ static void show_name(const struct object *obj,
 		      int always, int allow_undefined, int name_only)
 {
 	const char *name;
-	const unsigned char *sha1 = get_object_hash(*obj);
+	const struct object_id *oid = &obj->oid;
 
 	if (!name_only)
-		printf("%s ", caller_name ? caller_name : sha1_to_hex(sha1));
+		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
 	name = get_rev_name(obj);
 	if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
 		printf("undefined\n");
 	else if (always)
-		printf("%s\n", find_unique_abbrev(sha1, DEFAULT_ABBREV));
+		printf("%s\n", find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 	else
-		die("cannot describe '%s'", sha1_to_hex(sha1));
+		die("cannot describe '%s'", oid_to_hex(oid));
 }
 
 static char const * const name_rev_usage[] = {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b2d3e4ea..fa1b5cd7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2338,7 +2338,7 @@ static int ofscmp(const void *a_, const void *b_)
 	else if (a->offset > b->offset)
 		return 1;
 	else
-		return hashcmp(a->object->sha1, b->object->sha1);
+		return oidcmp(&a->object->oid, &b->object->oid);
 }
 
 static void add_objects_in_unpacked_packs(struct rev_info *revs)
diff --git a/builtin/pull.c b/builtin/pull.c
index bf3fd3f9..4b7e344a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -743,7 +743,7 @@ static int get_octopus_merge_base(unsigned char *merge_base,
 	if (!result)
 		return 1;
 
-	hashcpy(merge_base, result->item->object.sha1);
+	hashcpy(merge_base, get_object_hash(result->item->object));
 	return 0;
 }
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 6b3c469a..748c6ca9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -358,10 +358,10 @@ static void check_one_mergetag(struct commit *commit,
 
 	/* iterate over new parents */
 	for (i = 1; i < mergetag_data->argc; i++) {
-		unsigned char sha1[20];
-		if (get_sha1(mergetag_data->argv[i], sha1) < 0)
+		struct object_id oid;
+		if (get_sha1(mergetag_data->argv[i], oid.hash) < 0)
 			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
-		if (!hashcmp(tag->tagged->sha1, sha1))
+		if (!oidcmp(&tag->tagged->oid, &oid))
 			return; /* found */
 	}
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 9b889881..d0014b62 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -269,7 +269,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int patch_mode = 0, unborn;
 	const char *rev;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
 	const struct option options[] = {
@@ -295,26 +295,26 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
-	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", sha1);
+	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", oid.hash);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
-		hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
+		hashcpy(oid.hash, EMPTY_TREE_SHA1_BIN);
 	} else if (!pathspec.nr) {
 		struct commit *commit;
-		if (get_sha1_committish(rev, sha1))
+		if (get_sha1_committish(rev, oid.hash))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
-		commit = lookup_commit_reference(sha1);
+		commit = lookup_commit_reference(oid.hash);
 		if (!commit)
 			die(_("Could not parse object '%s'."), rev);
-		hashcpy(sha1, commit->object.sha1);
+		oidcpy(&oid, &commit->object.oid);
 	} else {
 		struct tree *tree;
-		if (get_sha1_treeish(rev, sha1))
+		if (get_sha1_treeish(rev, oid.hash))
 			die(_("Failed to resolve '%s' as a valid tree."), rev);
-		tree = parse_tree_indirect(sha1);
+		tree = parse_tree_indirect(oid.hash);
 		if (!tree)
 			die(_("Could not parse object '%s'."), rev);
-		hashcpy(sha1, tree->object.sha1);
+		oidcpy(&oid, &tree->object.oid);
 	}
 
 	if (patch_mode) {
@@ -357,15 +357,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		hold_locked_index(lock, 1);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, sha1, intent_to_add))
+			if (read_from_tree(&pathspec, oid.hash, intent_to_add))
 				return 1;
 			if (get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
-			int err = reset_index(sha1, reset_type, quiet);
+			int err = reset_index(oid.hash, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-				err = reset_index(sha1, MIXED, quiet);
+				err = reset_index(oid.hash, MIXED, quiet);
 			if (err)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
@@ -377,10 +377,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec.nr && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
-		update_ref_status = reset_refs(rev, sha1);
+		update_ref_status = reset_refs(rev, oid.hash);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
-			print_new_head_line(lookup_commit_reference(sha1));
+			print_new_head_line(lookup_commit_reference(oid.hash));
 	}
 	if (!pathspec.nr)
 		remove_branch_state();
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 1cd5db1a..c4166ea7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -84,11 +84,11 @@ static void show_commit(struct commit *commit, void *data)
 		fputs(find_unique_abbrev(get_object_hash(commit->object), revs->abbrev),
 		      stdout);
 	else
-		fputs(sha1_to_hex(commit->object.sha1), stdout);
+		fputs(oid_to_hex(&commit->object.oid), stdout);
 	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
-			printf(" %s", sha1_to_hex(parents->item->object.sha1));
+			printf(" %s", oid_to_hex(&parents->item->object.oid));
 			parents = parents->next;
 		}
 	}
@@ -97,7 +97,7 @@ static void show_commit(struct commit *commit, void *data)
 
 		children = lookup_decoration(&revs->children, &commit->object);
 		while (children) {
-			printf(" %s", sha1_to_hex(children->item->object.sha1));
+			printf(" %s", oid_to_hex(&children->item->object.oid));
 			children = children->next;
 		}
 	}
@@ -182,8 +182,8 @@ static void finish_object(struct object *obj,
 			  void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
-		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+		die("missing blob object '%s'", oid_to_hex(&obj->oid));
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(get_object_hash(*obj));
 }
@@ -201,7 +201,7 @@ static void show_object(struct object *obj,
 
 static void show_edge(struct commit *commit)
 {
-	printf("-%s\n", sha1_to_hex(commit->object.sha1));
+	printf("-%s\n", oid_to_hex(&commit->object.oid));
 }
 
 static void print_var_str(const char *var, const char *val)
@@ -242,7 +242,7 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 		cnt = reaches;
 
 	if (revs->commits)
-		sha1_to_hex_r(hex, revs->commits->item->object.sha1);
+		sha1_to_hex_r(hex, revs->commits->item->object.oid.hash);
 
 	if (flags & BISECT_SHOW_ALL) {
 		traverse_commit_list(revs, show_commit, show_object, info);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 007cc66a..35ebd17f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -129,7 +129,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	if (!author) {
 		warning(_("Missing author: %s"),
-		    sha1_to_hex(commit->object.sha1));
+		    oid_to_hex(&commit->object.oid));
 		return;
 	}
 	if (log->user_format) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index eb885705..18286409 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -496,7 +496,7 @@ static int show_merge_base(struct commit_list *seen, int num_rev)
 		int flags = commit->object.flags & all_mask;
 		if (!(flags & UNINTERESTING) &&
 		    ((flags & all_revs) == all_revs)) {
-			puts(sha1_to_hex(commit->object.sha1));
+			puts(oid_to_hex(&commit->object.oid));
 			exit_status = 0;
 			commit->object.flags |= UNINTERESTING;
 		}
@@ -516,7 +516,7 @@ static int show_independent(struct commit **rev,
 		unsigned int flag = rev_mask[i];
 
 		if (commit->object.flags == flag)
-			puts(sha1_to_hex(commit->object.sha1));
+			puts(oid_to_hex(&commit->object.oid));
 		commit->object.flags |= UNINTERESTING;
 	}
 	return 0;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1cf2806e..61a33788 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -46,7 +46,7 @@ static void add_object_buffer(struct object *object, char *buffer, unsigned long
 	obj->buffer = buffer;
 	obj->size = size;
 	if (add_decoration(&obj_decorate, object, obj))
-		die("object %s tried to add buffer twice!", sha1_to_hex(object->sha1));
+		die("object %s tried to add buffer twice!", oid_to_hex(&object->oid));
 }
 
 /*
@@ -170,7 +170,7 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 	unsigned char sha1[20];
 
 	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), sha1) < 0)
-		die("failed to write object %s", sha1_to_hex(obj->sha1));
+		die("failed to write object %s", oid_to_hex(&obj->oid));
 	obj->flags |= FLAG_WRITTEN;
 }
 
@@ -203,12 +203,12 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 
 	obj_buf = lookup_object_buffer(obj);
 	if (!obj_buf)
-		die("Whoops! Cannot find object '%s'", sha1_to_hex(obj->sha1));
+		die("Whoops! Cannot find object '%s'", oid_to_hex(&obj->oid));
 	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("Error in object");
 	fsck_options.walk = check_object;
 	if (fsck_walk(obj, NULL, &fsck_options))
-		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
+		die("Error on reachable objects of %s", oid_to_hex(&obj->oid));
 	write_cached_object(obj, obj_buf);
 	return 0;
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d281f6d8..475b9581 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -277,7 +277,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	if (commit)
 		argv_array_pushl(&cp.args, "update-ref", "HEAD",
-				 sha1_to_hex(commit->object.sha1), NULL);
+				 oid_to_hex(&commit->object.oid), NULL);
 	else
 		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
 				 symref.buf, NULL);
diff --git a/bundle.c b/bundle.c
index d4f52cfd..345c7863 100644
--- a/bundle.c
+++ b/bundle.c
@@ -171,7 +171,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		if (!(refs.objects[i].item->flags & SHOWN)) {
 			if (++ret == 1)
 				error("%s", message);
-			error("%s %s", sha1_to_hex(refs.objects[i].item->sha1),
+			error("%s %s", oid_to_hex(&refs.objects[i].item->oid),
 				refs.objects[i].name);
 		}
 
@@ -256,7 +256,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs)
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
 			write_or_die(pack_objects.in, "^", 1);
-		write_or_die(pack_objects.in, sha1_to_hex(object->sha1), 40);
+		write_or_die(pack_objects.in, oid_to_hex(&object->oid), GIT_SHA1_HEXSZ);
 		write_or_die(pack_objects.in, "\n", 1);
 	}
 	close(pack_objects.in);
@@ -321,16 +321,16 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *e = revs->pending.objects + i;
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *ref;
 		const char *display_ref;
 		int flag;
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
+		if (dwim_ref(e->name, strlen(e->name), oid.hash, &ref) != 1)
 			goto skip_write_ref;
-		if (read_ref_full(e->name, RESOLVE_REF_READING, sha1, &flag))
+		if (read_ref_full(e->name, RESOLVE_REF_READING, oid.hash, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
@@ -360,13 +360,13 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		 * commit that is referenced by the tag, and not the tag
 		 * itself.
 		 */
-		if (hashcmp(sha1, e->item->sha1)) {
+		if (oidcmp(&oid, &e->item->oid)) {
 			/*
 			 * Is this the positive end of a range expressed
 			 * in terms of a tag (e.g. v2.0 from the range
 			 * "v1.0..v2.0")?
 			 */
-			struct commit *one = lookup_commit_reference(sha1);
+			struct commit *one = lookup_commit_reference(oid.hash);
 			struct object *obj;
 
 			if (e->item == &(one->object)) {
@@ -378,7 +378,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 				 * end up triggering "empty bundle"
 				 * error.
 				 */
-				obj = parse_object_or_die(sha1, e->name);
+				obj = parse_object_or_die(oid.hash, e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(revs, obj, e->name);
 			}
@@ -386,7 +386,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		}
 
 		ref_count++;
-		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
+		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), 40);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, display_ref, strlen(display_ref));
 		write_or_die(bundle_fd, "\n", 1);
diff --git a/commit.c b/commit.c
index 410f001a..f2bcbbcb 100644
--- a/commit.c
+++ b/commit.c
@@ -265,10 +265,10 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 		ret = read_sha1_file(get_object_hash(commit->object), &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
-			    sha1_to_hex(commit->object.sha1));
+			    oid_to_hex(&commit->object.oid));
 		if (type != OBJ_COMMIT)
 			die("expected commit for %s, got %s",
-			    sha1_to_hex(commit->object.sha1), typename(type));
+			    oid_to_hex(&commit->object.oid), typename(type));
 		if (sizep)
 			*sizep = size;
 	}
@@ -327,10 +327,10 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	tail += size;
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
 			bufptr[tree_entry_len] != '\n')
-		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
+		return error("bogus commit object %s", oid_to_hex(&item->object.oid));
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	item->tree = lookup_tree(parent.hash);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
@@ -342,7 +342,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		if (tail <= bufptr + parent_entry_len + 1 ||
 		    get_sha1_hex(bufptr + 7, parent.hash) ||
 		    bufptr[parent_entry_len] != '\n')
-			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
+			return error("bad parents in commit %s", oid_to_hex(&item->object.oid));
 		bufptr += parent_entry_len + 1;
 		/*
 		 * The clone is shallow if nr_parent < 0, and we must
@@ -384,11 +384,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	if (type != OBJ_COMMIT) {
 		free(buffer);
 		return error("Object %s not a commit",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	}
 	ret = parse_commit_buffer(item, buffer, size);
 	if (save_commit_buffer && !ret) {
@@ -403,7 +403,7 @@ void parse_commit_or_die(struct commit *item)
 {
 	if (parse_commit(item))
 		die("unable to parse commit %s",
-		    item ? sha1_to_hex(item->object.sha1) : "(null)");
+		    item ? oid_to_hex(&item->object.oid) : "(null)");
 }
 
 int find_commit_subject(const char *commit_buffer, const char **subject)
@@ -1539,7 +1539,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	while (parents) {
 		struct commit *parent = pop_commit(&parents);
 		strbuf_addf(&buffer, "parent %s\n",
-			    sha1_to_hex(parent->object.sha1));
+			    oid_to_hex(&parent->object.oid));
 	}
 
 	/* Person/date information */
@@ -1623,7 +1623,7 @@ void print_commit_list(struct commit_list *list,
 {
 	for ( ; list; list = list->next) {
 		const char *format = list->next ? format_cur : format_last;
-		printf(format, sha1_to_hex(list->item->object.sha1));
+		printf(format, oid_to_hex(&list->item->object.oid));
 	}
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 7c8cbbf3..6239a61a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -511,7 +511,7 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	while (complete && cutoff <= complete->item->date) {
 		if (args->verbose)
 			fprintf(stderr, "Marking %s as complete\n",
-				sha1_to_hex(complete->item->object.sha1));
+				oid_to_hex(&complete->item->object.oid));
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
 }
diff --git a/fsck.c b/fsck.c
index baa7f298..f7d65a2c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -316,7 +316,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			result = options->walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data, options);
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
-					sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
+					oid_to_hex(&tree->object.oid), entry.path, entry.mode);
 		}
 		if (result < 0)
 			return result;
@@ -373,7 +373,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 	case OBJ_TAG:
 		return fsck_walk_tag((struct tag *)obj, data, options);
 	default:
-		error("Unknown object type for %s", sha1_to_hex(obj->sha1));
+		error("Unknown object type for %s", oid_to_hex(&obj->oid));
 		return -1;
 	}
 }
@@ -809,9 +809,9 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 int fsck_error_function(struct object *obj, int msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
+		warning("object %s: %s", oid_to_hex(&obj->oid), message);
 		return 0;
 	}
-	error("object %s: %s", sha1_to_hex(obj->sha1), message);
+	error("object %s: %s", oid_to_hex(&obj->oid), message);
 	return 1;
 }
diff --git a/http-backend.c b/http-backend.c
index bac40ef6..8870a268 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -436,7 +436,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 		o = deref_tag(o, name, 0);
 		if (!o)
 			return 0;
-		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1),
+		strbuf_addf(buf, "%s\t%s^{}\n", oid_to_hex(&o->oid),
 			    name_nons);
 	}
 	return 0;
diff --git a/http-push.c b/http-push.c
index 45ff2c4a..76268ede 100644
--- a/http-push.c
+++ b/http-push.c
@@ -275,7 +275,7 @@ static void start_fetch_loose(struct transfer_request *request)
 
 static void start_mkcol(struct transfer_request *request)
 {
-	char *hex = sha1_to_hex(request->obj->sha1);
+	char *hex = oid_to_hex(&request->obj->oid);
 	struct active_request_slot *slot;
 
 	request->url = get_remote_object_url(repo->url, hex, 1);
@@ -306,14 +306,14 @@ static void start_fetch_packed(struct transfer_request *request)
 
 	target = find_sha1_pack(get_object_hash(*request->obj), repo->packs);
 	if (!target) {
-		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", sha1_to_hex(request->obj->sha1));
+		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", oid_to_hex(&request->obj->oid));
 		repo->can_update_info_refs = 0;
 		release_request(request);
 		return;
 	}
 
 	fprintf(stderr,	"Fetching pack %s\n", sha1_to_hex(target->sha1));
-	fprintf(stderr, " which contains %s\n", sha1_to_hex(request->obj->sha1));
+	fprintf(stderr, " which contains %s\n", oid_to_hex(&request->obj->oid));
 
 	preq = new_http_pack_request(target, repo->url);
 	if (preq == NULL) {
@@ -350,7 +350,7 @@ static void start_fetch_packed(struct transfer_request *request)
 
 static void start_put(struct transfer_request *request)
 {
-	char *hex = sha1_to_hex(request->obj->sha1);
+	char *hex = oid_to_hex(&request->obj->oid);
 	struct active_request_slot *slot;
 	struct strbuf buf = STRBUF_INIT;
 	enum object_type type;
@@ -537,7 +537,7 @@ static void finish_request(struct transfer_request *request)
 			start_put(request);
 		} else {
 			fprintf(stderr, "MKCOL %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->obj->sha1),
+				oid_to_hex(&request->obj->oid),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
 			aborted = 1;
@@ -547,7 +547,7 @@ static void finish_request(struct transfer_request *request)
 			start_move(request);
 		} else {
 			fprintf(stderr,	"PUT %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->obj->sha1),
+				oid_to_hex(&request->obj->oid),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
 			aborted = 1;
@@ -556,12 +556,12 @@ static void finish_request(struct transfer_request *request)
 		if (request->curl_result == CURLE_OK) {
 			if (push_verbosely)
 				fprintf(stderr, "    sent %s\n",
-					sha1_to_hex(request->obj->sha1));
+					oid_to_hex(&request->obj->oid));
 			request->obj->flags |= REMOTE;
 			release_request(request);
 		} else {
 			fprintf(stderr, "MOVE %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->obj->sha1),
+				oid_to_hex(&request->obj->oid),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
 			aborted = 1;
@@ -1307,7 +1307,7 @@ static struct object_list **process_tree(struct tree *tree,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
 	if (parse_tree(tree) < 0)
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
+		die("bad tree object %s", oid_to_hex(&obj->oid));
 
 	obj->flags |= SEEN;
 	name = xstrdup(name);
@@ -1369,7 +1369,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 			p = process_blob((struct blob *)obj, p, NULL, name);
 			continue;
 		}
-		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
+		die("unknown pending object %s (%s)", oid_to_hex(&obj->oid), name);
 	}
 
 	while (objects) {
@@ -1490,7 +1490,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		o = deref_tag(o, ls->dentry_name, 0);
 		if (o)
 			strbuf_addf(buf, "%s\t%s^{}\n",
-				    sha1_to_hex(o->sha1), ls->dentry_name);
+				    oid_to_hex(&o->oid), ls->dentry_name);
 	}
 	free(ref);
 }
diff --git a/list-objects.c b/list-objects.c
index 41736d23..11732d93 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -84,7 +84,7 @@ static void process_tree(struct rev_info *revs,
 	if (parse_tree_gently(tree, revs->ignore_missing_links) < 0) {
 		if (revs->ignore_missing_links)
 			return;
-		die("bad tree object %s", sha1_to_hex(obj->sha1));
+		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 	obj->flags |= SEEN;
 	show(obj, path, name, cb_data);
@@ -229,7 +229,7 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		}
 		die("unknown pending object %s (%s)",
-		    sha1_to_hex(obj->sha1), name);
+		    oid_to_hex(&obj->oid), name);
 	}
 	object_array_clear(&revs->pending);
 	strbuf_release(&base);
diff --git a/log-tree.c b/log-tree.c
index 947c099f..94de4925 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -342,7 +342,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 {
 	const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
-	const char *name = sha1_to_hex(commit->object.sha1);
+	const char *name = oid_to_hex(&commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 	if (opt->total > 0) {
@@ -503,8 +503,8 @@ static void show_one_mergetag(struct commit *commit,
 	if (parse_tag_buffer(tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
 	else if (is_common_merge(commit) &&
-		 !hashcmp(tag->tagged->sha1,
-			  commit->parents->next->item->object.sha1))
+		 !oidcmp(&tag->tagged->oid,
+			  &commit->parents->next->item->object.oid))
 		strbuf_addf(&verify_message,
 			    "merged tag '%s'\n", tag->tag);
 	else if ((nth = which_parent(get_object_hash(*tag->tagged), commit)) < 0)
@@ -796,19 +796,19 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 {
 	int showed_log;
 	struct commit_list *parents;
-	unsigned const char *sha1;
+	struct object_id *oid;
 
 	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
 		return 0;
 
 	parse_commit_or_die(commit);
-	sha1 = commit->tree->object.sha1;
+	oid = &commit->tree->object.oid;
 
 	/* Root commit? */
 	parents = get_saved_parents(opt, commit);
 	if (!parents) {
 		if (opt->show_root_diff) {
-			diff_root_tree_sha1(sha1, "", &opt->diffopt);
+			diff_root_tree_sha1(oid->hash, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 		}
 		return !opt->loginfo;
@@ -827,8 +827,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			 * we merged _in_.
 			 */
 			parse_commit_or_die(parents->item);
-			diff_tree_sha1(parents->item->tree->object.sha1,
-				       sha1, "", &opt->diffopt);
+			diff_tree_sha1(parents->item->tree->object.oid.hash,
+				       oid->hash, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
 		}
@@ -842,8 +842,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		struct commit *parent = parents->item;
 
 		parse_commit_or_die(parent);
-		diff_tree_sha1(parent->tree->object.sha1,
-			       sha1, "", &opt->diffopt);
+		diff_tree_sha1(parent->tree->object.oid.hash,
+			       oid->hash, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 
 		showed_log |= !opt->loginfo;
diff --git a/merge-recursive.c b/merge-recursive.c
index 60ab95d0..cd34ae55 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -26,17 +26,17 @@
 static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 				      const char *subtree_shift)
 {
-	unsigned char shifted[20];
+	struct object_id shifted;
 
 	if (!*subtree_shift) {
-		shift_tree(get_object_hash(one->object), get_object_hash(two->object), shifted, 0);
+		shift_tree(get_object_hash(one->object), get_object_hash(two->object), shifted.hash, 0);
 	} else {
-		shift_tree_by(get_object_hash(one->object), get_object_hash(two->object), shifted,
+		shift_tree_by(get_object_hash(one->object), get_object_hash(two->object), shifted.hash,
 			      subtree_shift);
 	}
-	if (!hashcmp(two->object.sha1, shifted))
+	if (!oidcmp(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(shifted);
+	return lookup_tree(shifted.hash);
 }
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
@@ -1823,8 +1823,8 @@ int merge_trees(struct merge_options *o,
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
 			die(_("merging of trees %s and %s failed"),
-			    sha1_to_hex(head->object.sha1),
-			    sha1_to_hex(merge->object.sha1));
+			    oid_to_hex(&head->object.oid),
+			    oid_to_hex(&merge->object.oid));
 		else
 			exit(128);
 	}
diff --git a/merge.c b/merge.c
index fcff632b..5db7d56b 100644
--- a/merge.c
+++ b/merge.c
@@ -10,7 +10,7 @@
 static const char *merge_argument(struct commit *commit)
 {
 	if (commit)
-		return sha1_to_hex(commit->object.sha1);
+		return oid_to_hex(&commit->object.oid);
 	else
 		return EMPTY_TREE_SHA1_HEX;
 }
diff --git a/notes-merge.c b/notes-merge.c
index 21e1eb4c..7b1099c9 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -618,8 +618,8 @@ int notes_merge(struct notes_merge_options *o,
 
 	if (o->verbosity >= 4)
 		printf("Merging remote commit %.7s into local commit %.7s with "
-			"merge-base %.7s\n", sha1_to_hex(remote->object.sha1),
-			sha1_to_hex(local->object.sha1),
+			"merge-base %.7s\n", oid_to_hex(&remote->object.oid),
+			oid_to_hex(&local->object.oid),
 			sha1_to_hex(base_sha1));
 
 	if (!hashcmp(get_object_hash(remote->object), base_sha1)) {
diff --git a/object.c b/object.c
index 4a0f4138..c6844c90 100644
--- a/object.c
+++ b/object.c
@@ -168,7 +168,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	else {
 		if (!quiet)
 			error("object %s is a %s, not a %s",
-			      sha1_to_hex(obj->sha1),
+			      oid_to_hex(&obj->oid),
 			      typename(obj->type), typename(type));
 		return NULL;
 	}
diff --git a/object.h b/object.h
index 7c098d03..232727ba 100644
--- a/object.h
+++ b/object.h
@@ -49,10 +49,10 @@ struct object {
 	unsigned used : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
-	unsigned char sha1[20];
+	struct object_id oid;
 };
 
-#define get_object_hash(x) ((x).sha1)
+#define get_object_hash(x) ((x).oid.hash)
 
 extern const char *typename(unsigned int type);
 extern int type_from_string_gently(const char *str, ssize_t, int gentle);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 03f19266..f3bffa7f 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -311,7 +311,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		hash_pos = kh_put_sha1(writer.bitmaps, get_object_hash(*object), &hash_ret);
 		if (hash_ret == 0)
 			die("Duplicate entry when writing index: %s",
-			    sha1_to_hex(object->sha1));
+			    oid_to_hex(&object->oid));
 
 		kh_value(writer.bitmaps, hash_pos) = stored;
 		display_progress(writer.progress, writer.selected_nr - i);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 334108ab..1ee354f3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -906,7 +906,7 @@ static void test_show_object(struct object *object,
 
 	bitmap_pos = bitmap_position(get_object_hash(*object));
 	if (bitmap_pos < 0)
-		die("Object not in bitmap: %s\n", sha1_to_hex(object->sha1));
+		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -919,7 +919,7 @@ static void test_show_commit(struct commit *commit, void *data)
 
 	bitmap_pos = bitmap_position(get_object_hash(commit->object));
 	if (bitmap_pos < 0)
-		die("Object not in bitmap: %s\n", sha1_to_hex(commit->object.sha1));
+		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -950,13 +950,13 @@ void test_bitmap_walk(struct rev_info *revs)
 		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
 
 		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
-			sha1_to_hex(root->sha1), (int)bm->bit_size, ewah_checksum(bm));
+			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
 
 		result = ewah_to_bitmap(bm);
 	}
 
 	if (result == NULL)
-		die("Commit %s doesn't have an indexed bitmap", sha1_to_hex(root->sha1));
+		die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
 
 	revs->tag_objects = 1;
 	revs->tree_objects = 1;
diff --git a/pretty.c b/pretty.c
index fc257ccc..7d88b849 100644
--- a/pretty.c
+++ b/pretty.c
@@ -545,7 +545,7 @@ static void add_merge_info(const struct pretty_print_context *pp,
 		if (pp->abbrev)
 			hex = find_unique_abbrev(get_object_hash(p->object), pp->abbrev);
 		if (!hex)
-			hex = sha1_to_hex(p->object.sha1);
+			hex = oid_to_hex(&p->object.oid);
 		parent = parent->next;
 
 		strbuf_addf(sb, " %s", hex);
@@ -1124,7 +1124,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
-		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(sb, oid_to_hex(&commit->object.oid));
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
@@ -1139,12 +1139,12 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
-		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
+		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
 		return 1;
 	case 't':		/* abbreviated tree hash */
 		if (add_again(sb, &c->abbrev_tree_hash))
 			return 1;
-		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
+		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.oid.hash,
 						     c->pretty_ctx->abbrev));
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return 1;
@@ -1152,7 +1152,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
+			strbuf_addstr(sb, oid_to_hex(&p->item->object.oid));
 		}
 		return 1;
 	case 'p':		/* abbreviated parent hashes */
diff --git a/ref-filter.c b/ref-filter.c
index 25a82a46..2850c311 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -394,7 +394,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		else if (!strcmp(name, "type") && tag->tagged)
 			v->s = typename(tag->tagged->type);
 		else if (!strcmp(name, "object") && tag->tagged)
-			v->s = xstrdup(sha1_to_hex(tag->tagged->sha1));
+			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
 	}
 }
 
@@ -412,7 +412,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "tree")) {
-			v->s = xstrdup(sha1_to_hex(commit->tree->object.sha1));
+			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
 		}
 		else if (!strcmp(name, "numparent")) {
 			v->ul = commit_list_count(commit->parents);
@@ -425,7 +425,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 				struct commit *parent = parents->item;
 				if (parents != commit->parents)
 					strbuf_addch(&s, ' ');
-				strbuf_addstr(&s, sha1_to_hex(parent->object.sha1));
+				strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
 			}
 			v->s = strbuf_detach(&s, NULL);
 		}
@@ -1049,7 +1049,7 @@ struct contains_stack {
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
-		if (!hashcmp(want->item->object.sha1, c->object.sha1))
+		if (!oidcmp(&want->item->object.oid, &c->object.oid))
 			return 1;
 	return 0;
 }
diff --git a/remote.c b/remote.c
index bdae86c6..1abe1de2 100644
--- a/remote.c
+++ b/remote.c
@@ -2031,8 +2031,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	argv_array_push(&argv, ""); /* ignored */
 	argv_array_push(&argv, "--left-right");
 	argv_array_pushf(&argv, "%s...%s",
-			 sha1_to_hex(ours->object.sha1),
-			 sha1_to_hex(theirs->object.sha1));
+			 oid_to_hex(&ours->object.oid),
+			 oid_to_hex(&theirs->object.oid));
 	argv_array_push(&argv, "--");
 
 	init_revisions(&revs, NULL);
diff --git a/revision.c b/revision.c
index 897e9bd0..b49d197c 100644
--- a/revision.c
+++ b/revision.c
@@ -86,7 +86,7 @@ void show_object_with_name(FILE *out, struct object *obj,
 	leaf.elem = component;
 	leaf.elem_len = strlen(component);
 
-	fprintf(out, "%s ", sha1_to_hex(obj->sha1));
+	fprintf(out, "%s ", oid_to_hex(&obj->oid));
 	show_path_truncated(out, &leaf);
 	fputc('\n', out);
 }
@@ -106,10 +106,10 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	struct name_entry entry;
 	struct object *obj = &tree->object;
 
-	if (!has_sha1_file(obj->sha1))
+	if (!has_object_file(&obj->oid))
 		return;
 	if (parse_tree(tree) < 0)
-		die("bad tree %s", sha1_to_hex(obj->sha1));
+		die("bad tree %s", oid_to_hex(&obj->oid));
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
@@ -164,7 +164,7 @@ void mark_parents_uninteresting(struct commit *commit)
 			 * it is popped next time around, we won't be trying
 			 * to parse it and get an error.
 			 */
-			if (!has_sha1_file(commit->object.sha1))
+			if (!has_object_file(&commit->object.oid))
 				commit->object.parsed = 1;
 
 			if (commit->object.flags & UNINTERESTING)
@@ -286,7 +286,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!object) {
 			if (flags & UNINTERESTING)
 				return NULL;
-			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
+			die("bad object %s", oid_to_hex(&tag->tagged->oid));
 		}
 		object->flags |= flags;
 		/*
@@ -610,7 +610,7 @@ static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
 
 		st = lookup_decoration(&revs->treesame, &commit->object);
 		if (!st)
-			die("update_treesame %s", sha1_to_hex(commit->object.sha1));
+			die("update_treesame %s", oid_to_hex(&commit->object.oid));
 		relevant_parents = 0;
 		relevant_change = irrelevant_change = 0;
 		for (p = commit->parents, n = 0; p; n++, p = p->next) {
@@ -708,8 +708,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		}
 		if (parse_commit(p) < 0)
 			die("cannot simplify commit %s (because of %s)",
-			    sha1_to_hex(commit->object.sha1),
-			    sha1_to_hex(p->object.sha1));
+			    oid_to_hex(&commit->object.oid),
+			    oid_to_hex(&p->object.oid));
 		switch (rev_compare_tree(revs, p, commit)) {
 		case REV_TREE_SAME:
 			if (!revs->simplify_history || !relevant_commit(p)) {
@@ -741,8 +741,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 */
 				if (parse_commit(p) < 0)
 					die("cannot simplify commit %s (invalid %s)",
-					    sha1_to_hex(commit->object.sha1),
-					    sha1_to_hex(p->object.sha1));
+					    oid_to_hex(&commit->object.oid),
+					    oid_to_hex(&p->object.oid));
 				p->parents = NULL;
 			}
 		/* fallthrough */
@@ -754,7 +754,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				irrelevant_change = 1;
 			continue;
 		}
-		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
+		die("bad tree compare for commit %s", oid_to_hex(&commit->object.oid));
 	}
 
 	/*
@@ -1189,7 +1189,7 @@ static void add_rev_cmdline_list(struct rev_info *revs,
 {
 	while (commit_list) {
 		struct object *object = &commit_list->item->object;
-		add_rev_cmdline(revs, object, sha1_to_hex(object->sha1),
+		add_rev_cmdline(revs, object, oid_to_hex(&object->oid),
 				whence, flags);
 		commit_list = commit_list->next;
 	}
@@ -1435,7 +1435,7 @@ static void add_pending_commit_list(struct rev_info *revs,
 	while (commit_list) {
 		struct object *object = &commit_list->item->object;
 		object->flags |= flags;
-		add_pending_object(revs, object, sha1_to_hex(object->sha1));
+		add_pending_object(revs, object, oid_to_hex(&object->oid));
 		commit_list = commit_list->next;
 	}
 }
@@ -3094,7 +3094,7 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 		struct commit_list *p;
 		for (p = revs->previous_parents; p; p = p->next)
 			if (p->item == NULL || /* first commit */
-			    !hashcmp(p->item->object.sha1, commit->object.sha1))
+			    !oidcmp(&p->item->object.oid, &commit->object.oid))
 				break;
 		revs->linear = p != NULL;
 	}
@@ -3132,7 +3132,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
-						sha1_to_hex(commit->object.sha1));
+						oid_to_hex(&commit->object.oid));
 			}
 		}
 
@@ -3141,7 +3141,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			continue;
 		case commit_error:
 			die("Failed to simplify parents of commit %s",
-			    sha1_to_hex(commit->object.sha1));
+			    oid_to_hex(&commit->object.oid));
 		default:
 			if (revs->track_linear)
 				track_linear(revs, commit);
diff --git a/sequencer.c b/sequencer.c
index 968c1a5b..129fa8f0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -139,7 +139,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 		git_commit_encoding = "UTF-8";
 
 	out->message = logmsg_reencode(commit, NULL, git_commit_encoding);
-	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev = find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -397,12 +397,12 @@ static int is_original_commit_empty(struct commit *commit)
 
 	if (parse_commit(commit))
 		return error(_("Could not parse commit %s\n"),
-			     sha1_to_hex(commit->object.sha1));
+			     oid_to_hex(&commit->object.oid));
 	if (commit->parents) {
 		struct commit *parent = commit->parents->item;
 		if (parse_commit(parent))
 			return error(_("Could not parse parent commit %s\n"),
-				sha1_to_hex(parent->object.sha1));
+				oid_to_hex(&parent->object.oid));
 		ptree_sha1 = get_object_hash(parent->tree->object);
 	} else {
 		ptree_sha1 = EMPTY_TREE_SHA1_BIN; /* commit is root */
@@ -486,7 +486,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 		if (!opts->mainline)
 			return error(_("Commit %s is a merge but no -m option was given."),
-				sha1_to_hex(commit->object.sha1));
+				oid_to_hex(&commit->object.oid));
 
 		for (cnt = 1, p = commit->parents;
 		     cnt != opts->mainline && p;
@@ -494,11 +494,11 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			p = p->next;
 		if (cnt != opts->mainline || !p)
 			return error(_("Commit %s does not have parent %d"),
-				sha1_to_hex(commit->object.sha1), opts->mainline);
+				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
 	} else if (0 < opts->mainline)
 		return error(_("Mainline was specified but commit %s is not a merge."),
-			sha1_to_hex(commit->object.sha1));
+			oid_to_hex(&commit->object.oid));
 	else
 		parent = commit->parents->item;
 
@@ -511,11 +511,11 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			action_name(opts), sha1_to_hex(parent->object.sha1));
+			action_name(opts), oid_to_hex(&parent->object.oid));
 
 	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
-			sha1_to_hex(commit->object.sha1));
+			oid_to_hex(&commit->object.oid));
 
 	/*
 	 * "commit" is an existing commit.  We would want to apply
@@ -532,11 +532,11 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		strbuf_addstr(&msgbuf, "Revert \"");
 		strbuf_addstr(&msgbuf, msg.subject);
 		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
-		strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 
 		if (commit->parents && commit->parents->next) {
 			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			strbuf_addstr(&msgbuf, sha1_to_hex(parent->object.sha1));
+			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
@@ -562,7 +562,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
+			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 	}
diff --git a/server-info.c b/server-info.c
index c82e9ee3..5a86e297 100644
--- a/server-info.c
+++ b/server-info.c
@@ -62,7 +62,7 @@ static int add_info_ref(const char *path, const struct object_id *oid,
 		o = deref_tag(o, path, 0);
 		if (o)
 			if (fprintf(fp, "%s	%s^{}\n",
-				sha1_to_hex(o->sha1), path) < 0)
+				oid_to_hex(&o->oid), path) < 0)
 				return -1;
 	}
 	return 0;
diff --git a/sha1_name.c b/sha1_name.c
index d94657e3..37ba126d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -738,7 +738,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		o = deref_tag(o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(get_object_hash(*o))))
 			return -1;
-		hashcpy(sha1, o->sha1);
+		hashcpy(sha1, o->oid.hash);
 		return 0;
 	}
 
@@ -1022,7 +1022,7 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 		st = -1;
 	else {
 		st = 0;
-		hashcpy(sha1, mbs->item->object.sha1);
+		hashcpy(sha1, mbs->item->object.oid.hash);
 	}
 	free_commit_list(mbs);
 	return st;
diff --git a/shallow.c b/shallow.c
index 24410db1..e1f772d7 100644
--- a/shallow.c
+++ b/shallow.c
@@ -167,7 +167,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
 				printf("Removing %s from .git/shallow\n",
-				       sha1_to_hex(c->object.sha1));
+				       oid_to_hex(&c->object.oid));
 			return 0;
 		}
 	}
@@ -426,7 +426,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 
 		if (parse_commit(c))
 			die("unable to parse commit %s",
-			    sha1_to_hex(c->object.sha1));
+			    oid_to_hex(&c->object.oid));
 
 		for (p = c->parents; p; p = p->next) {
 			uint32_t **p_refs = ref_bitmap_at(&info->ref_bitmap,
diff --git a/submodule.c b/submodule.c
index 7ea90864..73cd4120 100644
--- a/submodule.c
+++ b/submodule.c
@@ -249,7 +249,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	for (list = merge_bases; list; list = list->next) {
 		list->item->object.flags |= UNINTERESTING;
 		add_pending_object(rev, &list->item->object,
-			sha1_to_hex(list->item->object.sha1));
+			oid_to_hex(&list->item->object.oid));
 	}
 	return prepare_revision_walk(rev);
 }
@@ -875,7 +875,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 
 	/* get all revisions that merge commit a */
 	snprintf(merged_revision, sizeof(merged_revision), "^%s",
-			sha1_to_hex(a->object.sha1));
+			oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
@@ -1006,7 +1006,7 @@ int merge_submodule(unsigned char result[20], const char *path,
 			"by using:\n\n"
 			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
 			"which will accept this suggestion.\n",
-			sha1_to_hex(merges.objects[0].item->sha1), path);
+			oid_to_hex(&merges.objects[0].item->oid), path);
 		break;
 
 	default:
diff --git a/tag.c b/tag.c
index 094616e3..ac014837 100644
--- a/tag.c
+++ b/tag.c
@@ -130,11 +130,11 @@ int parse_tag(struct tag *item)
 	data = read_sha1_file(get_object_hash(item->object), &type, &size);
 	if (!data)
 		return error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	if (type != OBJ_TAG) {
 		free(data);
 		return error("Object %s not a tag",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	}
 	ret = parse_tag_buffer(item, data, size);
 	free(data);
diff --git a/tree.c b/tree.c
index 0c2f2fdb..4964be38 100644
--- a/tree.c
+++ b/tree.c
@@ -216,11 +216,11 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	if (type != OBJ_TREE) {
 		free(buffer);
 		return error("Object %s not a tree",
-			     sha1_to_hex(item->object.sha1));
+			     oid_to_hex(&item->object.oid));
 	}
 	return parse_tree_buffer(item, buffer, size);
 }
@@ -248,6 +248,6 @@ struct tree *parse_tree_indirect(const unsigned char *sha1)
 		else
 			return NULL;
 		if (!obj->parsed)
-			parse_object(obj->sha1);
+			parse_object(obj->oid.hash);
 	} while (1);
 }
diff --git a/upload-pack.c b/upload-pack.c
index cb9cc858..c8295b71 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -130,14 +130,14 @@ static void create_pack_file(void)
 
 	for (i = 0; i < want_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			sha1_to_hex(want_obj.objects[i].item->sha1));
+			oid_to_hex(&want_obj.objects[i].item->oid));
 	fprintf(pipe_fd, "--not\n");
 	for (i = 0; i < have_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			sha1_to_hex(have_obj.objects[i].item->sha1));
+			oid_to_hex(&have_obj.objects[i].item->oid));
 	for (i = 0; i < extra_edge_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			sha1_to_hex(extra_edge_obj.objects[i].item->sha1));
+			oid_to_hex(&extra_edge_obj.objects[i].item->oid));
 	fprintf(pipe_fd, "\n");
 	fflush(pipe_fd);
 	fclose(pipe_fd);
@@ -491,7 +491,7 @@ static void check_non_tip(void)
 			continue;
 		if (!is_our_ref(o))
 			continue;
-		memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
+		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 42) < 0)
 			goto error;
 	}
@@ -500,7 +500,7 @@ static void check_non_tip(void)
 		o = want_obj.objects[i].item;
 		if (is_our_ref(o))
 			continue;
-		memcpy(namebuf, sha1_to_hex(o->sha1), 40);
+		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 41) < 0)
 			goto error;
 	}
@@ -534,7 +534,7 @@ error:
 		o = want_obj.objects[i].item;
 		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
-			    sha1_to_hex(o->sha1));
+			    oid_to_hex(&o->oid));
 	}
 }
 
@@ -646,7 +646,7 @@ static void receive_needs(void)
 			struct object *object = &result->item->object;
 			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
 				packet_write(1, "shallow %s",
-						sha1_to_hex(object->sha1));
+						oid_to_hex(&object->oid));
 				register_shallow(get_object_hash(*object));
 				shallow_nr++;
 			}
@@ -658,7 +658,7 @@ static void receive_needs(void)
 			if (object->flags & NOT_SHALLOW) {
 				struct commit_list *parents;
 				packet_write(1, "unshallow %s",
-					sha1_to_hex(object->sha1));
+					oid_to_hex(&object->oid));
 				object->flags &= ~CLIENT_SHALLOW;
 				/* make sure the real parents are parsed */
 				unregister_shallow(get_object_hash(*object));
diff --git a/walker.c b/walker.c
index 7d1ee30b..4eb4df8f 100644
--- a/walker.c
+++ b/walker.c
@@ -19,7 +19,7 @@ static void report_missing(const struct object *obj)
 {
 	fprintf(stderr, "Cannot obtain needed %s %s\n",
 		obj->type ? typename(obj->type): "object",
-		sha1_to_hex(obj->sha1));
+		oid_to_hex(&obj->oid));
 	if (!is_null_sha1(current_commit_sha1))
 		fprintf(stderr, "while processing commit %s.\n",
 			sha1_to_hex(current_commit_sha1));
@@ -80,7 +80,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 
 	hashcpy(current_commit_sha1, get_object_hash(commit->object));
 
-	walker_say(walker, "walk %s\n", sha1_to_hex(commit->object.sha1));
+	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
 
 	if (walker->get_tree) {
 		if (process(walker, &commit->tree->object))
@@ -130,7 +130,7 @@ static int process_object(struct walker *walker, struct object *obj)
 	}
 	return error("Unable to determine requirements "
 		     "of type %s for %s",
-		     typename(obj->type), sha1_to_hex(obj->sha1));
+		     typename(obj->type), oid_to_hex(&obj->oid));
 }
 
 static int process(struct walker *walker, struct object *obj)
@@ -139,7 +139,7 @@ static int process(struct walker *walker, struct object *obj)
 		return 0;
 	obj->flags |= SEEN;
 
-	if (has_sha1_file(obj->sha1)) {
+	if (has_object_file(&obj->oid)) {
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	}
-- 
2.6.2.409.gb049f0a
