Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80483C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3860F94
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhHJTuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHJTuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A0C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q10so4585505wro.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C/Wqr4D1BkHTZsllEtZgAV7yoegzqbDQRd/R1NodWLE=;
        b=ZJxct/y1HS6sxcFrYzKT4LAc2Emlc1l+DYdL4dfNYLF/bi8EXLym+neYiWddw+sPz8
         eQuxlm8rOcU6m2loiQmnXmepw9EfbvTUxokfww5LZcuk317Ou1xyhn1PyaJ+npFDelWF
         3cSQFFrtMUO+N2W8lY7Ugn6G5XC01TpfGjlYyE2QWuEP8bxAt6UhE+oHVKIZ7EIeuu6Z
         xoR9pjrN/VkIu/YSuIEX6n3nZ5nX3xPn9sbpmQJdvSUsRi8l3fMqWjf4UuNrREvm4+qa
         oMSSaXU8KvqnajSV6RM86qJ2299KNEnt5l2PKHbCNPVvBGsAuM6/+FcozDhil4CK8m11
         mITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C/Wqr4D1BkHTZsllEtZgAV7yoegzqbDQRd/R1NodWLE=;
        b=dRT5WIEYhbOx0Q2Nim2glfW27htvjwNFnA0muzgcEX2Is3p0+XPMvOaK8hn829/h8Y
         +Bdz0I/c+CPD8p0xR+YBei2MViWpfdmlwgdYra3edQXP9bybyUN8RDcosctHc9asBuOf
         odvZ67C2YFLNp7qDV0VC4JQzxRj3OZaalleY4I2XylqGECJW1NprwsmeOcSHK3hDOCS/
         V6N+fUryxdTRKeAqSLTVrDoP9WY06hCKZsVywKb8KbpJLLNOv+/ube5iTZv7d5QAKoIu
         qgT3JpC3XEwEeZyq4HnZ903oaP6qhPrpIbMkEpcTcnSg4VeYjg0FL1a+I7+ojqNN/8KZ
         cCaA==
X-Gm-Message-State: AOAM533A6X8IzgFUFeoZfRMqb41oSwjpCqIM/V5WbQuncf3TAqfQxE1r
        cy3GfVhm0/BFRnzK+2xGjSgQVW1z1EM=
X-Google-Smtp-Source: ABdhPJyrAvPJNDl75mrX3GfQ+gmRn/qh/J5lNE50peSy6sAUt6ydXdGxLYmTGTPwZ9A0Muer5B+RBw==
X-Received: by 2002:adf:80e8:: with SMTP id 95mr32986290wrl.388.1628625015247;
        Tue, 10 Aug 2021 12:50:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm8036354wms.24.2021.08.10.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:14 -0700 (PDT)
Message-Id: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:05 +0000
Subject: [PATCH v2 0/8] Sparse index: delete ignored files outside sparse cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE: I had to base this version on a merge of ds/add-with-sparse-index
and v2.33.0-rc1 because of some changes to dir.h that became important!

We launched an experimental release [1] of the sparse-index feature to our
internal users. We immediately discovered a problem due to the isolated way
in which we tested the sparse index: we were never building the project and
changing our sparse-checkout definition.

[1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp

Users who ran a build in one project and then moved to another still had
build artifacts in their worktree that lived inside the old directories.
Since the files are marked by the .gitignore patterns, these files were not
removed by the 'git sparse-checkout set' command. However, they make the
sparse-index unusable because every 'git status' command needs to expand the
sparse-directory entries in order to see if the files are tracked or not.
This made the first experimental release actually slower for all users
because of this cost.

The solution we shipped to these customers was to change the way our fork
handles these ignored files. Specifically, instead of Git completely
ignoring the files, we changed Git to understand that with cone-mode
sparse-checkout patterns, the users is asking for entire directories to be
removed from the worktree. The link [1] included earlier has this change.

I believe that this is a reasonable expectation, though I recognize that it
might look like breaking the expectations of how .gitignore files work.

Since feedback demonstrated that this is a desired behavior, v2 includes
this behavior for all "cone mode" repositories.

I'm interested in the community's thoughts about this change, as it seems
like one that we should make carefully and intentionally.

While the rewrite of the t7519 test seems unrelated, it is required to avoid
a test failure with this change that deletes files outside of the cone. By
moving the test into repositories not at $TRASH_DIRECTORY, we gain more
control over the repository structure.


Updates in V2
=============

 * This version correctly leaves untracked files alone. If untracked files
   are found, then the directory is left as-is, in case those ignored files
   are important to the user's work resolving those untracked files.

 * This behavior is now enabled by core.sparseCheckoutCone=true.

 * To use a sparse index as an in-memory data structure even when
   index.sparse is disabled, a new patch is included to modify the prototype
   of convert_to_sparse() to include a flags parameter.

 * A few cleanup patches that I was collecting based on feedback from the
   experimental release and intending for my next series were necessary for
   this implementation.

 * Cleaned up the tests (no NEEDSWORK) and the remainders of a previous
   implementation that used run_subcommand().

Thanks, -Stolee

Derrick Stolee (8):
  t7519: rewrite sparse index test
  sparse-index: silently return when not using cone-mode patterns
  sparse-index: silently return when cache tree fails
  unpack-trees: fix nested sparse-dir search
  sparse-checkout: create helper methods
  attr: be careful about sparse directories
  sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
  sparse-checkout: clear tracked sparse dirs

 Documentation/git-sparse-checkout.txt |  8 +++
 attr.c                                | 14 ++++
 builtin/add.c                         |  8 +--
 builtin/sparse-checkout.c             | 95 +++++++++++++++++++++++++++
 dir.c                                 | 29 ++++++++
 dir.h                                 |  6 ++
 read-cache.c                          |  4 +-
 sparse-index.c                        | 70 +++++++++++---------
 sparse-index.h                        |  3 +-
 t/t1091-sparse-checkout-builtin.sh    | 59 +++++++++++++++++
 t/t7519-status-fsmonitor.sh           | 38 ++++++-----
 unpack-trees.c                        | 18 +++--
 12 files changed, 290 insertions(+), 62 deletions(-)


base-commit: 80b8d6c56b8a5f5db1d5c2a0159fd808e8a7fc4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2Fderrickstolee%2Fsparse-index%2Fignored-files-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derrickstolee/sparse-index/ignored-files-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1009

Range-diff vs v1:

 1:  29f1633f6d5 = 1:  e66106f7a99 t7519: rewrite sparse index test
 -:  ----------- > 2:  fb3ff9108bf sparse-index: silently return when not using cone-mode patterns
 -:  ----------- > 3:  37198535268 sparse-index: silently return when cache tree fails
 -:  ----------- > 4:  10bcadb284e unpack-trees: fix nested sparse-dir search
 -:  ----------- > 5:  e9ed5cd2830 sparse-checkout: create helper methods
 -:  ----------- > 6:  5680df62e1c attr: be careful about sparse directories
 -:  ----------- > 7:  1dd73b36eb4 sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
 2:  9212bbf4e3c ! 8:  f74015a2be9 sparse-checkout: clear tracked sparse dirs
     @@ Commit message
          newer timestamps than the build artifacts, so the artifacts will need to
          be regenerated anyway.
      
     -    If users depend on ignored files within the sparse directories, then
     -    they have created a bad shape in their repository. Regardless, such
     -    shapes would create risk that changing the behavior for all cone mode
     -    users might be too risky to take on at the moment. Since this data shape
     -    makes it impossible to get performance benefits using the sparse index,
     -    we limit the change to only be enabled when the sparse index is enabled.
     -    Users can opt out of this behavior by disabline the sparse index.
     -
     -    Depending on user feedback or real-world use, we might want to consider
     -    expanding the behavior change to all of cone mode. Since we are
     -    currently restricting to the sparse index case, we can use the existence
     -    of sparse directory entries in the index as indicators of which
     -    directories should be removed.
     +    Use the sparse-index as a data structure in order to find the sparse
     +    directories that can be safely deleted. Re-expand the index to a full
     +    one if it was full before.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ Documentation/git-sparse-checkout.txt: case-insensitive check. This corrects for
       'git sparse-checkout set' command to reflect the expected cone in the working
       directory.
       
     -+When the sparse index is enabled through the `index.sparse` config option,
     -+the cone mode sparse-checkout patterns will also remove ignored files that
     ++The cone mode sparse-checkout patterns will also remove ignored files that
      +are not within the sparse-checkout definition. This is important behavior
      +to preserve the performance of the sparse index, but also matches that
     -+cone mode patterns care about directories, not files.
     ++cone mode patterns care about directories, not files. If there exist files
     ++that are untracked and not ignored, then Git will not delete files within
     ++that directory other than the tracked files that are now out of scope.
     ++These files should be removed manually to ensure Git can behave optimally.
      +
       
       SUBMODULES
       ----------
      
       ## builtin/sparse-checkout.c ##
     -@@
     - #include "wt-status.h"
     - #include "quote.h"
     - #include "sparse-index.h"
     -+#include "run-command.h"
     - 
     - static const char *empty_base = "";
     - 
      @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char **argv)
       	return 0;
       }
       
      +static void clean_tracked_sparse_directories(struct repository *r)
      +{
     -+	int i;
     ++	int i, was_full = 0;
      +	struct strbuf path = STRBUF_INIT;
      +	size_t pathlen;
     ++	struct string_list_item *item;
     ++	struct string_list sparse_dirs = STRING_LIST_INIT_DUP;
      +
      +	/*
      +	 * If we are not using cone mode patterns, then we cannot
      +	 * delete directories outside of the sparse cone.
      +	 */
     -+	if (!r || !r->index || !r->index->sparse_checkout_patterns ||
     -+	    !r->index->sparse_checkout_patterns->use_cone_patterns)
     ++	if (!r || !r->index || !r->worktree)
      +		return;
     -+	/*
     -+	 * NEEDSWORK: For now, only use this behavior when index.sparse
     -+	 * is enabled. We may want this behavior enabled whenever using
     -+	 * cone mode patterns.
     -+	 */
     -+	prepare_repo_settings(r);
     -+	if (!r->worktree || !r->settings.sparse_index)
     ++	init_sparse_checkout_patterns(r->index);
     ++	if (!r->index->sparse_checkout_patterns ||
     ++	    !r->index->sparse_checkout_patterns->use_cone_patterns)
      +		return;
      +
      +	/*
     -+	 * Since we now depend on the sparse index to enable this
     -+	 * behavior, use it to our advantage. This process is more
     -+	 * complicated without it.
     ++	 * Use the sparse index as a data structure to assist finding
     ++	 * directories that are safe to delete. This conversion to a
     ++	 * sparse index will not delete directories that contain
     ++	 * conflicted entries or submodules.
      +	 */
     -+	convert_to_sparse(r->index);
     ++	if (!r->index->sparse_index) {
     ++		/*
     ++		 * If something, such as a merge conflict or other concern,
     ++		 * prevents us from converting to a sparse index, then do
     ++		 * not try deleting files.
     ++		 */
     ++		if (convert_to_sparse(r->index, SPARSE_INDEX_IGNORE_CONFIG))
     ++			return;
     ++		was_full = 1;
     ++	}
      +
      +	strbuf_addstr(&path, r->worktree);
      +	strbuf_complete(&path, '/');
      +	pathlen = path.len;
      +
     ++	/*
     ++	 * Collect directories that have gone out of scope but also
     ++	 * exist on disk, so there is some work to be done. We need to
     ++	 * store the entries in a list before exploring, since that might
     ++	 * expand the sparse-index again.
     ++	 */
      +	for (i = 0; i < r->index->cache_nr; i++) {
      +		struct cache_entry *ce = r->index->cache[i];
      +
     -+		/*
     -+		 * Is this a sparse directory? If so, then definitely
     -+		 * include it. All contained content is outside of the
     -+		 * patterns.
     -+		 */
      +		if (S_ISSPARSEDIR(ce->ce_mode) &&
     -+		    repo_file_exists(r, ce->name)) {
     -+			strbuf_setlen(&path, pathlen);
     -+			strbuf_addstr(&path, ce->name);
     ++		    repo_file_exists(r, ce->name))
     ++			string_list_append(&sparse_dirs, ce->name);
     ++	}
     ++
     ++	for_each_string_list_item(item, &sparse_dirs) {
     ++		struct dir_struct dir = DIR_INIT;
     ++		struct pathspec p = { 0 };
     ++		struct strvec s = STRVEC_INIT;
     ++
     ++		strbuf_setlen(&path, pathlen);
     ++		strbuf_addstr(&path, item->string);
     ++
     ++		dir.flags |= DIR_SHOW_IGNORED_TOO;
     ++
     ++		setup_standard_excludes(&dir);
     ++		strvec_push(&s, path.buf);
      +
     ++		parse_pathspec(&p, PATHSPEC_GLOB, 0, NULL, s.v);
     ++		fill_directory(&dir, r->index, &p);
     ++
     ++		if (dir.nr) {
     ++			warning(_("directory '%s' contains untracked files,"
     ++				  " but is not in the sparse-checkout cone"),
     ++				item->string);
     ++		} else if (remove_dir_recursively(&path, 0)) {
      +			/*
      +			 * Removal is "best effort". If something blocks
      +			 * the deletion, then continue with a warning.
      +			 */
     -+			if (remove_dir_recursively(&path, 0))
     -+				warning(_("failed to remove directory '%s'"), path.buf);
     ++			warning(_("failed to remove directory '%s'"),
     ++				item->string);
      +		}
     ++
     ++		dir_clear(&dir);
      +	}
      +
     ++	string_list_clear(&sparse_dirs, 0);
      +	strbuf_release(&path);
      +
     -+	/*
     -+	 * This is temporary: the sparse-checkout builtin is not
     -+	 * integrated with the sparse-index yet, so we need to keep
     -+	 * it full during the process.
     -+	 */
     -+	ensure_full_index(r->index);
     ++	if (was_full)
     ++		ensure_full_index(r->index);
      +}
      +
       static int update_working_directory(struct pattern_list *pl)
     @@ builtin/sparse-checkout.c: static int update_working_directory(struct pattern_li
       	r->index->sparse_checkout_patterns = NULL;
       	return result;
       }
     -@@ builtin/sparse-checkout.c: static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
     - {
     - 	int result;
     - 	int changed_config = 0;
     -+	struct pattern_list *old_pl = xcalloc(1, sizeof(*old_pl));
     - 	struct pattern_list *pl = xcalloc(1, sizeof(*pl));
     - 
     -+	get_sparse_checkout_patterns(old_pl);
     -+
     - 	switch (m) {
     - 	case ADD:
     - 		if (core_sparse_checkout_cone)
     -@@ builtin/sparse-checkout.c: static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
     - 		set_config(MODE_NO_PATTERNS);
     - 
     - 	clear_pattern_list(pl);
     -+	clear_pattern_list(old_pl);
     - 	free(pl);
     -+	free(old_pl);
     - 	return result;
     - }
     - 
      
       ## t/t1091-sparse-checkout-builtin.sh ##
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success MINGW 'cone mode replace
      +test_expect_success 'cone mode clears ignored subdirectories' '
      +	rm repo/.git/info/sparse-checkout &&
      +
     -+	# NEEDSWORK: --sparse-index is required for now
     -+	git -C repo sparse-checkout init --cone --sparse-index &&
     ++	git -C repo sparse-checkout init --cone &&
      +	git -C repo sparse-checkout set deep/deeper1 &&
      +
      +	cat >repo/.gitignore <<-\EOF &&
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success MINGW 'cone mode replace
      +	git -C repo sparse-checkout set deep/deeper2 &&
      +	test_path_is_missing repo/deep/deeper1 &&
      +	test_path_is_dir repo/deep/deeper2 &&
     ++	test_path_is_dir repo/obj &&
     ++	test_path_is_file repo/file.o &&
     ++
     ++	>repo/deep/deeper2/ignored.o &&
     ++	>repo/deep/deeper2/untracked &&
     ++
     ++	# When an untracked file is in the way, all untracked files
     ++	# (even ignored files) are preserved.
     ++	git -C repo sparse-checkout set folder1 2>err &&
     ++	grep "contains untracked files" err &&
     ++	test_path_is_file repo/deep/deeper2/ignored.o &&
     ++	test_path_is_file repo/deep/deeper2/untracked &&
     ++
     ++	# The rest of the cone matches expectation
     ++	test_path_is_missing repo/deep/deeper1 &&
     ++	test_path_is_dir repo/obj &&
     ++	test_path_is_file repo/file.o &&
      +
      +	git -C repo status --porcelain=v2 >out &&
     -+	test_must_be_empty out
     ++	echo "? deep/deeper2/untracked" >expect &&
     ++	test_cmp expect out
      +'
      +
       test_done

-- 
gitgitgadget
