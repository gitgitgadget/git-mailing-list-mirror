Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC749C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhLJD7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbhLJD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829CC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t9so12905820wrx.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hp7xSSkxxTxI++Jpb0ZFiYrlZXVs65j8iPeSfE4RNbQ=;
        b=e3uWtM6p4RFVOtmR25EXy+eFWdSGMcj3ZHZOCdCQpPkd1V/55gkbcM/NioLCH7Q22f
         iyOXfCEpRXcHA6GdXe0PE9u8ybwc2SqlXfys93/RCXmzw6gN5oTVY/E1pkxiG6s1REdI
         zx1ZB7vPaCkpNxAq7mIqkXWbd1acWqsn824hF07wkhGFwnb3jXDtAQK2cDCocY0TfcpO
         N13b3xj/RzFiFsjoRobUer7cNxi3N8HDh1gknhJ1d8Mvwb9KVUANNrZVWTQxoJtHdUsu
         BtgZ1dCH/UuOQd7CMNH89GahleuSr60LPO0zkxpZCCpZzfn0gPIt+soC6+5gNWvbO2DT
         YZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hp7xSSkxxTxI++Jpb0ZFiYrlZXVs65j8iPeSfE4RNbQ=;
        b=WEivYgdnF1poEWjwYxP7Xm3xTx842OYSEnyBX4uvoykl+oi7ipRPLLF6tPOMUQhWE7
         G95FPoT6j/Ol90OFUGKL60ctrFl2tnK+TqYOQewBtnmfI5eXBS8wEVsunvLSW5HmbDRP
         e1i9u8uzm7o12XKQNzUXov8oXRBLgCvQW4Lm0wDQX/DABAH2mzmS4qhRFM4awRTOk1zx
         iS1vIWJaRRX6Il3TAiEzVyhnHv2malznwVHotajKgSvU7X6BIJvFQ6XHB2HSZwyrs30k
         0Hb83a7zFAFks0A5aKMlqIq3NRcjQijQlfpN05Zx3RPpHDfXxiQq7STNyB/kbXgl+j/R
         VQsw==
X-Gm-Message-State: AOAM5308OC8oa+2bwtM8CZVtPSPSn5kJwqA917LJ992blt2C8P0rdiCC
        57sFSnZ6TR5Wc3wy09bAhoQvMioz98Q=
X-Google-Smtp-Source: ABdhPJw9uaXP3GNvzQmuVxsBMZOW8//LGVndhcnL2FXK/0Z7er4iXkItPKhfD852LD6ODu93Hi9pmA==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr10959934wrw.283.1639108574139;
        Thu, 09 Dec 2021 19:56:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25sm1556005wms.17.2021.12.09.19.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:13 -0800 (PST)
Message-Id: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:03 +0000
Subject: [PATCH v3 00/10] sparse-checkout: make set subsume init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described at [1], the split of init and set subcommands in
sparse-checkout causes multiple issues:

 * Poor performance (deleting all tracked files, then later restoring many
   and maybe even most of them)
 * Poor UI (multiple progress bars in wrappers that hide both commands under
   1 user-facing command)
 * Loss of ignored files under directories the user wanted to keep

This series fixes this bug by providing a single command to switch to a
sparse-checkout: set. It does so by making set able to do the combined work
of init and set. It keeps init as-is to give folks time to adapt, but marks
it as deprecated. It also makes reapply able to toggle cone/non-cone mode
and sparse-index/non-sparse-index mode.

Changes since v2:

 * Small documentation wording improvement
 * Added Reviewed-by's from Stolee and Victoria

Changes since v1:

 * Inserted new patches 3 & 4 as additional preparatory cleanups
 * Took the new mode-toggling work code in sparse_checkout_set from the
   previous series and moved it into a new function, as a preparatory patch,
   and made it usable by init/set/reapply
 * Also updated reapply to allow mode-toggling
 * Updated the documentation as per above
 * Various other small items from review comments

A quick overview:

 * Patches 1-4: small preparatory refactorings
 * Patch 5: patch adding new function for toggling {cone,sparse-checkout}
   modes
 * Patch 6: the crux of the series; make set able to handle both init and
   set options
 * Patch 7: make reapply also able to do mode toggling
 * Patches 8-9: documentation modifications (Patch 4 is worth reviewing; it
   marks init as deprecated -- are others okay with that?)
 * Patch 10: trivial modification of git clone --sparse to use git
   sparse-checkout set rather than git sparse-checkout init.

[1]
https://lore.kernel.org/git/CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com/

Elijah Newren (10):
  sparse-checkout: pass use_stdin as a parameter instead of as a global
  sparse-checkout: break apart functions for sparse_checkout_(set|add)
  sparse-checkout: add sanity-checks on initial sparsity state
  sparse-checkout: disallow --no-stdin as an argument to set
  sparse-checkout: split out code for tweaking settings config
  sparse-checkout: enable `set` to initialize sparse-checkout mode
  sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
  git-sparse-checkout.txt: update to document init/set/reapply changes
  Documentation: clarify/correct a few sparsity related statements
  clone: avoid using deprecated `sparse-checkout init`

 Documentation/git-clone.txt           |   8 +-
 Documentation/git-sparse-checkout.txt | 100 +++++++------
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             | 196 ++++++++++++++++++++------
 t/t1091-sparse-checkout-builtin.sh    |  10 +-
 5 files changed, 219 insertions(+), 97 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1151%2Fnewren%2Fsparse-checkout-no-init-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1151/newren/sparse-checkout-no-init-v3
Pull-Request: https://github.com/git/git/pull/1151

Range-diff vs v2:

  1:  e41cfe3c1bb !  1:  814aed2d125 sparse-checkout: pass use_stdin as a parameter instead of as a global
     @@ Commit message
          incorrect.  Pass the value as function parameter instead to allow us to
          make subsequent changes.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  2:  6f7de8f5412 !  2:  04cd57592e9 sparse-checkout: break apart functions for sparse_checkout_(set|add)
     @@ Commit message
          function.  This does not introduce any behavioral changes; that will
          come in a subsequent patch.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  3:  bade5e52390 !  3:  f3af5edb25d sparse-checkout: add sanity-checks on initial sparsity state
     @@ Commit message
          only make sense when already in a sparse state.  Add a quick check
          that will error out early if this is not the case.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  4:  0180bfc4a93 !  4:  82a13cc0197 sparse-checkout: disallow --no-stdin as an argument to set
     @@ Commit message
          but didn't intend for --no-stdin to be permitted as well.
      
          Reported-by: Victoria Dye <vdye@github.com>
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  5:  3f5255eeef9 !  5:  7a812e0222c sparse-checkout: split out code for tweaking settings config
     @@ Commit message
          and make it slightly more general so it can handle being called from
          the new callers.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  6:  3c640f5bcef !  6:  7167a4b3118 sparse-checkout: enable `set` to initialize sparse-checkout mode
     @@ Commit message
          parameters that `init` takes and performing any necessary initialization
          if not already in a sparse checkout.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  7:  acb10889a1f !  7:  3687637915f sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
     @@ Commit message
          sparse-index without changing their sparsity paths.  Allow them to do so
          using the reapply command.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
  8:  17b033caf4b !  8:  7483d1363e5 git-sparse-checkout.txt: update to document init/set/reapply changes
     @@ Commit message
          to tweak the {cone,sparse-index} settings.  Update the documentation to
          reflect this, and mark `init` as deprecated.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-sparse-checkout.txt ##
     @@ Documentation/git-sparse-checkout.txt: C-style quoted strings.
      +	Deprecated command that behaves like `set` with no specified paths.
      +	May be removed in the future.
      ++
     -+Historically, `set` did not used to handle all the necessary config
     -+settings, which meant that both `init` and `set` had to be called.
     -+Invoking both meant the `init` step would first remove nearly all
     -+tracked files (and in cone mode, ignored files too), then the `set`
     -+step would add many of the tracked files (but not ignored files) back.
     -+In addition to the lost files, the performance and UI of this
     -+combination was poor.
     ++Historically, `set` did not handle all the necessary config settings,
     ++which meant that both `init` and `set` had to be called.  Invoking
     ++both meant the `init` step would first remove nearly all tracked files
     ++(and in cone mode, ignored files too), then the `set` step would add
     ++many of the tracked files (but not ignored files) back.  In addition
     ++to the lost files, the performance and UI of this combination was
     ++poor.
      ++
      +Also, historically, `init` would not actually initialize the
      +sparse-checkout file if it already existed.  This meant it was
  9:  922a65b4019 !  9:  11a45920602 Documentation: clarify/correct a few sparsity related statements
     @@ Metadata
       ## Commit message ##
          Documentation: clarify/correct a few sparsity related statements
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-clone.txt ##
 10:  d47b2c88242 ! 10:  395d9b194d3 clone: avoid using deprecated `sparse-checkout init`
     @@ Commit message
          The previous commits marked `sparse-checkout init` as deprecated; we
          can just use `set` instead here and pass it no paths.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Victoria Dye <vdye@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/clone.c ##

-- 
gitgitgadget
