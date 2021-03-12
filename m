Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58FC43381
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B767A64F7B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhCLWsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbhCLWsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:48:21 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B4C061761
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:20 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id g24so5119441qts.6
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LiJHBHaArQlwCOrUHSr2xSoSw/4CpnF5HkaLqRhlXQ=;
        b=tRNf5eWaEAkZ7RyYTqB0p/qVRoFPu5MFOBRAY/LbTMaDYzTqEojPrNCIdvUdiTqtXH
         nRAd2vPfFRp4xu4DigdGiYfamYM8GJAlnoYkm9Tu43Xl0QQJ0DNIQdUCP867w4paWbq4
         ALc7pHtnkIOLhPAE6NoRNWLvuyB02QDjdjLJa+f6mpMdSQaTEHuTc6eMrp3biiXqZndk
         IYl9jzFLGGzTZLAyVwb1+BjeP7chda38i/eoOti2gjZu+989hcjlpp7oZ7hpoXgWZUSa
         dWMwbK2dAX2F3uFLBk22wrpReLjxMat8CPGW49Nre9tdXmwIfLu3PutO8SX7V/kLA32r
         vpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LiJHBHaArQlwCOrUHSr2xSoSw/4CpnF5HkaLqRhlXQ=;
        b=VIrae7ja3TGlUgxjntDH0OUgtjogadAnvYs9oyz3+QctFYZQrb0yBXzWu57j0SolWE
         4RGp2aw/E6RFOheinGNaNBJIxyPjTi4EOxLlP9yqIUnQTCkDCn7kWrJ1TTflblMGLU/0
         +eobPdoBTc5ABwU/3VATD5NgeghxmFtyHKLLEmRXB15fOgayZdF+UgRr0gSBG/Y6efNU
         sSgro+ABAi1YKdR5vSrHy86JKM1/vTTb/ybTAzzb6vEQKlTEkMyjD1Svu3znXiCcFUSP
         cQ7Bg4a4fLV/ManUg1pz9glgC00cIcX6QnIWs8oCjmnC+Oi6CVvVYB04/C0uwjtyfzuJ
         DhGA==
X-Gm-Message-State: AOAM533KI7AfN6U5YzrIhw4oD52NF6nvPx14ZLdZ/9U61MFtr+lQNYYl
        2n6+PVa0rMCiSVWqMSTd8E7k0/dACEBBzw==
X-Google-Smtp-Source: ABdhPJz7hLktDzHiWqg1dpuxOkVzKzoVdfyqAQaj1rYBOpC5QVjVkMIj0zSwkyrEiaFjwgl5X5KziQ==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr13835770qtm.216.1615589297271;
        Fri, 12 Mar 2021 14:48:17 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j1sm4870400qti.55.2021.03.12.14.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:48:16 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH v3 4/7] pathspec: allow to ignore SKIP_WORKTREE entries on index matching
Date:   Fri, 12 Mar 2021 19:47:59 -0300
Message-Id: <69d51579b36defbcac2eedaef19465c2a973c041.1615588109.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
References: <cover.1615588108.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new enum parameter to `add_pathspec_matches_against_index()` and
`find_pathspecs_matching_against_index()`, allowing callers to specify
whether these function should attempt to match SKIP_WORKTREE entries or
not. This will be used in a future patch to make `git add` display a
warning when it is asked to update SKIP_WORKTREE entries.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c          |  6 ++++--
 builtin/check-ignore.c |  3 ++-
 pathspec.c             | 10 +++++++---
 pathspec.h             | 10 ++++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5fec21a792..050cb8af30 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -177,7 +177,8 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, &the_index, seen);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen,
+					   PS_HEED_SKIP_WORKTREE);
 	return seen;
 }
 
@@ -578,7 +579,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+			seen = find_pathspecs_matching_against_index(&pathspec,
+					&the_index, PS_HEED_SKIP_WORKTREE);
 
 		/*
 		 * file_exists() assumes exact match
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 3c652748d5..0f4480a11b 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -100,7 +100,8 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index,
+						     PS_HEED_SKIP_WORKTREE);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		pattern = NULL;
diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..6d502e64e5 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -21,7 +21,8 @@
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen)
+					char *seen,
+					enum ps_skip_worktree_action sw_action)
 {
 	int num_unmatched = 0, i;
 
@@ -38,6 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
+		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
+			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
 }
@@ -51,10 +54,11 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * given pathspecs achieves against all items in the index.
  */
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate)
+					    const struct index_state *istate,
+					    enum ps_skip_worktree_action sw_action)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
-	add_pathspec_matches_against_index(pathspec, istate, seen);
+	add_pathspec_matches_against_index(pathspec, istate, seen, sw_action);
 	return seen;
 }
 
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..0feb8e9f67 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -149,11 +149,17 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 		return strcmp(s1, s2);
 }
 
+enum ps_skip_worktree_action {
+  PS_HEED_SKIP_WORKTREE = 0,
+  PS_IGNORE_SKIP_WORKTREE = 1
+};
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					const struct index_state *istate,
-					char *seen);
+					char *seen,
+					enum ps_skip_worktree_action sw_action);
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate);
+					    const struct index_state *istate,
+					    enum ps_skip_worktree_action sw_action);
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
-- 
2.30.1

