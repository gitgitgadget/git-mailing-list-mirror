Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60171F404
	for <e@80x24.org>; Sun, 15 Apr 2018 13:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeDONtn (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 09:49:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:47039 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeDONtm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 09:49:42 -0400
Received: by mail-lf0-f66.google.com with SMTP id j68-v6so18386243lfg.13
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9E0t5nmkKnMjOir3g8nhyDgysG74g4jCjtdXNAzDSWk=;
        b=mQPmHxB+zhGcmfEJLYCMpQQxSlZ7T6bgFRmiGLDZVHxpSbqFCBQRzKWHhAX0+XJcLC
         yEx8HmIqDFOjH+8vT5jn7aA0xSpdZxJJPCFLQgHmLEPm+T8X5P+qp+45CHbYZn0NfW+T
         syf4KzJI5xZnd4yUT/XRe1w0cYfqdetwBR2T3ODrO1q6eP1U5WCKdQa2KWA62o3ooQRc
         sa1gvyLC1BIiX7mi5MUWM7VvWNILE+kATpoJsZ77+NiZ8ofYsYHo/KR3IbwcrzMQ9QCH
         pNNALpThS6+S3K5UUUAjNjMN1zBh5dyOMl7OzrbsAzilRwKlgQlx/+rJ0iUyK7aDaAV6
         tbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9E0t5nmkKnMjOir3g8nhyDgysG74g4jCjtdXNAzDSWk=;
        b=NlnuGudHOY6hRuZf8e04QGL0UGyd1kIeElouTu7lt0oeHYLmTFVXyi6SGD29UtGoUa
         aS1VoZircibYQMupEnHXXMGvRpnt001ljpCe4a3JIrw3YBU+kJr1UP7t5OUDG5ih7Pct
         kVYtUoE4ZtAgmq42SlhGJYLC0PAmZoJKX+ffNzE7KtugccsawA5TsP6+3AnQBuqeSXrX
         OJbzIjFAQrkyLuBuOybEkU+nQtE4w6J9pO1ktsV1gNwlgGejAmp0f436hgQRF4ZED8zl
         OI9VyfunYqMIwJrYyj8qb24chP7LE2IGGvtDO8qj6VbSoKiS/HCKIbr7FFUX5/WTHfws
         J7RQ==
X-Gm-Message-State: ALQs6tDTc7pT743qb+1fQ9MaI3c6rIh4L47z5sQ1RKzumnFQ4rBpnecW
        WL4tMDq8rDD8e+Zoocoky2OexXyT9lQ=
X-Google-Smtp-Source: AIpwx49tDBke5bR9qvqL76uN8QmZq/A4EK8ipKvM37KFISPwEzdNMdzoKjS+8NTosk/Ui64BKlzgVQ==
X-Received: by 2002:a19:d34c:: with SMTP id k73-v6mr4422370lfg.118.1523800181017;
        Sun, 15 Apr 2018 06:49:41 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.190])
        by smtp.gmail.com with ESMTPSA id a189-v6sm1638616lfb.12.2018.04.15.06.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 06:49:40 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, tiago@gitlab.com,
        christian.couder@gmail.com, sbeller@google.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v3] bisect: create 'bisect_flags' parameter in find_bisection()
Date:   Sun, 15 Apr 2018 15:49:25 +0200
Message-Id: <20180415134925.6203-1-haraldnordgren@gmail.com>
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
    Updating commit message

 bisect.c           | 20 ++++++++++++--------
 bisect.h           |  6 ++++--
 builtin/rev-list.c |  6 +++---
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b50884..19dac7491d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -254,7 +254,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     unsigned int bisect_flags)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -313,7 +313,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
+		if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -351,21 +351,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))
 				return p;
 		}
 	}
 
 	show_list("bisection 2 counted all", counted, nr, list);
 
-	if (!find_all)
+	if (!(bisect_flags & BISECT_FIND_ALL))
 		return best_bisection(list, nr);
 	else
 		return best_bisection_sorted(list, nr);
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, unsigned int bisect_flags)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -400,9 +400,9 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
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
@@ -943,6 +943,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct rev_info revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
+	unsigned int bisect_flags = 0;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -957,7 +958,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
+	if (skipped_revs.nr)
+		bisect_flags |= BISECT_FIND_ALL;
+
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index a5d9248a47..8efe243a34 100644
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
+			   unsigned int bisect_flags);
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fadd3ec14c..22c3d479fb 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -360,8 +360,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
-	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
+	unsigned int bisect_flags = 0;
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

