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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DF1C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C007B60555
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346829AbhIHBnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346668AbhIHBnr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D071C0613CF
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y132so485144wmc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xgVFZpCgEwxSR63IhFeNQZTeJ2cnt9VEz2UJ67AnEPM=;
        b=LBg7lWldvLCo/HWZKcBeHbiKxwwUPWzXF4dUdFUOC+0FbCr1eQfB/8A2wzSt6ISYab
         8bPubTsANccEmhDQD3s+IixkZleoJyF23MuV1DTwy5hYUTdmHQS3jMlvwupmuzm5/O60
         UKw0zv6JBOB2mVYr6Q64yMZgH99BpEKHlz3Nopi4I5vNZqRF93k1LnxXbp3BfPHRfuwm
         UfsiJiHCWM+lpGwN+9fKrd3ZCXrKQQ0GWCWEeaBdWckvhY8FMzO74qh7DMGn/zT8D4Dh
         P9tM7RJBrpHfpMyaG70anYz5uZ9QzmOzCkZhVccXf4KW6qEEbX7uyjuy2qrk4zuA4O5G
         FrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xgVFZpCgEwxSR63IhFeNQZTeJ2cnt9VEz2UJ67AnEPM=;
        b=nR8K8ac6SX4yTAuEJrhgJXxq0XJs3hLJzPs73lPc5I8aw06YT9rB95nQzgSgGS+9ov
         WtGNj32ig7hdtvPZsZ9HZ0rruLIlJC/ZDEQo10FykEmfxMhx32oWNuAKYiYXe3d91oy5
         fV+RMhifAIRGTR7zOTYo3S+GqoQG7wz27jBowivnmgF2/eYVi3X7cBhBtiuFxxQXYqGX
         Q61n7Y5xUtzw5BPsSl3vr9ebWCqo5NFzBsw3umSv+m3EWbSwiGB9Re23PaDGWcF9u5lW
         5PUqemkFSYI6ht1fjVFb3iEqs9Cj9cDfrSxPEWSa3txwlEYNyHXPjwFyftlJOQ56Q6Z3
         gsRA==
X-Gm-Message-State: AOAM532XRqY5uwEGxf9jAtuuQ4vofO9/k2mzC+ejmL+5BY18PtZkFNpv
        82ym9XKm5567cnp3x/+f7/4UknMuZX8=
X-Google-Smtp-Source: ABdhPJxw/rVqs3zzQC/bTHFiWTPRLwskPgeW5boVbDZKMUgiO2RiVDDAZ8i9SxpOqggES1vUMnZP5Q==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr921925wmi.184.1631065358704;
        Tue, 07 Sep 2021 18:42:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20sm541594wms.15.2021.09.07.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:38 -0700 (PDT)
Message-Id: <98b4cae2297cc93abe83a573360859c16806a6fd.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:30 +0000
Subject: [PATCH v5 6/9] sparse-checkout: create helper methods
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

