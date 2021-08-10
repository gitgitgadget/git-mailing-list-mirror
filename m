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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A96C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C522C60ED8
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhHJTus (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhHJTuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6609C06179B
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso2775139wmj.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pcwjy+V2SEhtxyn0vJUrmLOj7GCOWJeEG7NdwuPhcdA=;
        b=roEHwXZP1AsQ2wj7YYf3O85F9kD87kkxcK0U8HVJ9gkyZdlklrgIvPduJCJieVE6E8
         rbNfzl9FrSol91iYZxNB6s6nPDaAz6+86YcAz3AbKKdItKkAGpvMAp4eXJ7Z1SxySlfl
         bpn2+O7EDUVmMZsH7fCkuV457iyZu9BVeXubLjCbh8NhP/ySM7XkZZpeB2XVCspxgE5/
         TG/socyRh49m6mTA4L3Vnac9OTCnEp7hv42wceOX67zB/Oa2GsTN9lDHOXxL1uvZv5mK
         L82LfPiKT7nPs4a7NvclcUeTx35wMupgMGcQzbWr1xjpKhN2BfrZDqEGw2yZS4/4jVp3
         OQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pcwjy+V2SEhtxyn0vJUrmLOj7GCOWJeEG7NdwuPhcdA=;
        b=HJ0M9Wb0nXXFwF5m9HOJXxpdKFm6msLUw9vKjqhWUXjeq0v1q6XQ5jK4jFSvJVg7o3
         5SktQcy+6yKGjqYEq+iEkEYuu9+7aMdLSqILivuJ58aDmEWwNansiWsmvEyMLxTL8xlm
         01BkwVF3OM1uaOwFx19nkDeInSWOHftd9H6Ro3hgWuX6c3MJJIp473GsMWki4Rg3A65i
         qSQ0XJ+EiVc4nPYYBf2aM31Hd/EDFzuD3/HQcD5FO9uQI2dZQ5+ubqxrmPUfqXKu08t1
         35DOzwtLznWsFfwEgs7tKYBx4zM5DOIcXyllAfQsqYBBQmFXuSRThZlVM4mMzrf0w20U
         fSpg==
X-Gm-Message-State: AOAM533XJ6u2FzGIqEYpvDfMw+StE0rvmZQ7Wrw8la7rffRLo/e55LgQ
        lVzdsI76va5992HN5yXET/4ke+IJiKI=
X-Google-Smtp-Source: ABdhPJzBr9hdSPeX4h5SDQS+BCVGahv8rUsUivUnGaMOfMXQmZqFBjECL6fjbnMFZq1en6Y8B7rQVw==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr23629956wmm.63.1628625020207;
        Tue, 10 Aug 2021 12:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm24651324wrr.21.2021.08.10.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:19 -0700 (PDT)
Message-Id: <f74015a2be97eff51ade75a2af95a6e13309a8f2.1628625014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:13 +0000
Subject: [PATCH v2 8/8] sparse-checkout: clear tracked sparse dirs
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

When changing the scope of a sparse-checkout using cone mode, we might
have some tracked directories go out of scope. The current logic removes
the tracked files from within those directories, but leaves the ignored
files within those directories. This is a bit unexpected to users who
have given input to Git saying they don't need those directories
anymore.

This is something that is new to the cone mode pattern type: the user
has explicitly said "I want these directories and _not_ those
directories." The typical sparse-checkout patterns more generally apply
to "I want files with with these patterns" so it is natural to leave
ignored files as they are. This focus on directories in cone mode
provides us an opportunity to change the behavior.

Leaving these ignored files in the sparse directories makes it
impossible to gain performance benefits in the sparse index. When we
track into these directories, we need to know if the files are ignored
or not, which might depend on the _tracked_ .gitignore file(s) within
the sparse directory. This depends on the indexed version of the file,
so the sparse directory must be expanded.

By deleting the sparse directories when changing scope (or running 'git
sparse-checkout reapply') we regain these performance benefits as if the
repository was in a clean state.

Since these ignored files are frequently build output or helper files
from IDEs, the users should not need the files now that the tracked
files are removed. If the tracked files reappear, then they will have
newer timestamps than the build artifacts, so the artifacts will need to
be regenerated anyway.

Use the sparse-index as a data structure in order to find the sparse
directories that can be safely deleted. Re-expand the index to a full
one if it was full before.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  8 +++
 builtin/sparse-checkout.c             | 95 +++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 59 +++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index fdcf43f87cb..f9022b9d555 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -210,6 +210,14 @@ case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
 directory.
 
+The cone mode sparse-checkout patterns will also remove ignored files that
+are not within the sparse-checkout definition. This is important behavior
+to preserve the performance of the sparse index, but also matches that
+cone mode patterns care about directories, not files. If there exist files
+that are untracked and not ignored, then Git will not delete files within
+that directory other than the tracked files that are now out of scope.
+These files should be removed manually to ensure Git can behave optimally.
+
 
 SUBMODULES
 ----------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8ba9f13787b..b06c8f885ac 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -100,6 +100,99 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
+static void clean_tracked_sparse_directories(struct repository *r)
+{
+	int i, was_full = 0;
+	struct strbuf path = STRBUF_INIT;
+	size_t pathlen;
+	struct string_list_item *item;
+	struct string_list sparse_dirs = STRING_LIST_INIT_DUP;
+
+	/*
+	 * If we are not using cone mode patterns, then we cannot
+	 * delete directories outside of the sparse cone.
+	 */
+	if (!r || !r->index || !r->worktree)
+		return;
+	init_sparse_checkout_patterns(r->index);
+	if (!r->index->sparse_checkout_patterns ||
+	    !r->index->sparse_checkout_patterns->use_cone_patterns)
+		return;
+
+	/*
+	 * Use the sparse index as a data structure to assist finding
+	 * directories that are safe to delete. This conversion to a
+	 * sparse index will not delete directories that contain
+	 * conflicted entries or submodules.
+	 */
+	if (!r->index->sparse_index) {
+		/*
+		 * If something, such as a merge conflict or other concern,
+		 * prevents us from converting to a sparse index, then do
+		 * not try deleting files.
+		 */
+		if (convert_to_sparse(r->index, SPARSE_INDEX_IGNORE_CONFIG))
+			return;
+		was_full = 1;
+	}
+
+	strbuf_addstr(&path, r->worktree);
+	strbuf_complete(&path, '/');
+	pathlen = path.len;
+
+	/*
+	 * Collect directories that have gone out of scope but also
+	 * exist on disk, so there is some work to be done. We need to
+	 * store the entries in a list before exploring, since that might
+	 * expand the sparse-index again.
+	 */
+	for (i = 0; i < r->index->cache_nr; i++) {
+		struct cache_entry *ce = r->index->cache[i];
+
+		if (S_ISSPARSEDIR(ce->ce_mode) &&
+		    repo_file_exists(r, ce->name))
+			string_list_append(&sparse_dirs, ce->name);
+	}
+
+	for_each_string_list_item(item, &sparse_dirs) {
+		struct dir_struct dir = DIR_INIT;
+		struct pathspec p = { 0 };
+		struct strvec s = STRVEC_INIT;
+
+		strbuf_setlen(&path, pathlen);
+		strbuf_addstr(&path, item->string);
+
+		dir.flags |= DIR_SHOW_IGNORED_TOO;
+
+		setup_standard_excludes(&dir);
+		strvec_push(&s, path.buf);
+
+		parse_pathspec(&p, PATHSPEC_GLOB, 0, NULL, s.v);
+		fill_directory(&dir, r->index, &p);
+
+		if (dir.nr) {
+			warning(_("directory '%s' contains untracked files,"
+				  " but is not in the sparse-checkout cone"),
+				item->string);
+		} else if (remove_dir_recursively(&path, 0)) {
+			/*
+			 * Removal is "best effort". If something blocks
+			 * the deletion, then continue with a warning.
+			 */
+			warning(_("failed to remove directory '%s'"),
+				item->string);
+		}
+
+		dir_clear(&dir);
+	}
+
+	string_list_clear(&sparse_dirs, 0);
+	strbuf_release(&path);
+
+	if (was_full)
+		ensure_full_index(r->index);
+}
+
 static int update_working_directory(struct pattern_list *pl)
 {
 	enum update_sparsity_result result;
@@ -141,6 +234,8 @@ static int update_working_directory(struct pattern_list *pl)
 	else
 		rollback_lock_file(&lock_file);
 
+	clean_tracked_sparse_directories(r);
+
 	r->index->sparse_checkout_patterns = NULL;
 	return result;
 }
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 38fc8340f5c..71236981e64 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -642,4 +642,63 @@ test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
 	check_files repo/deep a deeper1
 '
 
+test_expect_success 'cone mode clears ignored subdirectories' '
+	rm repo/.git/info/sparse-checkout &&
+
+	git -C repo sparse-checkout init --cone &&
+	git -C repo sparse-checkout set deep/deeper1 &&
+
+	cat >repo/.gitignore <<-\EOF &&
+	obj/
+	*.o
+	EOF
+
+	git -C repo add .gitignore &&
+	git -C repo commit -m ".gitignore" &&
+
+	mkdir -p repo/obj repo/folder1/obj repo/deep/deeper2/obj &&
+	for file in folder1/obj/a obj/a folder1/file.o folder1.o \
+		    deep/deeper2/obj/a deep/deeper2/file.o file.o
+	do
+		echo ignored >repo/$file || return 1
+	done &&
+
+	git -C repo status --porcelain=v2 >out &&
+	test_must_be_empty out &&
+
+	git -C repo sparse-checkout reapply &&
+	test_path_is_missing repo/folder1 &&
+	test_path_is_missing repo/deep/deeper2 &&
+	test_path_is_dir repo/obj &&
+	test_path_is_file repo/file.o &&
+
+	git -C repo status --porcelain=v2 >out &&
+	test_must_be_empty out &&
+
+	git -C repo sparse-checkout set deep/deeper2 &&
+	test_path_is_missing repo/deep/deeper1 &&
+	test_path_is_dir repo/deep/deeper2 &&
+	test_path_is_dir repo/obj &&
+	test_path_is_file repo/file.o &&
+
+	>repo/deep/deeper2/ignored.o &&
+	>repo/deep/deeper2/untracked &&
+
+	# When an untracked file is in the way, all untracked files
+	# (even ignored files) are preserved.
+	git -C repo sparse-checkout set folder1 2>err &&
+	grep "contains untracked files" err &&
+	test_path_is_file repo/deep/deeper2/ignored.o &&
+	test_path_is_file repo/deep/deeper2/untracked &&
+
+	# The rest of the cone matches expectation
+	test_path_is_missing repo/deep/deeper1 &&
+	test_path_is_dir repo/obj &&
+	test_path_is_file repo/file.o &&
+
+	git -C repo status --porcelain=v2 >out &&
+	echo "? deep/deeper2/untracked" >expect &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget
