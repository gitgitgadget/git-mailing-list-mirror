Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D6C433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbiCNQLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiCNQLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:11:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2353CFED
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j17so24884786wrc.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tt25bh0YOXUg5hP9YIuTJG48GrAyCuzRI6qQlb4kzws=;
        b=I5nqYLEK7zBje8WmsD7zc1/wSPQ4hjDFlTXvi523t/t9H5iNJt3j45h8JiuixiFV+D
         Em0j0HJJIYi22HH61a0PTYevuV+urJIu9Q5qHcOVcS68TS2QaieoJHp7kZea+HEUSSQk
         hr/G+UXkkkxDWa58QB/G60xeB/Cb4jwuVr8OYr3Dkkuv+N9T0kqnxnlESGYH7EUXCklp
         9pTvyqsURPLGf5okqcbxte3UqRYk9G8Vaq84p78NHbCykMcXeHV7uG2raOFZ7MZ5Xf3b
         fWpndVChw6bIKldeCkKWnor4oHW+jNegm93zJrJSgTe/ReclCA+EqC8rBS/9jul6LzqM
         BH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tt25bh0YOXUg5hP9YIuTJG48GrAyCuzRI6qQlb4kzws=;
        b=e10qj2aidvCpLLkI5o5tcJIdVdfTwAkVxAoCCmTxmj/VhQIWDUJqcCF5JADHLsb02d
         irpeavV6Yc5AKwlj/Qpvv4NcVf9cFaSZ5onU4ZVQWZIjnfRFbJ5iS93aKtX3tf/UVoMY
         2rHZGePbd0cWo+Cr1bljFEsYh9LwMLGOy54HbHncE7cxP1eSLEkK2Up+2pzTrrA2Hsu0
         kfo2zZa/t/ORiFrXfzXP4weRJuv9WFF2+OEorYmC2T1+rGpQfwtSRAGSoznNBN1s4NUu
         rMw2LbK0XZ2aD3Kf7+rJZKoRF87JcgKa1sd7lffliZZb0MQs2Yv2qaV6B6mt7Fuarmjr
         JB0w==
X-Gm-Message-State: AOAM533s+611uX3im/hl6p+WLKmvBPHKJ9lWAwXIr13E65F04R6u7gEw
        tAV7MRDO+ruQoAPAKTrN2Bstu4BvFGE=
X-Google-Smtp-Source: ABdhPJy4QI/YaT13HmtH/kkkztkLcjS6lycDYWgXeKVtfYAcURcLG9sm/BI3NB/Dp6JckZe4Yc4nyg==
X-Received: by 2002:a5d:525b:0:b0:203:8f00:1a56 with SMTP id k27-20020a5d525b000000b002038f001a56mr15100720wrc.202.1647274231980;
        Mon, 14 Mar 2022 09:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b001f1f7b814d7sm13860816wru.69.2022.03.14.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:10:31 -0700 (PDT)
Message-Id: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:10:25 +0000
Subject: [PATCH v2 0/5] Allow 'reset --quiet' to refresh the index, use 'reset --quiet' in 'stash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the process of working on tests for 'git stash' sparse index integration,
I found that the '--quiet' option in 'git stash' does not suppress all
non-error output when used with '--index'. Specifically, this comes from an
invocation of 'git reset' without the '--quiet' flag in 'reset_head()'. Upon
enabling that flag, though, I discovered that 1) 'reset' does not refresh
the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
index to be refreshed after the reset.

This series aims to decouple the "suppress logging" and "skip index refresh"
behaviors in 'git reset --mixed', then allow 'stash' to internally use reset
with logs suppressed but index refresh enabled. This is accomplished by
introducing the '--[no-]refresh' option and 'reset.refresh' config setting
to 'git reset'. Additionally, in the spirit of backward-compatibility,
'--quiet' and/or 'reset.quiet=true' without any specified "refresh"
option/config will continue to skip 'refresh_index(...)'.

There are also some minor updates to the advice that suggests skipping the
index refresh:

 * replace recommendation to use "--quiet" with "--no-refresh"
 * use 'advise()' rather than 'printf()'
 * rename the advice config setting from 'advice.resetQuiet' to to
   'advice.resetNoRefresh'
 * suppress advice if '--quiet' is specified in 'reset'

Finally, tests are added to 't7102-reset.sh' verifying whether index refresh
happens when expected and to 't3903-stash.sh' verifying that 'apply --quiet'
no longer prints extraneous logs.


Changes since V1
================

 * Update cover letter title
 * Squash 't7102' test fixes from patch 5 into patch 2
 * Refactor 't7102' tests to properly use inline config settings

[1] https://lore.kernel.org/git/20181023190423.5772-2-peartben@gmail.com/

Thanks! -Victoria

Victoria Dye (5):
  reset: revise index refresh advice
  reset: introduce --[no-]refresh option to --mixed
  reset: replace '--quiet' with '--no-refresh' in performance advice
  reset: suppress '--no-refresh' advice if logging is silenced
  stash: make internal resets quiet and refresh index

 Documentation/config/advice.txt |  8 ++--
 Documentation/git-reset.txt     |  9 ++++
 advice.c                        |  2 +-
 advice.h                        |  2 +-
 builtin/reset.c                 | 21 ++++++---
 builtin/stash.c                 |  5 ++-
 t/t3903-stash.sh                | 12 +++++
 t/t7102-reset.sh                | 77 ++++++++++++++++++++++++++++++---
 8 files changed, 116 insertions(+), 20 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1170%2Fvdye%2Fstash%2Fmake-reset-quiet-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1170/vdye/stash/make-reset-quiet-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1170

Range-diff vs v1:

 1:  7206ef8dd8a = 1:  7206ef8dd8a reset: revise index refresh advice
 2:  bda93703013 ! 2:  7f0226bc3e6 reset: introduce --[no-]refresh option to --mixed
     @@ Commit message
          Add a new --[no-]refresh option that is intended to explicitly determine
          whether a mixed reset should end in an index refresh.
      
     -    A few years ago, [1] introduced behavior to the '--quiet' option to skip the
     -    call to 'refresh_index(...)' at the end of a mixed reset with the goal of
     -    improving performance. However, by coupling behavior that modifies the index
     -    with the option that silences logs, there is no way for users to have one
     -    without the other (i.e., silenced logs with a refreshed index) without
     +    Starting at 9ac8125d1a (reset: don't compute unstaged changes after reset
     +    when --quiet, 2018-10-23), using the '--quiet' option results in skipping
     +    the call to 'refresh_index(...)' at the end of a mixed reset with the goal
     +    of improving performance. However, by coupling behavior that modifies the
     +    index with the option that silences logs, there is no way for users to have
     +    one without the other (i.e., silenced logs with a refreshed index) without
          incurring the overhead of a separate call to 'git update-index --refresh'.
          Furthermore, there is minimal user-facing documentation indicating that
          --quiet skips the index refresh, potentially leading to unexpected issues
     @@ Commit message
          either is set, '--quiet' and 'reset.quiet' revert to controlling only
          whether logs are silenced and do not affect index refresh.
      
     -    [1] 9ac8125d1a (reset: don't compute unstaged changes after reset when
     -        --quiet, 2018-10-23)
     -
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-reset.txt ##
     @@ t/t7102-reset.sh: test_expect_success 'resetting an unmodified path is a no-op'
      +	git rm --cached file2 &&
      +
      +	# Step 2
     -+	git reset $1 --mixed HEAD &&
     ++	git $1 reset $2 --mixed HEAD &&
      +
      +	# Step 3
      +	git read-tree -m HEAD~1
     @@ t/t7102-reset.sh: test_expect_success 'resetting an unmodified path is a no-op'
      -	test_cmp expect output
      +	# Verify default behavior (with no config settings or command line
      +	# options)
     -+	test_index_refreshed &&
     ++	test_index_refreshed
      +'
      +test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
      +	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
      +	# determine refresh behavior
      +
      +	# Config setting
     -+	test_must_fail test_index_refreshed -c reset.quiet=true &&
     -+	test_index_refreshed -c reset.quiet=true &&
     ++	! test_index_refreshed "-c reset.quiet=true" &&
     ++	test_index_refreshed "-c reset.quiet=false" &&
      +
      +	# Command line option
     -+	test_must_fail test_index_refreshed --quiet &&
     -+	test_index_refreshed --no-quiet &&
     ++	! test_index_refreshed "" --quiet &&
     ++	test_index_refreshed "" --no-quiet &&
      +
      +	# Command line option overrides config setting
     -+	test_must_fail test_index_refreshed -c reset.quiet=false --quiet &&
     -+	test_index_refreshed -c reset.refresh=true --no-quiet
     ++	! test_index_refreshed "-c reset.quiet=false" --quiet &&
     ++	test_index_refreshed "-c reset.refresh=true" --no-quiet
      +'
      +
      +test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
      +	# Verify that --[no-]refresh and `reset.refresh` control index refresh
      +
      +	# Config setting
     -+	test_index_refreshed -c reset.refresh=true &&
     -+	test_must_fail test_index_refreshed -c reset.refresh=false &&
     ++	test_index_refreshed "-c reset.refresh=true" &&
     ++	! test_index_refreshed "-c reset.refresh=false" &&
      +
      +	# Command line option
     -+	test_index_refreshed --refresh &&
     -+	test_must_fail test_index_refreshed --no-refresh &&
     ++	test_index_refreshed "" --refresh &&
     ++	! test_index_refreshed "" --no-refresh &&
      +
      +	# Command line option overrides config setting
     -+	test_index_refreshed -c reset.refresh=false --refresh &&
     -+	test_must_fail test_index_refreshed -c reset.refresh=true --no-refresh
     ++	test_index_refreshed "-c reset.refresh=false" --refresh &&
     ++	! test_index_refreshed "-c reset.refresh=true" --no-refresh
      +'
      +
      +test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
      +	# Verify that *both* --refresh and `reset.refresh` override the
      +	# default non-refresh behavior of --quiet
     -+	test_index_refreshed --refresh --quiet &&
     -+	test_index_refreshed --refresh -c reset.quiet=true &&
     -+	test_index_refreshed -c reset.refresh=true --quiet &&
     -+	test_index_refreshed -c reset.refresh=true -c reset.quiet=true
     ++	test_index_refreshed "" "--quiet --refresh" &&
     ++	test_index_refreshed "-c reset.quiet=true" --refresh &&
     ++	test_index_refreshed "-c reset.refresh=true" --quiet &&
     ++	test_index_refreshed "-c reset.refresh=true -c reset.quiet=true"
       '
       
       test_expect_success '--mixed preserves skip-worktree' '
 3:  63c5ee36feb = 3:  f869723d64f reset: replace '--quiet' with '--no-refresh' in performance advice
 4:  3c65a9f1993 = 4:  cffca0ea5c6 reset: suppress '--no-refresh' advice if logging is silenced
 5:  052499bbc93 ! 5:  3334d4cb6f3 stash: make internal resets quiet and refresh index
     @@ t/t3903-stash.sh: test_expect_success 'apply -q is quiet' '
       test_expect_success 'save -q is quiet' '
       	git stash save --quiet >output.out 2>&1 &&
       	test_must_be_empty output.out
     -
     - ## t/t7102-reset.sh ##
     -@@ t/t7102-reset.sh: test_index_refreshed () {
     - 	git rm --cached file2 &&
     - 
     - 	# Step 2
     --	git reset $1 --mixed HEAD &&
     -+	git reset $@ --mixed HEAD &&
     - 
     - 	# Step 3
     - 	git read-tree -m HEAD~1
     -@@ t/t7102-reset.sh: test_index_refreshed () {
     - test_expect_success '--mixed refreshes the index' '
     - 	# Verify default behavior (with no config settings or command line
     - 	# options)
     --	test_index_refreshed &&
     -+	test_index_refreshed
     - '
     - test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
     - 	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
     - 	# determine refresh behavior
     - 
     --	# Config setting
     --	test_must_fail test_index_refreshed -c reset.quiet=true &&
     --	test_index_refreshed -c reset.quiet=true &&
     --
     - 	# Command line option
     --	test_must_fail test_index_refreshed --quiet &&
     -+	! test_index_refreshed --quiet &&
     - 	test_index_refreshed --no-quiet &&
     - 
     --	# Command line option overrides config setting
     --	test_must_fail test_index_refreshed -c reset.quiet=false --quiet &&
     --	test_index_refreshed -c reset.refresh=true --no-quiet
     -+	# Config: reset.quiet=false
     -+	test_config reset.quiet false &&
     -+	(
     -+		test_index_refreshed &&
     -+		! test_index_refreshed --quiet
     -+	) &&
     -+
     -+	# Config: reset.quiet=true
     -+	test_config reset.quiet true &&
     -+	(
     -+		! test_index_refreshed &&
     -+		test_index_refreshed --no-quiet
     -+	)
     - '
     - 
     - test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
     - 	# Verify that --[no-]refresh and `reset.refresh` control index refresh
     - 
     --	# Config setting
     --	test_index_refreshed -c reset.refresh=true &&
     --	test_must_fail test_index_refreshed -c reset.refresh=false &&
     --
     - 	# Command line option
     - 	test_index_refreshed --refresh &&
     --	test_must_fail test_index_refreshed --no-refresh &&
     -+	! test_index_refreshed --no-refresh &&
     -+
     -+	# Config: reset.refresh=false
     -+	test_config reset.refresh false &&
     -+	(
     -+		! test_index_refreshed &&
     -+		test_index_refreshed --refresh
     -+	) &&
     - 
     --	# Command line option overrides config setting
     --	test_index_refreshed -c reset.refresh=false --refresh &&
     --	test_must_fail test_index_refreshed -c reset.refresh=true --no-refresh
     -+	# Config: reset.refresh=true
     -+	test_config reset.refresh true &&
     -+	(
     -+		test_index_refreshed &&
     -+		! test_index_refreshed --no-refresh
     -+	)
     - '
     - 
     - test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
     - 	# Verify that *both* --refresh and `reset.refresh` override the
     - 	# default non-refresh behavior of --quiet
     -+
     - 	test_index_refreshed --refresh --quiet &&
     --	test_index_refreshed --refresh -c reset.quiet=true &&
     --	test_index_refreshed -c reset.refresh=true --quiet &&
     --	test_index_refreshed -c reset.refresh=true -c reset.quiet=true
     -+
     -+	# Config: reset.quiet=true
     -+	test_config reset.quiet true &&
     -+	test_index_refreshed --refresh &&
     -+
     -+	# Config: reset.quiet=true, reset.refresh=true
     -+	test_config reset.refresh true &&
     -+	test_index_refreshed
     - '
     - 
     - test_expect_success '--mixed preserves skip-worktree' '

-- 
gitgitgadget
