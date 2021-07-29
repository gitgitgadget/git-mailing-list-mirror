Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD73C432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BF660EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhG2OwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhG2OwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:52:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F4C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z4so7285955wrv.11
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x9b2nDgdmBFtr2mkDSTsXzBep9pKYX9OvykNpPOOG4M=;
        b=VIznoSYWrvjPrm8J83IlqfrFjuaDdy6yo5PEpUHLHZZjbws8JkC3WTKGYuYKTgyJX2
         SxUkNPYiinMVQyBq04cqSwspc1rSuAU7cMPok0Alcc9O01COLucbeT4GYbKFJUBfXDVr
         xYth6zZ+24eN5Wxb54Grs/CtSSZFuNbnrYfGdvzhZLMv30sZSQ5rKVGKw4lCT0ul+T0g
         28NUyUhPQMAHsf7SttGJ/oKVJl8aHdSCzRfY+OV573sNL7qEX8w9AeV2oWf0MZ0vV+ib
         XIyzuXfU9DI2gLWo+egyUCrZUAd7QHoCVw6HHrzYUVhhcvEtbk8BOITqCmvor2lGE547
         AKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x9b2nDgdmBFtr2mkDSTsXzBep9pKYX9OvykNpPOOG4M=;
        b=nTvA3HUWazYGOxF5+TyNprqg+oEOMmYh2uGyzZQnPNFAGUMroyrT03wEcb6TJgIQhY
         2jFT5HZTMaHp7IPIfLu8Czwj4KUPT3+LAkXWaqyXy43Nvkouh7Tw/xqycYA7UeTTre23
         YFfo7oIeTnDDfwU7SQIXytZgWEbY5F5S6A67nxeqXIBnu5n11xsF1annE3yN6Ks/II45
         IeQwiWI5CrjSf3hsRfoXTY3aajrwmRnxIbZAZbgTP4jbgUGvoGz9imnwhGR1yAj96rPc
         z3VyX0tvNsJl/y+UtHNUyKUA5GBXepeW+WVz8BUSCJnv0xfEHzKqFcgOkQmI3Az1dGUc
         rPNA==
X-Gm-Message-State: AOAM533YqoOJVV6a4jJecYr6KDzjBXftUZt/03LBwrXipGypfLnWTlMb
        CuD+3SKcW8fqD4xYzad4KRvdm1RbQ7M=
X-Google-Smtp-Source: ABdhPJyqOraB1zN/KQ7NU4MGBuiiy5rN017byj6HiSJxg54ZjC8HyAdIWbg+5eKni2d2tZ6Jj5h+9A==
X-Received: by 2002:adf:f707:: with SMTP id r7mr5180254wrp.175.1627570328892;
        Thu, 29 Jul 2021 07:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm3853189wrs.5.2021.07.29.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:52:08 -0700 (PDT)
Message-Id: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 14:52:02 +0000
Subject: [PATCH v3 0/5] Sparse Index: Integrate with 'git add'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series re-submits the 'git add' integration with sparse-index.
The performance gains are the same as before.

It is based on ds/commit-and-checkout-with-sparse-index.

This series was delayed from its initial submission for a couple reasons.

The first was because it was colliding with some changes in
mt/add-rm-in-sparse-checkout, so now we are far enough along that that
branch is in our history and we can work forwards.

The other concern was about how 'git add ' should respond when a path
outside of the sparse-checkout cone exists. One recommendation (that I am
failing to find a link to the message, sorry) was to disallow adding files
that would become index entries with SKIP_WORKTREE on. However, as I worked
towards that goal I found that change would cause problems for a realistic
scenario: merge conflicts outside of the sparse-checkout cone.

Update: Elijah points out that the SKIP_WORKTREE bit is removed from
conflict files, which allows adding the conflicted files without warning.
(However, we also need to be careful about untracked files, as documented in
the test added here.)

The first patch of this series adds tests that create merge conflicts
outside of the sparse cone and then presents different ways a user could
resolve the situation. We want all of them to be feasible, and this
includes:

 1. Reverting the file to a known version in history.
 2. Adding the file with its contents on disk.
 3. Moving the file to a new location in the sparse directory.

The one place I did continue to update is 'git add --refresh ' to match the
behavior added by mt/add-rm-in-sparse-checkout which outputs an error
message. This happens even when the file exists in the working directory,
but that seems appropriate enough.


Updates in V3
=============

 * Added disclaimer to the merge-conflict test that this is documenting
   current behavior, not endorsing it.

 * Added Elijah's reviewed-by. Thanks for the review!

Thanks, -Stolee

Derrick Stolee (5):
  t1092: test merge conflicts outside cone
  add: allow operating on a sparse-only index
  pathspec: stop calling ensure_full_index
  add: ignore outside the sparse-checkout in refresh()
  add: remove ensure_full_index() with --renormalize

 builtin/add.c                            | 15 ++++--
 pathspec.c                               |  2 -
 t/t1092-sparse-checkout-compatibility.sh | 67 ++++++++++++++++++++----
 3 files changed, 70 insertions(+), 14 deletions(-)


base-commit: 71e301501c88399711a1bf8515d1747e92cfbb9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-999%2Fderrickstolee%2Fsparse-index%2Fadd-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-999/derrickstolee/sparse-index/add-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/999

Range-diff vs v2:

 1:  8f2fd9370fe ! 1:  5e96df4df58 t1092: test merge conflicts outside cone
     @@ Metadata
       ## Commit message ##
          t1092: test merge conflicts outside cone
      
     +    Conflicts can occur outside of the sparse-checkout definition, and in
     +    that case users might try to resolve the conflicts in several ways.
     +    Document a few of these ways in a test. Make it clear that this behavior
     +    is not necessarily the optimal flow, since users can become confused
     +    when Git deletes these files from the worktree in later commands.
     +
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge' '
       	test_all_match git rev-parse HEAD^{tree}
       '
       
     ++# NEEDSWORK: This test is documenting current behavior, but that
     ++# behavior can be confusing to users so there is desire to change it.
     ++# Right now, users might be using this flow to work through conflicts,
     ++# so any solution should present advice to users who try this sequence
     ++# of commands to follow whatever new method we create.
      +test_expect_success 'merge with conflict outside cone' '
      +	init_repos &&
      +
 2:  6e43f118fa0 ! 2:  defab1b86d3 add: allow operating on a sparse-only index
     @@ Commit message
          the use of a sparse index. We modify a test in t1092 to demonstrate
          these changes which will be remedied in future changes.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/add.c ##
 3:  2ae91e0af29 ! 3:  9fc4313c889 pathspec: stop calling ensure_full_index
     @@ Commit message
          commits. Comparing to the full index case, we see the performance go
          from 0.33s to 0.05s, an 85% improvement.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## pathspec.c ##
 4:  a79728d4c64 ! 4:  0ec03ab021d add: ignore outside the sparse-checkout in refresh()
     @@ Commit message
          tracked, untracked, or ignored. We simply avoid updating the stat()
          information because there isn't even an entry that matches the path!
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/add.c ##
 5:  1543550a4e8 ! 5:  adf5b15ac3d add: remove ensure_full_index() with --renormalize
     @@ Commit message
          SKIP_WORKTREE bit, so it will continue to do so with a sparse index
          because the sparse directory entries also have this bit set.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/add.c ##

-- 
gitgitgadget
