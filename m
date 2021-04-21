Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7609C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B5A613F5
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhDUAs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhDUAs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:48:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264EC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:48:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x11so41323211qkp.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwVLQ7F9j0hWj04Jp8Pe7UH7SLqvdD5LhIh02AFaG1Q=;
        b=tAgozV0RG9lQlSoyx7qZesASHl/KNBqOyYlX3MgCgzZHsbJQP1Ad0Za5T2EjmmQ/W8
         +fW7nt/Nwo4RimQJa++jVi/pr9hLQVtV0a3fjPIFQh/C1GvKvA3rvjB4rL+w4lmDYsC2
         H+QmWqikwKCIekKsKiEAP4SvBDl+nvRcsIf6qvH5nAWBLe/Ndksy4S7xqGVupzs8c3AI
         nQ9iFNmwEBTzlTTufZ3kFyGJb5E5K5t7mqaM7VBaEgFTKnAVm8Y3ZwerQBskdxa8MmPK
         47BZI2nQ6s/FlKKJXsymnvz3GdTDOC/xChY0YK1T7k5v8dzjoUfM9cTVTgf/5Te9mJl9
         brDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwVLQ7F9j0hWj04Jp8Pe7UH7SLqvdD5LhIh02AFaG1Q=;
        b=d+njtW8b9mQhSJZGqzY57Hhi64ctby1xnQn5nJjXCl4ADFZMux9VuDECUWWFSmnm2p
         Pp2PpMNMw7moRmrDer6QgnTj5N1O9jugG2UEWDoZHdJdtGN1E3imvAENIIlFBclpy6Pw
         dk8NIL5cIfXw0vaFRSLdlmmqYKFDk3TYFShVM17UbVQxPTGSQ8ij/SUsicw0/Vcm5X4H
         DtEKN2yuzwESlyTdht2qnPImV9FScezCh4NuJV8fiQmJZ0MUULppUDxBLt1POhz7oFMC
         /4a4IJZjNhNSmmBhv/VrNnN+Hf5khXwZ/rEiPYyO9BUG03zROhWeysLX+mu1xgkdKbCW
         8hog==
X-Gm-Message-State: AOAM53232TBobR+5I4V0hlc/K6ZzK/QzNgZyV5bguGQGBBludOFf/f3g
        A5U0VO5dXYQ7xm32hDjlZZSzdZJQQwsSQzdG
X-Google-Smtp-Source: ABdhPJx+XHIUNjMVBAESX7cJPsG0LV9o2mJ/Q0KNi9pvHhTfTPHIUGfcvCeoqduqK6UHvEnDK8/28g==
X-Received: by 2002:a37:a78d:: with SMTP id q135mr3600942qke.210.1618966102292;
        Tue, 20 Apr 2021 17:48:22 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id m22sm415162qtg.67.2021.04.20.17.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 17:48:21 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2] git-rev-list: add --first-parent-not flag
Date:   Tue, 20 Apr 2021 17:48:17 -0700
Message-Id: <20210421004817.22536-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.333.g1dd712761c
In-Reply-To: <20210417001525.19960-1-jerry@skydio.com>
References: <20210417001525.19960-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the --path-first-parent-not flag, which
causes the traversal of any "not" commits
to visit only the first parent upon encountering
a merge commit.

   -A-----E-F-G--main
     \   / /
      B-C-D--topic

In this example, the goal is to return the
set {B, C, D} which represents a topic
branch that has been merged into main branch.
`git rev-list topic ^main` will end up returning
no commits since excluding main will end up
traversing the commits on topic as well.
`git rev-list --first-parent-not topic ^main`
however will return {B, C, D} as desired.

Add docs for the new flag, and clarify the
doc for --first-parent to indicate that it
applies to traversing the set of included
commits only. The semantics of existing flags
however have not changed.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V1->V2:
- Shortened flag name to --first-parent-not
- Updated example history in commit msg

 Documentation/rev-list-options.txt | 21 ++++++++++++++-------
 blame.c                            |  2 +-
 revision.c                         | 30 ++++++++++++++++++++----------
 revision.h                         |  3 ++-
 shallow.c                          |  2 +-
 t/t6012-rev-list-simplify.sh       | 18 ++++++++++++------
 6 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b1c8f86c6e..6666f13b30 100644
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
 
+--first-parent-not::
+	When finding commits to exclude, follow only the first
+	parent commit upon seeing a merge commit.  This causes
+	"not" commits to exclude only commits on that branch itself
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
index 553c0faa9b..4b87b48235 100644
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
+		if (revs && revs->first_parent_not)
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
+		if (revs && revs->first_parent_not)
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
+			if (revs->first_parent_not)
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
+	} else if (!strcmp(arg, "--first-parent-not")) {
+		revs->first_parent_not = 1;
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
index a24f72dcd1..82afbd0f8a 100644
--- a/revision.h
+++ b/revision.h
@@ -164,6 +164,7 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
+			first_parent_not:1,
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
index 4f7fa8b6c0..7da8542e58 100755
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
+check_result 'F E D C' --first-parent-not F ^L
+check_result '' F ^L
+check_result 'L K I H G J' L ^F
+check_result 'L K I H G B J' --first-parent-not L ^F
+check_result 'L K I H G B' --first-parent-not --first-parent L ^F
+
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
 	printf "%s\n" E C B A >expect &&
-- 
2.29.0

