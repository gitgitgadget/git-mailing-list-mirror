Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4991F516
	for <e@80x24.org>; Fri, 22 Jun 2018 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeFVMkN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 08:40:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34142 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeFVMkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 08:40:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so6594613wro.1
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=46CVWMmV6xxMb6Anml3Gsu+w+wNWh74sFK5Rr99jgZI=;
        b=LvyHDw6NSs8fb3HUj24BMfqwJu7aVElwKmnF8/j1A4ULiWcVsC7OpHflgoMvl2YXV6
         TQJiK2DWFaQqvbddhCvsp8kNSQ1K/jVTp63dbR8rbpHSmQmdSP8xT2ZlDmNeTGFFwqPs
         C59GeSSL/iKl3ZvO4kc7CBXLl7fEvQ5NJ8EYTZks988EogBI2cmgEtQpaRutYlAoM7qh
         6F2FBBCTysj3FNihaSOXJn9S9ojcn7q5ADec1o9AMdOcdh7zCZ+AnB6HEaRvgn27XfeW
         LK86JUhUaMTJklSXDQuQvvb/I+5sERDPnQEWzdxnC5Kr3DT+wtXKVp+TUDuIY0T66yyI
         A9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=46CVWMmV6xxMb6Anml3Gsu+w+wNWh74sFK5Rr99jgZI=;
        b=h8GYbyt+ISnkaWw5vp6/RWSKUdsFQ3OqmpE2fkcjAczdNyutYuXFnMuKs3nMfvHf6w
         oE2qu8oTEbsVwutrtuBO9yPkscG4iM94AAwsGJ+Xp7pQb01dR267cGjOFIpqdJpOZeXc
         AAfybrvGUCqg2SFDL8eqaknEpUfmdEF5LdzLtBC2PGTSBmGaECuf5sO5fMBCg89/rMPh
         dWJx2G32T7AJ3cX8bbP6+qkuL1jBbQvUJgIy8UyI17D/pZ0kHvZSxplpt5tpAN5YuZWv
         d8bIwtTa+TPbtMnjykxQpfZk86iUfvS4vCfAV9gubAEiggbRdIedfgq0lfPkfoz3JTC7
         1QPQ==
X-Gm-Message-State: APt69E3YnYC0e0+s7/VN0xiPO1tu+07FKoR7qC9+rMZtkVISZThJa2pI
        PwvQ7gJz9mf8sBcB+Bsqtb/0H6m2G5Y=
X-Google-Smtp-Source: AAOMgpeyz2QSu0buXBRIFRM4MqwHWZnA3xzV50eSWvU6fkjyGj7SfchzZUptROHkCTFUTkv6SMidog==
X-Received: by 2002:adf:e94a:: with SMTP id m10-v6mr78131wrn.126.1529671210770;
        Fri, 22 Jun 2018 05:40:10 -0700 (PDT)
Received: from tiagos-mbp.mynet ([88.98.209.186])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2980355wrl.20.2018.06.22.05.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 05:40:10 -0700 (PDT)
From:   Tiago Botelho <tiagonbotelho@gmail.com>
X-Google-Original-From: Tiago Botelho <tiagonbotelho@hotmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        haraldnordgren@gmail.com, gitster@pobox.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
Date:   Fri, 22 Jun 2018 13:39:45 +0100
Message-Id: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
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

This patch resolves every issue with the unit tests. 

The bug detected by Junio regarding do_find_bisection() propagating 
a weight of -1 over to the child nodes ended up not being an 
issue since it cannot happen in practice, there will always be at 
least one UNINTERESTING parent which will propagate either a weight 
of 0 or 1 throughout the child nodes.

 bisect.c                   | 43 ++++++++++++++++++++++------------
 bisect.h                   |  1 +
 builtin/rev-list.c         |  3 +++
 revision.c                 |  3 ---
 t/t6002-rev-list-bisect.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4eafc8262..cb80f29c5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -82,15 +82,16 @@ static inline void weight_set(struct commit_list *elem, int weight)
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
@@ -117,10 +118,10 @@ static inline int halfway(struct commit_list *p, int nr)
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
 
@@ -146,10 +147,14 @@ static void show_list(const char *debug, int counted, int nr,
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
@@ -267,13 +272,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
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
@@ -289,7 +294,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 initialize", counted, nr, list);
+	show_list("bisection 2 initialize", counted, nr, list, bisect_flags);
 
 	/*
 	 * If you have only one parent in the resulting set
@@ -319,7 +324,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		counted++;
 	}
 
-	show_list("bisection 2 count_distance", counted, nr, list);
+	show_list("bisection 2 count_distance", counted, nr, list, bisect_flags);
 
 	while (counted < nr) {
 		for (p = list; p; p = p->next) {
@@ -329,6 +334,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
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
@@ -346,7 +356,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, nr, list, bisect_flags);
 			}
 			else
 				weight_set(p, weight(q));
@@ -357,7 +367,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 counted all", counted, nr, list);
+	show_list("bisection 2 counted all", counted, nr, list, bisect_flags);
 
 	if (!find_all)
 		return best_bisection(list, nr);
@@ -372,7 +382,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	struct commit_list *list, *p, *best, *next, *last;
 	int *weights;
 
-	show_list("bisection 2 entry", 0, 0, *commit_list);
+	show_list("bisection 2 entry", 0, 0, *commit_list, bisect_flags);
 
 	/*
 	 * Count the number of total and tree-changing items on the
@@ -395,7 +405,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 		on_list++;
 	}
 	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
+	show_list("bisection 2 sorted", 0, nr, list, bisect_flags);
 
 	*all = nr;
 	weights = xcalloc(on_list, sizeof(*weights));
@@ -962,6 +972,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (skipped_revs.nr)
 		bisect_flags |= BISECT_FIND_ALL;
 
+	if (revs.first_parent_only)
+		bisect_flags |= BISECT_FIRST_PARENT;
+
 	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
diff --git a/bisect.h b/bisect.h
index 1d40a33ad..e445567c2 100644
--- a/bisect.h
+++ b/bisect.h
@@ -2,6 +2,7 @@
 #define BISECT_H
 
 #define BISECT_FIND_ALL		(1u<<0)
+#define BISECT_FIRST_PARENT    	(1u<<1)
 
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
index a66140803..c9cd349de 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,62 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# We generate the following commit graph:
+#
+#   B ------ C
+#  /          \
+# A            FX
+#  \          /
+#   D - CC - EX
+
+test_expect_success 'setup' '
+  test_commit A &&
+  test_commit B &&
+  test_commit C &&
+  git reset --hard A &&
+  test_commit D &&
+  test_commit CC &&
+  test_commit EX &&
+  test_merge FX C
+'
+
+test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent FX ^A' <<EOF
+$(git rev-parse CC)
+EOF
+
+test_output_expect_success "--first-parent" 'git rev-list --first-parent FX ^A' <<EOF
+$(git rev-parse FX)
+$(git rev-parse EX)
+$(git rev-parse CC)
+$(git rev-parse D)
+EOF
+
+test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent FX ^A' <<EOF
+bisect_rev='$(git rev-parse CC)'
+bisect_nr=1
+bisect_good=1
+bisect_bad=1
+bisect_all=4
+bisect_steps=1
+EOF
+
+test_expect_success "--bisect-all --first-parent" '
+cat >expect1 <<EOF &&
+$(git rev-parse CC) (dist=2)
+$(git rev-parse EX) (dist=1)
+$(git rev-parse D) (dist=1)
+$(git rev-parse FX) (dist=0)
+EOF
+
+cat >expect2 <<EOF &&
+$(git rev-parse CC) (dist=2)
+$(git rev-parse D) (dist=1)
+$(git rev-parse EX) (dist=1)
+$(git rev-parse FX) (dist=0)
+EOF
+
+git rev-list --bisect-all --first-parent FX ^A >actual &&
+  ( test_cmp expect1 actual || test_cmp expect2 actual )
+'
+
 test_done
-- 
2.16.3

