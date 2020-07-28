Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C413DC433F1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9947420786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLmlcLLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgG1PoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgG1PoU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:44:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CAC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:44:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so8207333wrc.7
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CwT6Jo3zMarCXGqx6U+CA47cKnL3AKHeLcYZHYKgMww=;
        b=hLmlcLLIq/nX/iRQu1jraID5mnkRxLbsWCaFeMRXzHN4zulzPoAXBlQgeDJXa7sRNj
         8IREowhGicgDjzj0CAfghDtNv1dvySr5o91E5zyhGYILd/absfTWEzk+YWqyUSzOHq/k
         EptXdv1qkpCPTuhhGW1a56V5iDGTECT9aP6Et9zf/CjlvXCx+6u7LNZYV6wxJl6AhUot
         tq7+QE5zFqMOX6XFKAEFDrpTD7ZZsiyJmKa6KPaes3zYu7WNK8zWmErVSTYjQVXPjuhg
         YVchckTkUiF5ZVe27aYcqIHzCHUqZRQn/shRcBy7gsMeuEynfQWklm3DDB4yJNZeI93c
         yLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CwT6Jo3zMarCXGqx6U+CA47cKnL3AKHeLcYZHYKgMww=;
        b=r5iNFyVreNNFAqzTN6tIE6k5jWsOIF1CfaBC5uVF0k/QqQcMFmdljdpW5g38cmRSxg
         MZ59H5YlWxb27ShBCu+xaY1wxWBzxklEiHGoMzPRAbI1hshFY9yAdzQZveyb7p8rJuVH
         5nHFjpUTlLmzDYTxkPU3tGZ26azvOsA4FpwSX1kkf0U9exzIx/46Smyn8CwuaASlVfs8
         9De+NBFIj/4yfhzxGK4jzUFjQXOq4/v5ou+8ji1+8GNrOYbUPRHQjWiPsRIHZDiCfgs0
         NXI4MHWKnPwU07wr5b39vTKHPnSUb92tzjdUTbyqUaf3JBilwhqSnft8qGbClzxBD8A0
         kP5A==
X-Gm-Message-State: AOAM5323K9WRxCidoc8Zdy6tRoPkqmkVhtjhQDT3VzaKTXHGAclu0wlg
        60j+5eHagkXMwy9aFldH5JYqp4TM
X-Google-Smtp-Source: ABdhPJyxycQWUpgkrsFZxcf4f+hVIyTTRfoXzbOhFd0GmKGradycQBE3yiaW20+YmHqMxJfLNVO53A==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr25829767wrn.356.1595951058630;
        Tue, 28 Jul 2020 08:44:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm17323993wro.83.2020.07.28.08.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:44:18 -0700 (PDT)
Message-Id: <25263842832eeb09769b55cec025978b5f361eca.1595951056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.686.git.1595951056.gitgitgadget@gmail.com>
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
From:   "Aaron Lipman via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 15:44:14 +0000
Subject: [PATCH 1/3] rev-list: allow bisect and first-parent flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Aaron Lipman <alipman88@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aaron Lipman <alipman88@gmail.com>

Add first_parent_only parameter to find_bisection(), removing the
barrier that prevented combining the --bisect and --first-parent flags
when using git rev-list

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
Based-on-patch-by: Tiago Botelho <tiagonbotelho@hotmail.com>
---
 Documentation/rev-list-options.txt |  7 ++---
 bisect.c                           | 43 +++++++++++++++++-----------
 bisect.h                           |  2 +-
 builtin/rev-list.c                 |  2 +-
 revision.c                         |  3 --
 t/t6000-rev-list-misc.sh           |  4 +--
 t/t6002-rev-list-bisect.sh         | 45 ++++++++++++++++++++++++++++++
 7 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b01b2b6773..d3117ce51b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -128,8 +128,7 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	because merges into a topic branch tend to be only about
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
-	brought in to your history by such a merge. Cannot be
-	combined with --bisect.
+	brought in to your history by such a merge.
 
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
@@ -207,7 +206,7 @@ ifndef::git-rev-list[]
 	Pretend as if the bad bisection ref `refs/bisect/bad`
 	was listed and as if it was followed by `--not` and the good
 	bisection refs `refs/bisect/good-*` on the command
-	line. Cannot be combined with --first-parent.
+	line.
 endif::git-rev-list[]
 
 --stdin::
@@ -743,7 +742,7 @@ outputs 'midpoint', the output of the two commands
 would be of roughly the same length.  Finding the change which
 introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
-one. Cannot be combined with --first-parent.
+one.
 
 --bisect-vars::
 	This calculates the same as `--bisect`, except that refs in
diff --git a/bisect.c b/bisect.c
index d5e830410f..762f68c8e9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -37,7 +37,7 @@ static const char *term_good;
  * We care just barely enough to avoid recursing for
  * non-merge entries.
  */
-static int count_distance(struct commit_list *entry)
+static int count_distance(struct commit_list *entry, int first_parent_only)
 {
 	int nr = 0;
 
@@ -52,10 +52,10 @@ static int count_distance(struct commit_list *entry)
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
 		entry = p;
-		if (p) {
+		if (p && !first_parent_only) {
 			p = p->next;
 			while (p) {
-				nr += count_distance(p);
+				nr += count_distance(p, first_parent_only);
 				p = p->next;
 			}
 		}
@@ -88,15 +88,16 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	**commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
-static int count_interesting_parents(struct commit *commit)
+static int count_interesting_parents(struct commit *commit, int first_parent_only)
 {
 	struct commit_list *p;
 	int count;
 
 	for (count = 0, p = commit->parents; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
-		count++;
+		if (!(p->item->object.flags & UNINTERESTING))
+			count++;
+		if (first_parent_only)
+			break;
 	}
 	return count;
 }
@@ -259,7 +260,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     int find_all, int first_parent_only)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -271,7 +272,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
-		switch (count_interesting_parents(commit)) {
+		switch (count_interesting_parents(commit, first_parent_only)) {
 		case 0:
 			if (!(flags & TREESAME)) {
 				weight_set(p, 1);
@@ -314,7 +315,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		weight_set(p, count_distance(p));
+		weight_set(p, count_distance(p, first_parent_only));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
@@ -330,13 +331,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			struct commit_list *q;
 			unsigned flags = p->item->object.flags;
 
+			/* if commit p has already been weighted, continue. */
 			if (0 <= weight(p))
 				continue;
+
+			/*
+			 * otherwise, find the first interesting
+			 * already-weighted parent of p and store as q.
+			 */
 			for (q = p->item->parents; q; q = q->next) {
-				if (q->item->object.flags & UNINTERESTING)
-					continue;
-				if (0 <= weight(q))
+				if (!(q->item->object.flags & UNINTERESTING) && 0 <= weight(q)) {
+					break;
+				} else if (first_parent_only) {
+					q = NULL;
 					break;
+				}
 			}
 			if (!q)
 				continue;
@@ -370,7 +379,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, int find_all, int first_parent_only)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -406,7 +415,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, find_all, first_parent_only);
 	if (best) {
 		if (!find_all) {
 			list->item = best->item;
@@ -991,6 +1000,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
+	int first_parent_only = 0; /* TODO: pass --first-parent flag from git bisect start */
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -1001,11 +1011,12 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		return res;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
+	revs.first_parent_only = first_parent_only;
 	revs.limited = 1;
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
+	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, first_parent_only);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index 8bad8d8391..a63af0505f 100644
--- a/bisect.h
+++ b/bisect.h
@@ -12,7 +12,7 @@ struct repository;
  * best commit, as chosen by `find_all`.
  */
 void find_bisection(struct commit_list **list, int *reaches, int *all,
-		    int find_all);
+		    int find_all, int first_parent_only);
 
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f520111eda..d1a14596b2 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -638,7 +638,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches, all;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
+		find_bisection(&revs.commits, &reaches, &all, bisect_find_all, revs.first_parent_only);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
diff --git a/revision.c b/revision.c
index 6aa7f4f567..f0ad2603c1 100644
--- a/revision.c
+++ b/revision.c
@@ -2869,9 +2869,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
-	if (revs->first_parent_only && revs->bisect)
-		die(_("--first-parent is incompatible with --bisect"));
-
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
 		die(_("-L does not yet support diff formats besides -p and -s"));
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 3dc1ad8f71..26e3533562 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -125,8 +125,8 @@ test_expect_success 'rev-list can negate index objects' '
 	test_cmp expect actual
 '
 
-test_expect_success '--bisect and --first-parent can not be combined' '
-	test_must_fail git rev-list --bisect --first-parent HEAD
+test_expect_success '--bisect and --first-parent can be combined' '
+	git rev-list --bisect --first-parent HEAD
 '
 
 test_expect_success '--header shows a NUL after each commit' '
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index a661408038..7fc0f75ca5 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,49 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent E ^F' <<EOF
+e4
+EOF
+
+test_output_expect_success "--first-parent" 'git rev-list --first-parent E ^F' <<EOF
+E
+e1
+e2
+e3
+e4
+e5
+e6
+e7
+e8
+EOF
+
+test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent E ^F' <<EOF
+bisect_rev='e5'
+bisect_nr=4
+bisect_good=4
+bisect_bad=3
+bisect_all=9
+bisect_steps=2
+EOF
+
+test_expect_success "--bisect-all --first-parent" '
+cat > expect.unsorted <<EOF &&
+$(git rev-parse E) (tag: E, dist=0)
+$(git rev-parse e1) (tag: e1, dist=1)
+$(git rev-parse e2) (tag: e2, dist=2)
+$(git rev-parse e3) (tag: e3, dist=3)
+$(git rev-parse e4) (tag: e4, dist=4)
+$(git rev-parse e5) (tag: e5, dist=4)
+$(git rev-parse e6) (tag: e6, dist=3)
+$(git rev-parse e7) (tag: e7, dist=2)
+$(git rev-parse e8) (tag: e8, dist=1)
+EOF
+
+# expect results to be ordered by distance (descending),
+# commit hash (ascending)
+sort -k4,4r -k1,1 expect.unsorted > expect &&
+git rev-list --bisect-all --first-parent E ^F > actual &&
+test_cmp actual expect
+'
+
 test_done
-- 
gitgitgadget

