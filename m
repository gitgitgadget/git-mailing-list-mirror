Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12B81F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeDRVFs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:05:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37235 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbeDRVFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:05:47 -0400
Received: by mail-lf0-f67.google.com with SMTP id b23-v6so4666137lfg.4
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prXnUVopNHli1Irn5JwB7gWxKXKsAYLVMmm3vFsL3M0=;
        b=aVo263TcCTCa4WoiYH/yBG8CWlHzVXbDpoRk7XP3ucNszqNWdk4vDOQCOUj2aHUgO6
         tvz8hPNpEccUJW07yRt4y47G9cuFVphwxSH5R8nzxxkJwGquc/eVX9fjSKE8b4XvMk4e
         jh8Z0dGmdfh7b59MyqDKbvqAA8ANTfSQXGd/E7vzUnMJjdlHMjMOxZFhrk+Rfr2sdZun
         r3Y3gWR2z3XhHp8JuNFO7iWo4utVyiPb9H6prjH6x54zTwmk6vLzgrNEavia0A4czHJF
         f08PH01x0p2KDlLSfUjNEVbkgCRHomzoXF3GPu9J8T//jq5FXzvpSLqbUMT9CvPGinP6
         jORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prXnUVopNHli1Irn5JwB7gWxKXKsAYLVMmm3vFsL3M0=;
        b=uVbfG0FR1/Jvnkq4qj85hgfnFFNN0criKgnnW/6uQdtMls2+++klz+cm19C4lq1Ixv
         qjUOUtpN8qI+I+2KXrd+vu3X8YzGVAgxvWUZQdsEGzLuCZmV88GFiS5M5iea601BPuRj
         2IEKby7cXi10VDleuc7TiRSZT2w6K5orRiugBdp4Tfn4j+k+NEPswZVxzuftYAlDz9KH
         Hay3MwLSQRR3EhPFYI1yWQwcX4He6aJTVTOn+nvrm7xIdKB9XIcqRmmbboFwhPnelE95
         TB4s8JVvzUt/SQgsg31v9o3cqZAWKW+NEcLQz31JVFd8GyUwvK4ZLT0VbHC8wt9JcRFO
         0/DQ==
X-Gm-Message-State: ALQs6tCa1+2Rkfcd8pfDehw+RrxoXq+oGTIWhB769A9TaBw881I8HTix
        VVqSubr5VMhSqw1jf0kgrPhmxjh8
X-Google-Smtp-Source: AIpwx4/6MM1G47DuvnvV1p+a6/SXXWspCjvX+xHKRzfSK5spEodO9tMGb0uMpY2k2dnjNBKn5Tkk/Q==
X-Received: by 2002:a19:dd83:: with SMTP id w3-v6mr2561260lfi.82.1524085545334;
        Wed, 18 Apr 2018 14:05:45 -0700 (PDT)
Received: from localhost.localdomain (c-83f6d854.017-110-73746f16.cust.bredbandsbolaget.se. [84.216.246.131])
        by smtp.gmail.com with ESMTPSA id d4-v6sm433477lfg.65.2018.04.18.14.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 14:05:44 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, tiago@gitlab.com,
        christian.couder@gmail.com, sbeller@google.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v4] bisect: create 'bisect_flags' parameter in find_bisection()
Date:   Wed, 18 Apr 2018 23:05:35 +0200
Message-Id: <20180418210535.1862-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180415085841.1269-1-haraldnordgren@gmail.com>
References: <20180415085841.1269-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it possible to implement bisecting only on first parents or on
merge commits by passing flags to find_bisection(), instead of just
a 'find_all' boolean.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---

Notes:
    Use unsigned type and cache flag value

 bisect.c           | 15 ++++++++++-----
 bisect.h           |  6 ++++--
 builtin/rev-list.c |  6 +++---
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b50884..4eafc8262b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -254,9 +254,10 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     unsigned bisect_flags)
 {
 	int n, counted;
+	unsigned find_all = bisect_flags & BISECT_FIND_ALL;
 	struct commit_list *p;
 
 	counted = 0;
@@ -365,7 +366,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, unsigned bisect_flags)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -400,9 +401,9 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, bisect_flags);
 	if (best) {
-		if (!find_all) {
+		if (!(bisect_flags & BISECT_FIND_ALL)) {
 			list->item = best->item;
 			free_commit_list(list->next);
 			best = list;
@@ -943,6 +944,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct rev_info revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
+	unsigned bisect_flags = 0;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -957,7 +959,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
+	if (skipped_revs.nr)
+		bisect_flags |= BISECT_FIND_ALL;
+
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index a5d9248a47..1d40a33ad2 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,15 +1,17 @@
 #ifndef BISECT_H
 #define BISECT_H
 
+#define BISECT_FIND_ALL		(1u<<0)
+
 /*
  * Find bisection. If something is found, `reaches` will be the number of
  * commits that the best commit reaches. `all` will be the count of
  * non-SAMETREE commits. If nothing is found, `list` will be NULL.
  * Otherwise, it will be either all non-SAMETREE commits or the single
- * best commit, as chosen by `find_all`.
+ * best commit, as chosen by flag `BISECT_FIND_ALL`.
  */
 extern void find_bisection(struct commit_list **list, int *reaches, int *all,
-			   int find_all);
+			   unsigned bisect_flags);
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fadd3ec14c..8752f5bbed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -360,8 +360,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
-	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
+	unsigned bisect_flags = 0;
 	const char *show_progress = NULL;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -426,7 +426,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
-			bisect_find_all = 1;
+			bisect_flags |= BISECT_FIND_ALL;
 			info.flags |= BISECT_SHOW_ALL;
 			revs.show_decorations = 1;
 			continue;
@@ -538,7 +538,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches, all;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
+		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
-- 
2.14.3 (Apple Git-98)

