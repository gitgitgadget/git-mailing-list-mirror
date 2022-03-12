Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60196C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiCLDMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiCLDM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A702923F7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t11so15556454wrm.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dPA3Cp+eZKAXcC+F6jf++D9wuF2Z9CZAdGc7LK5o814=;
        b=OGtyyoF7ifc10l617AfaiXUYpICvJljmq7UtyT7CHy5Z7fIGPIqJFeNZq5i80dQU5r
         mEqOCTDe01k/Eiz36aWiRux3ePc8I+AOzzQqn7e4qwFYt2VupwmUIJdFrLUn0iJqfkss
         CsP5NhU3iJZL78wMpboWkukhp5jIgWZJpB5FirrqX9X/I7moSczPbkQgdtjmF4bu+zgB
         7+/llgWlI3PT34kUaI5Ap2TN5/1uWpQKrqc3tdi3nRc0unWUOrMxvfFvO+wF2ZcRmi5y
         S4mpArgfAvPMDyncLoDrPOn9fGRANilS9OBXBrTFNoaOdqhlsgO8OQzqBH3I1Rp9C54f
         hilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dPA3Cp+eZKAXcC+F6jf++D9wuF2Z9CZAdGc7LK5o814=;
        b=R/5iPBOrVrnwu3YD9NTKzapl+PnCwU8E1CsTKlx4/5OZPpdftbWG4WOLbp91AcDrnb
         6xH4LNmE3IeL06Zon3nxdXo/h9ez81lbrR2/IH+VGKvywUfVqun1BOYDee5Scp1X+HP+
         iRIOBaDFjRptO5aBKeqezRmXbF5YmE26BKLa53xRdeZ7fyhvdJSfCyYYMFsm0mSu3mIG
         Bzo50r+EjvnWNTr5CTePoE9IqOM5uOwBXvkBzW549FH2/yeh3OOwyJCIceprJF0pYEjF
         2bHv2Cx3ZvMt+0uM4EMUq5s6SXRRc2+lRPKlyGgOak858VklFHGCJvOhAL1XFS76kJ/X
         +Y8w==
X-Gm-Message-State: AOAM530Q18vg67bVzag/bkyJiuSOaWRP9NwQ5Ypf2m0uEoXK7m3+dfRZ
        deTF4WMfl7EqQPPnT4MzXxdwRKz2wlk=
X-Google-Smtp-Source: ABdhPJzYoEL7/u12ztPLmVuS+UIl2kGaySrZOiF/6CJ2iPjoIFzgV+D/NiWwZ9UjvL7kalsqpQs27w==
X-Received: by 2002:a5d:5982:0:b0:203:7e01:49c3 with SMTP id n2-20020a5d5982000000b002037e0149c3mr9041162wri.330.1647054682823;
        Fri, 11 Mar 2022 19:11:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm8628791wmc.36.2022.03.11.19.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:22 -0800 (PST)
Message-Id: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:12 +0000
Subject: [PATCH v2 0/9] sparse-checkout: make cone mode the default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Updates Log ==

Changes since v1:

 * rebased on master, to remove dependence on en/present-despite-skipped
   (which has since merged to master). Earlier version of series wasn't
   picked up anyway, so rebasing should be safe.
 * Wording and code style tweaks suggested by Stolee in his review

== Overview ==

This patch changes the default mode for sparse-checkout from non-cone mode
to cone-mode, and marks non-cone mode as deprecated. There is no plan to
remove non-cone mode, we are merely recommending against its use.

The code change is pretty small, and most of this series is about
documentation updates -- to focus on directories rather than patterns, to
explain the new default, to explain why we are deprecating non-cone mode
(the final patch), and to make other related cleanups to simplify the
manual.

Patch 1: Update tests to not assume cone-mode is the default Patch 2: Make
cone-mode the default Patches 3-9: Various updates to
git-sparse-checkout.txt, divided up for ease of review

== Alternative ==

There is one primary alternative to this series: make sparse-checkout error
when neither --cone nor --no-cone are specified (so that there is no
default), and wait until a future date to make --cone the default. That'd be
reasonable, but I had three reason to avoid going this route (note that item
2 means there's little practical difference between cone-mode-as-default and
no-mode-is-default):

 1. git-sparse-checkout.txt has the following huge warning early in the
    manual:

""" THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN THE
FUTURE. """

 2. If users are unaware of the default change and attempt to provide
    patterns instead of directories, then they will get error messages added
    from en/sparse-checkout-fixes. They can learn at that time to get around
    the error messages by providing --no-cone.

 3. If users are unaware of the default change and provide directories, then
    that's where non-cone mode and cone mode overlap and things happen to
    work. (There is a slight difference in that cone mode will include files
    from parent directories of any specified directory, but that means the
    user gets a few more files in their sparse-checkout with cone mode than
    they would with non-cone mode.)

== CCs ==

Elijah Newren (9):
  tests: stop assuming --no-cone is the default mode for sparse-checkout
  sparse-checkout: make --cone the default
  git-sparse-checkout.txt: wording updates for the cone mode default
  git-sparse-checkout.txt: update docs for deprecation of 'init'
  git-sparse-checkout.txt: shuffle some sections and mark as internal
  git-sparse-checkout.txt: add a new EXAMPLES section
  git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a
    bit
  git-sparse-checkout.txt: mark non-cone mode as deprecated
  Documentation: some sparsity wording clarifications

 Documentation/git-read-tree.txt       |   9 +-
 Documentation/git-sparse-checkout.txt | 249 +++++++++++++++++++-------
 builtin/sparse-checkout.c             |   2 +-
 t/t1091-sparse-checkout-builtin.sh    |  15 +-
 t/t3602-rm-sparse-checkout.sh         |   6 +-
 t/t3705-add-sparse-checkout.sh        |   4 +-
 t/t6428-merge-conflicts-sparse.sh     |   4 +-
 t/t7002-mv-sparse-checkout.sh         |   2 +-
 t/t7012-skip-worktree-writing.sh      |   2 +-
 9 files changed, 207 insertions(+), 86 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1148%2Fnewren%2Fsparse-checkout-default-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1148/newren/sparse-checkout-default-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1148

Range-diff vs v1:

  1:  8c3e730e86b =  1:  05dba7069c5 tests: stop assuming --no-cone is the default mode for sparse-checkout
  2:  b174b42ed82 !  2:  a53179764bc sparse-checkout: make --cone the default
     @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_i
       	/* Set cone/non-cone mode appropriately */
       	core_apply_sparse_checkout = 1;
      -	if (*cone_mode == 1) {
     -+	if (*cone_mode == 1 || *cone_mode == -1) {
     ++	if (*cone_mode) { /* also handles "not specified" (value of -1) */
       		mode = MODE_CONE_PATTERNS;
       		core_sparse_checkout_cone = 1;
       	} else {
  3:  f98b3fac78a =  3:  8eab21996c7 git-sparse-checkout.txt: wording updates for the cone mode default
  4:  cd871966c06 =  4:  eb3b318b39e git-sparse-checkout.txt: update docs for deprecation of 'init'
  5:  fe37a966699 =  5:  7333198b778 git-sparse-checkout.txt: shuffle some sections and mark as internal
  6:  3265f41bcab !  6:  a814ea9e8d2 git-sparse-checkout.txt: add a new EXAMPLES section
     @@ Documentation/git-sparse-checkout.txt: paths to pass to a subsequent 'set' or 'a
      +
      +`git sparse-checkout reapply`::
      +
     -+	It is possible for commands to update the working tree in a way
     -+	that does not respect the selected sparsity directories, either
     -+	because of special cases (such as hitting conflicts when
     -+	merging/rebasing), or because some commands didn't fully support
     -+	sparse checkouts (e.g. the old `recursive` merge backend had
     -+	only limited support).  This command reapplies the existing
     -+	sparse directory specifications to make the working directory
     -+	match.
     ++	It is possible for commands to update the working tree in a
     ++	way that does not respect the selected sparsity directories.
     ++	This can come from tools external to Git writing files, or
     ++	even affect Git commands because of either special cases (such
     ++	as hitting conflicts when merging/rebasing), or because some
     ++	commands didn't fully support sparse checkouts (e.g. the old
     ++	`recursive` merge backend had only limited support).  This
     ++	command reapplies the existing sparse directory specifications
     ++	to make the working directory match.
      +
       INTERNALS -- SPARSE CHECKOUT
       ----------------------------
  7:  bdbf61ee6a0 =  7:  78028ecaa58 git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a bit
  8:  3e35d62c5ee =  8:  2d2b81986a5 git-sparse-checkout.txt: mark non-cone mode as deprecated
  9:  e7d3ff70914 =  9:  4b89a3392b0 Documentation: some sparsity wording clarifications

-- 
gitgitgadget
