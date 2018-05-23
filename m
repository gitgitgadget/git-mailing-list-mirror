Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D039A200B9
	for <e@80x24.org>; Wed, 23 May 2018 12:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbeEWMAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 08:00:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39656 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbeEWMAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 08:00:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id w18-v6so22233596wrn.6
        for <git@vger.kernel.org>; Wed, 23 May 2018 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B4mi73MRoPOzjIU9/b7Yw2WvHnc288KlBEVb0j8Zk/w=;
        b=uyaJqMWVG0tyK3w8HgyMkbH9y537yhadMflSHit+1xD/vcOsodyKe/DBpe8tRVFBCv
         DKU9+5Ma9NovQlC0bzBvMyKcC65i64sEu3CnVh1efs14eSVfwt4dwr9xUYm91/xaaShd
         YtGnG8sEgTjcRc+eXx6Y4o4SYyOSo8jK33BJt7cecOvuOyjUgAy9Ybmvm6zkQ0bpaXps
         nLWMCpICdhJIgnR5HjQ4qW9VB5QBL4bFPP+l5y+xj2HpZQbuA3ICncAdGuGM8pMZivNL
         TFa6QP8A8gYZYyCKXbEk4xDFlyk7w2/BbLjoz2POLMZ/qmj6eIpKq3kQ+KTPiZxSTnF3
         xZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B4mi73MRoPOzjIU9/b7Yw2WvHnc288KlBEVb0j8Zk/w=;
        b=h/cjBPvU5hmLl7EqpLWtYpnjw+4Zj49pKJC8trZYnfWYElg+R1DknPfDf5yjti3m3f
         Y/fdYYDo2XJwR8QbcyAkTeJoO35uA3OKxnqbAcBHnP+1njegZUDECociR/AX7IlM3wkn
         i0Azlvv2d67DE8zkPXBpKIvvUhRFCniw0mAZbgbe1pAg7lu3KEF3NumnTivfcCx2S/0k
         REZXw6p4098N4Y//4esqt5iV5UDWTZCK7Js3IHbbgIe9CKr9Ds0r/GBZzQyjMVNx+ces
         brvXn86mCcvgiyOawH3hfJ5h8kpBep47qODCVjk6TZ/9IpyJjTtuTy7Q6YyUvAbE3gT+
         4EJA==
X-Gm-Message-State: ALKqPwdp5Mez9lvPsvZtGCGXn2JrIoDVy4DjmsUckdBnHD7raHtMruei
        hjPfQrYWcgdgchMLx9Q5WflIZIqHv20=
X-Google-Smtp-Source: AB8JxZqSuAbuvHvJBV/ohUO0cdY8rF/H9747Mgt8KizIFxqgKAc3S6IGeIBfPExqx+j0TrNrxu15IA==
X-Received: by 2002:adf:e407:: with SMTP id g7-v6mr2164487wrm.143.1527076850831;
        Wed, 23 May 2018 05:00:50 -0700 (PDT)
Received: from 192.168.1.103 ([88.98.201.186])
        by smtp.gmail.com with ESMTPSA id g105-v6sm29885694wrd.45.2018.05.23.05.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 May 2018 05:00:49 -0700 (PDT)
From:   Tiago Botelho <tiagonbotelho@gmail.com>
X-Google-Original-From: Tiago Botelho <tiagonbotelho@hotmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        haraldnordgren@gmail.com, Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: [RFC PATCH v3 1/2] Implement --first-parent for git rev-list --bisect
Date:   Wed, 23 May 2018 13:00:28 +0100
Message-Id: <20180523120028.36427-1-tiagonbotelho@hotmail.com>
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
 bisect.c           | 53 +++++++++++++++++++++++++++++++----------------------
 bisect.h           |  3 ++-
 builtin/rev-list.c |  3 +++
 revision.c         |  3 ---
 4 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4eafc8262..f43713574 100644
--- a/bisect.c
+++ b/bisect.c
@@ -34,7 +34,7 @@ static const char *term_good;
  * We care just barely enough to avoid recursing for
  * non-merge entries.
  */
-static int count_distance(struct commit_list *entry)
+static int count_distance(struct commit_list *entry, unsigned bisect_flags)
 {
 	int nr = 0;
 
@@ -49,10 +49,10 @@ static int count_distance(struct commit_list *entry)
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
 		entry = p;
-		if (p) {
+		if (p && !(bisect_flags & BISECT_FIRST_PARENT)) {
 			p = p->next;
 			while (p) {
-				nr += count_distance(p);
+				nr += count_distance(p, bisect_flags);
 				p = p->next;
 			}
 		}
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
@@ -310,7 +315,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		weight_set(p, count_distance(p));
+		weight_set(p, count_distance(p, bisect_flags));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
@@ -319,7 +324,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		counted++;
 	}
 
-	show_list("bisection 2 count_distance", counted, nr, list);
+	show_list("bisection 2 count_distance", counted, nr, list, bisect_flags);
 
 	while (counted < nr) {
 		for (p = list; p; p = p->next) {
@@ -329,9 +334,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			if (0 <= weight(p))
 				continue;
 			for (q = p->item->parents; q; q = q->next) {
-				if (q->item->object.flags & UNINTERESTING)
-					continue;
-				if (0 <= weight(q))
+				if (!(q->item->object.flags & UNINTERESTING))
+					if (0 <= weight(q))
+						break;
+				if (bisect_flags & BISECT_FIRST_PARENT)
 					break;
 			}
 			if (!q)
@@ -346,7 +352,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, nr, list, bisect_flags);
 			}
 			else
 				weight_set(p, weight(q));
@@ -357,7 +363,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 counted all", counted, nr, list);
+	show_list("bisection 2 counted all", counted, nr, list, bisect_flags);
 
 	if (!find_all)
 		return best_bisection(list, nr);
@@ -372,7 +378,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	struct commit_list *list, *p, *best, *next, *last;
 	int *weights;
 
-	show_list("bisection 2 entry", 0, 0, *commit_list);
+	show_list("bisection 2 entry", 0, 0, *commit_list, bisect_flags);
 
 	/*
 	 * Count the number of total and tree-changing items on the
@@ -395,7 +401,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 		on_list++;
 	}
 	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
+	show_list("bisection 2 sorted", 0, nr, list, bisect_flags);
 
 	*all = nr;
 	weights = xcalloc(on_list, sizeof(*weights));
@@ -962,6 +968,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (skipped_revs.nr)
 		bisect_flags |= BISECT_FIND_ALL;
 
+	if (revs.first_parent_only)
+		bisect_flags |= BISECT_FIRST_PARENT;
+
 	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
diff --git a/bisect.h b/bisect.h
index 1d40a33ad..5b7358fc9 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,7 +1,8 @@
 #ifndef BISECT_H
 #define BISECT_H
 
-#define BISECT_FIND_ALL		(1u<<0)
+#define BISECT_FIND_ALL		  (1u<<0)
+#define BISECT_FIRST_PARENT (1u<<1)
 
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
 
-- 
2.16.3

