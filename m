Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8580C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7886138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhHXVzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbhHXVzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA6C0613C1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso1566962wmr.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=36kJNonbXo/64agdD8fpLIv3/3HvGVknzEl/5at4bAs=;
        b=P7GKIkG3/cpja8upecmM3h9/zKGOJnolktDrvkimLQ76w/VfnCbcC1as9rMcz0jGiB
         rndF5cU2/Xy/Fb5iZZnVNmGsLGNyTfl+ZJt0SZCmAWhZMccpHQ4oZQ4WkoQyiOJ2uZap
         pIK8BXYyw49MhV18XBfHNyn3Z5OUFtZl7hOfmKwE/xFZZ8G4ppiazoQTVP6G5PQ6S1PR
         VqXnlla6ElHfBjy2qREFbLz55YvnwOPwENxfW0m+rD6CEGG78EffuOXvJOzHOm4tuV+f
         CeSA/pFwyZxuYPBVGVD1tW6Qp5Roy3cW8881gn0kLh54eFfPVorJxkvJVWEGsRTSjxRl
         6KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=36kJNonbXo/64agdD8fpLIv3/3HvGVknzEl/5at4bAs=;
        b=NCi0YLADhfC/7qOYeRnMMGj6BqUlk7/p+8JMPaw5QVHe55Di5M/nT8zczTUcpnej0s
         1wKVkXNnQrtBFhmNb9umVy9Zx0ihE9rWoVNW/+MyHPIzWaxTCrpkSa3Wp5aqgGWcguSR
         k96GV8NjOf/8vPzaCfu75gGpE6fmQTYyV6dqO1nEXckSAfVNPzIjMzrqcyWHD/JivsrO
         mVCZE/7R50AAX7uMwwHSuBiwOXxL9TlhWYUmJQyQn1olLoJCDYqOeD/UOdXFY7miSOB7
         9NBmQ9GX493MKViNIn67ki5ZUYFfQb9bka4T/DPUgTQjRuJLqoxBeJgqJFjdcFTvJrpB
         FJ8A==
X-Gm-Message-State: AOAM533IALXduO8LqitEBSkpUFi42lvmSGyxAXCvMsuAl6oOYKa4M08+
        I167Vw8DUjp/fnCCkjl+/XrUDykcviE=
X-Google-Smtp-Source: ABdhPJxT6SujB94TmJcv8LYuaO/Kzj9cSi43n5QpI9De/1w/Wc7q/7sHK+z+dOkG/nwdcI9NVUFoEg==
X-Received: by 2002:a05:600c:4304:: with SMTP id p4mr5064806wme.18.1629842093424;
        Tue, 24 Aug 2021 14:54:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25sm3453512wmr.15.2021.08.24.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:53 -0700 (PDT)
Message-Id: <f6c0d4e3a0695c331b8216103bb46bfb4a461d1e.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:44 +0000
Subject: [PATCH 12/13] mv: add '--sparse' option to ignore sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Users can get into strange situations if 'git mv' allows moving files
into, out of, or around the sparse-checkout cone. However, some users
may still want to do it. Allow knowledgeable users to do so via a new
'--sparse' option.

There are some special cases that occur in this change, such as the case
of a directory that doesn't match the sparse-checkout cone, but exists
in the working tree because a subset of its contents do match. We need
to communicate that index entries with the SKIP_WORKTREE bit are not
expected to be in the working directory and hence are not needed when
moving the contents. This is only a check for the existence of the
source file. The call to rename_cache_entry_at() still changes the index
appropriately in these cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/mv.c                  | 24 ++++++++++++++----------
 t/t7002-mv-sparse-checkout.sh | 34 ++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index b58fd4ce5ba..92ea9f0ca37 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -118,17 +118,18 @@ static int index_range_of_same_dir(const char *src, int length,
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
-	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
+	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
 		OPT__FORCE(&force, N_("force move/rename even if target exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
+		OPT_BOOL(0, "sparse", &ignore_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
+	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
@@ -182,11 +183,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (show_only)
 			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
 
-		if (!path_in_sparse_checkout(src, &the_index)) {
+		if (!ignore_sparse && !path_in_sparse_checkout(src, &the_index)) {
 			string_list_append(&only_match_skip_worktree, src);
 			skip_sparse = 1;
 		}
-		if (!path_in_sparse_checkout(dst, &the_index)) {
+		if (!ignore_sparse && !path_in_sparse_checkout(dst, &the_index)) {
 			string_list_append(&only_match_skip_worktree, dst);
 			skip_sparse = 1;
 		}
@@ -194,9 +195,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			continue;
 
 		length = strlen(src);
-		if (lstat(src, &st) < 0)
-			bad = _("bad source");
-		else if (!strncmp(src, dst, length) &&
+		if (lstat(src, &st) < 0) {
+			/* only error if existence is expected. */
+			if (modes[i] != SPARSE)
+				bad = _("bad source");
+		} else if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
 			bad = _("can not move directory into itself");
 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
@@ -225,11 +228,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
-					const char *path = active_cache[first + j]->name;
+					const struct cache_entry *ce = active_cache[first + j];
+					const char *path = ce->name;
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len, path + length + 1);
-					modes[argc + j] = INDEX;
+					modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
 					submodule_gitfile[argc + j] = NULL;
 				}
 				argc += last - first;
@@ -293,7 +297,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (mode != INDEX && rename(src, dst) < 0) {
+		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 5397c6d07bd..517fd587fa8 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -31,7 +31,9 @@ test_expect_success 'mv refuses to move sparse-to-sparse' '
 	echo b >>expect &&
 	echo e >>expect &&
 	cat sparse_hint >>expect &&
-	test_cmp expect stderr
+	test_cmp expect stderr &&
+	git mv --sparse b e 2>stderr &&
+	test_must_be_empty stderr
 '
 
 test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
@@ -44,7 +46,9 @@ test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
 	echo b >>expect &&
 	echo e >>expect &&
 	cat sparse_hint >>expect &&
-	test_cmp expect stderr
+	test_cmp expect stderr &&
+	git mv --sparse -k b e 2>stderr &&
+	test_must_be_empty stderr
 '
 
 test_expect_success 'mv refuses to move non-sparse-to-sparse' '
@@ -55,7 +59,9 @@ test_expect_success 'mv refuses to move non-sparse-to-sparse' '
 	cat sparse_error_header >expect &&
 	echo e >>expect &&
 	cat sparse_hint >>expect &&
-	test_cmp expect stderr
+	test_cmp expect stderr &&
+	git mv --sparse a e 2>stderr &&
+	test_must_be_empty stderr
 '
 
 test_expect_success 'mv refuses to move sparse-to-non-sparse' '
@@ -67,7 +73,9 @@ test_expect_success 'mv refuses to move sparse-to-non-sparse' '
 	cat sparse_error_header >expect &&
 	echo b >>expect &&
 	cat sparse_hint >>expect &&
-	test_cmp expect stderr
+	test_cmp expect stderr &&
+	git mv --sparse b e 2>stderr &&
+	test_must_be_empty stderr
 '
 
 test_expect_success 'recursive mv refuses to move (possible) sparse' '
@@ -80,7 +88,14 @@ test_expect_success 'recursive mv refuses to move (possible) sparse' '
 	echo sub >>expect &&
 	echo sub2 >>expect &&
 	cat sparse_hint >>expect &&
-	test_cmp expect stderr
+	test_cmp expect stderr &&
+	git mv --sparse sub sub2 2>stderr &&
+	test_must_be_empty stderr &&
+	git commit -m "moved sub to sub2" &&
+	git rev-parse HEAD~1:sub >expect &&
+	git rev-parse HEAD:sub2 >actual &&
+	test_cmp expect actual &&
+	git reset --hard HEAD~1
 '
 
 test_expect_success 'recursive mv refuses to move sparse' '
@@ -93,7 +108,14 @@ test_expect_success 'recursive mv refuses to move sparse' '
 	echo sub/dir2/e >>expect &&
 	echo sub2/dir2/e >>expect &&
 	cat sparse_hint >>expect &&
-	test_cmp expect stderr
+	test_cmp expect stderr &&
+	git mv --sparse sub sub2 2>stderr &&
+	test_must_be_empty stderr &&
+	git commit -m "moved sub to sub2" &&
+	git rev-parse HEAD~1:sub >expect &&
+	git rev-parse HEAD:sub2 >actual &&
+	test_cmp expect actual &&
+	git reset --hard HEAD~1
 '
 
 test_done
-- 
gitgitgadget

