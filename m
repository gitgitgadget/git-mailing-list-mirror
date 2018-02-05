Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208B01F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBFANp (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:13:45 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36948 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFANc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:13:32 -0500
Received: by mail-pl0-f66.google.com with SMTP id ay8so114058plb.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P4cDL7bcG0zRmpeSz3aQadTDkFkL2tAodZCZ4LkPt5s=;
        b=RffXPA9vVm2bWzpG0Jm+mJRReOKyZMlzh3CKcQyRshThNiw21nKZ9Cb1uiFqScczQC
         14vjQ/Hztw4aEfXc5zr2EdUqBfe1QMWCGRGjE4lip6L+qgxoFg0HUTkhnQDduzOF2s34
         VU1kAraf6NDw2JTk5b77Vr4ROE1DXLOAqy5ZgL2dcFnd9hgAgeDUTP2Y6zGri2un4v3F
         AFesfyNJa+LpIl2q5uAbAelwEt9z2pSIGjYqa9CazzIvjvfliChhdIYFGrIG8YX8nhzN
         BOiSCVCxoVohv6A8HLznbYtFC8HKH/R1ayJxqET+BrrBJ9bR62pKUuo2bC0Azu9wYwSy
         0Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P4cDL7bcG0zRmpeSz3aQadTDkFkL2tAodZCZ4LkPt5s=;
        b=KitL9L8bg2SEtosnliEzzeZ/LKywaQ3zmLk5UNvqBvtvmhL2kH1VoxLFS9BScNYoat
         rAG+p5sAIvIOUHtWJzDnkJgtCIMcetoVu2VCMq0h8SBI4WsdrbJULgaQTxqCUXAXPvqq
         t+2pKdoE9IPPWUm/5WnHZ3eplrT+WimrK3NVZ3iFs0IneTArFUJoS1ZcTXyERq3hCGhE
         793x9NmIVwMB6AC0afQexA/nzTsyroUgcWHmi85I8aXFFXrDhkZK7y2oCa1ewJcnsmiJ
         JCFYPtaaLkWAzFfkCgLGHxYDTNh/i8tfiajXf29MU6p3SdpEa+MJPqK/8+vV1DUFNm1w
         1cBg==
X-Gm-Message-State: APf1xPAhkvgU22j9qltzPQFdtuNYqpZCPFw9PwH5RsY+8ywO7ir97EmT
        6qWsg6tF60QcNHOwLrxXDtFDtUEOCeI=
X-Google-Smtp-Source: AH8x227hJZMkdBDmWktKtxNI2fyHGPpg4Vn+zEO8Uqy9K7jcJ0rNOld5hCn+7UuzT6Tt35zytWIonw==
X-Received: by 2002:a17:902:34f:: with SMTP id 73-v6mr548256pld.122.1517876011618;
        Mon, 05 Feb 2018 16:13:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v73sm19184390pfk.84.2018.02.05.16.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:13:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 090/194] object: add repository argument to lookup_commit_reference
Date:   Mon,  5 Feb 2018 15:55:51 -0800
Message-Id: <20180205235735.216710-70-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of lookup_commit_reference
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bisect.c                               |  2 +-
 blame.c                                |  2 +-
 branch.c                               |  2 +-
 builtin/branch.c                       |  7 ++++---
 builtin/clone.c                        |  3 ++-
 builtin/describe.c                     |  2 +-
 builtin/diff-tree.c                    |  2 +-
 builtin/log.c                          |  7 ++++---
 builtin/merge-base.c                   |  5 +++--
 builtin/notes.c                        |  3 ++-
 builtin/pull.c                         | 15 ++++++++++-----
 builtin/reset.c                        |  4 ++--
 builtin/rev-parse.c                    |  6 +++---
 builtin/show-branch.c                  |  2 +-
 builtin/tag.c                          |  2 +-
 bundle.c                               |  3 ++-
 commit.c                               |  6 +++---
 commit.h                               |  4 +++-
 contrib/coccinelle/object_parser.cocci |  7 +++++++
 notes-merge.c                          |  5 +++--
 parse-options-cb.c                     |  2 +-
 remote.c                               |  4 ++--
 revision.c                             |  4 ++--
 sequencer.c                            |  4 ++--
 sha1_name.c                            |  4 ++--
 submodule.c                            | 10 +++++-----
 26 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2f3008b078..c3066bd972 100644
--- a/bisect.c
+++ b/bisect.c
@@ -717,7 +717,7 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 
 static struct commit *get_commit_reference(const struct object_id *oid)
 {
-	struct commit *r = lookup_commit_reference(oid);
+	struct commit *r = lookup_commit_reference(the_repository, oid);
 	if (!r)
 		die(_("Not a valid commit name %s"), oid_to_hex(oid));
 	return r;
diff --git a/blame.c b/blame.c
index 98761c32d5..1aab6228cc 100644
--- a/blame.c
+++ b/blame.c
@@ -101,7 +101,7 @@ static struct commit_list **append_parent(struct commit_list **tail, const struc
 {
 	struct commit *parent;
 
-	parent = lookup_commit_reference(oid);
+	parent = lookup_commit_reference(the_repository, oid);
 	if (!parent)
 		die("no such commit %s", oid_to_hex(oid));
 	return &commit_list_insert(parent, tail)->next;
diff --git a/branch.c b/branch.c
index 2672054f0b..0b7aaa1aca 100644
--- a/branch.c
+++ b/branch.c
@@ -301,7 +301,7 @@ void create_branch(const char *name, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(&oid)) == NULL)
+	if ((commit = lookup_commit_reference(the_repository, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
 	oidcpy(&oid, &commit->object.oid);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed058..2d752c6614 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -126,7 +126,8 @@ static int branch_merged(int kind, const char *name,
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(upstream, RESOLVE_REF_READING,
 				    &oid, NULL)) != NULL)
-			reference_rev = lookup_commit_reference(&oid);
+			reference_rev = lookup_commit_reference(the_repository,
+								&oid);
 	}
 	if (!reference_rev)
 		reference_rev = head_rev;
@@ -159,7 +160,7 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
 			       int kinds, int force)
 {
-	struct commit *rev = lookup_commit_reference(oid);
+	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!rev) {
 		error(_("Couldn't look up commit object for '%s'"), refname);
 		return -1;
@@ -213,7 +214,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 
 	if (!force) {
-		head_rev = lookup_commit_reference(&head_oid);
+		head_rev = lookup_commit_reference(the_repository, &head_oid);
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
diff --git a/builtin/clone.c b/builtin/clone.c
index ecd71b9444..6efe189846 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -690,7 +690,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(&our->old_oid);
+		struct commit *c = lookup_commit_reference(the_repository,
+							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
diff --git a/builtin/describe.c b/builtin/describe.c
index f1172a8bf0..5bd0920ebd 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -295,7 +295,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
-	cmit = lookup_commit_reference(oid);
+	cmit = lookup_commit_reference(the_repository, oid);
 
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index ab491efa9e..603f619532 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -11,7 +11,7 @@ static struct rev_info log_tree_opt;
 
 static int diff_tree_commit_oid(const struct object_id *oid)
 {
-	struct commit *commit = lookup_commit_reference(oid);
+	struct commit *commit = lookup_commit_reference(the_repository, oid);
 	if (!commit)
 		return -1;
 	return log_tree_commit(&log_tree_opt, commit);
diff --git a/builtin/log.c b/builtin/log.c
index 2c3579b1f7..529e19ce6f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -901,8 +901,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	o2 = rev->pending.objects[1].item;
 	flags1 = o1->flags;
 	flags2 = o2->flags;
-	c1 = lookup_commit_reference(&o1->oid);
-	c2 = lookup_commit_reference(&o2->oid);
+	c1 = lookup_commit_reference(the_repository, &o1->oid);
+	c2 = lookup_commit_reference(the_repository, &o2->oid);
 
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
@@ -1850,7 +1850,8 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 {
 	struct object_id oid;
 	if (get_oid(arg, &oid) == 0) {
-		struct commit *commit = lookup_commit_reference(&oid);
+		struct commit *commit = lookup_commit_reference(the_repository,
+								&oid);
 		if (commit) {
 			commit->object.flags |= flags;
 			add_pending_object(revs, &commit->object, arg);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 3b7600150b..bbead6f33e 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "parse-options.h"
+#include "repository.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
@@ -42,7 +43,7 @@ static struct commit *get_commit_reference(const char *arg)
 
 	if (get_oid(arg, &revkey))
 		die("Not a valid object name %s", arg);
-	r = lookup_commit_reference(&revkey);
+	r = lookup_commit_reference(the_repository, &revkey);
 	if (!r)
 		die("Not a valid commit name %s", arg);
 
@@ -171,7 +172,7 @@ static int handle_fork_point(int argc, const char **argv)
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
-	derived = lookup_commit_reference(&oid);
+	derived = lookup_commit_reference(the_repository, &oid);
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
diff --git a/builtin/notes.c b/builtin/notes.c
index 1bd3994caa..18128eb439 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "notes.h"
 #include "object-store.h"
+#include "repository.h"
 #include "blob.h"
 #include "pretty.h"
 #include "refs.h"
@@ -711,7 +712,7 @@ static int merge_commit(struct notes_merge_options *o)
 
 	if (get_oid("NOTES_MERGE_PARTIAL", &oid))
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
-	else if (!(partial = lookup_commit_reference(&oid)))
+	else if (!(partial = lookup_commit_reference(the_repository, &oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
 	else if (parse_commit(partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
diff --git a/builtin/pull.c b/builtin/pull.c
index 511dbbe0f6..90aa922260 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -758,10 +758,13 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 {
 	struct commit_list *revs = NULL, *result;
 
-	commit_list_insert(lookup_commit_reference(curr_head), &revs);
-	commit_list_insert(lookup_commit_reference(merge_head), &revs);
+	commit_list_insert(lookup_commit_reference(the_repository, curr_head),
+			   &revs);
+	commit_list_insert(lookup_commit_reference(the_repository, merge_head),
+			   &revs);
 	if (!is_null_oid(fork_point))
-		commit_list_insert(lookup_commit_reference(fork_point), &revs);
+		commit_list_insert(lookup_commit_reference(the_repository, fork_point),
+				   &revs);
 
 	result = get_octopus_merge_bases(revs);
 	free_commit_list(revs);
@@ -935,9 +938,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			struct commit_list *list = NULL;
 			struct commit *merge_head, *head;
 
-			head = lookup_commit_reference(&orig_head);
+			head = lookup_commit_reference(the_repository,
+						       &orig_head);
 			commit_list_insert(head, &list);
-			merge_head = lookup_commit_reference(&merge_heads.oid[0]);
+			merge_head = lookup_commit_reference(the_repository,
+							     &merge_heads.oid[0]);
 			if (is_descendant_of(merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
diff --git a/builtin/reset.c b/builtin/reset.c
index e15f595799..ea600bc62a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -327,7 +327,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		struct commit *commit;
 		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
-		commit = lookup_commit_reference(&oid);
+		commit = lookup_commit_reference(the_repository, &oid);
 		if (!commit)
 			die(_("Could not parse object '%s'."), rev);
 		oidcpy(&oid, &commit->object.oid);
@@ -404,7 +404,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		update_ref_status = reset_refs(rev, &oid);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
-			print_new_head_line(lookup_commit_reference(&oid));
+			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
 	if (!pathspec.nr)
 		remove_branch_state();
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 74aa644cbb..b5515df1ae 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -280,8 +280,8 @@ static int try_difference(const char *arg)
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
-			a = lookup_commit_reference(&oid);
-			b = lookup_commit_reference(&end);
+			a = lookup_commit_reference(the_repository, &oid);
+			b = lookup_commit_reference(the_repository, &end);
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
@@ -333,7 +333,7 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 	}
 
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents)) {
 		*dotdot = '^';
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index fb90c9ab3e..03c98efbe5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -811,7 +811,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			       MAX_REVS), MAX_REVS);
 		if (get_oid(ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
-		commit = lookup_commit_reference(&revkey);
+		commit = lookup_commit_reference(the_repository, &revkey);
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
diff --git a/builtin/tag.c b/builtin/tag.c
index 014d7c9e9b..1fad1e6733 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -309,7 +309,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		}
 		free(buf);
 
-		if ((c = lookup_commit_reference(oid)) != NULL)
+		if ((c = lookup_commit_reference(the_repository, oid)) != NULL)
 			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
diff --git a/bundle.c b/bundle.c
index 1b5f1beb3b..d9579f851e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -378,7 +378,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			 * in terms of a tag (e.g. v2.0 from the range
 			 * "v1.0..v2.0")?
 			 */
-			struct commit *one = lookup_commit_reference(&oid);
+			struct commit *one = lookup_commit_reference(the_repository,
+								     &oid);
 			struct object *obj;
 
 			if (e->item == &(one->object)) {
diff --git a/commit.c b/commit.c
index b6e253f1af..b943b97aee 100644
--- a/commit.c
+++ b/commit.c
@@ -32,14 +32,14 @@ struct commit *lookup_commit_reference_gently_the_repository(
 	return object_as_type(obj, OBJ_COMMIT, quiet);
 }
 
-struct commit *lookup_commit_reference(const struct object_id *oid)
+struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
 {
 	return lookup_commit_reference_gently(the_repository, oid, 0);
 }
 
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
 {
-	struct commit *c = lookup_commit_reference(oid);
+	struct commit *c = lookup_commit_reference(the_repository, oid);
 	if (!c)
 		die(_("could not parse %s"), ref_name);
 	if (oidcmp(oid, &c->object.oid)) {
@@ -65,7 +65,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 
 	if (get_oid_committish(name, &oid))
 		return NULL;
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (parse_commit(commit))
 		return NULL;
 	return commit;
diff --git a/commit.h b/commit.h
index 2ce5597066..9159165fde 100644
--- a/commit.h
+++ b/commit.h
@@ -47,7 +47,9 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(const struct object_id *oid);
-struct commit *lookup_commit_reference(const struct object_id *oid);
+#define lookup_commit_reference(r, o) \
+		lookup_commit_reference_##r(o)
+struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
 #define lookup_commit_reference_gently(r, o, q) \
 		lookup_commit_reference_gently_##r(o, q)
 struct commit *lookup_commit_reference_gently_the_repository(
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 7c1ef62e6d..bc00029f8c 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -67,3 +67,10 @@ expression F;
  lookup_commit_reference_gently(
 +the_repository,
  E, F)
+
+@@
+expression E;
+@@
+ lookup_commit_reference(
++the_repository,
+ E)
diff --git a/notes-merge.c b/notes-merge.c
index 1053c65e83..ea701827ba 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "refs.h"
 #include "object-store.h"
+#include "repository.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
@@ -553,7 +554,7 @@ int notes_merge(struct notes_merge_options *o,
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
 		local = NULL; /* local_oid == null_oid indicates unborn ref */
-	else if (!(local = lookup_commit_reference(&local_oid)))
+	else if (!(local = lookup_commit_reference(the_repository, &local_oid)))
 		die("Could not parse local commit %s (%s)",
 		    oid_to_hex(&local_oid), o->local_ref);
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
@@ -571,7 +572,7 @@ int notes_merge(struct notes_merge_options *o,
 			die("Failed to resolve remote notes ref '%s'",
 			    o->remote_ref);
 		}
-	} else if (!(remote = lookup_commit_reference(&remote_oid))) {
+	} else if (!(remote = lookup_commit_reference(the_repository, &remote_oid))) {
 		die("Could not parse remote commit %s (%s)",
 		    oid_to_hex(&remote_oid), o->remote_ref);
 	}
diff --git a/parse-options-cb.c b/parse-options-cb.c
index c6679cb2cd..624fcee6f4 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -87,7 +87,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 		return -1;
 	if (get_oid(arg, &oid))
 		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
 		return error("no such commit %s", arg);
 	commit_list_insert(commit, opt->value);
diff --git a/remote.c b/remote.c
index a9386476fe..ecfa60a975 100644
--- a/remote.c
+++ b/remote.c
@@ -2039,13 +2039,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, &oid))
 		return -1;
-	theirs = lookup_commit_reference(&oid);
+	theirs = lookup_commit_reference(the_repository, &oid);
 	if (!theirs)
 		return -1;
 
 	if (read_ref(branch->refname, &oid))
 		return -1;
-	ours = lookup_commit_reference(&oid);
+	ours = lookup_commit_reference(the_repository, &oid);
 	if (!ours)
 		return -1;
 
diff --git a/revision.c b/revision.c
index 629af0dca5..5c5375ac54 100644
--- a/revision.c
+++ b/revision.c
@@ -1563,8 +1563,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		struct commit *a, *b;
 		struct commit_list *exclude;
 
-		a = lookup_commit_reference(&a_obj->oid);
-		b = lookup_commit_reference(&b_obj->oid);
+		a = lookup_commit_reference(the_repository, &a_obj->oid);
+		b = lookup_commit_reference(the_repository, &b_obj->oid);
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
diff --git a/sequencer.c b/sequencer.c
index d0c3c808aa..d24586bc6f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -857,7 +857,7 @@ static int update_squash_messages(enum todo_command command,
 
 		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(&head)))
+		if (!(head_commit = lookup_commit_reference(the_repository, &head)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
@@ -1300,7 +1300,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (status < 0)
 		return -1;
 
-	item->commit = lookup_commit_reference(&commit_oid);
+	item->commit = lookup_commit_reference(the_repository, &commit_oid);
 	return !item->commit;
 }
 
diff --git a/sha1_name.c b/sha1_name.c
index 160fec7062..ea169a28c1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -849,7 +849,7 @@ static int get_parent(const char *name, int len,
 
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
@@ -877,7 +877,7 @@ static int get_nth_ancestor(const char *name, int len,
 	ret = get_oid_1(name, len, &oid, GET_OID_COMMITTISH);
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
 		return -1;
 
diff --git a/submodule.c b/submodule.c
index 1504812842..aec62e6c7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -515,8 +515,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(one);
-	*right = lookup_commit_reference(two);
+	*left = lookup_commit_reference(the_repository, one);
+	*right = lookup_commit_reference(the_repository, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -1820,9 +1820,9 @@ int merge_submodule(struct object_id *result, const char *path,
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(base)) ||
-	    !(commit_a = lookup_commit_reference(a)) ||
-	    !(commit_b = lookup_commit_reference(b))) {
+	if (!(commit_base = lookup_commit_reference(the_repository, base)) ||
+	    !(commit_a = lookup_commit_reference(the_repository, a)) ||
+	    !(commit_b = lookup_commit_reference(the_repository, b))) {
 		MERGE_WARNING(path, "commits not present");
 		return 0;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

