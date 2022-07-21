Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0682C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiGUJOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiGUJOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:14:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AABB3AE6E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:14:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso462837wmm.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rzKpLoYCPhJjZiQicblJ+1wB5g8EkHQM27lXTq6eZc8=;
        b=jDNv3/23su8H8Y5o5gOM0adj9PUj3l29VMX9jadAVL8Sj6IeheHNzChQS2hhIvcdty
         GztF5h5DsoOVkOG/1WRe0GVVtVhIRIucf0rv9Og1oLtK8z93TqrDXlv7ZW5X1iA77lGL
         fvlB8Bq3y5dcddG8oCtzA/PczPkv/mPvSV3SZfgGFg8ddOGA7mIpYPugBb2O0qkIAb4o
         fNdZP1cyYsjeY1Gz8uDW4rWnny6PmdSnaRaoofSBVZVn4YvZ2aI5h1rWj9PHUqf3J6B0
         oLSeUfDgKAe/y20IuQCuHxjji1Iu8xV3W5drgZsgSlkCKS/JIdEsIN0Qnc6BELJGWVRG
         +MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rzKpLoYCPhJjZiQicblJ+1wB5g8EkHQM27lXTq6eZc8=;
        b=JLmvtqzdm3uzOfk98rPhu7a5a84th+72fEr/uhscgW/0XsVo8G9J0hOVwKo5AnI9yv
         MnqMoK6Bm4YbPqkB2TqC2NTRYk7F2XTN6vJWiZBcM7oGLjZC5yLRHJN13h5rV3FnO8nT
         dC6J8SUHIOqyc1+bnuJGas4LvFo2lPiI7LScc415QmXqY63GuEETmqLD/SO8fdlrZiws
         ExA9jeRwABdjWpR2Aps+zp34JFIH6uH/MlWXOyMtV33pn0YpxfDOWBMBcBPttHxHSjYs
         PHyV9JjmagbVVSAfocr/v+MiMeyH8p8F6r8hnTKsd9z+jdSbORjJ8USYX4BYuTPosbI3
         tFnQ==
X-Gm-Message-State: AJIora9KeZSbzmCC6FobtgTRtG2cMbuisN5dlLzJidS1a/YzzDAYIOqs
        JxU5wAM0qvGvA+o3ApgD7IlHKpTQTRA=
X-Google-Smtp-Source: AGRyM1vumwWDtlJR4h06SzJdfT7R4zIHDfavEjTtqbMYd313b6EhmcwvQY2ei52PlWlNQ26RFV/K1g==
X-Received: by 2002:a05:600c:a08:b0:3a1:9319:ab78 with SMTP id z8-20020a05600c0a0800b003a19319ab78mr7290461wmp.158.1658394856189;
        Thu, 21 Jul 2022 02:14:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b0021e4fd8e10bsm1352179wru.11.2022.07.21.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:14:15 -0700 (PDT)
Message-Id: <pull.1295.git.1658394854464.gitgitgadget@gmail.com>
From:   "v via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:14:14 +0000
Subject: [PATCH] repository:new config to only check files matched
 sparse-checkout patterns.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     v <fvoidcn@gmail.com>, Canwei He <fvoidcn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Canwei He <fvoidcn@gmail.com>

By Default with sparse checkouts, all files with SKIP_WORKTREE bit
in the index must check whether exists in the worktree. And Git will
expand all of that files in the index and must traverse recursively
in the worktree. This option can be used to tell Git that just check
files which can match the sparse-checkout patterns.

It is useful when you are using a visual file system in order to
on-demand loading working tree lazily. It can control which directory
should load by using sparse-checkout patterns. But it doesn't want to
visit other directory which haven't been load but just have an empty
directory for the entry of the file loading switch. In default model,
Git would traverse root direcotry recursively however all files would
be loaded, this behaviour would very expensive. With
`sparse.onlyCheckFilesMatchPatterns` model, Git would just check the
path witch only matched the sparse-checkout patterns to prevent loading
all the directory.

Signed-off-by: Canwei He <fvoidcn@gmail.com>
---
    repository:new config to only check files matched sparse-checkout
    patterns.
    
    repository:new config to only check files matched sparse-checkout
    patterns.
    
    By Default with sparse checkouts, all files with SKIP_WORKTREE bit in
    the index must check whether exists in the worktree. And Git will expand
    all of that files in the index and must traverse recursively in the
    worktree. This option can be used to tell Git that just check files
    which can match the sparse-checkout patterns.
    
    It is useful when you are using a visual file system in order to
    on-demand loading working tree lazily. It can control which directory
    should load by using sparse-checkout patterns. But it doesn't want to
    visit other directory which haven't been load but just have an empty
    directory for the entry of the file loading switch. In default model,
    Git would traverse root direcotry recursively however all files would be
    loaded, this behaviour would very expensive. With
    sparse.onlyCheckFilesMatchPatterns model, Git would just check the path
    witch only matched the sparse-checkout patterns to prevent loading all
    the directory.
    
    Signed-off-by: Canwei He fvoidcn@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1295%2FfvoidCN%2Fvoidhe-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1295/fvoidCN/voidhe-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1295

 Documentation/config/sparse.txt  | 25 ++++++++++++++++
 cache.h                          |  1 +
 config.c                         |  5 ++++
 environment.c                    |  1 +
 sparse-index.c                   | 19 ++++++++----
 t/t1090-sparse-checkout-scope.sh | 50 ++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
index aff49a8d3a3..f71716f446a 100644
--- a/Documentation/config/sparse.txt
+++ b/Documentation/config/sparse.txt
@@ -25,3 +25,28 @@ Regardless of this setting, Git does not check for
 present-despite-skipped files unless sparse checkout is enabled, so
 this config option has no effect unless `core.sparseCheckout` is
 `true`.
+
+sparse.onlyCheckFilesMatchPatterns::
+    By Default with sparse checkouts, all files with SKIP_WORKTREE bit
+    in the index must check whether exists in the worktree. And Git will
+    expand all of that files in the index and must traverse recursively
+    in the worktree. This option can be used to tell Git that just check
+    files which can match the sparse-checkout patterns.
++
+The default is `false`, which allows Git to automatically recover
+from the list of files in the index and working tree falling out of
+sync.
++
+Set this to `true` if you just hope Git maintain the consistency
+between the presence of working tree files and sparsity patterns
+confining to which match the sparse-checkout patterns.For example,
+if you are using a visual file system in order to on-demand loading
+working tree lazily. It can control which directory should load by
+using sparse-checkout patterns. But it doesn't want to visit other
+directory which haven't been load but just have an empty directory
+for the entry of the file loading switch.
++
+Regardless of this setting, Git does not check for
+present-despite-skipped files unless sparse checkout is enabled, so
+this config option has no effect unless `core.sparseCheckout` is
+`true`.
\ No newline at end of file
diff --git a/cache.h b/cache.h
index ac5ab4ef9d3..d1ed717403c 100644
--- a/cache.h
+++ b/cache.h
@@ -1074,6 +1074,7 @@ extern int protect_ntfs;
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
+extern int sparse_only_check_files_match_patterns;
 
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
diff --git a/config.c b/config.c
index 9b0e9c93285..5ab9719479a 100644
--- a/config.c
+++ b/config.c
@@ -1758,6 +1758,11 @@ static int git_default_sparse_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "sparse.onlycheckfilesmatchpatterns")) {
+		sparse_only_check_files_match_patterns = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config/sparse.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index b3296ce7d15..0ee4190c7dc 100644
--- a/environment.c
+++ b/environment.c
@@ -73,6 +73,7 @@ int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
+int sparse_only_check_files_match_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..264f4965e24 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -502,14 +502,21 @@ restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
-		if (ce_skip_worktree(ce) &&
-		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
-			if (S_ISSPARSEDIR(ce->ce_mode)) {
-				ensure_full_index(istate);
-				goto restart;
+		if (ce_skip_worktree(ce)) {
+			if (sparse_only_check_files_match_patterns &&
+			    !path_in_sparse_checkout(ce->name, istate)){
+				continue;
+			}
+
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+				if (S_ISSPARSEDIR(ce->ce_mode)) {
+					ensure_full_index(istate);
+					goto restart;
+				}
+				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			}
-			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
+
 	}
 }
 
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index d1833c0f31b..da8173ebe5d 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -71,6 +71,56 @@ test_expect_success 'skip-worktree on files outside sparse patterns' '
 	test_cmp expect actual
 '
 
+test_expect_success 'skip-worktree on files only matched patterns. default' '
+	git clean -f . &&
+	git update-index  --refresh &&
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone "a*" &&
+	test_config sparse.expectFilesOutsideOfPatterns false &&
+	git checkout-index --all --ignore-skip-worktree-bits &&
+
+	git ls-files -t >output &&
+	! grep ^S output >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'skip-worktree on files only matched patterns. b,c not in patterns' '
+	git clean -f . &&
+	git update-index  --refresh &&
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone "a*" &&
+	test_config sparse.onlyCheckFilesMatchPatterns true &&
+	git checkout-index --all --ignore-skip-worktree-bits &&
+
+	git ls-files -t >output &&
+	cat <<-\EOF >expect &&
+	H a
+	S b
+	S c
+	EOF
+	test_cmp expect output >>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'skip-worktree on files only matched patterns. file b in patterns c is not' '
+	git clean -f . &&
+	git update-index  --refresh &&
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone "a*" &&
+	test_config sparse.onlyCheckFilesMatchPatterns true &&
+	echo "b*" >>.git/info/sparse-checkout &&
+	git checkout-index --all --ignore-skip-worktree-bits &&
+
+	git ls-files -t >output &&
+	cat <<-\EOF >expect &&
+	H a
+	H b
+	S c
+	EOF
+	test_cmp expect output >>actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
 	test_create_repo server &&
 	git clone "file://$(pwd)/server" client &&

base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
-- 
gitgitgadget
