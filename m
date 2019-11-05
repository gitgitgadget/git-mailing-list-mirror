Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C2B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 05:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKEFVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 00:21:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39740 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKEFVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 00:21:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so11052218pfo.6
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 21:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+87KtbzxdeWpFS3vB3shdQLCmIrroDOfiJAUFSp5W4=;
        b=cMV3NGaljru9fAAqrjS7Oe55k+oqqaJdXIIVIcnaJp04JRFdZmSkXVDZvncafgFRWJ
         YQI+N/ymf/ym5XujiUrBTB3W7m+lpt5Y9S37GDL8Qt5caUCKkUkwIpAhSPbBGsaYtBnq
         bPmIcsRkZIcKHP04q/BU83hjiXoNBlCbqCXeiHPhVaJ9JAvPHt7yGJf3JGNTgp6sC7a8
         6M8T3TlgPLcIiZ0W6uorpOhvUA8fkEiyhAk2B5F0b85dyRITrLTyRLk3/1MiEZcTCsaR
         BrxEkAmO1+zHWa8LF40zNcXAS/LHMlzlarWANF1nddJbEv5vokspf5Ehf3WlVF2rQqBA
         xDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+87KtbzxdeWpFS3vB3shdQLCmIrroDOfiJAUFSp5W4=;
        b=t6oMW6O3Q71AWyZ98vCEI1wPpH6fFOlpmjRrE8MBfZAJkvjjcY0sMBdA5pMq2jkcNO
         HlWOgghFOIZFoXl39neAWygCp2Jjejzg5mId/6X6DOlZtpeMImw86g3VInxU/4fVAWZv
         HqXu2RLvDcYQvoHwj0wBcjRTOHjOBRL1GVWUZZFh9Hm6vsriu9cXFInaNMBbiyckpy03
         +1v5T9THm0kHO4Ihit6kqPmNnO+Y/ynKtfGR6l3ypfVnPUhi+V4ErCFzUd/2KKx0mh/c
         xtxhiTyIlcIsEEUcj/aHsusXnjbonSN6ullfvXfyXwyZBc4dKywQJWvQnxyH35OjonhE
         Ztsw==
X-Gm-Message-State: APjAAAXSgfZb0qcZvpjtkSq7dxdVcm8mNeTiraEgz7tpfOsGsyNxpFx2
        awzF8EmEWQxbgw/Zwz5LDQB1tHNu9JCK4w==
X-Google-Smtp-Source: APXvYqw6wIMzPDcrOWanflVgkl+fINI50a5JEiulUMa7wqbgNtnr0CBbrzr6nGc4B7qjVQKX9d6w8Q==
X-Received: by 2002:a63:535a:: with SMTP id t26mr35057017pgl.215.1572931308173;
        Mon, 04 Nov 2019 21:21:48 -0800 (PST)
Received: from localhost.localdomain ([73.96.104.150])
        by smtp.gmail.com with ESMTPSA id h6sm3852884pji.21.2019.11.04.21.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 21:21:47 -0800 (PST)
From:   workingjubilee@gmail.com
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Jubilee Young <workingjubilee@gmail.com>
Subject: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
Date:   Mon,  4 Nov 2019 21:21:41 -0800
Message-Id: <20191105052141.15913-2-workingjubilee@gmail.com>
X-Mailer: git-send-email 2.24.0.1.gdc0fb1c0fe
In-Reply-To: <20191105052141.15913-1-workingjubilee@gmail.com>
References: <20191105052141.15913-1-workingjubilee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jubilee Young <workingjubilee@gmail.com>

Not all repository maintainers expect every commit to pass tests, only
testing the merge commits. Currently bisection assumes every commit is
of interest. The highly-requested --bisect --first-parent feature imbues
git with the same indifference to minutiae when the option is set, so
that it casually riffles through commits, throwing aside mountains of
irrelevant data when looking for a breaking change. Further refinement
of where breaks occurred can be gained by bisecting over the merge's
range.

Note, bisecting on --first-parent becomes part of findall's previously
existing pass-through as an "option state" flag.

In order to limit possible obfuscation of bisect operations resulting
from the addition of new flags, some extra documentation was folded in
to the patch.

Signed-off-by: Jubilee Young <workingjubilee@gmail.com>
Based-on-patch-by: Tiago Botelho <tiagonbotelho@hotmail.com>
Based-on-patch-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 bisect.c                   | 56 ++++++++++++++++++++++++++------------
 bisect.h                   | 17 ++++++++++--
 builtin/rev-list.c         |  9 ++++--
 revision.c                 |  3 --
 t/t6000-rev-list-misc.sh   |  4 +--
 t/t6002-rev-list-bisect.sh | 54 ++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/bisect.c b/bisect.c
index e81c91d02c..54129a796b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -88,15 +88,16 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	**commit_weight_at(&commit_weight, elem->item) = weight;
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
+			count++;
+		if (bisect_flags & BISECT_FIRST_PARENT)
+			break;
 	}
 	return count;
 }
@@ -123,7 +124,7 @@ static inline int halfway(struct commit_list *p, int nr)
 }
 
 static void show_list(const char *debug, int counted, int nr,
-		      struct commit_list *list)
+		      struct commit_list *list, unsigned bisect_flags)
 {
 	struct commit_list *p;
 
@@ -259,10 +260,12 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     unsigned bisect_flags)
 {
 	int n, counted;
 	struct commit_list *p;
+	unsigned first_parent = bisect_flags & BISECT_FIRST_PARENT;
+	unsigned find_all = bisect_flags & BISECT_FIND_ALL;
 
 	counted = 0;
 
@@ -271,13 +274,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
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
@@ -293,7 +296,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 initialize", counted, nr, list);
+	show_list("bisection 2 initialize", counted, nr, list, bisect_flags);
 
 	/*
 	 * If you have only one parent in the resulting set
@@ -323,7 +326,8 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		counted++;
 	}
 
-	show_list("bisection 2 count_distance", counted, nr, list);
+	/* should match bisection 2 initialize when BISECT_FIRST_PARENT */
+	show_list("bisection 2 count_distance", counted, nr, list, bisect_flags);
 
 	while (counted < nr) {
 		for (p = list; p; p = p->next) {
@@ -333,6 +337,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			if (0 <= weight(p))
 				continue;
 			for (q = p->item->parents; q; q = q->next) {
+				/*
+				 * first_parent can skip parent nodes, but only when
+				 * confirmed as being of no interest.
+				 */
+				if (first_parent) {
+					if ((q->item->object.flags & UNINTERESTING) ||
+						(weight(q) < 0)) {
+						q = NULL;
+					}
+					break;
+				}
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
 				if (0 <= weight(q))
@@ -350,7 +365,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, nr, list, bisect_flags);
 			}
 			else
 				weight_set(p, weight(q));
@@ -361,7 +376,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 counted all", counted, nr, list);
+	show_list("bisection 2 counted all", counted, nr, list, bisect_flags);
 
 	if (!find_all)
 		return best_bisection(list, nr);
@@ -370,13 +385,14 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, unsigned bisect_flags)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
 	int *weights;
+	unsigned find_all = bisect_flags & BISECT_FIND_ALL;
 
-	show_list("bisection 2 entry", 0, 0, *commit_list);
+	show_list("bisection 2 entry", 0, 0, *commit_list, bisect_flags);
 	init_commit_weight(&commit_weight);
 
 	/*
@@ -400,13 +416,13 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 		on_list++;
 	}
 	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
+	show_list("bisection 2 sorted", 0, nr, list, bisect_flags);
 
 	*all = nr;
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, bisect_flags);
 	if (best) {
 		if (!find_all) {
 			list->item = best->item;
@@ -950,6 +966,7 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 	struct rev_info revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
+	unsigned bisect_flags = 0;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -964,7 +981,12 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
+	if (skipped_revs.nr)
+		bisect_flags |= BISECT_FIND_ALL;
+	if (revs.first_parent_only)
+		bisect_flags |= BISECT_FIRST_PARENT;
+
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index 4e69a11ea8..518be01999 100644
--- a/bisect.h
+++ b/bisect.h
@@ -3,16 +3,18 @@
 
 struct commit_list;
 struct repository;
+#define BISECT_FIND_ALL	(1U<<0)
+#define BISECT_FIRST_PARENT	(1U<<1)
 
 /*
  * Find bisection. If something is found, `reaches` will be the number of
  * commits that the best commit reaches. `all` will be the count of
  * non-SAMETREE commits. If nothing is found, `list` will be NULL.
  * Otherwise, it will be either all non-SAMETREE commits or the single
- * best commit, as chosen by `find_all`.
+ * best commit, as chosen by the flag `BISECT_FIND_ALL`.
  */
 void find_bisection(struct commit_list **list, int *reaches, int *all,
-		    int find_all);
+		    unsigned bisect_flags);
 
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
@@ -31,6 +33,17 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
+/*
+ * Coordinates a bisection by examining input made available so far,
+ * setting up internal variables, and then bisecting with them.
+ * no_checkout directs this to only update BISECT_HEAD refs.
+ *
+ * Exit code 10 on successful bisection, so caller should exit with 0.
+ * Exit code 4 when no commits were found to bisect through.
+ * Exit code 1 MAY result from skipping the commit it would report.
+ *
+ * Otherwise, returns a call to command handlers which choose an exit.
+ */
 int bisect_next_all(struct repository *r,
 		    const char *prefix,
 		    int no_checkout);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e28d62ec64..759a182ec6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -374,8 +374,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
-	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
+	unsigned bisect_flags = 0;
 	const char *show_progress = NULL;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -443,7 +443,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
-			bisect_find_all = 1;
+			bisect_flags |= BISECT_FIND_ALL;
 			info.flags |= BISECT_SHOW_ALL;
 			revs.show_decorations = 1;
 			continue;
@@ -565,7 +565,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches, all;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
+		if (revs.first_parent_only)
+			bisect_flags |= BISECT_FIRST_PARENT;
+
+		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
diff --git a/revision.c b/revision.c
index 0e39b2b8a5..c6f0a9f213 100644
--- a/revision.c
+++ b/revision.c
@@ -2716,9 +2716,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
-	if (revs->first_parent_only && revs->bisect)
-		die(_("--first-parent is incompatible with --bisect"));
-
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
 		die(_("-L does not yet support diff formats besides -p and -s"));
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b8cf82349b..95949e4ff1 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -122,8 +122,8 @@ test_expect_success 'rev-list can negate index objects' '
 	test_cmp expect actual
 '
 
-test_expect_success '--bisect and --first-parent can not be combined' '
-	test_must_fail git rev-list --bisect --first-parent HEAD
+test_expect_success '--bisect and --first-parent CAN be combined' '
+	git rev-list --bisect --first-parent HEAD
 '
 
 test_expect_success '--header shows a NUL after each commit' '
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index a661408038..6caf2af650 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,58 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# --first-parent tests
+
+# --bisect --first-parent should pluck out the middle.
+printf "%s\n" e4 |
+test_output_expect_success "--bisect --first-parent" '
+	git rev-list --bisect --first-parent E ^F
+'
+
+printf "%s\n" E e1 e2 e3 e4 e5 e6 e7 e8 |
+test_output_expect_success "--first-parent" '
+	git rev-list --first-parent E ^F
+'
+
+test_output_expect_success '--bisect-vars --first-parent' '
+	git rev-list --bisect-vars --first-parent E ^F
+' <<-EOF
+	bisect_rev='e5'
+	bisect_nr=4
+	bisect_good=4
+	bisect_bad=3
+	bisect_all=9
+	bisect_steps=2
+EOF
+
+test_expect_success '--bisect-all --first-parent returns correct order' '
+	git rev-list --bisect-all --first-parent E ^F >actual &&
+
+	# Make sure the entries are sorted in the dist order
+	sed -e "s/.*dist=\([0-9]\).*/\1/" actual >actual.dists &&
+	sort -r -n actual.dists >actual.dists.sorted &&
+	test_cmp actual.dists.sorted actual.dists
+'
+
+# NEEDSWORK: this test could afford being hardened against other
+# changes in the same file.
+test_expect_success '--bisect-all --first-parent compares correctly' '
+	cat >expect <<-EOF &&
+	$(git rev-parse tags/e5) (tag: e5, dist=4)
+	$(git rev-parse tags/e4) (tag: e4, dist=4)
+	$(git rev-parse tags/e6) (tag: e6, dist=3)
+	$(git rev-parse tags/e3) (tag: e3, dist=3)
+	$(git rev-parse tags/e7) (tag: e7, dist=2)
+	$(git rev-parse tags/e2) (tag: e2, dist=2)
+	$(git rev-parse tags/e8) (tag: e8, dist=1)
+	$(git rev-parse tags/e1) (tag: e1, dist=1)
+	$(git rev-parse tags/E) (tag: E, dist=0)
+EOF
+
+git rev-list --bisect-all --first-parent E ^F >actual &&
+	sort actual >actual.sorted &&
+	sort expect >expect.sorted &&
+	test_cmp expect.sorted actual.sorted
+'
+
 test_done
-- 
2.24.0.1.gdc0fb1c0fe
