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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C2C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F566127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhHXVws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhHXVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FFC0613A4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e5so16776011wrp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6BhipxpdLHCjlk4DMmYt4bLPZa+qCBdpfxVEfdEvEY0=;
        b=reoyDRmJ+9yAM3OUOBU5YwAc1OY5goeArhBv93ipTXr6mrwhb/J56vcRPTZpe3vUKg
         hyuU4+Sie6/VTwnYc3WdN6wxSeseSbh1mbtPib0hQVj2B/V5iBBbvR8Qpfd1HtXN3gw1
         aiRKAR6aPLQsMHUKdkSMIey4OLCVjg80d7J0hjf/C+6ejNfnNEHg18fJnOgAyK38FYnE
         nPklPlIvPv5Z4K7XYu2tgveU5ol/COtEMbR5+Cjq3vJA7zgSiEABWyJdZCEdwUXO3HSJ
         NPKPBFLap3LGZh8pNHaJBFY7FtW3GGaCRRIr2oGj1bgEYc84UU5y7by3JVEklQj/K7yR
         1O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6BhipxpdLHCjlk4DMmYt4bLPZa+qCBdpfxVEfdEvEY0=;
        b=s7W1cbUR7riQb2UV+bTaKeFzlI3uEjIgBJitIRiRRFpsnf+Wg3D/HbBo2dghAaGmcq
         mYeMEb5ua3gqjdD97NJK0cYrozvEdCgph5UVJ/WMDhjTv5tp+ZSmyDGWeXzrRxRnTR/X
         hlhEGSvTI0A1BTQPCTrzLSYsWTJc2x0Mvtm3zZIlW1Fb3rpPbqkMAVeB+Q7KKSPF4bvE
         goy5KFIc2EHubgEWtQ6PQ4gHiOUCI9Qf4bD7oRLJHRmsW1m0P6Xozr0IHUeVFjzQTXfi
         yVDthwYPcw+QzS96D++D/2zt2ctv2Swxbycqc7FAPL728Kvd+F7XrABdPowkhddmhTdZ
         PH1g==
X-Gm-Message-State: AOAM533VAFty7jnz90/gnmWJ+bQlmA6vbdS/mDPfrTE1jx5r03Wxv0fd
        voP6VS7mVjUcnu8shDvs4Mb/v0emeQw=
X-Google-Smtp-Source: ABdhPJxejw9VHhCZS9C+7W56NIl3oppHtSpGjtD9lZ0SUkCmzItq3w5lPSfdVzpGjrHD9F9gDHvQWA==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr21492230wrb.35.1629841912282;
        Tue, 24 Aug 2021 14:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21sm3655648wms.32.2021.08.24.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:51 -0700 (PDT)
Message-Id: <c19d93ec5d7f2ff1eeba40d75aad872250073586.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:43 +0000
Subject: [PATCH v4 09/10] sparse-checkout: clear tracked sparse dirs
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

We must take special care to look for untracked, non-ignored files in
these directories before deleting them. We do not want to delete any
meaningful work that the users were doing in those directories and
perhaps forgot to add and commit before switching sparse-checkout
definitions. Since those untracked files might be code files that
generated ignored build output, also do not delete any ignored files
from these directories in that case. The users can recover their state
by resetting their sparse-checkout definition to include that directory
and continue. Alternatively, they can see the warning that is presented
and delete the directory themselves to regain the performance they
expect.

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
 Documentation/git-sparse-checkout.txt | 10 +++
 builtin/sparse-checkout.c             | 94 +++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 59 +++++++++++++++++
 3 files changed, 163 insertions(+)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index fdcf43f87cb..42056ee9ff9 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -210,6 +210,16 @@ case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
 directory.
 
+When changing the sparse-checkout patterns in cone mode, Git will inspect each
+tracked directory that is not within the sparse-checkout cone to see if it
+contains any untracked files. If all of those files are ignored due to the
+`.gitignore` patterns, then the directory will be deleted. If any of the
+untracked files within that directory is not ignored, then no deletions will
+occur within that directory and a warning message will appear. If these files
+are important, then reset your sparse-checkout definition so they are included,
+use `git add` and `git commit` to store them, then remove any remaining files
+manually to ensure Git can behave optimally.
+
 
 SUBMODULES
 ----------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8ba9f13787b..d0f5c4702be 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -100,6 +100,98 @@ static int sparse_checkout_list(int argc, const char **argv)
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
+	if (init_sparse_checkout_patterns(r->index) ||
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
+		if (convert_to_sparse(r->index, SPARSE_INDEX_MEMORY_ONLY))
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
@@ -141,6 +233,8 @@ static int update_working_directory(struct pattern_list *pl)
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

