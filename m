Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC3C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A1061107
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhDHUlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHUls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:41:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC7C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y2so2514653qtw.13
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GpZMX9j9mYyDgG6mIRx69Tr0uJ8rKyH2j/fStBdNA8=;
        b=oEYzwKqrslFg83OSTtx4Y34ERy2eHSgT8UvnppDhlRnqNgqH62tX970oO27rXduoTD
         /JbjvfgwE25aWBvG0DdraqlKpTRbp/cvP1iIzAsDdgPLk1GRsNHoLw3jh5mYHDImaTL3
         MRrWO4ikkEzlvj2/MDlv4X5MOkNCcmO3y6um3+av8RiMPct+NCHM9cS78juU+A4TkXPu
         ANFC7zdXPjXOZlC27s4Yh/7K5+5AOG+gG78FcAogG49hECcypcAS3cZjXR0MfMVHAalL
         HihxAUQPLSr7SFpis4fF6YljRTopYH1AnHvgO9cNngIPYrZ2tpDJJBspOLEYuFvugl+w
         kbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GpZMX9j9mYyDgG6mIRx69Tr0uJ8rKyH2j/fStBdNA8=;
        b=aKySYDw1WcrQPSBw6DASyDmwQy66SQw7DTOLUos/pG+aA9Ck/B4wJ46gslXLJ+Zb6X
         OJ1jxPXPsYrRnVbRtYuyL+ConJTImKcTw/4aDsHpyxQXJ/inqVJWrdxnUzLWpDzkL3X8
         BDTTVevZJdqiigDhTHwFMeD0vICqONk/SM3r3kz0wNRHg1UPhgGJmB7SFILzUw3fcwxS
         nc3L4KcdtnxfWzaITsNIv/hh0i2PfKwVXSwDlwWUsLcrwD4GigNzypBKDFNm3/G0i+1T
         23f0VAa+H8a8fftnTGQbQpg2F8MDcn4/1hjbTqAypkmxjm9RSt3jskAMJ5/XdjOJjECz
         3kRw==
X-Gm-Message-State: AOAM530546J4oTbyfvH/WysvAIRYTijMMZRm2YEwydS15SmNzNdjUxap
        uhGHSxobjfAr2gF3xRgqrMTctYbtG4I7NA==
X-Google-Smtp-Source: ABdhPJwONUZyaeMERTvccoOCytRCFn9LVhdHNulPq3s/dY62eQdKhDD1m520yerqp2nBfKkbVsTyhA==
X-Received: by 2002:ac8:5c8d:: with SMTP id r13mr9394756qta.366.1617914494806;
        Thu, 08 Apr 2021 13:41:34 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 0/7] add/rm: honor sparse checkout and warn on sparse paths
Date:   Thu,  8 Apr 2021 17:41:21 -0300
Message-Id: <cover.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
References: <cover.1615588108.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
when asked to update sparse entries.

There are two changes since v3:

- `test_i18ncmp` and `test_i18ngrep` were replaced by `test_cmp` and
  `grep`

- The flag added in patch 5 now makes refresh_index() completely ignore
  skip_worktree entries, instead of just suppressing their matches on
  the seen[] array. The previous implementation was not necessarily
  wrong but, as Junio pointed out, it was rather odd to keep matching
  the entries if we no longer want to use the matches.

  As "side effects", the new version of the flag also makes
  refresh_index() refrain from both:

  (1) checking and warning if skip_worktree entries matching the given
  pathspec are unmerged.

  (2) marking skip_worktree entries matching the given pathspec with
  CE_UPTODATE.

  The change (1) is actually interesting because `git add` doesn't
  update skip_worktree entries, and thus, it doesn't make much sense to
  warn if they are unmerged. Besides, we will already warn if the user
  requests to update such entries, anyway. And finally, unmerged
  entries should not have the skip_worktree bit set in the first place.
  (`git merge` should clean this bit when writing the new index, and
  neither `git sparse-checkout` nor `git update-index` allow to set the
  bit on an unmerged entry.)

  Change (2) is perhaps not very beneficial, but it is also not harmful.
  The only practical difference we get by not setting the CE_UPTODATE
  flag in the skip_worktree entries is that, when writing a new index at
  the end of `git add --refresh`, do_write_index() will start checking
  if these entries are racy clean. Note that it already does that for
  all the skip_worktree entries that do not match the user-given
  pathspecs. And, in fact, this behavior distinction based on the
  pathspec only happens with `--refresh`. Plain `git add` and other
  options don't mark any skip_worktree entry with CE_UPTODATE
  (regardless of the pathspecs) and thus, all these entries are checked
  when writing the index. So `git add --refresh` will only do what the
  other options already do. 

  (Additionally, as I mentioned in [1], there might actually be at least
  one advantage in checking if the skip_worktree entries are racy clean.
  But this is a very specific case, and it's probably a topic for a
  another thread :)

[1]: https://lore.kernel.org/git/CAHd-oW4kRLjV9Sq3CFt-V1Ot9pYFzJggU1zPp3Hcuw=qWfq7Mg@mail.gmail.com/

Matheus Tavares (7):
  add: include magic part of pathspec on --refresh error
  t3705: add tests for `git add` in sparse checkouts
  add: make --chmod and --renormalize honor sparse checkouts
  pathspec: allow to ignore SKIP_WORKTREE entries on index matching
  refresh_index(): add flag to ignore SKIP_WORKTREE entries
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
 read-cache.c                     |   3 +
 t/t3602-rm-sparse-checkout.sh    |  78 ++++++++++++++++
 t/t3700-add.sh                   |   6 ++
 t/t3705-add-sparse-checkout.sh   | 155 +++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |   5 -
 t/t7012-skip-worktree-writing.sh |  19 ----
 16 files changed, 408 insertions(+), 63 deletions(-)
 create mode 100755 t/t3602-rm-sparse-checkout.sh
 create mode 100755 t/t3705-add-sparse-checkout.sh

Range-diff against v3:
1:  216e3e1af0 ! 1:  65f241b5c7 add: include magic part of pathspec on --refresh error
    @@ t/t3700-add.sh: test_expect_success 'git add --refresh with pathspec' '
     +test_expect_success 'git add --refresh correctly reports no match error' "
     +	echo \"fatal: pathspec ':(icase)nonexistent' did not match any files\" >expect &&
     +	test_must_fail git add --refresh ':(icase)nonexistent' 2>actual &&
    -+	test_i18ncmp expect actual
    ++	test_cmp expect actual
     +"
     +
      test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
2:  fd250e29b3 = 2:  5d0cdb3718 t3705: add tests for `git add` in sparse checkouts
3:  3ab45d387a = 3:  565c7d3460 add: make --chmod and --renormalize honor sparse checkouts
4:  df4509268a = 4:  a6e98b17eb pathspec: allow to ignore SKIP_WORKTREE entries on index matching
5:  ceb6b508a2 ! 5:  4330f50930 refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
    +    refresh_index(): add flag to ignore SKIP_WORKTREE entries
     
    -    refresh_index() optionally takes a seen[] array to mark the pathspec
    -    items that had matches in the index. This is used by `git add --refresh`
    -    to find out if there was any pathspec without matches, and display an
    -    error accordingly.
    -
    -    In the following patch, `git add` will also learn to warn about
    -    pathspecs that match no eligible path for updating, but do match sparse
    -    entries. For that, we will need a seen[] array marked exclusively with
    -    matches from dense entries. To avoid having to call ce_path_match()
    -    again for these entries after refresh_index() returns, add a flag that
    -    implements this restriction inside the function itself.
    -
    -    Note that refresh_index() does not update sparse entries, regardless of
    -    passing the flag or not. The flag only controls whether matches with
    -    these entries should appear in the seen[] array.
    +    refresh_index() doesn't update SKIP_WORKTREE entries, but it still
    +    matches them against the given pathspecs, marks the matches on the
    +    seen[] array, check if unmerged, etc. In the following patch, one caller
    +    will need refresh_index() to ignore SKIP_WORKTREE entries entirely, so
    +    add a flag that implements this behavior.
     
         While we are here, also realign the REFRESH_* flags and convert the hex
         values to the more natural bit shift format, which makes it easier to
    @@ cache.h: int match_stat_data_racy(const struct index_state *istate,
     +#define REFRESH_IGNORE_SUBMODULES        (1 << 4) /* ignore submodules */
     +#define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
     +#define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
    -+#define REFRESH_DONT_MARK_SPARSE_MATCHES (1 << 7) /* don't mark sparse entries' matches on seen[] */
    ++#define REFRESH_IGNORE_SKIP_WORKTREE     (1 << 7) /* ignore skip_worktree entries */
      int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
      /*
       * Refresh the index and write it to disk.
    @@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
      	int quiet = (flags & REFRESH_QUIET) != 0;
      	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
      	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
    -+	int no_sparse_on_seen = (flags & REFRESH_DONT_MARK_SPARSE_MATCHES) != 0;
    ++	int ignore_skip_worktree = (flags & REFRESH_IGNORE_SKIP_WORKTREE) != 0;
      	int first = 1;
      	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
      	unsigned int options = (CE_MATCH_REFRESH |
     @@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
    - 		int filtered = 0;
    - 		int t2_did_lstat = 0;
    - 		int t2_did_scan = 0;
    -+		char *cur_seen;
    - 
      		ce = istate->cache[i];
      		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
      			continue;
    ++		if (ignore_skip_worktree && ce_skip_worktree(ce))
    ++			continue;
      
    --		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
    -+		cur_seen = no_sparse_on_seen && ce_skip_worktree(ce) ? NULL : seen;
    -+		if (pathspec && !ce_path_match(istate, ce, pathspec, cur_seen))
    + 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
      			filtered = 1;
    - 
    - 		if (ce_stage(ce)) {
6:  048b406fa3 ! 6:  da9cd3e9f6 add: warn when asked to update SKIP_WORKTREE entries
    @@ builtin/add.c: static char *prune_directory(struct dir_struct *dir, struct paths
     +	int i, ret = 0;
     +	char *skip_worktree_seen = NULL;
     +	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
    -+	int flags = REFRESH_DONT_MARK_SPARSE_MATCHES |
    ++	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
     +		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
      
      	seen = xcalloc(pathspec->nr, 1);
    @@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
      	rm sparse_entry &&
     -	git add sparse_entry &&
     +	test_must_fail git add sparse_entry 2>stderr &&
    -+	test_i18ncmp error_and_hint stderr &&
    ++	test_cmp error_and_hint stderr &&
      	test_sparse_entry_unchanged
      '
      
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add . does not remove s
     +	echo . >>expect &&
     +	cat sparse_hint >>expect &&
     +
    -+	test_i18ncmp expect stderr &&
    ++	test_cmp expect stderr &&
      	test_sparse_entry_unchanged
      '
      
    @@ t/t3705-add-sparse-checkout.sh: do
      		echo modified >sparse_entry &&
     -		git add $opt sparse_entry &&
     +		test_must_fail git add $opt sparse_entry 2>stderr &&
    -+		test_i18ncmp error_and_hint stderr &&
    ++		test_cmp error_and_hint stderr &&
      		test_sparse_entry_unchanged
      	'
      done
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --refresh does not
      	test-tool chmtime -60 sparse_entry &&
     -	git add --refresh sparse_entry &&
     +	test_must_fail git add --refresh sparse_entry 2>stderr &&
    -+	test_i18ncmp error_and_hint stderr &&
    ++	test_cmp error_and_hint stderr &&
      	git ls-files --debug sparse_entry | grep mtime >after &&
      	test_cmp before after
      '
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --refresh does not
      	setup_sparse_entry &&
     -	git add --chmod=+x sparse_entry &&
     +	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
    -+	test_i18ncmp error_and_hint stderr &&
    ++	test_cmp error_and_hint stderr &&
      	test_sparse_entry_unchanged &&
      	! test -x sparse_entry
      '
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does
      	echo "sparse_entry text=auto" >.gitattributes &&
     -	git add --renormalize sparse_entry &&
     +	test_must_fail git add --renormalize sparse_entry 2>stderr &&
    -+	test_i18ncmp error_and_hint stderr &&
    ++	test_cmp error_and_hint stderr &&
     +	test_sparse_entry_unchanged
     +'
     +
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does
     +	setup_sparse_entry &&
     +	rm sparse_entry &&
     +	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
    -+	test_i18ncmp error_and_hint stderr &&
    ++	test_cmp error_and_hint stderr &&
      	test_sparse_entry_unchanged
      '
      
     +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
     +	setup_sparse_entry &&
     +	test_must_fail git add nonexistent 2>stderr &&
    -+	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
    -+	test_i18ngrep ! -F -f sparse_error_header stderr
    ++	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
    ++	! grep -F -f sparse_error_header stderr
     +'
     +
     +test_expect_success 'do not warn when pathspec matches dense entries' '
    @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add --renormalize does
     +test_expect_success 'add obeys advice.updateSparsePath' '
     +	setup_sparse_entry &&
     +	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
    -+	test_i18ncmp sparse_entry_error stderr
    ++	test_cmp sparse_entry_error stderr
     +
     +'
     +
7:  dd0fe93eb7 ! 7:  4459976ae9 rm: honor sparse checkout patterns
    @@ t/t3602-rm-sparse-checkout.sh (new)
     +	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
     +		git sparse-checkout set a &&
     +		test_must_fail git rm $opt b 2>stderr &&
    -+		test_i18ncmp b_error_and_hint stderr &&
    ++		test_cmp b_error_and_hint stderr &&
     +		git ls-files --error-unmatch b
     +	'
     +done
    @@ t/t3602-rm-sparse-checkout.sh (new)
     +	git reset --hard &&
     +	git sparse-checkout set a &&
     +	test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
    -+	test_i18ncmp sparse_entry_b_error stderr
    ++	test_cmp sparse_entry_b_error stderr
     +'
     +
     +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
     +	git reset --hard &&
     +	git sparse-checkout set a &&
     +	test_must_fail git rm nonexistent 2>stderr &&
    -+	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
    -+	test_i18ngrep ! -F -f sparse_error_header stderr
    ++	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
    ++	! grep -F -f sparse_error_header stderr
     +'
     +
     +test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
-- 
2.30.1

