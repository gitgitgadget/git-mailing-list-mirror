Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26801F424
	for <e@80x24.org>; Wed,  9 May 2018 21:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965728AbeEIV5e (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 17:57:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37195 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965428AbeEIV5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 17:57:33 -0400
Received: by mail-wr0-f196.google.com with SMTP id h5-v6so53118wrm.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=molKGnK11UxMCjHRO2cMbAPDAG2MaEhuS+niyZqylPI=;
        b=uTdLVSAQX0rvUOCaSrzXu8qrthZnVMFrTV3PwaTHpQqn45TADYcnLn4Z5dFEJrMc4d
         pHz9/cxRnZqugJ6+0O77FfdA8A5BOirqw/sDo5GJkb6QDcvMeN1/c7xvbyQ8zW2jcqAb
         hDYxPEhte4/9T5MgNvqBACbVJZl7fTpV7UfeOZyYMukFAnw/LZiC4/4p3hweTXeWdDRp
         1EPCDOZD74b/N4D2MvqssIdfMfWkPvkBC943cftxc5+IHhCQLGDHKR2Y4Kra+gu9tYbM
         asjwoM7xLF4lCY05NFCrCd9twUBJ8l7h937TfUo7P0/tEIIjw4aKdLV/phT9vjim0JFU
         tNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=molKGnK11UxMCjHRO2cMbAPDAG2MaEhuS+niyZqylPI=;
        b=Ih0etaICda1OH4h6ohF4yFxRXj1T+omS6O4fUfvkgE+mzsQ2pwxNUkU1/sVYAfCfyo
         hSnSwlXEm5NBemIleK6kwJW7FVrlsIIqDaGj99d9MaXmUF9vXMqg9jylcm/+NI8Rn7Ki
         TMsyMSRmv1DcpIC6b5Ct678SHQ77owinTORYLXdefnLcKI9KDXAFreYFvguyJIWcarIz
         dJtFrywAI2mBRz2C8el5DIn7llY6cU/tL0NvQkuDKUX4CcXF4957c1E22TfRN73pWzRm
         Liu+oleSC9ez7xOYpQFo4g9eiE0mTXP4297SCpohl9Q/18Il237e5RZW3Y1f2TU1dR+A
         T50A==
X-Gm-Message-State: ALQs6tBOUGJPpEXh2H9X6ZOUKIEnZzXbMU57q3m1rGi/T+34N1u2HSjs
        3BkyShy2DCkXWPLUsyEHOLEuhQ==
X-Google-Smtp-Source: AB8JxZobieL3FBkNPJxVvfCOlvZ0gnPl9oFranzTut+7LV4Xiw4v2jBanLl/4DdGIufQawWCC6f8Wg==
X-Received: by 2002:adf:b90a:: with SMTP id k10-v6mr41710268wrf.283.1525903051645;
        Wed, 09 May 2018 14:57:31 -0700 (PDT)
Received: from tiagos-mbp.mynet ([88.98.201.186])
        by smtp.gmail.com with ESMTPSA id i30-v6sm57462819wra.38.2018.05.09.14.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 May 2018 14:57:31 -0700 (PDT)
From:   Tiago Botelho <tiagonbotelho@gmail.com>
X-Google-Original-From: Tiago Botelho <tiagonbotelho@hotmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: [PATCH] Implement --first-parent for git rev-list --bisect
Date:   Wed,  9 May 2018 22:57:28 +0100
Message-Id: <20180509215728.57046-1-tiagonbotelho@hotmail.com>
X-Mailer: git-send-email 2.16.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 bisect.c           | 53 +++++++++++++++++++++++++++++++----------------------
 bisect.h           |  1 +
 builtin/rev-list.c |  3 +++
 3 files changed, 35 insertions(+), 22 deletions(-)

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
index 1d40a33ad..9d69940e6 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,6 +1,7 @@
 #ifndef BISECT_H
 #define BISECT_H
 
+#define BISECT_FIRST_PARENT (1u<<1)
 #define BISECT_FIND_ALL		(1u<<0)
 
 /*
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
-- 
2.16.3

