Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD05E20281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbdKEUZW (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:25:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43756 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKEUZU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:25:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so7134242wmr.0
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDtCwdYy325dJOiGHRMbj1UNmZ5KNNfoQfoxwoutOo4=;
        b=pJyf3MoMTmIFUavvdIHvt7A2YcggoXKlK/vJJ0hBmaU5l6m3MgPBoWvXK0axgwKfeH
         Bf3XaCRXUbepE1IgbVZOsxXbJPo8RPh0z3OXxYBAwfTYYfHTbEIAuwMzwKv0s4N/SpOn
         eJb3tuflTYzxkt1COvsETjxFklZxIRv9jhyWZoeixn1ei4q0o+lXDFRmaSmzQk29D3bT
         7M1mawCWkIMpxs47Wh8aAMCvYmilopw36vt2zITqqDcklta9oKFgIPeQZjEPSGelZR1V
         gZeISHUCkwAogPrXRK8WPxbS80Ot1uvsVhSfeIQFMeu4vun0g6TCVIOdq9GiBFEXmik3
         5oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDtCwdYy325dJOiGHRMbj1UNmZ5KNNfoQfoxwoutOo4=;
        b=C5sRyhg/CXKOAuROfhgvLeIkOf0Lk1hos7cZ00bf4VKilQ9qc4+r9hffi3QkzAnQky
         YqkRETsaGqlelnkXVQ84+aeVOZxcCmKI+PJ8OO6pO36S1iLR6Ej6RzPG5ZojItXMZn46
         cx1DnCapfqatQMDeNGpav9z8p1MJFesUJstlVLlBD7fC4+LBmz0sd0UdSBTvSlx3yesj
         xqr4vFLpECww0cmUS2uPyxCnGc1Ed7LYt1N5Sg0E/usj6dlLdRhfhyQskguncnoSBvUs
         XmZcDQrj6thgfRm8pKmV8TGH38KjdQkHLDmPlk1QtRM4DrXDV6dSUcYhaYqWqoMf33q1
         lgtw==
X-Gm-Message-State: AJaThX44TSLBCVZBgTdHSeopMCF9Kq4WJRoNOfCCCFscwE/Fxu3kegyU
        FIOgFbeN9mbr1VvABXo0MMCwxC6Z
X-Google-Smtp-Source: ABhQp+SIheh8zhfem8RJEyhD/LWzE9oWGiHzuIF3YXchSBK1Q2+6d02UYdZ6CsZWTifwhqNFbCAwoQ==
X-Received: by 10.28.160.23 with SMTP id j23mr4159412wme.125.1509913519037;
        Sun, 05 Nov 2017 12:25:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 71sm12917543wmg.0.2017.11.05.12.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:25:18 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/4] bisect: change calling-convention of `find_bisection()`
Date:   Sun,  5 Nov 2017 21:24:28 +0100
Message-Id: <ec6382fb9505cf7b0a880bb515c0f878415a3b9e.1509906092.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509906092.git.martin.agren@gmail.com>
References: <CAN0heSoBeG_8zLwS-71_ZVBF-HsVGKY1W1QiTSQ_ybwWCPauog@mail.gmail.com> <cover.1509906092.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function takes a commit list and returns a commit list. The
returned list is built by modifying the original list. Thus the caller
should not use the original list again (and after the next commit fixes
a memory leak, it must not).

Change the function signature so that it takes a **list and has void
return type. That should make it harder to misuse this function.

While we're here, document this function.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 bisect.h           | 12 +++++++++---
 bisect.c           | 16 +++++++---------
 builtin/rev-list.c |  3 +--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/bisect.h b/bisect.h
index acd12ef80..c535e6d12 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,9 +1,15 @@
 #ifndef BISECT_H
 #define BISECT_H
 
-extern struct commit_list *find_bisection(struct commit_list *list,
-					  int *reaches, int *all,
-					  int find_all);
+/*
+ * Find bisection. If something is found, `reaches` will be the number of
+ * commits that the best commit reaches. `all` will be the count of
+ * non-SAMETREE commits. If nothing is found, `list` will be NULL.
+ * Otherwise, it will be either all non-SAMETREE commits or the single
+ * best commit, as chosen by `find_all`.
+ */
+extern void find_bisection(struct commit_list **list, int *reaches, int *all,
+			   int find_all);
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
diff --git a/bisect.c b/bisect.c
index 96beeb5d1..5a3ae4971 100644
--- a/bisect.c
+++ b/bisect.c
@@ -360,21 +360,20 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
-struct commit_list *find_bisection(struct commit_list *list,
-					  int *reaches, int *all,
-					  int find_all)
+void find_bisection(struct commit_list **commit_list, int *reaches,
+		    int *all, int find_all)
 {
 	int nr, on_list;
-	struct commit_list *p, *best, *next, *last;
+	struct commit_list *list, *p, *best, *next, *last;
 	int *weights;
 
-	show_list("bisection 2 entry", 0, 0, list);
+	show_list("bisection 2 entry", 0, 0, *commit_list);
 
 	/*
 	 * Count the number of total and tree-changing items on the
 	 * list, while reversing the list.
 	 */
-	for (nr = on_list = 0, last = NULL, p = list;
+	for (nr = on_list = 0, last = NULL, p = *commit_list;
 	     p;
 	     p = next) {
 		unsigned flags = p->item->object.flags;
@@ -402,7 +401,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 		*reaches = weight(best);
 	}
 	free(weights);
-	return best;
+	*commit_list = best;
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
@@ -954,8 +953,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	revs.commits = find_bisection(revs.commits, &reaches, &all,
-				       !!skipped_revs.nr);
+	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1c74d4a7..fb1c36af6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -397,8 +397,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
-		revs.commits = find_bisection(revs.commits, &reaches, &all,
-					      bisect_find_all);
+		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
-- 
2.15.0.415.gac1375d7e

