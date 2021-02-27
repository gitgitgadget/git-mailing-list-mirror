Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B9C433E6
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8264E33
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhB0Abi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhB0Abc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:31:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFBC06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so6407044wrx.8
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=y2rJZKick92KpqO3Qn4yrXVV+BCG/PLhxfV9B2ZDgB8=;
        b=LkQSkwmEe40k+xqlNdIqhXuDjYed2IJ+hKowJd8I/M+TFRJoZrHggxEDXOpnGNYXT2
         FiDj6Z6gkRBPPZHU9oFCBiU4meinrGPI2CU+xmtagvfufVKG6RPFojs/gO6PxD3N3a+H
         hHg0/OESdr2H0EBDV9PNBte4gHWWHZGYqMS80kP6wcRi+K0Ix07/V6/SeE02d1ocbnT0
         SaFxGEXycZQp2TK53SWChHpqT1MXUS3Y8mkJCO1Q8lkC6DRdZCQXq33ko6VRob2L9CM4
         CxaqYLk1SmU2eNPQkcPHn+y97jWvDV48b/aFa8FUKR4HYYqUrO/BwbjZS9Fgt6EdW6vg
         bIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=y2rJZKick92KpqO3Qn4yrXVV+BCG/PLhxfV9B2ZDgB8=;
        b=KCLyhNCl9FvXCSyVIdf6Otj00t5G0VSs/MTUjZqgeBEGB2O1lJeImsWJhG6Ux7by43
         u/Wn0P9BnFtIedx3nKNuV0AD1nVqZL3XoM2FZomdkWVB1UYKevB7cN/0yQClmhTOjlYK
         /CdH0Opq5++Nrr7ZrbEDVdDan4s5VaOhp7oMA6r4v8SkfaFu2hOd6py9BHumgmTb5xJP
         AcY0Pz+Q7ZiZ66Hye3Kii8KoxqCjKC5rnAyNBsv3LnJdm87ru/lktxy8SLh77wGO5PJn
         YAV8bkb5kzn+aBRav2aMK7jlpWnwrmlFJoFutCfPrxFfrJspMnhJg04Y+RymibUvRoy4
         gZ5g==
X-Gm-Message-State: AOAM531lZGb/O0wP4oA7rj1yB2lSvzVVp8vgFCF9P559YcpNiIQYFlXk
        T7sN6iipZM+mp2Jo3Eys9wp+VEDtGnU=
X-Google-Smtp-Source: ABdhPJxFV/Uk56Nf0Ict0kH1zimN5mrobau5y+AnGihps0wHbsR0TiajmiRvkSXh5SgajyV/eFcoHg==
X-Received: by 2002:a5d:6205:: with SMTP id y5mr5736297wru.238.1614385850847;
        Fri, 26 Feb 2021 16:30:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm15556513wrx.79.2021.02.26.16.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:50 -0800 (PST)
Message-Id: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:38 +0000
Subject: [PATCH v4 00/10] Optimization batch 8: use file basenames even more
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/diffcore-rename (a concatenation of what I was
calling ort-perf-batch-6 and ort-perf-batch-7).

Changes since v3:

 * Update the commit messages (one was out of date after the rearrangement),
   and include Stolee's Reviewed-by

Elijah Newren (10):
  diffcore-rename: use directory rename guided basename comparisons
  diffcore-rename: provide basic implementation of idx_possible_rename()
  diffcore-rename: add a mapping of destination names to their indices
  Move computation of dir_rename_count from merge-ort to diffcore-rename
  diffcore-rename: add function for clearing dir_rename_count
  diffcore-rename: move dir_rename_counts into dir_rename_info struct
  diffcore-rename: extend cleanup_dir_rename_info()
  diffcore-rename: compute dir_rename_counts in stages
  diffcore-rename: limit dir_rename_counts computation to relevant dirs
  diffcore-rename: compute dir_rename_guess from dir_rename_counts

 Documentation/gitdiffcore.txt |   2 +-
 diffcore-rename.c             | 449 ++++++++++++++++++++++++++++++++--
 diffcore.h                    |   7 +
 merge-ort.c                   | 144 +----------
 4 files changed, 449 insertions(+), 153 deletions(-)


base-commit: aeca14f748afc7fb5b65bca56ea2ebd970729814
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-844%2Fnewren%2Fort-perf-batch-8-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-844/newren/ort-perf-batch-8-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/844

Range-diff vs v3:

  1:  6afa9add40b9 !  1:  823d07532e00 diffcore-rename: use directory rename guided basename comparisons
     @@ Commit message
          min_basename_score threshold required for marking the two files as
          renames.
      
     -    This commit introduces an idx_possible_rename() function which will give
     +    This commit introduces an idx_possible_rename() function which will
          do this directory rename detection for us and give us the index within
          rename_dst of the resulting filename.  For now, this function is
          hardcoded to return -1 (not found) and just hooks up how its results
          would be used once we have a more complete implementation in place.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/gitdiffcore.txt ##
  2:  40f57bcc2055 !  2:  2dde621d7de5 diffcore-rename: add a new idx_possible_rename function
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: add a new idx_possible_rename function
     +    diffcore-rename: provide basic implementation of idx_possible_rename()
      
     -    find_basename_matches() is great when both the remaining set of possible
     -    rename sources and the remaining set of possible rename destinations
     -    have exactly one file each with a given basename.  It allows us to match
     -    up files that have been moved to different directories without changing
     -    filenames.
     +    Add a new struct dir_rename_info with various values we need inside our
     +    idx_possible_rename() function introduced in the previous commit.  Add a
     +    basic implementation for this function showing how we plan to use the
     +    variables, but which will just return early with a value of -1 (not
     +    found) when those variables are not set up.
      
     -    When basenames are not unique, though, we want to be able to guess which
     -    directories the source files have been moved to.  Since this is the job
     -    of directory rename detection, we employ it.  However, since it is a
     -    directory rename detection idea, we also limit it to cases where we know
     -    there could have been a directory rename, i.e. where the source
     -    directory has been removed.  This has to be signalled by dirs_removed
     -    being non-NULL and containing an entry for the relevant directory.
     -    Since merge-ort.c is the only caller that currently does so, this
     -    optimization is only effective for merge-ort right now.  In the future,
     -    this condition could be reconsidered or we could modify other callers to
     -    pass the necessary strset.
     -
     -    Anyway, that's a lot of background so that we can actually describe the
     -    new function.  Add an idx_possible_rename() function which combines the
     -    recently added dir_rename_guess and idx_map fields to provide the index
     -    within rename_dst of a potential match for a given file.
     -
     -    Future commits will add checks after calling this function to compare
     -    the resulting 'likely rename' candidates to see if the two files meet
     -    the elevated min_basename_score threshold for marking them as actual
     -    renames.
     +    Future commits will do the work necessary to set up those other
     +    variables so that idx_possible_rename() does not always return -1.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  3:  0e14961574ea !  3:  21b9cf1da30e diffcore-rename: add a mapping of destination names to their indices
     @@ Commit message
          dir_rename_guess; these will be more fully populated in subsequent
          commits.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  4:  9b9d5b207b03 !  4:  3617b0209cc4 Move computation of dir_rename_count from merge-ort to diffcore-rename
     @@ Commit message
          preliminary computation of dir_rename_count after exact rename
          detection, followed by some updates after inexact rename detection.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  5:  f286e89464ea !  5:  2baf39d82f3e diffcore-rename: add function for clearing dir_rename_count
     @@ Commit message
          for clearing, or partially clearing it out.  Add a
          partial_clear_dir_rename_count() function for this purpose.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  6:  ab353f2e75eb !  6:  02f1f7c02d32 diffcore-rename: move dir_rename_counts into dir_rename_info struct
     @@ Commit message
          dir_rename_info struct.  Future commits will then make dir_rename_counts
          be computed in stages, and add computation of dir_rename_guess.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  7:  bd50d9e53804 !  7:  9c3436840534 diffcore-rename: extend cleanup_dir_rename_info()
     @@ Commit message
          Extend cleanup_dir_rename_info() to handle these two different cases,
          cleaning up the relevant bits of information for each case.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  8:  44cfae6505f2 !  8:  6bd398d3707e diffcore-rename: compute dir_rename_counts in stages
     @@ Commit message
          augment the counts via calling update_dir_rename_counts() after each
          basename-guide and inexact rename detection match is found.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
  9:  752aff3a7995 !  9:  46304aaebf5a diffcore-rename: limit dir_rename_counts computation to relevant dirs
     @@ Commit message
          info->relevant_source_dirs variable for this purpose, even though at
          this stage we will only set it to dirs_removed for simplicity.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
 10:  65f7bfb735f2 ! 10:  4be565c47208 diffcore-rename: compute dir_rename_guess from dir_rename_counts
     @@ Commit message
              mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
              just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##

-- 
gitgitgadget
