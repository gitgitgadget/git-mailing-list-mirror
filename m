Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D5C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 21:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiAKVjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiAKVjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 16:39:47 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548DC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 13:39:46 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y17so778902qtx.9
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 13:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ax2LhUXC2Nu9QMLyN+2Co+YJfFaDdHolP75jND4SzoE=;
        b=oKMl3ucToaIR8zfxUd1RCMvjKi2faOCYgQiuXTyHnGURZQt2CDSeKfkLQktcYUoepO
         2Lrc4jRWmGbNDrjgC4wZ1x9bcvm8/Zxz6iLu7RIbARqtb3TZAbpl4ndrPpICTmTYLMWJ
         sOLRWGB8o8SrxkHGvXJCtPy2Fc8fYbCXQWI/RUg5Rs8ReSXFi1NJrM3JoUrBRD1x9ja3
         wXgH+mo2I7RCad5HrTfkk2XsYf/Uvfj5XH595K+f7aQDP2enR0lF4J5++OHQcwfTTAUH
         pv9IDwLGDO4XjMElYD2xZFvEdQ7ZHMxYf7mx09kFa03ySANOaAur3p7U/47iYEoZhjNx
         i4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ax2LhUXC2Nu9QMLyN+2Co+YJfFaDdHolP75jND4SzoE=;
        b=KZFmTl6HjwescDvD/P0b5cRqN/gH9nG8wM6EKn7y1tA1cEgyjECRk9m8WO9AgspmNr
         TlCd1sPMVC6cbGyNpSl4a2W6sd5lYU9j7s9duTDi1yDjXF1L2MBwTqetM5EvSog1WuKA
         K+Rxg551K7hxpqy2MTZyVSYUy3LSC0UpprzMnuYlvVorAh1Nnuh5BdwSHvbZB/cy6qRZ
         bsKYFkVm1WKDAnHpop51DS5ugDdqC1+/aNyUPMWZru3zoEegwa2zpg9S9CxdtUpZgBSi
         lN1EV9ViTYSPDom5rJHmOcDzKC41DAGL1FAreKLw0Z/Qd+tvF+sXqMRDKBr4Qrkzv+nh
         /LtA==
X-Gm-Message-State: AOAM532M5y9Sze6e9SugfW20I3cyYg2E7i0jfPOB3wQwtHgsifRonqqY
        t8o8SoFacgeeLf0O5FE4ObQHcyk8i6fKqA==
X-Google-Smtp-Source: ABdhPJydrKxt0ltfgYsvsjp5LyfoIYBYLsRhp7Gcl66oTM594c+NmpCTH/lNxYQIJJoArN+VzM8apg==
X-Received: by 2002:a05:622a:15cc:: with SMTP id d12mr5429869qty.190.1641937185480;
        Tue, 11 Jan 2022 13:39:45 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id c7sm8072874qtx.67.2022.01.11.13.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:39:44 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V4] git-rev-list: add --exclude-first-parent-only flag
Date:   Tue, 11 Jan 2022 13:39:41 -0800
Message-Id: <20220111213941.30129-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.0.rc0.1.g35997f12ab
In-Reply-To: <20220105232755.23523-1-jerry@skydio.com>
References: <20220105232755.23523-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful to know when a branch first diverged in history
from some integration branch in order to be able to enumerate
the user's local changes. However, these local changes can
include arbitrary merges, so it is necessary to ignore this
merge structure when finding the divergence point.

In order to do this, teach the "rev-list" family to accept
"--exclude-first-parent-only", which restricts the traversal
of excluded commits to only follow first parent links.

   -A-----E-F-G--main
     \   / /
      B-C-D--topic

In this example, the goal is to return the set {B, C, D} which
represents a topic branch that has been merged into main branch.
`git rev-list topic ^main` will end up returning no commits
since excluding main will end up traversing the commits on topic
as well. `git rev-list --exclude-first-parent-only topic ^main`
however will return {B, C, D} as desired.

Add docs for the new flag, and clarify the doc for --first-parent
to indicate that it applies to traversing the set of included
commits only.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V3->V4:
- Updated flag name
- Updated doc and commit text to describe the exact use-case

 Documentation/rev-list-options.txt | 22 +++++++++++++++-------
 blame.c                            |  2 +-
 revision.c                         | 30 ++++++++++++++++++++----------
 revision.h                         |  3 ++-
 shallow.c                          |  2 +-
 t/t6012-rev-list-simplify.sh       | 18 ++++++++++++------
 6 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 43a86fa562..fd4f4e26c9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -120,23 +120,31 @@ providing this option will cause it to die.
 `--no-min-parents` and `--no-max-parents` reset these limits (to no limit)
 again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
 parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
 --first-parent::
-	Follow only the first parent commit upon seeing a merge
-	commit.  This option can give a better overview when
-	viewing the evolution of a particular topic branch,
-	because merges into a topic branch tend to be only about
-	adjusting to updated upstream from time to time, and
-	this option allows you to ignore the individual commits
-	brought in to your history by such a merge.
+	When finding commits to include, follow only the first
+	parent commit upon seeing a merge commit.  This option
+	can give a better overview when viewing the evolution of
+	a particular topic branch, because merges into a topic
+	branch tend to be only about adjusting to updated upstream
+	from time to time, and this option allows you to ignore
+	the individual commits brought in to your history by such
+	a merge.
 ifdef::git-log[]
 +
 This option also changes default diff format for merge commits
 to `first-parent`, see `--diff-merges=first-parent` for details.
 endif::git-log[]
 
+--exclude-first-parent-only::
+	When finding commits to exclude (with a '{caret}'), follow only
+	the first parent commit upon seeing a merge commit.
+	This can be used to find the set of changes in a topic branch
+	from the point where it diverged from the remote branch, given
+	that arbitrary merges can be valid topic branch changes.
+
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
 
 --all::
diff --git a/blame.c b/blame.c
index 206c295660..083d99fdbc 100644
--- a/blame.c
+++ b/blame.c
@@ -2613,11 +2613,11 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
 		else {
 			commit->object.flags |= UNINTERESTING;
 			if (commit->object.parsed)
-				mark_parents_uninteresting(commit);
+				mark_parents_uninteresting(sb->revs, commit);
 		}
 		/* treat root commit as boundary */
 		if (!commit->parents && !sb->show_root)
 			commit->object.flags |= UNINTERESTING;
 
diff --git a/revision.c b/revision.c
index ad4286fbdd..d8d326d6b0 100644
--- a/revision.c
+++ b/revision.c
@@ -271,11 +271,11 @@ static void commit_stack_clear(struct commit_stack *stack)
 {
 	FREE_AND_NULL(stack->items);
 	stack->nr = stack->alloc = 0;
 }
 
-static void mark_one_parent_uninteresting(struct commit *commit,
+static void mark_one_parent_uninteresting(struct rev_info *revs, struct commit *commit,
 					  struct commit_stack *pending)
 {
 	struct commit_list *l;
 
 	if (commit->object.flags & UNINTERESTING)
@@ -288,24 +288,30 @@ static void mark_one_parent_uninteresting(struct commit *commit,
 	 * here. However, it may turn out that we've
 	 * reached this commit some other way (where it
 	 * wasn't uninteresting), in which case we need
 	 * to mark its parents recursively too..
 	 */
-	for (l = commit->parents; l; l = l->next)
+	for (l = commit->parents; l; l = l->next) {
 		commit_stack_push(pending, l->item);
+		if (revs && revs->exclude_first_parent_only)
+			break;
+	}
 }
 
-void mark_parents_uninteresting(struct commit *commit)
+void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_stack pending = COMMIT_STACK_INIT;
 	struct commit_list *l;
 
-	for (l = commit->parents; l; l = l->next)
-		mark_one_parent_uninteresting(l->item, &pending);
+	for (l = commit->parents; l; l = l->next) {
+		mark_one_parent_uninteresting(revs, l->item, &pending);
+		if (revs && revs->exclude_first_parent_only)
+			break;
+	}
 
 	while (pending.nr > 0)
-		mark_one_parent_uninteresting(commit_stack_pop(&pending),
+		mark_one_parent_uninteresting(revs, commit_stack_pop(&pending),
 					      &pending);
 
 	commit_stack_clear(&pending);
 }
 
@@ -439,11 +445,11 @@ static struct commit *handle_commit(struct rev_info *revs,
 		struct commit *commit = (struct commit *)object;
 
 		if (repo_parse_commit(revs->repo, commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 
 			if (!revs->topo_order || !generation_numbers_enabled(the_repository))
 				revs->limited = 1;
 		}
 		if (revs->sources) {
@@ -1122,18 +1128,20 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (p)
 				p->object.flags |= UNINTERESTING;
 			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
 				continue;
 			if (p->parents)
-				mark_parents_uninteresting(p);
+				mark_parents_uninteresting(revs, p);
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
 				commit_list_insert_by_date(p, list);
 			if (queue)
 				prio_queue_put(queue, p);
+			if (revs->exclude_first_parent_only)
+				break;
 		}
 		return 0;
 	}
 
 	/*
@@ -1420,11 +1428,11 @@ static int limit_list(struct rev_info *revs)
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
 		if (process_parents(revs, commit, &original_list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 			slop = still_interesting(original_list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
 			break;
 		}
@@ -2221,10 +2229,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("until", argv, &optarg))) {
 		revs->min_age = approxidate(optarg);
 		return argcount;
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
+	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
+		revs->exclude_first_parent_only = 1;
 	} else if (!strcmp(arg, "--ancestry-path")) {
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
@@ -3343,11 +3353,11 @@ static void explore_walk_step(struct rev_info *revs)
 
 	if (process_parents(revs, c, NULL, NULL) < 0)
 		return;
 
 	if (c->object.flags & UNINTERESTING)
-		mark_parents_uninteresting(c);
+		mark_parents_uninteresting(revs, c);
 
 	for (p = c->parents; p; p = p->next)
 		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
 }
 
diff --git a/revision.h b/revision.h
index 3f66147bfd..374a4ff468 100644
--- a/revision.h
+++ b/revision.h
@@ -156,10 +156,11 @@ struct rev_info {
 			cherry_pick:1,
 			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
+			exclude_first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
 
 			/*
 			 * Blobs are shown without regard for their existence.
@@ -396,11 +397,11 @@ struct commit *get_revision(struct rev_info *revs);
 const char *get_revision_mark(const struct rev_info *revs,
 			      const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
-void mark_parents_uninteresting(struct commit *commit);
+void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
 void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
diff --git a/shallow.c b/shallow.c
index 9ed18eb884..71e5876f37 100644
--- a/shallow.c
+++ b/shallow.c
@@ -601,11 +601,11 @@ static int mark_uninteresting(const char *refname, const struct object_id *oid,
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
-	mark_parents_uninteresting(commit);
+	mark_parents_uninteresting(NULL, commit);
 	return 0;
 }
 
 static void post_assign_shallow(struct shallow_info *info,
 				struct ref_bitmap *ref_bitmap,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 4f7fa8b6c0..e2851fd75d 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -14,17 +14,16 @@ note () {
 unnote () {
 	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
 }
 
 #
-# Create a test repo with interesting commit graph:
+# Create a test repo with an interesting commit graph:
 #
-# A--B----------G--H--I--K--L
-#  \  \           /     /
-#   \  \         /     /
-#    C------E---F     J
-#        \_/
+# A-----B-----G--H--I--K--L
+#  \     \      /     /
+#   \     \    /     /
+#    C--D--E--F     J
 #
 # The commits are laid out from left-to-right starting with
 # the root commit A and terminating at the tip commit L.
 #
 # There are a few places where we adjust the commit date or
@@ -140,10 +139,17 @@ check_result 'I B A' --topo-order -- file
 check_result 'I B A' --date-order -- file
 check_result 'I B A' --author-date-order -- file
 check_result 'H' --first-parent -- another-file
 check_result 'H' --first-parent --topo-order -- another-file
 
+check_result 'L K I H G B A' --first-parent L
+check_result 'F E D C' --exclude-first-parent-only F ^L
+check_result '' F ^L
+check_result 'L K I H G J' L ^F
+check_result 'L K I H G B J' --exclude-first-parent-only L ^F
+check_result 'L K I H G B' --exclude-first-parent-only --first-parent L ^F
+
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
 	printf "%s\n" E C B A >expect &&
 	git log --pretty="$FMT" --full-history E -- lost |
 	unnote >actual &&
-- 
2.32.0.1314.g6ed4fcc4cc

