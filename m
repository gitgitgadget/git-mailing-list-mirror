Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE00C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7FF610A7
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhDQAPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQAPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 20:15:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A2C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 17:15:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so10620972pja.5
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/RyzPiUF0jIzfcwQ6l5NUdbOre18DA56TOOkRAW6do=;
        b=ypqfZTaD/BBHjK1DlBWJZ1gUqT64+sDhI2GZcrp3MvHEYyFSSEKIt0HLUFaL6WvA96
         XoK4VvPVhXFbQmPyxO3NUzd3pefoHrmbxxyW5Wv+ZX4Bkcb6L9UFZgxTuQzpxyDZlI01
         za6iSJDd+T+5vFF52Ga85VikXcf0OZma2xGfhjgw1XReDqheXiIQTs4nOHYqF7UKDZ4d
         5qgfVYIYlj3ZT1blwn1JIi5J//4BaCMynsgvrqMyrDZFue5ngQ1gipHgT8Uj65c0dz3C
         uLaOK6vTiLvxz3Np4JkDx3xMCpcXC6UeylPF/XjwatvXnTso0HiAjnnCr5BxLE0matQc
         4sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/RyzPiUF0jIzfcwQ6l5NUdbOre18DA56TOOkRAW6do=;
        b=hQ1axANjkJ0c4n0q9VQ02TwqKsNP9J3ZNmN1r2DqfAj1abK7L48+Pt33ZOnQSJvERl
         5oqYKuY1fYpg9OXwcZYQvfWM2eh/Uk4IEQyq6P7UIbPusgAFf/nJPGZx1wVjzRZgUbxi
         prYgSllyPaycBfnrMz8bJlbE1Z+1nLuc+uZRQnREYePWiRUzi0TBnUOGb9i7l2LA/Aee
         UG4BrWFW5jAqGd5to/cMvD895zVKGS7eTavllcMjlVUyPF4L0djduXM3UTUm8rUD22bC
         ZrCadOS6bYFznSsDLjhqGiOt5VHfVwAacmqVRn2e/JYknzqZPs/Vt9u8dKNnw50LL8QH
         LzNg==
X-Gm-Message-State: AOAM5335JuhgMezSRiLVHpmAOrPbiAUdzspgkuyn4H72Uwju+Aa5MXtR
        I01Ney/IWdGQHtm9WkYjyvgFKhx1jZFJicLh
X-Google-Smtp-Source: ABdhPJxdAvh+3sjOkl6+nZs0N2SpXnVo6zRq70Wx2rfS+0MuWUPN2eTA9Y5QodLjZPHkKfIkcnK6BQ==
X-Received: by 2002:a17:90b:285:: with SMTP id az5mr12080456pjb.0.1618618527862;
        Fri, 16 Apr 2021 17:15:27 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id ms8sm6415229pjb.57.2021.04.16.17.15.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 17:15:27 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-rev-list: add --exclude-path-first-parent flag
Date:   Fri, 16 Apr 2021 17:15:25 -0700
Message-Id: <20210417001525.19960-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.0.rc2.1.g7892e03ec0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the --exclude-path-first-parent flag,
which works similarly to --first-parent,
but affects only the graph traversal for
the set of commits being excluded.

   -A-------E-HEAD
     \     /
      B-C-D

In this example, the goal is to return the
set {B, C, D} which represents a working
branch that has been merged into main branch
E. `git rev-list D ^E` will end up returning
no commits since the exclude path eliminates
D and its ancestors.
`git rev-list --exclude-path-first-parent D ^E`
however will return {B, C, D} as desired.

Add docs for the new flag, and clarify the
doc for --first-parent to indicate that it
applies to traversing the set of included
commits only. The semantics of existing flags
however have not changed.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 Documentation/rev-list-options.txt | 21 ++++++++++++++-------
 blame.c                            |  2 +-
 revision.c                         | 30 ++++++++++++++++++++----------
 revision.h                         |  3 ++-
 shallow.c                          |  2 +-
 t/t6012-rev-list-simplify.sh       | 18 ++++++++++++------
 6 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b1c8f86c6e..681d6649b4 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -122,19 +122,26 @@ again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
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
 
+--exclude-path-first-parent::
+	When finding commits to exclude, follow only the first
+	parent commit upon seeing a merge commit.  This causes
+	exclusions to exclude only commits on that branch itself
+	and not those brought in by a merge.
+
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
diff --git a/blame.c b/blame.c
index 5018bb8fb2..8354dc0252 100644
--- a/blame.c
+++ b/blame.c
@@ -2615,7 +2615,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 		else {
 			commit->object.flags |= UNINTERESTING;
 			if (commit->object.parsed)
-				mark_parents_uninteresting(commit);
+				mark_parents_uninteresting(sb->revs, commit);
 		}
 		/* treat root commit as boundary */
 		if (!commit->parents && !sb->show_root)
diff --git a/revision.c b/revision.c
index 553c0faa9b..e1deb3f194 100644
--- a/revision.c
+++ b/revision.c
@@ -268,7 +268,7 @@ static void commit_stack_clear(struct commit_stack *stack)
 	stack->nr = stack->alloc = 0;
 }
 
-static void mark_one_parent_uninteresting(struct commit *commit,
+static void mark_one_parent_uninteresting(struct rev_info *revs, struct commit *commit,
 					  struct commit_stack *pending)
 {
 	struct commit_list *l;
@@ -285,20 +285,26 @@ static void mark_one_parent_uninteresting(struct commit *commit,
 	 * wasn't uninteresting), in which case we need
 	 * to mark its parents recursively too..
 	 */
-	for (l = commit->parents; l; l = l->next)
+	for (l = commit->parents; l; l = l->next) {
 		commit_stack_push(pending, l->item);
+		if (revs && revs->exclude_path_first_parent_only)
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
+		if (revs && revs->exclude_path_first_parent_only)
+			break;
+	}
 
 	while (pending.nr > 0)
-		mark_one_parent_uninteresting(commit_stack_pop(&pending),
+		mark_one_parent_uninteresting(revs, commit_stack_pop(&pending),
 					      &pending);
 
 	commit_stack_clear(&pending);
@@ -437,7 +443,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (repo_parse_commit(revs->repo, commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 
 			if (!revs->topo_order || !generation_numbers_enabled(the_repository))
 				revs->limited = 1;
@@ -1120,7 +1126,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
 				continue;
 			if (p->parents)
-				mark_parents_uninteresting(p);
+				mark_parents_uninteresting(revs, p);
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
@@ -1128,6 +1134,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 				commit_list_insert_by_date(p, list);
 			if (queue)
 				prio_queue_put(queue, p);
+			if (revs->exclude_path_first_parent_only)
+				break;
 		}
 		return 0;
 	}
@@ -1418,7 +1426,7 @@ static int limit_list(struct rev_info *revs)
 		if (process_parents(revs, commit, &list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 			slop = still_interesting(list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
@@ -2214,6 +2222,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
+	} else if (!strcmp(arg, "--exclude-path-first-parent")) {
+		revs->exclude_path_first_parent_only = 1;
 	} else if (!strcmp(arg, "--ancestry-path")) {
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
@@ -3341,7 +3351,7 @@ static void explore_walk_step(struct rev_info *revs)
 		return;
 
 	if (c->object.flags & UNINTERESTING)
-		mark_parents_uninteresting(c);
+		mark_parents_uninteresting(revs, c);
 
 	for (p = c->parents; p; p = p->next)
 		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
diff --git a/revision.h b/revision.h
index a24f72dcd1..712710ed62 100644
--- a/revision.h
+++ b/revision.h
@@ -164,6 +164,7 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
+			exclude_path_first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
 
@@ -405,7 +406,7 @@ const char *get_revision_mark(const struct rev_info *revs,
 void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
-void mark_parents_uninteresting(struct commit *commit);
+void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
 void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
diff --git a/shallow.c b/shallow.c
index 9ed18eb884..71e5876f37 100644
--- a/shallow.c
+++ b/shallow.c
@@ -603,7 +603,7 @@ static int mark_uninteresting(const char *refname, const struct object_id *oid,
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
-	mark_parents_uninteresting(commit);
+	mark_parents_uninteresting(NULL, commit);
 	return 0;
 }
 
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 4f7fa8b6c0..aa8220f3a4 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -16,13 +16,12 @@ unnote () {
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
@@ -142,6 +141,13 @@ check_result 'I B A' --author-date-order -- file
 check_result 'H' --first-parent -- another-file
 check_result 'H' --first-parent --topo-order -- another-file
 
+check_result 'L K I H G B A' --first-parent L
+check_result 'F E D C' --exclude-path-first-parent F ^L
+check_result '' F ^L
+check_result 'L K I H G J' L ^F
+check_result 'L K I H G B J' --exclude-path-first-parent L ^F
+check_result 'L K I H G B' --exclude-path-first-parent --first-parent L ^F
+
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
 	printf "%s\n" E C B A >expect &&
-- 
2.29.0

