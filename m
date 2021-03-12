Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8232EC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4929564F69
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhCLWsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbhCLWsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:48:11 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E53C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:11 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l4so26078464qkl.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cweDk0NkiP/OE+wGRCh9XB3xJDNUhQXPeal38SFrV7k=;
        b=j2W7D83eFFiu4FZ+bU5vo/MRCJwwd1gDzKxDU40Hk4A19gknxDr/tmXbkXN2jOstWQ
         sWruUurUYGlIBfvjNywUpkP5VsJAglTgv7jIiezuXzM9ul5w8cJaLKZoFT/JYPyVAPaU
         88uxiTD6G3yhU287EjfLiKuBodpqiTFP8T8Ak2d5tIj432p5CBpEJe3hIROZ6LymFuyY
         xtBHsTLDcdyEsmq8NViC3olot+AblGF8m3G5jNxT0LJMlKpFdEqy9JMK4ziZ4+sD737o
         84PPqay/24rCbLbDR42UODKNNA7UIFGiUAOZW2Yg3sSFPBLjgDpBtcdiGDTHHNBqDh9S
         AOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cweDk0NkiP/OE+wGRCh9XB3xJDNUhQXPeal38SFrV7k=;
        b=HcVqNYLfS8uLQcBxaspNDvg4+lDUsv8TbxwwJn4oml6MUP/YVJNEmjABJ5ynMMRCn3
         gSGEOQn9IArUe7PTF3CjxWqQEYQjEZCJEyVdG53R/jBKRfz/ga0g0sAtCjZGzFOEYFcv
         JZLRDu5/mc2evtV/pz3kpqAMSpSAlT50uR2daKVtaUJSQ9t7DXKdpm9IiUAHQfVxLzOR
         kpcpL+Ij3ZZnT5MU+dLlTqiFZNNSUmhmqqD1jTnXAlIbmac254oq+BYuaMRrXrwPX6TX
         Cnv1Em+RMbkLj/o3X0j0GGnRatUfmjoaZ3awnW7j6GpxZj7FeUgF6PFQU5Zto1KW6Sj6
         348A==
X-Gm-Message-State: AOAM53230JY9dA9b9K5jA7VRxOFGO1g7JyyXAz/t/gOsuFk7co7OHCLk
        kFIxRohs9SQ5ScuqZ3LFgXjzWraiD79hdA==
X-Google-Smtp-Source: ABdhPJyMJg6/7WTsRfQJk4dZEccwCl+3NLuDpvAjjTdSCp/AdZjEA7YcV9oBJK6W8mOsJoROeYArkw==
X-Received: by 2002:a37:94b:: with SMTP id 72mr13848769qkj.94.1615589289605;
        Fri, 12 Mar 2021 14:48:09 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j1sm4870400qti.55.2021.03.12.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:48:08 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH v3 0/7] add/rm: honor sparse checkout and warn on sparse paths
Date:   Fri, 12 Mar 2021 19:47:55 -0300
Message-Id: <cover.1615588108.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
when they are asked to update sparse entries.

Main changes since v2:

Patch 2:
- Removed unnecessary `rm` in t3705's auxiliary function and added
  comment about	why `update-index --force-remove` is used there.

Patch 4:
- Replaced the boolean function parameter with a more descriptive enum.
  This way, readers don't have to go to the function definition to
  understand what the caller wants.

Patches 5 and 6:
- Reworded both commit messages and the advice.updateSparsePath docs to
  avoid saying "pathspecs that *only* match sparse entries", as the
  situations to which they refer might also include matches among
  ignored paths.
- Rephrased the warning message about sparse paths so that it doesn't
  contradict the message on ignored paths when they are displayed
  together.

Patch 7:
- Adjusted the tests to check for the new sparse warning message.

Matheus Tavares (7):
  add: include magic part of pathspec on --refresh error
  t3705: add tests for `git add` in sparse checkouts
  add: make --chmod and --renormalize honor sparse checkouts
  pathspec: allow to ignore SKIP_WORKTREE entries on index matching
  refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
  add: warn when asked to update SKIP_WORKTREE entries
  rm: honor sparse checkout patterns

 Documentation/config/advice.txt  |   4 +
 Documentation/git-rm.txt         |   4 +-
 advice.c                         |  20 ++++
 advice.h                         |   4 +
 builtin/add.c                    |  77 ++++++++++++---
 builtin/check-ignore.c           |   3 +-
 builtin/rm.c                     |  35 ++++---
 cache.h                          |  15 +--
 pathspec.c                       |  25 ++++-
 pathspec.h                       |  18 +++-
 read-cache.c                     |   5 +-
 t/t3602-rm-sparse-checkout.sh    |  78 ++++++++++++++++
 t/t3700-add.sh                   |   6 ++
 t/t3705-add-sparse-checkout.sh   | 155 +++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |   5 -
 t/t7012-skip-worktree-writing.sh |  19 ----
 16 files changed, 409 insertions(+), 64 deletions(-)
 create mode 100755 t/t3602-rm-sparse-checkout.sh
 create mode 100755 t/t3705-add-sparse-checkout.sh

Range-diff against v2:
1:  46147a8637 = 1:  05b66a8c2b add: include magic part of pathspec on --refresh error
2:  2de55420fa ! 2:  d93c3f5146 t3705: add tests for `git add` in sparse checkouts
    @@ t/t3705-add-sparse-checkout.sh (new)
     +
     +# Optionally take a printf format string to write to the sparse_entry file
     +setup_sparse_entry () {
    -+	rm -f sparse_entry &&
    ++	# 'sparse_entry' might already be in the index with the skip-worktree
    ++	# bit set. Remove it so that the subsequent git add can update it.
     +	git update-index --force-remove sparse_entry &&
    -+
     +	if test $# -eq 1
     +	then
     +		printf "$1" >sparse_entry
3:  604480ade9 = 3:  c90d5e3c23 add: make --chmod and --renormalize honor sparse checkouts
4:  1494e65316 ! 4:  69d51579b3 pathspec: allow to ignore SKIP_WORKTREE entries on index matching
    @@ Metadata
      ## Commit message ##
         pathspec: allow to ignore SKIP_WORKTREE entries on index matching
     
    -    Add the 'ignore_skip_worktree' boolean parameter to both
    -    add_pathspec_matches_against_index() and
    -    find_pathspecs_matching_against_index(). When true, these functions will
    -    not try to match the given pathspec with SKIP_WORKTREE entries. This
    -    will be used in a future patch to make `git add` display a hint
    -    when the pathspec matches only sparse paths.
    +    Add a new enum parameter to `add_pathspec_matches_against_index()` and
    +    `find_pathspecs_matching_against_index()`, allowing callers to specify
    +    whether these function should attempt to match SKIP_WORKTREE entries or
    +    not. This will be used in a future patch to make `git add` display a
    +    hint when it is asked to update SKIP_WORKTREE entries.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ builtin/add.c: static char *prune_directory(struct dir_struct *dir, struct paths
      	}
      	dir->nr = dst - dir->entries;
     -	add_pathspec_matches_against_index(pathspec, &the_index, seen);
    -+	add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);
    ++	add_pathspec_matches_against_index(pathspec, &the_index, seen,
    ++					   PS_HEED_SKIP_WORKTREE);
      	return seen;
      }
      
    @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
      
      		if (!seen)
     -			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
    -+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
    ++			seen = find_pathspecs_matching_against_index(&pathspec,
    ++					&the_index, PS_HEED_SKIP_WORKTREE);
      
      		/*
      		 * file_exists() assumes exact match
    @@ builtin/check-ignore.c: static int check_ignore(struct dir_struct *dir,
      	 * 'git status', 'git add' etc.
      	 */
     -	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
    -+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
    ++	seen = find_pathspecs_matching_against_index(&pathspec, &the_index,
    ++						     PS_HEED_SKIP_WORKTREE);
      	for (i = 0; i < pathspec.nr; i++) {
      		full_path = pathspec.items[i].match;
      		pattern = NULL;
    @@ pathspec.c
      void add_pathspec_matches_against_index(const struct pathspec *pathspec,
      					const struct index_state *istate,
     -					char *seen)
    -+					char *seen, int ignore_skip_worktree)
    ++					char *seen,
    ++					enum ps_skip_worktree_action sw_action)
      {
      	int num_unmatched = 0, i;
      
    @@ pathspec.c: void add_pathspec_matches_against_index(const struct pathspec *paths
      		return;
      	for (i = 0; i < istate->cache_nr; i++) {
      		const struct cache_entry *ce = istate->cache[i];
    -+		if (ignore_skip_worktree && ce_skip_worktree(ce))
    ++		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
     +			continue;
      		ce_path_match(istate, ce, pathspec, seen);
      	}
    @@ pathspec.c: void add_pathspec_matches_against_index(const struct pathspec *paths
      char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
     -					    const struct index_state *istate)
     +					    const struct index_state *istate,
    -+					    int ignore_skip_worktree)
    ++					    enum ps_skip_worktree_action sw_action)
      {
      	char *seen = xcalloc(pathspec->nr, 1);
     -	add_pathspec_matches_against_index(pathspec, istate, seen);
    -+	add_pathspec_matches_against_index(pathspec, istate, seen,
    -+					   ignore_skip_worktree);
    ++	add_pathspec_matches_against_index(pathspec, istate, seen, sw_action);
      	return seen;
      }
      
     
      ## pathspec.h ##
     @@ pathspec.h: static inline int ps_strcmp(const struct pathspec_item *item,
    + 		return strcmp(s1, s2);
    + }
      
    ++enum ps_skip_worktree_action {
    ++  PS_HEED_SKIP_WORKTREE = 0,
    ++  PS_IGNORE_SKIP_WORKTREE = 1
    ++};
      void add_pathspec_matches_against_index(const struct pathspec *pathspec,
      					const struct index_state *istate,
     -					char *seen);
    -+					char *seen, int ignore_skip_worktree);
    ++					char *seen,
    ++					enum ps_skip_worktree_action sw_action);
      char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
     -					    const struct index_state *istate);
     +					    const struct index_state *istate,
    -+					    int ignore_skip_worktree);
    ++					    enum ps_skip_worktree_action sw_action);
      int match_pathspec_attrs(const struct index_state *istate,
      			 const char *name, int namelen,
      			 const struct pathspec_item *item);
5:  584811e5c0 ! 5:  34a61a0d03 refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
    @@ Commit message
     
         refresh_index() optionally takes a seen[] array to mark the pathspec
         items that had matches in the index. This is used by `git add --refresh`
    -    to find out if there were any pathspec without matches, and display an
    +    to find out if there was any pathspec without matches, and display an
         error accordingly.
     
         In the following patch, `git add` will also learn to warn about
    -    pathspecs that only match sparse entries (which are not updated). But
    -    for that, we will need a seen[] array marked exclusively with matches
    -    from dense entries. To avoid having to call ce_path_match() again for
    -    these entries after refresh_index() returns, add a flag that implements
    -    this restriction inside the function itself.
    +    pathspecs that match no eligible path for updating, but do match sparse
    +    entries. For that, we will need a seen[] array marked exclusively with
    +    matches from dense entries. To avoid having to call ce_path_match()
    +    again for these entries after refresh_index() returns, add a flag that
    +    implements this restriction inside the function itself.
     
         Note that refresh_index() does not update sparse entries, regardless of
         passing the flag or not. The flag only controls whether matches with
    @@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
      	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
      	unsigned int options = (CE_MATCH_REFRESH |
     @@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
    - 		int cache_errno = 0;
    - 		int changed = 0;
      		int filtered = 0;
    + 		int t2_did_lstat = 0;
    + 		int t2_did_scan = 0;
     +		char *cur_seen;
      
      		ce = istate->cache[i];
6:  15f399f4fa ! 6:  66d5c71182 add: warn when pathspec only matches SKIP_WORKTREE entries
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    add: warn when pathspec only matches SKIP_WORKTREE entries
    +    add: warn when asked to update SKIP_WORKTREE entries
     
         `git add` already refrains from updating SKIP_WORKTREE entries, but it
    -    silently exits with zero code when a pathspec only matches these
    -    entries. Instead, let's warn the user and display a hint on how to
    -    update these entries.
    +    silently exits with zero code when it is asked to do so. Instead, let's
    +    warn the user and display a hint on how to update these entries.
     
    -    Note that the warning is only shown if the pathspec matches no untracked
    -    paths in the working tree and only matches index entries with the
    -    SKIP_WORKTREE bit set. A warning message was chosen over erroring out
    -    right away to reproduce the same behavior `add` already exhibits with
    -    ignored files. This also allow users to continue their workflow without
    -    having to invoke `add` again with only the matching pathspecs, as the
    -    matched files will have already been added.
    +    Note that we only warn the user whey they give a pathspec item that
    +    matches no eligible path for updating, but it does match one or more
    +    SKIP_WORKTREE entries. A warning was chosen over erroring out right away
    +    to reproduce the same behavior `add` already exhibits with ignored
    +    files. This also allow users to continue their workflow without having
    +    to invoke `add` again with only the eligible paths (as those will have
    +    already been added).
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ Documentation/config/advice.txt: advice.*::
      		Advice shown if a user runs the add command without providing
      		the pathspec parameter.
     +	updateSparsePath::
    -+		Advice shown if the pathspec given to linkgit:git-add[1] only
    -+		matches index entries outside the current sparse-checkout.
    ++		Advice shown when linkgit:git-add[1] is asked to update index
    ++		entries outside the current sparse checkout.
      --
     
      ## advice.c ##
    @@ advice.c: void NORETURN die_conclude_merge(void)
     +	if (!pathspec_list->nr)
     +		return;
     +
    -+	fprintf(stderr, _("The following pathspecs only matched index entries outside the current\n"
    -+			  "sparse checkout:\n"));
    ++	fprintf(stderr, _("The following pathspecs didn't match any"
    ++			  " eligible path, but they do match index\n"
    ++			  "entries outside the current sparse checkout:\n"));
     +	for_each_string_list_item(item, pathspec_list)
     +		fprintf(stderr, "%s\n", item->string);
     +
     +	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
    -+			  _("Disable or modify the sparsity rules if you intend to update such entries."));
    -+
    ++			  _("Disable or modify the sparsity rules if you intend"
    ++			    " to update such entries."));
     +}
     +
      void detach_advice(const char *new_name)
    @@ advice.h: void advise_if_enabled(enum advice_type type, const char *advice, ...)
     
      ## builtin/add.c ##
     @@ builtin/add.c: static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
    - 			*dst++ = entry;
      	}
      	dir->nr = dst - dir->entries;
    --	add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);
    -+	add_pathspec_matches_against_index(pathspec, &the_index, seen, 1);
    + 	add_pathspec_matches_against_index(pathspec, &the_index, seen,
    +-					   PS_HEED_SKIP_WORKTREE);
    ++					   PS_IGNORE_SKIP_WORKTREE);
      	return seen;
      }
      
    @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
     +		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
      
      		if (!seen)
    --			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
    -+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 1);
    + 			seen = find_pathspecs_matching_against_index(&pathspec,
    +-					&the_index, PS_HEED_SKIP_WORKTREE);
    ++					&the_index, PS_IGNORE_SKIP_WORKTREE);
      
      		/*
      		 * file_exists() assumes exact match
    @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
     +				continue;
     +			}
     +
    -+			/* Don't complain at 'git add .' inside empty repo. */
    ++			/* Don't complain at 'git add .' on empty repo */
     +			if (!path[0])
     +				continue;
     +
    @@ pathspec.h
     @@ pathspec.h: void add_pathspec_matches_against_index(const struct pathspec *pathspec,
      char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
      					    const struct index_state *istate,
    - 					    int ignore_skip_worktree);
    + 					    enum ps_skip_worktree_action sw_action);
     +char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec);
     +static inline int matches_skip_worktree(const struct pathspec *pathspec,
     +					int item, char **seen_ptr)
    @@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
      	EOF
      }
      
    -+test_expect_success 'setup' '
    ++test_expect_success 'setup' "
     +	cat >sparse_error_header <<-EOF &&
    -+	The following pathspecs only matched index entries outside the current
    -+	sparse checkout:
    ++	The following pathspecs didn't match any eligible path, but they do match index
    ++	entries outside the current sparse checkout:
     +	EOF
     +
     +	cat >sparse_hint <<-EOF &&
     +	hint: Disable or modify the sparsity rules if you intend to update such entries.
    -+	hint: Disable this message with "git config advice.updateSparsePath false"
    ++	hint: Disable this message with \"git config advice.updateSparsePath false\"
     +	EOF
     +
     +	echo sparse_entry | cat sparse_error_header - >sparse_entry_error &&
     +	cat sparse_entry_error sparse_hint >error_and_hint
    -+'
    ++"
     +
      test_expect_success 'git add does not remove sparse entries' '
      	setup_sparse_entry &&
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does
     -	git add --renormalize sparse_entry &&
     +	test_must_fail git add --renormalize sparse_entry 2>stderr &&
     +	test_i18ncmp error_and_hint stderr &&
    - 	test_sparse_entry_unchanged
    - '
    - 
    ++	test_sparse_entry_unchanged
    ++'
    ++
     +test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
     +	setup_sparse_entry &&
     +	rm sparse_entry &&
     +	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
     +	test_i18ncmp error_and_hint stderr &&
    -+	test_sparse_entry_unchanged
    -+'
    -+
    + 	test_sparse_entry_unchanged
    + '
    + 
     +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
     +	setup_sparse_entry &&
     +	test_must_fail git add nonexistent 2>stderr &&
     +	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
    -+	test_i18ngrep ! "The following pathspecs only matched index entries" stderr
    ++	test_i18ngrep ! -F -f sparse_error_header stderr
     +'
     +
     +test_expect_success 'do not warn when pathspec matches dense entries' '
7:  bb29aa4d8f ! 7:  d25ea10560 rm: honor sparse checkout patterns
    @@ Metadata
      ## Commit message ##
         rm: honor sparse checkout patterns
     
    -    `git add` refrains from adding or updating paths outside the sparsity
    -    rules, but `git rm` doesn't follow the same restrictions. This is
    -    somewhat counter-intuitive and inconsistent. So make `rm` honor the
    -    sparse checkout and advise on how to remove SKIP_WORKTREE entries, just
    -    like `add` does. Also add some tests for the new behavior.
    +    `git add` refrains from adding or updating index entries that are
    +    outside the current sparse checkout, but `git rm` doesn't follow the
    +    same restriction. This is somewhat counter-intuitive and inconsistent.
    +    So make `rm` honor the sparsity rules and advise on how to remove
    +    SKIP_WORKTREE entries, just like `add` does. Also add some tests for the
    +    new behavior.
     
         Suggested-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
    @@ Documentation/config/advice.txt: advice.*::
      		Advice shown if a user runs the add command without providing
      		the pathspec parameter.
      	updateSparsePath::
    --		Advice shown if the pathspec given to linkgit:git-add[1] only
    --		matches index entries outside the current sparse-checkout.
    -+		Advice shown if the pathspec given to linkgit:git-add[1] or
    -+		linkgit:git-rm[1] only matches index entries outside the
    -+		current sparse-checkout.
    +-		Advice shown when linkgit:git-add[1] is asked to update index
    +-		entries outside the current sparse checkout.
    ++		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
    ++		is asked to update index entries outside the current sparse
    ++		checkout.
      --
     
      ## Documentation/git-rm.txt ##
    @@ t/t3602-rm-sparse-checkout.sh (new)
     +
     +. ./test-lib.sh
     +
    -+test_expect_success 'setup' '
    ++test_expect_success 'setup' "
     +	mkdir -p sub/dir &&
     +	touch a b c sub/d sub/dir/e &&
     +	git add -A &&
     +	git commit -m files &&
     +
    -+	cat >sparse_entry_b_error <<-EOF &&
    -+	The following pathspecs only matched index entries outside the current
    -+	sparse checkout:
    -+	b
    ++	cat >sparse_error_header <<-EOF &&
    ++	The following pathspecs didn't match any eligible path, but they do match index
    ++	entries outside the current sparse checkout:
     +	EOF
     +
    -+	cat >b_error_and_hint sparse_entry_b_error - <<-EOF
    ++	cat >sparse_hint <<-EOF &&
     +	hint: Disable or modify the sparsity rules if you intend to update such entries.
    -+	hint: Disable this message with "git config advice.updateSparsePath false"
    ++	hint: Disable this message with \"git config advice.updateSparsePath false\"
     +	EOF
    -+'
    ++
    ++	echo b | cat sparse_error_header - >sparse_entry_b_error &&
    ++	cat sparse_entry_b_error sparse_hint >b_error_and_hint
    ++"
     +
     +for opt in "" -f --dry-run
     +do
    @@ t/t3602-rm-sparse-checkout.sh (new)
     +	git sparse-checkout set a &&
     +	test_must_fail git rm nonexistent 2>stderr &&
     +	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
    -+	test_i18ngrep ! "The following pathspecs only matched index entries" stderr
    ++	test_i18ngrep ! -F -f sparse_error_header stderr
     +'
     +
     +test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
-- 
2.30.1

