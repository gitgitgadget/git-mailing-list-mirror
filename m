Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7AEC6FA8E
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 04:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiIWEQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 00:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIWEQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 00:16:03 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038411C172
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 21:16:02 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v130so15007270oie.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XlMkJ0cFT1ShUk2AJjAUknb8zpn0PgRmnjX04Zs92N8=;
        b=XFhvjfhrDft7bzYxQ5XWnmHwzZdl60nZaJ3b6WdsPeu8Nbu9Zr6mg8blELu7siUnmx
         euziYx8S96uM0dj0Mt+3pxEFlQ55TzCZDdVxUqwq0vGp+/xgDDRKscrPcKCFzB5Vs5NZ
         lOJVsp1sUrOMDVuEqc8tH/sXOkC0lKi5+RNGsc+KTN1COfZhj0R/mLC5J0f0xP/UPRT3
         eMM+o5cjFvDiUs/K2/lvbGGviZOOe4pIUm4qrm9WHsm6KqpL0nK5K8eCSsaMUXPfnH6Y
         kD1Y14P1LGSTbO6sAJrrtPKO89YM7DKkz1iETkc1OJJSnVQWjo+3F7s6cacZ4eyOK5Vo
         +MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XlMkJ0cFT1ShUk2AJjAUknb8zpn0PgRmnjX04Zs92N8=;
        b=p18Im+KuEXzThqVm+IgHEefPycPUMrwnc3ytiy3lGhu/g778JUwjYtTvDixlAkGluc
         gllt0exlqmJu7YgR2ZFKlBV5qGkOqOxOPtVQ2YPellvwHxJ+FxbeW7ZJkN3I/7fPZpKE
         BEFIpp3TCGVjhTMlNKuI0DH48txhbADc1k3+Olmy5av/JGgtg4Q0ulivGNBmfUrN0mID
         jvUOWNjdYtrDp2iEGEiYbxZHcJzbsSkL4B+HFY3mKo6/UcMoGhHJRnhRPAGM7K7DIN+9
         mdN2yzMTYqW3RoBD/URmIN9mpheX03mP0YFjNp+5blPR1xB255932RMH6SbthKEq2RyE
         Z9WQ==
X-Gm-Message-State: ACrzQf1HAL5WZvu8/5eteXJHNQctnSQnKZZ0nLBwOhlH5TIljopJerRA
        L+uluGhad9PM2S44h1CAW4GtbA0YWc8=
X-Google-Smtp-Source: AMsMyM5pckFIB0ccjFPzkLgo1X8+8CShjAYkQIruLIfeN64K5K1OoV2SlgDCbMQcFqPdJh4/xdFvKQ==
X-Received: by 2002:a05:6808:1b06:b0:350:20b7:2b74 with SMTP id bx6-20020a0568081b0600b0035020b72b74mr8210710oib.203.1663906561119;
        Thu, 22 Sep 2022 21:16:01 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id j1-20020a9d7381000000b00655dda40f54sm3533514otk.78.2022.09.22.21.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 21:16:00 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com, avarab@gmail.com
Cc:     derrickstolee@github.com, gitster@pobox.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v6 0/1] grep: integrate with sparse index
Date:   Thu, 22 Sep 2022 21:15:50 -0700
Message-Id: <20220923041551.27790-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate `git-grep` with sparse-index and test the performance
improvement.

Changes since v5
----------------

* Drop the `--sparse` option patch and edit corresponding tests. 
  We can wait until a better name is decided to replace `--sparse`.

* Modify the commit message, especially get rid of the `--sparse`
  occurences.

Changes since v4
----------------
* Reset the length of `struct strbuf name` back to `name_base_len`,
  instead of 0, after `grep_tree()` returns.

* Add test cases in t1092 for `grep` recursing into submodules.

* Add a few NEEDSWORK to explain the current problem with submodules.

Changes since v3
----------------
* Shorten the perf result tables in commit message.

* Update the commit message to reflect the changes in the commit.

* Update the commit message to indicate the performance improvement
  is dependent on the pathspec.

* Stop passing `ce_mode` through `check_attr`. Instead, set the
  `base_len` to 0 to make the code more reasonable and less abuse of
  `check_attr`.

* Remove another invention of `base`. Use the existing `name` as the
  argument for `grep_tree()`, and reset it back to `ce->name` after
  `grep_tree()` returns.

* Update the p2000 test to use a more general pathspec for better
  compatibility (i.e. do not use git repository specific pathspec).

* Add tests to t1092 'grep is not expanded' to verify the change
  brought by "builtin/grep.c: walking tree instead of expanding index
  with --sparse": the index *never* expands.

Changes since v2
----------------

* Modify the commit message for "builtin/grep.c: integrate with sparse
  index" to make it obvious that the perf test results are not from
  p2000 tests, but from manual perf runs.

* Add tree-walking logic as an extra (the third) patch to improve the
  performance when --sparse is used. This resolved the left-over-bit
  in v2 [1].

[1] https://lore.kernel.org/git/20220829232843.183711-1-shaoxuan.yuan02@gmail.com/

Changes since v1
----------------

* Rewrite the commit message for "builtin/grep.c: add --sparse option"
  to be clearer.

* Update the documentation (both in-code and man page) for --sparse.

* Add a few tests to test the new behavior (when _only_ --cached is
  supplied).

* Reformat the perf test results to not look like directly from p2000
  tests.

* Put the "command_requires_full_index" lines right after parse_options().

* Add a pathspec test in t1092, and reword a few test documentations.

Shaoxuan Yuan (1):
  builtin/grep.c: integrate with sparse index

 builtin/grep.c                           | 48 +++++++++++++++-
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 72 ++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 3 deletions(-)

Range-diff against v5:
1:  1d00d23bf9 < -:  ---------- builtin/grep.c: add --sparse option
2:  926b8d2462 < -:  ---------- builtin/grep.c: integrate with sparse index
3:  18b65034fe ! 1:  8604111d74 builtin/grep.c: walking tree instead of expanding index with --sparse
    @@ Metadata
     Author: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## Commit message ##
    -    builtin/grep.c: walking tree instead of expanding index with --sparse
    +    builtin/grep.c: integrate with sparse index
     
    -    Before this patch, whenever --sparse is used, `git-grep` utilizes the
    -    ensure_full_index() method to expand the index and search all the
    -    entries. Because this method requires walking all the trees and
    -    constructing the index, it is the slow part within the whole command.
    +    Turn on sparse index and remove ensure_full_index().
    +
    +    Before this patch, `git-grep` utilizes the ensure_full_index() method to
    +    expand the index and search all the entries. Because this method
    +    requires walking all the trees and constructing the index, it is the
    +    slow part within the whole command.
     
         To achieve better performance, this patch uses grep_tree() to search the
         sparse directory entries and get rid of the ensure_full_index() method.
    @@ Commit message
            result of expanding the index.
     
         2) grep_tree() utilizes pathspecs to limit the scope of searching.
    -       ensure_full_index() always expands the index when --sparse is used,
    -       that means it will always walk all the trees and blobs in the repo
    -       without caring if the user only wants a subset of the content, i.e.
    -       using a pathspec. On the other hand, grep_tree() will only search
    -       the contents that match the pathspec, and thus possibly walking fewer
    -       trees.
    +       ensure_full_index() always expands the index, which means it will
    +       always walk all the trees and blobs in the repo without caring if
    +       the user only wants a subset of the content, i.e. using a pathspec.
    +       On the other hand, grep_tree() will only search the contents that
    +       match the pathspec, and thus possibly walking fewer trees.
     
         3) grep_tree() does not construct and copy back a new index, while
            ensure_full_index() does. This also saves some time.
    @@ Commit message
         - Summary:
     
         p2000 tests demonstrate a ~71% execution time reduction for
    -    `git grep --cached --sparse bogus -- "f2/f1/f1/*"` using tree-walking
    -    logic. However, notice that this result varies depending on the pathspec
    +    `git grep --cached bogus -- "f2/f1/f1/*"` using tree-walking logic.
    +    However, notice that this result varies depending on the pathspec
         given. See below "Command used for testing" for more details.
     
         Test                              HEAD~   HEAD
    @@ Commit message
     
         - Command used for testing:
     
    -            git grep --cached --sparse bogus -- "f2/f1/f1/*"
    +            git grep --cached bogus -- "f2/f1/f1/*"
     
         The reason for specifying a pathspec is that, if we don't specify a
         pathspec, then grep_tree() will walk all the trees and blobs to find the
    @@ Commit message
     
                 Command used:
     
    -                    git grep --cached --sparse bogus
    +                    git grep --cached bogus
     
                 Test                                HEAD~  HEAD
                 ---------------------------------------------------
    @@ Commit message
         Suggested-by: Derrick Stolee <derrickstolee@github.com>
         Helped-by: Derrick Stolee <derrickstolee@github.com>
         Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/grep.c ##
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      	if (repo_read_index(repo) < 0)
      		die(_("index file corrupt"));
      
    --	if (grep_sparse)
    --		ensure_full_index(repo->index);
    --
    +-	/* TODO: audit for interaction with sparse-index. */
    +-	ensure_full_index(repo->index);
      	for (nr = 0; nr < repo->index->cache_nr; nr++) {
      		const struct cache_entry *ce = repo->index->cache[nr];
      
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
     +			struct tree_desc tree;
     +			void *data;
     +			unsigned long size;
    -+
    -+			data = read_object_file(&ce->oid, &type, &size);
    -+			init_tree_desc(&tree, data, size);
      
     -		if (S_ISREG(ce->ce_mode) &&
    ++			data = read_object_file(&ce->oid, &type, &size);
    ++			init_tree_desc(&tree, data, size);
    ++
     +			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
     +			strbuf_setlen(&name, name_base_len);
     +			strbuf_addstr(&name, ce->name);
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
      				   S_ISDIR(ce->ce_mode) ||
      				   S_ISGITLINK(ce->ce_mode))) {
    +@@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
    + 			     PARSE_OPT_KEEP_DASHDASH |
    + 			     PARSE_OPT_STOP_AT_NON_OPTION);
    + 
    ++	if (the_repository->gitdir) {
    ++		prepare_repo_settings(the_repository);
    ++		the_repository->settings.command_requires_full_index = 0;
    ++	}
    ++
    + 	if (use_index && !startup_info->have_repository) {
    + 		int fallback = 0;
    + 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
     
      ## t/perf/p2000-sparse-operations.sh ##
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git read-tree -mu HEAD
    @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
      run_on_sparse () {
      	(
      		cd sparse-checkout &&
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep is not expanded' '
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: rm' '
    + 	ensure_not_expanded rm -r deep
    + '
      
    - 	# All files within the folder1/* pathspec are sparse,
    - 	# so this command does not find any matches
    --	ensure_not_expanded ! grep a -- folder1/*
    ++test_expect_success 'grep with and --cached' '
    ++	init_repos &&
    ++
    ++	test_all_match git grep --cached a &&
    ++	test_all_match git grep --cached a -- "folder1/*"
    ++'
    ++
    ++test_expect_success 'grep is not expanded' '
    ++	init_repos &&
    ++
    ++	ensure_not_expanded grep a &&
    ++	ensure_not_expanded grep a -- deep/* &&
    ++
    ++	# All files within the folder1/* pathspec are sparse,
    ++	# so this command does not find any matches
     +	ensure_not_expanded ! grep a -- folder1/* &&
     +
     +	# test out-of-cone pathspec with or without wildcard
    -+	ensure_not_expanded grep --sparse --cached a -- "folder1/a" &&
    -+	ensure_not_expanded grep --sparse --cached a -- "folder1/*" &&
    ++	ensure_not_expanded grep --cached a -- "folder1/a" &&
    ++	ensure_not_expanded grep --cached a -- "folder1/*" &&
     +
     +	# test in-cone pathspec with or without wildcard
    -+	ensure_not_expanded grep --sparse --cached a -- "deep/a" &&
    -+	ensure_not_expanded grep --sparse --cached a -- "deep/*"
    ++	ensure_not_expanded grep --cached a -- "deep/a" &&
    ++	ensure_not_expanded grep --cached a -- "deep/*"
     +'
     +
     +# NEEDSWORK: when running `grep` in the superproject with --recurse-submodules,
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep is not expan
     +	# do not use ensure_not_expanded() here, becasue `grep` should be
     +	# run in the superproject, not in "./sparse-index"
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    -+	git grep --sparse --cached --recurse-submodules a -- "*/folder1/*" &&
    ++	git grep --cached --recurse-submodules a -- "*/folder1/*" &&
     +	test_region ! index ensure_full_index trace2.txt
     +'
     +
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep is not expan
     +	sparse-checkout/folder1/a:a
     +	sparse-index/folder1/a:a
     +	EOF
    -+	git grep --sparse --cached --recurse-submodules a -- "*/folder1/*" >actual &&
    ++	git grep --cached --recurse-submodules a -- "*/folder1/*" >actual &&
     +	test_cmp actual expect
    - '
    - 
    ++'
    ++
      test_done

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
2.37.0

