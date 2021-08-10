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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2DEC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4D161075
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhHJTuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhHJTum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C87C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so306426wmd.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AkDIkGh+DheEaNgO3OtM/BD/mizdLYg7oJenasMDoPY=;
        b=GbjlOSZGntIE02DFVDU05jz5XUog3GphYLWWJ3+wkHH0jOtwHnV4HAFGYHd51YaJ35
         +ADJsyNOY7s5X3Uy4a/Gh//UqL5PKgGzxmAGE8j95AMQZ1QqrT0sPos7+x/xzcRciEhS
         obbcs8OHX4eqoO+Ywd+kCv6+ywNruu5amGH/k5PBgCaDtwqzcvWG0DM4SbPxi1mHEGLQ
         LiUQhYrSEk+Ap6GSmj/m700pqyNG3rhBdveTzzch12OS9fUVUf4R8zaGeRAXMrZK9Pq7
         LzPrM3xTLx/QkquyUzOm8vxbF5Q5KxlvhBeLl5NV1etOuteegokHBBLFBP+aF8yG+SP2
         Dv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AkDIkGh+DheEaNgO3OtM/BD/mizdLYg7oJenasMDoPY=;
        b=Z4Ys61P59FeUGZ1C1RmZvWuA2IeW3NoPkUpfZkkC7Zag41ixVw4KZ/9FJ0v+IOuwzm
         kABP1bOapJyGXfvHQzbbARdMxV3DETeprVzl82He/viKygHuq3La/uvb7uzG+1O2UAwJ
         D04fcEzoEZPBRmNP5sy6jMw083n3u5X/JOE+WrOkIaevF1L4Ns87w8pjvK+ntdEvkykS
         kEJdRL4czJ3dPZZVhJDsRL7UuAs2JoDZr6jfWFB7qakjPW1o6Z5JQI45N1py9arowKDo
         GkjjG6YOk9F65ehTDOPwaGsYySp78KtsVEYF6dNi1HLtFQfe1Z3G0AwA+G+0TlVmLAU7
         R24Q==
X-Gm-Message-State: AOAM532AvD3vHb//vFD6efS7IViQ0OMWcJtmnatH9T3aObQTrsGSZ08e
        dB8CbdZn0v6YQyPhp60eXyLetc+XZFc=
X-Google-Smtp-Source: ABdhPJytixIN/ifI6TWu1QpctwYixFRSK/MNtZRZNjiT/3qE6/BDIwzY8UDxNO6amawvpTw8y2S5EA==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr6245062wmh.99.1628625018181;
        Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm12775785wrs.29.2021.08.10.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:17 -0700 (PDT)
Message-Id: <e9ed5cd283087b8f23112f6f3ecbb5a282c4c717.1628625014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:10 +0000
Subject: [PATCH v2 5/8] sparse-checkout: create helper methods
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
 dir.c          | 29 +++++++++++++++++++++++++++++
 dir.h          |  6 ++++++
 sparse-index.c | 12 +++---------
 4 files changed, 40 insertions(+), 15 deletions(-)

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
index 03c4d212672..7027bdfa068 100644
--- a/dir.c
+++ b/dir.c
@@ -1439,6 +1439,35 @@ done:
 	return result;
 }
 
+int init_sparse_checkout_patterns(struct index_state *istate)
+{
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
+enum pattern_match_result path_in_sparse_checkout(const char *path,
+						  struct index_state *istate)
+{
+	int dtype = DT_REG;
+	init_sparse_checkout_patterns(istate);
+
+	if (!istate->sparse_checkout_patterns)
+		return MATCHED;
+
+	return path_matches_pattern_list(path, strlen(path), NULL, &dtype,
+					 istate->sparse_checkout_patterns,
+					 istate);
+}
+
 static struct path_pattern *last_matching_pattern_from_lists(
 		struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int pathlen,
diff --git a/dir.h b/dir.h
index b3e1a54a971..9af2e8c4ba4 100644
--- a/dir.h
+++ b/dir.h
@@ -394,6 +394,12 @@ enum pattern_match_result path_matches_pattern_list(const char *pathname,
 				const char *basename, int *dtype,
 				struct pattern_list *pl,
 				struct index_state *istate);
+
+int init_sparse_checkout_patterns(struct index_state *state);
+
+enum pattern_match_result path_in_sparse_checkout(const char *path,
+						  struct index_state *istate);
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

