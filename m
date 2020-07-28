Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B207C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA2F20825
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz2iJW25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgG1Po0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgG1PoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:44:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD446C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:44:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so6607633wmk.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5v3fEUfnLwd1LsUrFDfDyscbyisA6/VmX+6x+9gitYQ=;
        b=kz2iJW25V5ZQ7qUB0BRkKk/+4FJhdXLMqKrmT/Ow/qrfSKC178f/DbpcshVZaulxAc
         CZUzw0Wnvc6fzx74b9im65yHLvVNx+M50BbnOKGpUCujw9Sg5Z80iAY1j/dCBat5A22B
         4LL9Khm9LZ/RtVxkf9lDukayd9zXIpFx83uGe1g0+vqXXfmQ/nK7SCm5gOUcqpCgy0NA
         9l+t7r0yttjTP/TmXKA6t6/I8I+flrUc0vt5bE6QAzzG71AikzUSuD4/qIh82izO8l/4
         xT6v8SXEO7zaVg9GTVMyEZ8Fdf5U+B1EVVpib4LaUYXzKOjc0EeWG1wOboOPXNG/VEga
         mLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5v3fEUfnLwd1LsUrFDfDyscbyisA6/VmX+6x+9gitYQ=;
        b=WEqqKCTg1lMisleRMs3EQ8wbbzZX3HDSDsfEZsMpNPzyTXes/TdIh6yP7OMf5yCm2H
         Tu8oPY7aEWR4CsWnZbXDgnv3h5qyN6Peu8bBCBilMutD6IJ8QHKGStgHdOCcrZZ1k8sa
         YkCF6bQ/5LuhHCPbNnstPgp6MRrehf/LcnBl0CEphkEF9O2Otop5W6SUYzT17NtT0v+Z
         bBjbzmoDbU+FJDN4ygE+LUn2ctd5mFkzD38hq70OZQPx9kUO4F73H46vTjqaNjuVLuBo
         s4BFqdigLPsRS0c4MbViH93OHQ9aH8ezn8csAIxUEE0o7f4UXlZwMc2bh5CVgei5pEVu
         S6vw==
X-Gm-Message-State: AOAM5307HecxiNMuEBzyVgPOj0rGLa+rcf5+MP8wOMG2r1XZGMJa8qP7
        vvy+up5rmf6jtLSkCJd44hRzEPLC
X-Google-Smtp-Source: ABdhPJz/kvPGQiQSll8vyHWjRHDhGq1sF8X297t72uHv94gFdami/YwJBrHJG7v/3BnlTPyp/3eReA==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr4386320wme.19.1595951061957;
        Tue, 28 Jul 2020 08:44:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm18421111wrx.73.2020.07.28.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:44:20 -0700 (PDT)
Message-Id: <24d116870e5c9ae03b585737a197f38d679fedb3.1595951056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.686.git.1595951056.gitgitgadget@gmail.com>
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
From:   "Aaron Lipman via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 15:44:16 +0000
Subject: [PATCH 3/3] bisect: combine args passed to find_bisection()
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

Now that find_bisection() accepts multiple boolean arguments, these may
be combined into a single unsigned integer in order to declutter some of
the code in bisect.c

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
Based-on-patch-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 bisect.c           | 43 +++++++++++++++++++++++++------------------
 bisect.h           |  5 ++++-
 builtin/rev-list.c |  9 ++++++++-
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/bisect.c b/bisect.c
index eee1f6f138..9599c58fd8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -37,7 +37,7 @@ static const char *term_good;
  * We care just barely enough to avoid recursing for
  * non-merge entries.
  */
-static int count_distance(struct commit_list *entry, int first_parent_only)
+static int count_distance(struct commit_list *entry, unsigned bisect_flags)
 {
 	int nr = 0;
 
@@ -52,10 +52,10 @@ static int count_distance(struct commit_list *entry, int first_parent_only)
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
 		entry = p;
-		if (p && !first_parent_only) {
+		if (p && !(bisect_flags & BISECT_FIRST_PARENT)) {
 			p = p->next;
 			while (p) {
-				nr += count_distance(p, first_parent_only);
+				nr += count_distance(p, bisect_flags);
 				p = p->next;
 			}
 		}
@@ -88,7 +88,7 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	**commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
-static int count_interesting_parents(struct commit *commit, int first_parent_only)
+static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
 {
 	struct commit_list *p;
 	int count;
@@ -96,7 +96,7 @@ static int count_interesting_parents(struct commit *commit, int first_parent_onl
 	for (count = 0, p = commit->parents; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING))
 			count++;
-		if (first_parent_only)
+		if (bisect_flags & BISECT_FIRST_PARENT)
 			break;
 	}
 	return count;
@@ -260,7 +260,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all, int first_parent_only)
+					     unsigned bisect_flags)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -272,7 +272,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
-		switch (count_interesting_parents(commit, first_parent_only)) {
+		switch (count_interesting_parents(commit, bisect_flags)) {
 		case 0:
 			if (!(flags & TREESAME)) {
 				weight_set(p, 1);
@@ -315,11 +315,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		weight_set(p, count_distance(p, first_parent_only));
+		weight_set(p, count_distance(p, bisect_flags));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
+		if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -342,7 +342,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			for (q = p->item->parents; q; q = q->next) {
 				if (!(q->item->object.flags & UNINTERESTING) && 0 <= weight(q)) {
 					break;
-				} else if (first_parent_only) {
+				} else if (bisect_flags & BISECT_FIRST_PARENT) {
 					q = NULL;
 					break;
 				}
@@ -365,21 +365,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
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
-		    int *all, int find_all, int first_parent_only)
+		    int *all, unsigned bisect_flags)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -415,9 +415,9 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all, first_parent_only);
+	best = do_find_bisection(list, nr, weights, bisect_flags);
 	if (best) {
-		if (!find_all) {
+		if (!(bisect_flags & BISECT_FIND_ALL)) {
 			list->item = best->item;
 			free_commit_list(list->next);
 			best = list;
@@ -1007,23 +1007,30 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
-	int first_parent_only = read_first_parent_option();
+	unsigned bisect_flags = 0;
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
+	if (read_first_parent_option())
+		bisect_flags |= BISECT_FIRST_PARENT;
+
+	if (!!skipped_revs.nr)
+		bisect_flags |= BISECT_FIND_ALL;
+
 	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
 	if (res)
 		return res;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
-	revs.first_parent_only = first_parent_only;
+
+	revs.first_parent_only = !!(bisect_flags & BISECT_FIRST_PARENT);
 	revs.limited = 1;
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, first_parent_only);
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index 8ee80f5b48..402ddcfb5e 100644
--- a/bisect.h
+++ b/bisect.h
@@ -12,7 +12,7 @@ struct repository;
  * best commit, as chosen by `find_all`.
  */
 void find_bisection(struct commit_list **list, int *reaches, int *all,
-		    int find_all, int first_parent_only);
+		    unsigned bisect_flags);
 
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
@@ -23,6 +23,9 @@ struct commit_list *filter_skipped(struct commit_list *list,
 #define BISECT_SHOW_ALL		(1<<0)
 #define REV_LIST_QUIET		(1<<1)
 
+#define BISECT_FIND_ALL		(1u<<0)
+#define BISECT_FIRST_PARENT	(1u<<1)
+
 struct rev_list_info {
 	struct rev_info *revs;
 	int flags;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d1a14596b2..1536ea6f28 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -637,8 +637,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (bisect_list) {
 		int reaches, all;
+		unsigned bisect_flags = 0;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all, revs.first_parent_only);
+		if (bisect_find_all)
+			bisect_flags |= BISECT_FIND_ALL;
+
+		if (revs.first_parent_only)
+			bisect_flags |= BISECT_FIRST_PARENT;
+
+		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
-- 
gitgitgadget
