Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A24C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiGUIQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiGUIQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4D7D1DA
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z13so1101354wro.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tE9NZ6YOclKdzH0hjbfJXb5JHuuzYVsJ2ZpndiIgoNY=;
        b=X0EsWGaU+1ixLX28JDPiOMry1edaPKOKa9zZxiwlH4kFZGQhwmOFxT+43vxHiduo+I
         wPPhnl7DZqdlaS6H6e3Yal9i+yuFx5OtbUIqaDD9tQD8ZQxe/3jCorfi7dRAdna9pU4H
         8LS2L3TbjZsaWbwpPEvMYcNKlXbfFdmiMxDIivjjnKsNzlK1UrQR1pDGWJ0RK+6VAHRF
         eyM28neLr/js9FRwwXakEVe2W+y1t2h5yQ03c316imN56L+FAnRfydMooHBpX3CDNIiy
         szVm03TSMiaSJcpj1mhKzbJoGuaaPardXuraMwoobczqnrLE5LV2MSG5t8va7rQhLBRR
         rEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tE9NZ6YOclKdzH0hjbfJXb5JHuuzYVsJ2ZpndiIgoNY=;
        b=apTpc2zUcce2IY8uhCBWEqU5Jn3wz85M2AHYrORZr0/FsGPMni2g7P3kK1BgiaSjFz
         oLi3bVm9opIJSFRTSSPagT9eCLWXqYvLnMbBR78U3ROmVONIZ/N0AgKQz1lMIyiZO2Xg
         8KgLV3kttbab0VyIEO6ycNlmBRlXxFtsI9T+6ENpy4KWTRZMaLrG5oUXNmqTIfuUb7Qt
         5H4/v9eUMbBdUcFw+uH0iDoJQECUGSiVqRdm1XmeSkWw2havwzZ1SjL5AcfFhSiccgMN
         shycwstn4Uvp+FFjkL5iaIo677r56zl85nt9PwK3ygSHU87FmfzHv8SUacO8oInwNKV8
         qomw==
X-Gm-Message-State: AJIora88oQnFM1iHpLhvfe7dg6vVshVZ01j79sSm8QVMPXR29eneS+rQ
        0TQOUGa6929zlM0wVuEVDGLbR2r8hzQ=
X-Google-Smtp-Source: AGRyM1vx0Shd0kw/wOZcxqAHcRXg4NIbh7n9nv4TucUkMELfsKglBqVTcPOl5AGvaz2gK4e8WtGAkQ==
X-Received: by 2002:a5d:4e06:0:b0:21d:a85c:3466 with SMTP id p6-20020a5d4e06000000b0021da85c3466mr34269245wrt.572.1658391392898;
        Thu, 21 Jul 2022 01:16:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q184-20020a1c43c1000000b003a302fb9df7sm4802615wma.21.2022.07.21.01.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:32 -0700 (PDT)
Message-Id: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:24 +0000
Subject: [PATCH v3 0/7] Fix merge restore state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: Rebased on master, yet again, because (1) Junio merged his commit to
master separately, and (2) Ævar's intentional duplication of my second
patch[1] later conflicted with other changes I had to make in the same area.
(Which isn't a big deal, but for future reference, it would be nicer to
avoid conflicts by omitting the fixup I had already submitted[2] instead of
intentionally duplicating it).

This started as a simple series to fix restore_state() in builtin/merge.c,
fixing an issue reported by ZheNing Hu[3]. It's grown so much it's hard to
call it simple. Anyway...

Changes since v2:

 * Removed the first two patches, as noted above in the comment about
   rebasing.
 * Inserted new patches 3, 4, and 5 to fix some related bugs. Folks are more
   likely to object to patch 5 than the others; people should probably take
   a look at that one if they have limited time.
 * Dramatically reworded commit messages given the misunderstandings of what
   was being addressed and done. Hopefully it is much clearer what the last
   three patches are doing and what they are not doing, and why.
 * Added several new testcases

[1]
https://lore.kernel.org/git/patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com/
[2] https://lore.kernel.org/git/xmqqedyyghsc.fsf@gitster.g/ [3]
https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com/

Elijah Newren (7):
  merge-ort-wrappers: make printed message match the one from recursive
  merge-resolve: abort if index does not match HEAD
  merge: do not abort early if one strategy fails to handle the merge
  merge: fix save_state() to work when there are stat-dirty files
  merge: make restore_state() restore staged state too
  merge: ensure we can actually restore pre-merge state
  merge: do not exit restore_state() prematurely

 builtin/merge.c                          | 59 ++++++++++++++++++------
 git-merge-resolve.sh                     | 10 ++++
 merge-ort-wrappers.c                     |  7 ++-
 t/t6402-merge-rename.sh                  |  2 +-
 t/t6424-merge-unrelated-index-changes.sh | 58 +++++++++++++++++++++++
 t/t6439-merge-co-error-msgs.sh           |  1 +
 t/t7607-merge-state.sh                   | 32 +++++++++++++
 7 files changed, 154 insertions(+), 15 deletions(-)
 create mode 100755 t/t7607-merge-state.sh


base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1231%2Fnewren%2Ffix-merge-restore-state-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1231/newren/fix-merge-restore-state-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1231

Range-diff vs v2:

 1:  6147e72c309 < -:  ----------- t6424: make sure a failed merge preserves local changes
 2:  230d84f09c8 < -:  ----------- merge: remove unused variable
 -:  ----------- > 1:  e39b2e15ece merge-ort-wrappers: make printed message match the one from recursive
 -:  ----------- > 2:  2810dec7608 merge-resolve: abort if index does not match HEAD
 -:  ----------- > 3:  b41853e3f99 merge: do not abort early if one strategy fails to handle the merge
 3:  89e5e633241 ! 4:  64700338a28 merge: fix save_state() to work when there are racy-dirty files
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge: fix save_state() to work when there are racy-dirty files
     +    merge: fix save_state() to work when there are stat-dirty files
      
     -    When there are racy-dirty files, but no files are modified,
     +    When there are stat-dirty files, but no files are modified,
          `git stash create` exits with unsuccessful status.  This causes merge
     -    to fail.  Refresh the index first to avoid this problem.
     +    to fail.  Copy some code from sequencer.c's create_autostash to refresh
     +    the index first to avoid this problem.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/merge.c: static int save_state(struct object_id *stash)
       	strvec_pushl(&cp.args, "stash", "create", NULL);
       	cp.out = -1;
       	cp.git_cmd = 1;
     +
     + ## t/t6424-merge-unrelated-index-changes.sh ##
     +@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'subtree' '
     + 	test_path_is_missing .git/MERGE_HEAD
     + '
     + 
     ++test_expect_success 'avoid failure due to stat-dirty files' '
     ++	git reset --hard &&
     ++	git checkout B^0 &&
     ++
     ++	# Make "a" be stat-dirty
     ++	test-tool chmtime =+1 a &&
     ++
     ++	# stat-dirty file should not prevent stash creation in builtin/merge.c
     ++	git merge -s resolve -s recursive D^0
     ++'
     ++
     + test_expect_success 'resolve && recursive && ort' '
     + 	git reset --hard &&
     + 	git checkout B^0 &&
 4:  4a8b7c9e06d ! 5:  91c495c770e merge: make restore_state() restore staged state too
     @@ Metadata
       ## Commit message ##
          merge: make restore_state() restore staged state too
      
     -    merge can be invoked with uncommitted changes, including staged changes.
     -    merge is responsible for restoring this state if some of the merge
     -    strategies make changes.  However, it was not restoring staged changes
     -    due to the lack of the "--index" option to "git stash apply".  Add the
     -    option to fix this shortcoming.
     +    There are multiple issues at play here:
     +
     +      1) If `git merge` is invoked with staged changes, it should abort
     +         without doing any merging, and the user's working tree and index
     +         should be the same as before merge was invoked.
     +      2) Merge strategies are responsible for enforcing the index == HEAD
     +         requirement. (See 9822175d2b ("Ensure index matches head before
     +         invoking merge machinery, round N", 2019-08-17) for some history
     +         around this.)
     +      3) Merge strategies can bail saying they are not an appropriate
     +         handler for the merge in question (possibly allowing other
     +         strategies to be used instead).
     +      4) Merge strategies can make changes to the index and working tree,
     +         and have no expectation to clean up after themselves, *even* if
     +         they bail out and say they are not an appropriate handler for
     +         the merge in question.  (The `octopus` merge strategy does this,
     +         for example.)
     +      5) Because of (3) and (4), builtin/merge.c stashes state before
     +         trying merge strategies and restores it afterward.
     +
     +    Unfortunately, if users had staged changes before calling `git merge`,
     +    builtin/merge.c could do the following:
     +
     +       * stash the changes, in order to clean up after the strategies
     +       * try all the merge strategies in turn, each of which report they
     +         cannot function due to the index not matching HEAD
     +       * restore the changes via "git stash apply"
     +
     +    But that last step would have the net effect of unstaging the user's
     +    changes.  Fix this by adding the "--index" option to "git stash apply".
     +    While at it, also squelch the stash apply output; we already report
     +    "Rewinding the tree to pristine..." and don't need a detailed `git
     +    status` report afterwards.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/merge.c: static void reset_hard(const struct object_id *oid, int verbose
       			  const struct object_id *stash)
       {
      -	const char *args[] = { "stash", "apply", NULL, NULL };
     -+	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
     ++	const char *args[] = { "stash", "apply", "--index", "--quiet",
     ++			       NULL, NULL };
       
       	if (is_null_oid(stash))
       		return;
     @@ builtin/merge.c: static void reset_hard(const struct object_id *oid, int verbose
       	reset_hard(head, 1);
       
      -	args[2] = oid_to_hex(stash);
     -+	args[3] = oid_to_hex(stash);
     ++	args[4] = oid_to_hex(stash);
       
       	/*
       	 * It is OK to ignore error here, for example when there was
     +
     + ## t/t6424-merge-unrelated-index-changes.sh ##
     +@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'resolve && recursive && ort' '
     + 
     + 	test_seq 0 10 >a &&
     + 	git add a &&
     ++	git rev-parse :a >expect &&
     + 
     + 	sane_unset GIT_TEST_MERGE_ALGORITHM &&
     + 	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
     +@@ t/t6424-merge-unrelated-index-changes.sh: test_expect_success 'resolve && recursive && ort' '
     + 	grep "Trying merge strategy resolve..." output &&
     + 	grep "Trying merge strategy recursive..." output &&
     + 	grep "Trying merge strategy ort..." output &&
     +-	grep "No merge strategy handled the merge." output
     ++	grep "No merge strategy handled the merge." output &&
     ++
     ++	# Changes to "a" should remain staged
     ++	git rev-parse :a >actual &&
     ++	test_cmp expect actual
     + '
     + 
     + test_done
 5:  a03075167c1 ! 6:  887967c1f3f merge: ensure we can actually restore pre-merge state
     @@ Metadata
       ## Commit message ##
          merge: ensure we can actually restore pre-merge state
      
     -    Merge strategies can fail -- not just have conflicts, but give up and
     -    say that they are unable to handle the current type of merge.  However,
     -    they can also make changes to the index and working tree before giving
     -    up; merge-octopus does this, for example.  Currently, we do not expect
     -    the individual strategies to clean up after themselves, but instead
     -    expect builtin/merge.c to do so.  For it to be able to, it needs to save
     -    the state before trying the merge strategy so it can have something to
     -    restore to.  Therefore, remove the shortcut bypassing the save_state()
     -    call.
     +    Merge strategies can:
     +      * succeed with a clean merge
     +      * succeed with a conflicted merge
     +      * fail to handle the given type of merge
     +
     +    If one is thinking in terms of automatic mergeability, they would use
     +    the word "fail" instead of "succeed" for the second bullet, but I am
     +    focusing here on ability of the merge strategy to handle the given
     +    inputs, not on whether the given inputs are mergeable.  The third
     +    category is about the merge strategy failing to know how to handle the
     +    given data; examples include:
     +
     +      * Passing more than 2 branches to 'recursive' or 'ort'
     +      * Passing 2 or fewer branches to 'octopus'
     +      * Trying to do more complicated merges with 'resolve' (I believe
     +        directory/file conflicts will cause it to bail.)
     +      * Octopus running into a merge conflict for any branch OTHER than
     +        the final one (see the "exit 2" codepath of commit 98efc8f3d8
     +        ("octopus: allow manual resolve on the last round.", 2006-01-13))
     +
     +    That final one is particularly interesting, because it shows that the
     +    merge strategy can muck with the index and working tree, and THEN bail
     +    and say "sorry, this strategy cannot handle this type of merge; use
     +    something else".
     +
     +    Further, we do not currently expect the individual strategies to clean
     +    up after themselves, but instead expect builtin/merge.c to do so.  For
     +    it to be able to, it needs to save the state before trying the merge
     +    strategy so it can have something to restore to.  Therefore, remove the
     +    shortcut bypassing the save_state() call.
     +
     +    There is another bug on the restore_state() side of things, so no
     +    testcase will be added until the next commit when we have addressed that
     +    issue as well.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
       	 * sync with the head commit.  The strategies are responsible
       	 * to ensure this.
      +	 *
     -+	 * Stash away the local changes so that we can try more than one.
     ++	 * Stash away the local changes so that we can try more than one
     ++	 * and/or recover from merge strategies bailing while leaving the
     ++	 * index and working tree polluted.
       	 */
      -	if (use_strategies_nr == 1 ||
      -	    /*
 6:  0783b48c121 ! 7:  81c40492a62 merge: do not exit restore_state() prematurely
     @@ Commit message
          appropriate function to do the work which would update the in-memory
          index automatically.  For now, just do the simple fix.)
      
     +    Also, add a testcase checking this, one for which the octopus strategy
     +    fails on the first commit it attempts to merge, and thus which it
     +    cannot handle at all and must completely bail on (as per the "exit 2"
     +    code path of commit 98efc8f3d8 ("octopus: allow manual resolve on the
     +    last round.", 2006-01-13)).
     +
          Reported-by: ZheNing Hu <adlternative@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/merge.c ##
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,
     - {
     - 	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
     + 	const char *args[] = { "stash", "apply", "--index", "--quiet",
     + 			       NULL, NULL };
       
      -	if (is_null_oid(stash))
      -		return;
     @@ builtin/merge.c: static void restore_state(const struct object_id *head,
      +	if (is_null_oid(stash))
      +		goto refresh_cache;
      +
     - 	args[3] = oid_to_hex(stash);
     + 	args[4] = oid_to_hex(stash);
       
       	/*
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,
     @@ t/t7607-merge-state.sh (new)
      +
      +test_expect_success 'set up custom strategy' '
      +	test_commit --no-tag "Initial" base base &&
     -+git show-ref &&
      +
      +	for b in branch1 branch2 branch3
      +	do
      +		git checkout -b $b main &&
     -+		test_commit --no-tag "Change on $b" base $b
     ++		test_commit --no-tag "Change on $b" base $b || return 1
      +	done &&
      +
      +	git checkout branch1 &&
     -+	test_must_fail git merge branch2 branch3 &&
     ++	# This is a merge that octopus cannot handle.  Note, that it does not
     ++	# just hit conflicts, it completely fails and says that it cannot
     ++	# handle this type of merge.
     ++	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
     ++	grep "fatal: merge program failed" output &&
     ++	grep "Should not be doing an octopus" output &&
     ++
     ++	# Make sure we did not leave stray changes around when no appropriate
     ++	# merge strategy was found
      +	git diff --exit-code --name-status &&
      +	test_path_is_missing .git/MERGE_HEAD
      +'

-- 
gitgitgadget
