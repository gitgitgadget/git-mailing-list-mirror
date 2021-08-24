Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705BDC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B8C6138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhHXVwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhHXVwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA4C061796
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so2871199wme.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xgVFZpCgEwxSR63IhFeNQZTeJ2cnt9VEz2UJ67AnEPM=;
        b=IuWj03W4epfDI5t1SDaFu7hHtX3UL+FJAUHFF50Ce53MTt3gue0wA4KKIPaFWZMiP9
         d2uKrzbFNYQKkqCCgOZkK4G1JgzuhAgHogFFt8HN+cLw0IzQhGQzoBaqqMNYuO+e7xu7
         qZ4hqnGOWeMT3/3Pz3wtqIer5eK1w8CEAKVidFT9MTt7OhHLN+KkveTth5AsRhA+Tt/U
         hDwsIEEHJ75LyTHO+DQoecag1i8wIZE36YYnjRcU9mjEks1AcqTfN4GfzCIz7CRlP4x9
         eO7+Ci37sampxBaRnmo/1fxNhMAUoGMzMmes+a+2H1KwK39pIiO0x4xDYZp92xpgov8+
         Lh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xgVFZpCgEwxSR63IhFeNQZTeJ2cnt9VEz2UJ67AnEPM=;
        b=mhLmhP6EWfP34prnU0PCi7iG2LZndvJFgsJ/x7xR8/9gKu2wHr7GKXXoLVFUbXpCFu
         4bSaM4rvVxrtu9F6Ub7hcJLoP53xsI7m9HE4OpToRhZ43zKt0a2/4ZXBWWT/glorYF7R
         OoddgztM3NGhkS7tKa5H+pGh3B+SVkwyA+n+hxayEj9X25vDVqc/8rt64rvwzoqH/aTn
         k8+KqmnzhoxIwSTXeoY9MNEZW9Er8cvEDZu5N7VamINcRrpgKbO4jxgE7qiCfjowBuNj
         NfKU9OU8weyQFwr7brHYxuCfqDtIDe0D5zC9yl+e0bxBBHq5+GW+ctYrT446Q5Zt8gSM
         pbgA==
X-Gm-Message-State: AOAM5313e4w4mUwPiu02JktxAPy7De6fNk+JiFnHuANBDSLl4wklRnrz
        z2idiZfouh+5lGD7BqJr0Y3jvfmPM6A=
X-Google-Smtp-Source: ABdhPJzqr8U5lQWQv5c45/8cfM++XsmCET3QbRjloEeHwNvE7PdC/r9dcknCSdoxXoOt188Sa5iwdg==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr5975899wmh.161.1629841909585;
        Tue, 24 Aug 2021 14:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm4082794wmj.0.2021.08.24.14.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:49 -0700 (PDT)
Message-Id: <1958751aa0ef84ec18ddc7363d1f0c9e6c3f8d4d.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:40 +0000
Subject: [PATCH v4 06/10] sparse-checkout: create helper methods
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
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

We add a path_in_cone_mode_sparse_checkout() as well that will only
return false if the path is outside of the sparse-checkout definition
_and_ the sparse-checkout patterns are in cone mode.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c  |  7 +------
 dir.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dir.h          |  8 ++++++++
 sparse-index.c | 14 +++-----------
 4 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 17528e8f922..88a6c0c69fb 100644
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
@@ -199,12 +197,9 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i]) {
 			const char *path = pathspec->items[i].original;
-			int dtype = DT_REG;
 
 			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
-			    (sparse_checkout_enabled &&
-			     !path_matches_pattern_list(path, strlen(path), NULL,
-							&dtype, &pl, &the_index))) {
+			    !path_in_sparse_checkout(path, &the_index)) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec->items[i].original);
 			} else {
diff --git a/dir.c b/dir.c
index 03c4d212672..86afa2eae00 100644
--- a/dir.c
+++ b/dir.c
@@ -1439,6 +1439,58 @@ done:
 	return result;
 }
 
+int init_sparse_checkout_patterns(struct index_state *istate)
+{
+	if (!core_apply_sparse_checkout)
+		return 1;
+	if (istate->sparse_checkout_patterns)
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
+static int path_in_sparse_checkout_1(const char *path,
+				     struct index_state *istate,
+				     int require_cone_mode)
+{
+	const char *base;
+	int dtype = DT_REG;
+
+	/*
+	 * We default to accepting a path if there are no patterns or
+	 * they are of the wrong type.
+	 */
+	if (init_sparse_checkout_patterns(istate) ||
+	    (require_cone_mode &&
+	     !istate->sparse_checkout_patterns->use_cone_patterns))
+		return 1;
+
+	base = strrchr(path, '/');
+	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
+					 &dtype,
+					 istate->sparse_checkout_patterns,
+					 istate) > 0;
+}
+
+int path_in_sparse_checkout(const char *path,
+			    struct index_state *istate)
+{
+	return path_in_sparse_checkout_1(path, istate, 0);
+}
+
+int path_in_cone_mode_sparse_checkout(const char *path,
+				     struct index_state *istate)
+{
+	return path_in_sparse_checkout_1(path, istate, 1);
+}
+
 static struct path_pattern *last_matching_pattern_from_lists(
 		struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int pathlen,
diff --git a/dir.h b/dir.h
index b3e1a54a971..6823312521e 100644
--- a/dir.h
+++ b/dir.h
@@ -394,6 +394,14 @@ enum pattern_match_result path_matches_pattern_list(const char *pathname,
 				const char *basename, int *dtype,
 				struct pattern_list *pl,
 				struct index_state *istate);
+
+int init_sparse_checkout_patterns(struct index_state *state);
+
+int path_in_sparse_checkout(const char *path,
+			    struct index_state *istate);
+int path_in_cone_mode_sparse_checkout(const char *path,
+				      struct index_state *istate);
+
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len);
diff --git a/sparse-index.c b/sparse-index.c
index 880c5f72338..23f7c3bd361 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -33,19 +33,14 @@ static int convert_to_sparse_rec(struct index_state *istate,
 {
 	int i, can_convert = 1;
 	int start_converted = num_converted;
-	enum pattern_match_result match;
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
-	if (match != NOT_MATCHED)
+	if (path_in_sparse_checkout(ct_path, istate))
 		can_convert = 0;
 
 	for (i = start; can_convert && i < end; i++) {
@@ -152,11 +147,8 @@ int convert_to_sparse(struct index_state *istate)
 	if (!istate->repo->settings.sparse_index)
 		return 0;
 
-	if (!istate->sparse_checkout_patterns) {
-		istate->sparse_checkout_patterns = xcalloc(1, sizeof(struct pattern_list));
-		if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < 0)
-			return 0;
-	}
+	if (init_sparse_checkout_patterns(istate))
+		return 0;
 
 	/*
 	 * We need cone-mode patterns to use sparse-index. If a user edits
-- 
gitgitgadget

