Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA6C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D7A60F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhHQNYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbhHQNYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2AC0612AD
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g138so13697419wmg.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5SS0RogwT3BDZ9sDPz8oKtXXDz/pUkaYBLo7L26BzEM=;
        b=lnggUh389xYW2n+lvMY/O9dnH4SDhL+YvQD96IQGhwKixKkGB4ZvRdhBVJ+DiQTu58
         akk5umu01w4f4Db58XswLCqt2GjK2CPlLJinyK+qqpislPdzIBd3WU0UlEkdNQWRvFqH
         4iboFpgRPkdOCSAY8Mfj08aadOjDuOuIhzkZ1QpZuFmvxHgyQOj7Gh3bYpqFgsvRDm6K
         Rq9FIGiIvrcOQVh5M9HZddl5kB/HPYZhuj7cRmza3huVROEhZ4vegzcbIF4f3FmP4wUD
         7gqG7h2oWgBh8wEO/awIa3HfnSkaL1JP2nuRjUSW3mHbXouGvt8BYPxoZ24QyXgrs/gn
         UgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5SS0RogwT3BDZ9sDPz8oKtXXDz/pUkaYBLo7L26BzEM=;
        b=uefJ/y5z0CYYTYkeleCDolERiUjLk9/5/z3m0qIF4osn637eqhsWZOY4LZal3XQWhC
         jcUL+dBPfcxo1djTBAcxYRCP40wXeOkwPXiS3U/iXzYDFkB0en/jbTmSV7ZMayDtHXZi
         l97zIliHDlekl2nXPh8pNfNeq63M7chs2X2fH0GOyotKk5jt5dGa6rdNP4xHUYKUfBEG
         7sW9d6F10xWB0VwamAi6j4CxqYRHYkZsPOHMVGmVvwmQDMQtsj1krfB3nY1dhYXyy4oc
         kjeYx58mf30jY+Lz2yDNRhWG4/qFCHTpRSu7p1/0xPOg3+hfgwti1S1Gvq9pxdNth16+
         +tCQ==
X-Gm-Message-State: AOAM5326sfbLOUcXVDfdCsEKMgHqBbsPtXl67wymbZ59IY2P1xMd9w6m
        1ZKmzoPjImuRI2Bygc7LCxNibnE5haw=
X-Google-Smtp-Source: ABdhPJzbgVhaOmSnJpXRVrVROHvLD49iVjKYYM3LXpzMgbJc/PkRvLp6S5SqTYxgFv/bCOyfff37Mw==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr3246992wme.13.1629206609983;
        Tue, 17 Aug 2021 06:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm2514892wmj.23.2021.08.17.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:28 -0700 (PDT)
Message-Id: <5d28570c82af19b4bda4253e72ace3760dfe2606.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:19 +0000
Subject: [PATCH v3 5/8] sparse-checkout: create helper methods
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we integrate the sparse index into more builtins, we occasionally
need to check the sparse-checkout patterns to see if a path is within
the sparse-checkout cone. Create some helper methods that help
initialize the patterns and check for pattern matching to make this
easier.

The existing callers of commands like get_sparse_checkout_patterns() use
a custom 'struct pattern_list' that is not necessarily the one in the
'struct index_state', so there are not many previous uses that could
adopt these helpers. There are just two in builtin/add.c and
sparse-index.c that can use path_in_sparse_checkout().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c  |  8 ++------
 dir.c          | 33 +++++++++++++++++++++++++++++++++
 dir.h          |  6 ++++++
 sparse-index.c | 12 +++---------
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 17528e8f922..f675bdeae4a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -190,8 +190,6 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
 		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
-	struct pattern_list pl = { 0 };
-	int sparse_checkout_enabled = !get_sparse_checkout_patterns(&pl);
 
 	seen = xcalloc(pathspec->nr, 1);
 	refresh_index(&the_index, flags, pathspec, seen,
@@ -199,12 +197,10 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i]) {
 			const char *path = pathspec->items[i].original;
-			int dtype = DT_REG;
 
 			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
-			    (sparse_checkout_enabled &&
-			     !path_matches_pattern_list(path, strlen(path), NULL,
-							&dtype, &pl, &the_index))) {
+			    (core_apply_sparse_checkout &&
+			     path_in_sparse_checkout(path, &the_index) == NOT_MATCHED)) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec->items[i].original);
 			} else {
diff --git a/dir.c b/dir.c
index 03c4d212672..6fd4f2e0f27 100644
--- a/dir.c
+++ b/dir.c
@@ -1439,6 +1439,39 @@ done:
 	return result;
 }
 
+int init_sparse_checkout_patterns(struct index_state *istate)
+{
+	if (!core_apply_sparse_checkout ||
+	    istate->sparse_checkout_patterns)
+		return 0;
+
+	CALLOC_ARRAY(istate->sparse_checkout_patterns, 1);
+
+	if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < 0) {
+		FREE_AND_NULL(istate->sparse_checkout_patterns);
+		return -1;
+	}
+
+	return 0;
+}
+
+int path_in_sparse_checkout(const char *path,
+			    struct index_state *istate)
+{
+	const char *base;
+	int dtype = DT_REG;
+	init_sparse_checkout_patterns(istate);
+
+	if (!istate->sparse_checkout_patterns)
+		return MATCHED;
+
+	base = strrchr(path, '/');
+	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
+					 &dtype,
+					 istate->sparse_checkout_patterns,
+					 istate) > 0;
+}
+
 static struct path_pattern *last_matching_pattern_from_lists(
 		struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int pathlen,
diff --git a/dir.h b/dir.h
index b3e1a54a971..b899ee43d81 100644
--- a/dir.h
+++ b/dir.h
@@ -394,6 +394,12 @@ enum pattern_match_result path_matches_pattern_list(const char *pathname,
 				const char *basename, int *dtype,
 				struct pattern_list *pl,
 				struct index_state *istate);
+
+int init_sparse_checkout_patterns(struct index_state *state);
+
+int path_in_sparse_checkout(const char *path,
+			    struct index_state *istate);
+
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len);
diff --git a/sparse-index.c b/sparse-index.c
index b6e90417556..2efc9fd4910 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -34,17 +34,14 @@ static int convert_to_sparse_rec(struct index_state *istate,
 	int i, can_convert = 1;
 	int start_converted = num_converted;
 	enum pattern_match_result match;
-	int dtype = DT_UNKNOWN;
 	struct strbuf child_path = STRBUF_INIT;
-	struct pattern_list *pl = istate->sparse_checkout_patterns;
 
 	/*
 	 * Is the current path outside of the sparse cone?
 	 * Then check if the region can be replaced by a sparse
 	 * directory entry (everything is sparse and merged).
 	 */
-	match = path_matches_pattern_list(ct_path, ct_pathlen,
-					  NULL, &dtype, pl, istate);
+	match = path_in_sparse_checkout(ct_path, istate);
 	if (match != NOT_MATCHED)
 		can_convert = 0;
 
@@ -153,11 +150,8 @@ int convert_to_sparse(struct index_state *istate)
 	if (!istate->repo->settings.sparse_index)
 		return 0;
 
-	if (!istate->sparse_checkout_patterns) {
-		istate->sparse_checkout_patterns = xcalloc(1, sizeof(struct pattern_list));
-		if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < 0)
-			return 0;
-	}
+	if (init_sparse_checkout_patterns(istate) < 0)
+		return 0;
 
 	/*
 	 * We need cone-mode patterns to use sparse-index. If a user edits
-- 
gitgitgadget

