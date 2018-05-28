Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3F41F51C
	for <e@80x24.org>; Mon, 28 May 2018 09:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeE1JUo (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:20:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52402 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbeE1JUn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:20:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id 18-v6so24757858wml.2
        for <git@vger.kernel.org>; Mon, 28 May 2018 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vHWT0ZeASuEAftAP3xgixnrJgPVSmw+qfcavt0DxHLk=;
        b=dVDdy15bBsPbwDtToIjWtReJhc/PSKe2aLgaS0UVFC0xvPI6mByiqOlO28zQmdeQjS
         ZnhxpirbVpWcgyMVrRsN/bMhNjJ0+jH2QIT/Ok+IWXX5rBV9i01V0VFAGfUeuL1slEN3
         LNrJ4nxUVeyIvCpQCQFXr+zD7uhMFn3DNI50s49OWfwqQFG1BJ1Id1nFWfwiLlnhczUQ
         +LS5G+vkUeuuInPMOdpR9xWd6TpQ/249jJzi0fj1hd+9Rk8JqGSt0XzEMV8FwUeJ0B3I
         1gdIr+RiUv8SGI0NR4EU/WdGy3W2lpHid5gSEHPQXpzf7H4JwGdezJ+TIW2IW8Man/vI
         YS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vHWT0ZeASuEAftAP3xgixnrJgPVSmw+qfcavt0DxHLk=;
        b=mCah1K+GqkpvuAdl7rv9QjlUUeeZNHjQnxSM8wyteXYGIT7jxtmoFCJtSIsePHe+PS
         fHMrQisZT+jVqVVosxMZDdMgSVXXwLuWANqTxzpDTevXduHQ7i8b4WysofW1b0cKd1YD
         R+Nnlg1uQ79bN2Qs2FjrLPCEk9I8RXTWEFhTJdE3NRnljn/1iugpEF8/4dujxzCqxBuX
         RhinOxdmP4Z4MVuvfv0f28oUbYtFV7qkrEN+Aza6La5srN3VgwqW4fwZ+HnOo1iSQ9AB
         fVtZWBqtzLtx/vttvzszuYR53ytT6hbp0nJQyqPyaiPXtrURs/xYtdCtofHY3wmdn+K9
         SugQ==
X-Gm-Message-State: ALKqPwe8QfIDGbDSB1K701Kg93pv+FkTuqiVySXYHham3xUhYfFqpshF
        UrjGrlktK4tv3R83YqkV4sPvvbgq
X-Google-Smtp-Source: ADUXVKJ02FZXby1JWhpOY/39WF1vYyQp+1eJDQVfQWHpsHk5Qg4lKjM/9Ku0ysdp7IZi/AOMYyiy/g==
X-Received: by 2002:a1c:55c9:: with SMTP id j192-v6mr9883749wmb.160.1527499241446;
        Mon, 28 May 2018 02:20:41 -0700 (PDT)
Received: from tiagos-mbp.mynet ([88.98.201.186])
        by smtp.gmail.com with ESMTPSA id 141-v6sm23443092wmf.35.2018.05.28.02.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 May 2018 02:20:39 -0700 (PDT)
From:   Tiago Botelho <tiagonbotelho@gmail.com>
X-Google-Original-From: Tiago Botelho <tiagonbotelho@hotmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        haraldnordgren@gmail.com, gitster@pobox.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: [RFC PATCH v4] Implement --first-parent for git rev-list --bisect
Date:   Mon, 28 May 2018 10:20:17 +0100
Message-Id: <20180528092017.19022-1-tiagonbotelho@hotmail.com>
X-Mailer: git-send-email 2.16.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will enable users to implement bisecting on first parents
which can be useful for when the commits from a feature branch
that we want to merge are not always tested.

Signed-off-by: Tiago Botelho <tiagonbotelho@hotmail.com>
---

This patch adds all Junio's suggestions, namely do_find_bisection() being
broken when assigning q's weight to p if in first parent mode and q being
not UNINTERESTING and its weight still not being known.

The graph displayed in the unit tests was also changed from being top-bottom
to be left-right in order to keep it consistent with graphs in other tests.

 bisect.c                   | 45 ++++++++++++++++++++++++++++++---------------
 bisect.h                   |  3 ++-
 builtin/rev-list.c         |  3 +++
 revision.c                 |  3 ---
 t/t6002-rev-list-bisect.sh | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4eafc8262..e58cb8d62 100644
--- a/bisect.c
+++ b/bisect.c
@@ -33,6 +33,8 @@ static const char *term_good;
  *
  * We care just barely enough to avoid recursing for
  * non-merge entries.
+ *
+ * Note: This function does not support the usage --first-parent.
  */
 static int count_distance(struct commit_list *entry)
 {
@@ -82,15 +84,16 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	*((int*)(elem->item->util)) = weight;
 }
 
-static int count_interesting_parents(struct commit *commit)
+static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
 {
 	struct commit_list *p;
 	int count;
 
 	for (count = 0, p = commit->parents; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
-		count++;
+		if (!(p->item->object.flags & UNINTERESTING))
+		    count++;
+		if (bisect_flags & BISECT_FIRST_PARENT)
+			break;
 	}
 	return count;
 }
@@ -117,10 +120,10 @@ static inline int halfway(struct commit_list *p, int nr)
 }
 
 #if !DEBUG_BISECT
-#define show_list(a,b,c,d) do { ; } while (0)
+#define show_list(a,b,c,d,e) do { ; } while (0)
 #else
 static void show_list(const char *debug, int counted, int nr,
-		      struct commit_list *list)
+		      struct commit_list *list, unsigned bisect_flags)
 {
 	struct commit_list *p;
 
@@ -146,10 +149,14 @@ static void show_list(const char *debug, int counted, int nr,
 		else
 			fprintf(stderr, "---");
 		fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));
-		for (pp = commit->parents; pp; pp = pp->next)
+		for (pp = commit->parents; pp; pp = pp->next) {
 			fprintf(stderr, " %.*s", 8,
 				oid_to_hex(&pp->item->object.oid));
 
+			if (bisect_flags & BISECT_FIRST_PARENT)
+				break;
+		}
+
 		subject_len = find_commit_subject(buf, &subject_start);
 		if (subject_len)
 			fprintf(stderr, " %.*s", subject_len, subject_start);
@@ -267,13 +274,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		p->item->util = &weights[n++];
-		switch (count_interesting_parents(commit)) {
+		switch (count_interesting_parents(commit, bisect_flags)) {
 		case 0:
 			if (!(flags & TREESAME)) {
 				weight_set(p, 1);
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, nr, list, bisect_flags);
 			}
 			/*
 			 * otherwise, it is known not to reach any
@@ -289,7 +296,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 initialize", counted, nr, list);
+	show_list("bisection 2 initialize", counted, nr, list, bisect_flags);
 
 	/*
 	 * If you have only one parent in the resulting set
@@ -319,7 +326,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		counted++;
 	}
 
-	show_list("bisection 2 count_distance", counted, nr, list);
+	show_list("bisection 2 count_distance", counted, nr, list, bisect_flags);
 
 	while (counted < nr) {
 		for (p = list; p; p = p->next) {
@@ -329,6 +336,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			if (0 <= weight(p))
 				continue;
 			for (q = p->item->parents; q; q = q->next) {
+				if ((bisect_flags & BISECT_FIRST_PARENT)) {
+					if (weight(q) < 0)
+						q = NULL;
+					break;
+				}
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
 				if (0 <= weight(q))
@@ -346,7 +358,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, nr, list, bisect_flags);
 			}
 			else
 				weight_set(p, weight(q));
@@ -357,7 +369,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 counted all", counted, nr, list);
+	show_list("bisection 2 counted all", counted, nr, list, bisect_flags);
 
 	if (!find_all)
 		return best_bisection(list, nr);
@@ -372,7 +384,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	struct commit_list *list, *p, *best, *next, *last;
 	int *weights;
 
-	show_list("bisection 2 entry", 0, 0, *commit_list);
+	show_list("bisection 2 entry", 0, 0, *commit_list, bisect_flags);
 
 	/*
 	 * Count the number of total and tree-changing items on the
@@ -395,7 +407,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 		on_list++;
 	}
 	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
+	show_list("bisection 2 sorted", 0, nr, list, bisect_flags);
 
 	*all = nr;
 	weights = xcalloc(on_list, sizeof(*weights));
@@ -962,6 +974,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (skipped_revs.nr)
 		bisect_flags |= BISECT_FIND_ALL;
 
+	if (revs.first_parent_only)
+		bisect_flags |= BISECT_FIRST_PARENT;
+
 	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
diff --git a/bisect.h b/bisect.h
index 1d40a33ad..dfb7faeec 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,7 +1,8 @@
 #ifndef BISECT_H
 #define BISECT_H
 
-#define BISECT_FIND_ALL		(1u<<0)
+#define BISECT_FIND_ALL 	(1u<<0)
+#define BISECT_FIRST_PARENT 	(1u<<1)
 
 /*
  * Find bisection. If something is found, `reaches` will be the number of
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8752f5bbe..66439e1b3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -538,6 +538,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches, all;
 
+		if (revs.first_parent_only)
+			bisect_flags |= BISECT_FIRST_PARENT;
+
 		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
diff --git a/revision.c b/revision.c
index 4e0e193e5..b9d063805 100644
--- a/revision.c
+++ b/revision.c
@@ -2474,9 +2474,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
-	if (revs->first_parent_only && revs->bisect)
-		die(_("--first-parent is incompatible with --bisect"));
-
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index a66140803..774d9a4fd 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,41 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# We generate the following commit graph:
+#
+#   B - C
+#  /      \
+# A        FX
+#  \      /
+#   D - EX
+
+test_expect_success 'setup' '
+  test_commit A &&
+  test_commit B &&
+  test_commit C &&
+  git reset --hard A &&
+  test_commit D &&
+  test_commit EX &&
+  test_merge FX C
+'
+
+test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent FX ^A' <<EOF
+$(git rev-parse EX)
+EOF
+
+test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent FX ^A' <<EOF
+bisect_rev='$(git rev-parse EX)'
+bisect_nr=1
+bisect_good=0
+bisect_bad=1
+bisect_all=3
+bisect_steps=1
+EOF
+
+test_output_expect_success "--bisect-all --first-parent" 'git rev-list --bisect-all --first-parent FX ^A' <<EOF
+$(git rev-parse EX) (dist=1)
+$(git rev-parse D) (dist=1)
+$(git rev-parse FX) (dist=0)
+EOF
+
 test_done
-- 
2.16.3

