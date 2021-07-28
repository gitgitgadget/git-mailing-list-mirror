Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E47DC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 03:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21CE60F91
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 03:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhG1DUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 23:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 23:20:38 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB788C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 20:20:37 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id jm13so864494qvb.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 20:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THhDEnxS4FWYDie86CJsRuobdJJXIfy2eAVw7tAtcMQ=;
        b=yNrjk+zTA4AeacszZB0qwyMe/SvQ6SdbPc44oz74ZiJIJWz3ity18tqK6CUU1OtTzF
         ZlRbhI3kNa+81ZMtxRd8+i1OSGFIIQw8eFB7nUo+hUImp2iwOYvoPXEmOrQQpfPZ7fn8
         DKBSMwqJQe64+UMJgqlvBegIq7raTVIxheDWWVB4AWOFjWqYir8pa2WzgiL4C94JfT80
         kDtvbhy45h14VHUNlLKL0xhdsxAwtmBsAoIineM5OhQ+G1GG4CDa39YhOBKZjI3uEOZk
         08iZyLORPbn+RP+LIhkKiYyQpWjxRj3fO8LSY8um4Xz9RIzcmcdsjUFIE05qEpvoGw4M
         zfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THhDEnxS4FWYDie86CJsRuobdJJXIfy2eAVw7tAtcMQ=;
        b=JWpnH7zCPws1X32m9kkYF8Cnx9Cy/nBFpgN4O/qct40ft2Z8zEAgHK+LsX/yDWszC8
         nhJ605zkSgTr0/X49eZy+S92oh3y+ETGw9Q78l8g8+NYfIL8RGAMzBK4oEWQAkO9e5P+
         wmgjPdrigc+mvrI9jXktUGoaAZZGsX4phJlu2/itEbLhnCeZuQ2tHzQXqDBzILi+uMPX
         aY4cNSdypGg2/LTmtTVEUbwEraOxpvpoZbWi4bq8duEARnRh1ev870ECMT+3cP1RcywC
         PHxEr7AbRTOR8G2NvO7jobQUknbCAgANYPyRFvW1RASecQW9CjExxeyGtUP1pEKtqFyc
         gA6w==
X-Gm-Message-State: AOAM5325/WsjnumS9t3D0urC0GsYyZ+wsi1HXStR6uxM3zXWT9w661Kv
        MKdjgty5crPiYOfl1pTrjYku4jeMrlPu/Q==
X-Google-Smtp-Source: ABdhPJwS7Iw/duWdBhb1R4aqwuDFWmm+oWtT58ch0hMji4wFPG9EYLSiMXgMbh4MOoTB3oJ01dQ60g==
X-Received: by 2002:a0c:9ac7:: with SMTP id k7mr26345084qvf.49.1627442436569;
        Tue, 27 Jul 2021 20:20:36 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id v25sm2675967qkf.108.2021.07.27.20.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jul 2021 20:20:36 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3] git-rev-list: add --first-parent-not flag
Date:   Tue, 27 Jul 2021 20:20:33 -0700
Message-Id: <20210728032033.24233-1-jerry@skydio.com>
X-Mailer: git-send-email 2.32.0.4.g29b9734da9
In-Reply-To: <20210421004817.22536-1-jerry@skydio.com>
References: <20210421004817.22536-1-jerry@skydio.com>
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
V2->V3: rebase on master and rerun tests

Most recent discussion was relating to the specific
flag name. If you have a specific suggestion for
what the name should be I'm happy to use that.

 Documentation/rev-list-options.txt | 21 ++++++++++++++-------
 blame.c                            |  2 +-
 revision.c                         | 30 ++++++++++++++++++++----------
 revision.h                         |  3 ++-
 shallow.c                          |  2 +-
 t/t6012-rev-list-simplify.sh       | 18 ++++++++++++------
 6 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 24569b06d1..8e8b1e7c9b 100644
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
index 206c295660..083d99fdbc 100644
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
index cddd0542a6..60b78b4dce 100644
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
@@ -438,7 +444,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (repo_parse_commit(revs->repo, commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 
 			if (!revs->topo_order || !generation_numbers_enabled(the_repository))
 				revs->limited = 1;
@@ -1121,7 +1127,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
 				continue;
 			if (p->parents)
-				mark_parents_uninteresting(p);
+				mark_parents_uninteresting(revs, p);
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
@@ -1129,6 +1135,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 				commit_list_insert_by_date(p, list);
 			if (queue)
 				prio_queue_put(queue, p);
+			if (revs->first_parent_not)
+				break;
 		}
 		return 0;
 	}
@@ -1419,7 +1427,7 @@ static int limit_list(struct rev_info *revs)
 		if (process_parents(revs, commit, &original_list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
-			mark_parents_uninteresting(commit);
+			mark_parents_uninteresting(revs, commit);
 			slop = still_interesting(original_list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
@@ -2220,6 +2228,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
+	} else if (!strcmp(arg, "--first-parent-not")) {
+		revs->first_parent_not = 1;
 	} else if (!strcmp(arg, "--ancestry-path")) {
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
@@ -3347,7 +3357,7 @@ static void explore_walk_step(struct rev_info *revs)
 		return;
 
 	if (c->object.flags & UNINTERESTING)
-		mark_parents_uninteresting(c);
+		mark_parents_uninteresting(revs, c);
 
 	for (p = c->parents; p; p = p->next)
 		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
diff --git a/revision.h b/revision.h
index fbb068da9f..cec6898c2c 100644
--- a/revision.h
+++ b/revision.h
@@ -161,6 +161,7 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
+			first_parent_not:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
 
@@ -404,7 +405,7 @@ const char *get_revision_mark(const struct rev_info *revs,
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
2.32.0.1314.g6ed4fcc4cc

