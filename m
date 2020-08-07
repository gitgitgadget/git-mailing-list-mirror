Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2DAC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4920222CA1
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfoiv86y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHGV6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGV6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:58:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468CFC061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:58:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h21so2430248qtp.11
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6UwM6j8eidTtpYmyItGs75YkR8MUmcwnvce7RBDw1Q=;
        b=qfoiv86ydRTsM/tJ2+Z82EW7qMOAgelWrO24e/Ergy8AwjCpAf5TKXyQ/iFTqE/B4J
         9nChVDZZLX3t9ZtnxAEr5zrL2MuIYmkxvAvw3GL4mnVQc3WieAHEeynCF2d13FwjmZo6
         0/6fCmBxwyfPPsRdfg2dZ+McgAr5pHb6gg9sXNlUEsiDVFGLzREJxppcPdEzROS13i37
         cPmRWrDMu9vs7QYiJOvMkoOXKHTFRQzDMKwt2V0ogBbz0m/UW5orOHxDizK9fWvTpFUS
         FUpL8ykmM2k7Trnlr2IftLV3utfWI7nmmhrKRwknny3KVA7lSxnMUkxRul+rnTZlcFb0
         cetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6UwM6j8eidTtpYmyItGs75YkR8MUmcwnvce7RBDw1Q=;
        b=S0XnCfsA7AHjQzrZwizN7rcsagzxIyWXtSalXfge479tcFv/w9byIeRLOljUMRJOMo
         kaEB6sE5dao5BhIiswTsyTiF+aae7sYLHYsPZTZrJ7/NS02BW9DFFGMnL1yuC4ZwqLPO
         79zPdnLdyCe8ADHVTj4lN8kk/NoZabBS9iM9ObV6OsduKldP2b3MWS6gjwF4IZTo+SVj
         ev2T2HgOU6vDODYBwpjY1vEK41Wb5Xq4qopHKaSQy7N3bICiixndWEl7z4Ek6s+M95C3
         Up0HziWO5IMVChSf8pZDvgfDhgfwtycdzHlIX8eSit3FADD2dZ6e4OLWttv9CkIW0wh4
         6lLA==
X-Gm-Message-State: AOAM533dm0W1CjOlO7so6fJ9jx+Rrje6GLvWIy6mP3P+Ttu9rdFYWGCB
        x6OKmwrCcdt71TrFeS6BylRzvTPqTh0=
X-Google-Smtp-Source: ABdhPJzZi922xE8hXKdbesKWleEmCqXg32Rx1qQodLTQv1Xy6XjZUG1tAtJGoIn3hdjSDlBENdztuA==
X-Received: by 2002:ac8:180b:: with SMTP id q11mr15740308qtj.389.1596837528119;
        Fri, 07 Aug 2020 14:58:48 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id 84sm7141579qkl.11.2020.08.07.14.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 14:58:47 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v5 2/5] rev-list: allow bisect and first-parent flags
Date:   Fri,  7 Aug 2020 17:58:35 -0400
Message-Id: <20200807215838.19571-3-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200807215838.19571-1-alipman88@gmail.com>
References: <20200804220113.5909-1-alipman88@gmail.com>
 <20200807215838.19571-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add first_parent_only parameter to find_bisection(), removing the
barrier that prevented combining the --bisect and --first-parent flags
when using git rev-list

Based-on-patch-by: Tiago Botelho <tiagonbotelho@hotmail.com>
Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/rev-list-options.txt |  7 ++---
 bisect.c                           | 28 ++++++++++++-------
 bisect.h                           |  2 +-
 builtin/rev-list.c                 |  2 +-
 revision.c                         |  3 --
 t/t6000-rev-list-misc.sh           |  4 +--
 t/t6002-rev-list-bisect.sh         | 45 ++++++++++++++++++++++++++++++
 7 files changed, 70 insertions(+), 21 deletions(-)

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
index d5e830410f..a11fdb1473 100644
--- a/bisect.c
+++ b/bisect.c
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
@@ -314,6 +315,8 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
+		if (first_parent_only)
+			BUG("shouldn't be calling count-distance in fp mode");
 		weight_set(p, count_distance(p));
 		clear_distance(list);
 
@@ -332,7 +335,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 
 			if (0 <= weight(p))
 				continue;
-			for (q = p->item->parents; q; q = q->next) {
+
+			for (q = p->item->parents;
+			     q;
+			     q = first_parent_only ? NULL : q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
 				if (0 <= weight(q))
@@ -370,7 +376,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, int find_all, int first_parent_only)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -406,7 +412,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, find_all, first_parent_only);
 	if (best) {
 		if (!find_all) {
 			list->item = best->item;
@@ -991,6 +997,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
+	int first_parent_only = 0; /* TODO: pass --first-parent flag from git bisect start */
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -1001,11 +1008,12 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
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
index 6de29cdf7a..e628d5ea56 100644
--- a/revision.c
+++ b/revision.c
@@ -2891,9 +2891,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
-	if (revs->first_parent_only && revs->bisect)
-		die(_("--first-parent is incompatible with --bisect"));
-
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
 		die(_("-L does not yet support diff formats besides -p and -s"));
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 3bb0e4ff8f..fc4d55dcb2 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -128,8 +128,8 @@ test_expect_success 'rev-list can negate index objects' '
 	test_cmp expect actual
 '
 
-test_expect_success '--bisect and --first-parent can not be combined' '
-	test_must_fail git rev-list --bisect --first-parent HEAD
+test_expect_success '--bisect and --first-parent can be combined' '
+	git rev-list --bisect --first-parent HEAD
 '
 
 test_expect_success '--header shows a NUL after each commit' '
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index a661408038..b95a0212ad 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,49 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+test_output_expect_success '--bisect --first-parent' 'git rev-list --bisect --first-parent E ^F' <<EOF
+e4
+EOF
+
+test_output_expect_success '--first-parent' 'git rev-list --first-parent E ^F' <<EOF
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
+test_output_expect_success '--bisect-vars --first-parent' 'git rev-list --bisect-vars --first-parent E ^F' <<EOF
+bisect_rev='e5'
+bisect_nr=4
+bisect_good=4
+bisect_bad=3
+bisect_all=9
+bisect_steps=2
+EOF
+
+test_expect_success '--bisect-all --first-parent' '
+	cat >expect.unsorted <<-EOF &&
+	$(git rev-parse E) (tag: E, dist=0)
+	$(git rev-parse e1) (tag: e1, dist=1)
+	$(git rev-parse e2) (tag: e2, dist=2)
+	$(git rev-parse e3) (tag: e3, dist=3)
+	$(git rev-parse e4) (tag: e4, dist=4)
+	$(git rev-parse e5) (tag: e5, dist=4)
+	$(git rev-parse e6) (tag: e6, dist=3)
+	$(git rev-parse e7) (tag: e7, dist=2)
+	$(git rev-parse e8) (tag: e8, dist=1)
+	EOF
+
+	# expect results to be ordered by distance (descending),
+	# commit hash (ascending)
+	sort -k4,4r -k1,1 expect.unsorted >expect &&
+	git rev-list --bisect-all --first-parent E ^F >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.3 (Apple Git-128)

