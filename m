Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3082BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1846127A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbhI1PWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbhI1PWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:22:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B0C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:20:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c73-20020a1c9a4c000000b0030d040bb895so3042023wme.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MIYC7caHEcGgNnPvyKX4TarSZoZpcdkjhSRFXDnkIk0=;
        b=FGZPbM7j7+l1vyakjcP98TYvuZt2qKAeTUgQQqsmqKjTdHxD5dodKQQyNO/ov0F+WO
         dvmk572JIDMTalHzoMSUDgpkaQ4alg+GvOmmcNVAFiD7pQUPflKKuTtXl06B8v4GiYKn
         8gv03SXpFrpote3Vhfpllp6qGRFxuRymzUqlzqaBUXzqgcyIAuWPpBLCO6ezhBHSwfZD
         guW9XClOiv2LNiFXh1eH17EpFyeeCBRG4Q+ttPskxCjNjRLwpQJGvXlbJFQ1fXfa0S5m
         Skp4J9CO25EgG01kh7SB1ZjXMko+EpmqxL4//44QuU6sMH8/BE5KAn+0p5Jog17qggcO
         3y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MIYC7caHEcGgNnPvyKX4TarSZoZpcdkjhSRFXDnkIk0=;
        b=fUD2Kq3MtzxSKaH75bUm7tJgVKKNoOJ38TIODR3OeJZ2CGRbgNtKh/4V5gb9QViwba
         KvBaU0n3RxZ0Txtw2/wH6H1qqdOvcdVQHp1aowwyK229yFFl/+9lXf+Y2hf99Kmjy66A
         SgNE3PO3jVXqxoBQk4y4Q//FW0Sw+m8L79jxl6VPiBEEcDwObnQPiLd404fTzDwgSlV/
         r/ze1epxNSMsdgSc8Brw9t0sNfdmGgcGGwV9oudFYq/zIkYTKYv7ycwAlAdLilRimAJo
         /qfzgi18APRfC6zrivt0Z/2pLn8xLcLnTdErsGF77lCsHAojKsnijCLPBUQZ3kd545lw
         1X0A==
X-Gm-Message-State: AOAM532dLiXRnZacTjdLDb30/kb4h47/3c+fQuL3jPkYQKSXGxM9FR8b
        34QtvG6XdPVOceKplGe3G3uDh2Gr78g=
X-Google-Smtp-Source: ABdhPJx15jRq5fUu48Ov9I0zkDGj1uj5XaXCov/ZBUZl6fjtiFH6w4vZNU8k/JqXIqnhgM8BI81zDA==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr5334209wml.93.1632842422590;
        Tue, 28 Sep 2021 08:20:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm3039373wmi.1.2021.09.28.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:20:21 -0700 (PDT)
Message-Id: <pull.1047.git.1632842421213.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:20:21 +0000
Subject: [PATCH] reset: behave correctly with sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

When using the sparse checkout feature, 'git reset' will add entries to
the index that will have the skip-worktree bit off but will leave the
working directory empty. File data is lost because the index version of
the files has been changed but there is nothing that is in the working
directory. This will cause the next 'git status' call to show either
deleted for files modified or deleting or nothing for files added. The
added files should be shown as untracked and modified files should be
shown as modified.

To fix this when the reset is running if there is not a file in the
working directory and if it will be missing with the new index entry or
was not missing in the previous version, we create the previous index
version of the file in the working directory so that status will report
correctly and the files will be availble for the user to deal with.

This fixes a documented failure from t1092 that was created in 19a0acc
(t1092: test interesting sparse-checkout scenarios, 2021-01-23).

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    reset: behave correctly with sparse-checkout
    
    This is a version of a commit [1] that has been in the microsoft/git
    fork for a while (authored in March 2017). I finally got around to
    figuring out why a test marked as 'test_expect_failure' was succeeding
    in our fork by bisecting to this commit.
    
    I only made superficial modifications from Kevin's original commit. Some
    style things, including whitespace and variable names, plus the switch
    to 'test_expect_success' in t1092.
    
    [1]
    https://github.com/microsoft/git/commit/6b8a074edfe3f4c06d08c3e1f2e496d3aef0a056
    
    Thanks, Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1047%2Fderrickstolee%2Fsparse-checkout%2Freset-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1047/derrickstolee/sparse-checkout/reset-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1047

 builtin/reset.c                          | 39 +++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  4 +-
 t/t7114-reset-sparse-checkout.sh         | 61 ++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100755 t/t7114-reset-sparse-checkout.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..8ffcd713720 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,8 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
+#include "entry.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -127,12 +129,49 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
+	int pos;
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
+		struct diff_filespec *two = q->queue[i]->two;
 		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		int was_missing = !two->mode && is_null_oid(&two->oid);
 		struct cache_entry *ce;
+		struct cache_entry *ce_before;
+		struct checkout state = CHECKOUT_INIT;
+
+		/*
+		 * When using the sparse-checkout feature the cache entries
+		 * that are added here will not have the skip-worktree bit
+		 * set. Without this code there is data that is lost because
+		 * the files that would normally be in the working directory
+		 * are not there and show as deleted for the next status.
+		 * In the case of added files, they just disappear.
+		 *
+		 * We need to create the previous version of the files in
+		 * the working directory so that they will have the right
+		 * content and the next status call will show modified or
+		 * untracked files correctly.
+		 */
+		if (core_apply_sparse_checkout && !file_exists(two->path)) {
+			pos = cache_name_pos(two->path, strlen(two->path));
+			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&
+			    (is_missing || !was_missing)) {
+				state.force = 1;
+				state.refresh_cache = 1;
+				state.istate = &the_index;
+
+				ce_before = make_cache_entry(&the_index, two->mode,
+							     &two->oid, two->path,
+							     0, 0);
+				if (!ce_before)
+					die(_("make_cache_entry failed for path '%s'"),
+						two->path);
+
+				checkout_entry(ce_before, &state, NULL, NULL);
+			}
+		}
 
 		if (is_missing && !intent_to_add) {
 			remove_file_from_cache(one->path);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..c5977152661 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -459,9 +459,7 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_failure 'checkout and reset (mixed)' '
+test_expect_success 'checkout and reset (mixed)' '
 	init_repos &&
 
 	test_all_match git checkout -b reset-test update-deep &&
diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
new file mode 100755
index 00000000000..a8029707fb1
--- /dev/null
+++ b/t/t7114-reset-sparse-checkout.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='reset when using a sparse-checkout'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_tick &&
+	echo "checkout file" >c &&
+	echo "modify file" >m &&
+	echo "delete file" >d &&
+	git add . &&
+	git commit -m "initial commit" &&
+	echo "added file" >a &&
+	echo "modification of a file" >m &&
+	git rm d &&
+	git add . &&
+	git commit -m "second commit" &&
+	git checkout -b endCommit
+'
+
+test_expect_success 'reset when there is a sparse-checkout' '
+	echo "/c" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	git checkout -B resetBranch &&
+	test_path_is_missing m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	git reset HEAD~1 &&
+	echo "checkout file" >expect &&
+	test_cmp expect c &&
+	echo "added file" >expect &&
+	test_cmp expect a &&
+	echo "modification of a file" >expect &&
+	test_cmp expect m &&
+	test_path_is_missing d
+'
+
+test_expect_success 'reset after deleting file without skip-worktree bit' '
+	git checkout -f endCommit &&
+	git clean -xdf &&
+	cat >.git/info/sparse-checkout <<-\EOF &&
+	/c
+	/m
+	EOF
+	test_config core.sparsecheckout true &&
+	git checkout -B resetAfterDelete &&
+	test_path_is_file m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	rm -f m &&
+	git reset HEAD~1 &&
+	echo "checkout file" >expect &&
+	test_cmp expect c &&
+	echo "added file" >expect &&
+	test_cmp expect a &&
+	test_path_is_missing m &&
+	test_path_is_missing d
+'
+
+test_done

base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0
-- 
gitgitgadget
