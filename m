Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB79CC433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhLaFEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhLaFEH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E70C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so54078940wrr.8
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MYkVLS8i9G4e86IOleUmOwRCo9NDuqkodayPPEYmcoY=;
        b=cE7CTlWO3J138EqfWdAT2Y4TkvNllEXlXpm7qn7ICGcXPq0n6Q9NAFIRw8ecmVYrMC
         +Dn/VvU8P70yhhH+q3zvY8ck5zUHo3Thnd6IzyndRJzXDbk2Lt/P/unfSlQYEkB9NHLJ
         isUiamZHnE27kHLYKBvcFVAYMKK0xLJL/hnqaTgmZtxpocdIEql7cCIy4674wvLAm/W1
         vxQaCNkVFYAlGEusPCxImzvsFDNF9Nt6yLdHH4l4y8hdGcWdOVik2d3ZqCGZ3zwnX1DS
         vYU9CckcZ5PAtBci8J/k8hPO4iDvRWNUX9VZDd4jl/uQn9coINTcHiNu4NzkOn1aQAFM
         5Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MYkVLS8i9G4e86IOleUmOwRCo9NDuqkodayPPEYmcoY=;
        b=nxkrxxrJZ8vW2WO7Q9fuvf3oRXS9DLBM26A+s/BnB2RyOGJkRQdvyifdOWuJRYPPXf
         uVfZYZvRunGqtprmzSPYHJ1xxJGNaDr4ylo32fAShDy5ZhmJDBHuwountq+vU1ljw+RM
         zVJ2D7E8f7rwb+BFV7hjyXQj0Yluvs3ofBLXErs8vjfjR8ZksUw/0t8OaCOC1IIJGA7u
         TnH7Y229zYEosaJtEOkdVcrJCX5hvjHrRm0SJ02uzjfJHkWenRpGQPdXRojGpLNwgjjz
         SqzvRDgzPmPVj3DQaInuf/T90jOY12rIqFeIPasYHA3vSZIwQG9/4M1SsJZerr7mMnZx
         cjVw==
X-Gm-Message-State: AOAM531+072kHsHamSxH3Is8d1aH/y6QtP9Sf9t3uiPA0hq56jWICOqg
        eQsIU+CTuA/mWHOB1cpworjCvuqXxh8=
X-Google-Smtp-Source: ABdhPJz7hOo6/TPJyLC+yYlMZPRZoEChQ+ocQ935gb46Up1KCzSYwDPKwcTeW3tpOl7XQTACN2hKiw==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr27195198wrj.576.1640927045916;
        Thu, 30 Dec 2021 21:04:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm3245250wrz.82.2021.12.30.21.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:05 -0800 (PST)
Message-Id: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:03:56 +0000
Subject: [PATCH 0/8] RFC: Server side merges (no ref updating, no commit creating, no touching
 worktree or index)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(NOTE for Junio: This series has a minor conflict with en/remerge-diff --
this series moves a code block into a new function, but en/remerge-diff adds
a BUG() message to that code block. But this series is just RFC, so you may
want to wait to pick it up.)

NOTE2: A preliminary version of this series was discussed here:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet/

This series introduces a new option to git-merge-tree: --real (best name I
could come up with). This new option is designed to allow a server-side
"real" merge (or allow folks client-side to do merges with branches they
don't even have checked out). Real merges differ from trivial merges in that
they handle:

 * three way content merges
 * recursive ancestor consolidation
 * renames
 * proper directory/file conflict handling
 * etc.

The reason this is different from merge is that merge-tree does NOT:

 * Read/write/update any working tree (and assumes there probably isn't one)
 * Read/write/update any index (and assumes there probably isn't one)
 * Create a commit object
 * Update any refs

This series attempts to guess what kind of output would be wanted, basically
choosing:

 * clean merge or conflict signalled via exit status
 * stdout consists solely of printing the hash of the resulting tree (though
   that tree may include files that have conflict markers)
 * new optional --messages flag for specifying a file where informational
   messages (e.g. conflict notices and files involved in three-way-content
   merges) can be written; by default, this output is simply discarded
 * new optional --conflicted-list flag for specifying a file where the names
   of conflicted-files can be written in a NUL-character-separated list

This design means it's basically just a low-level tool that other scripts
would use and do additional work with. Perhaps something like this:

   NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT


Elijah Newren (8):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-ort: allow update messages to be written to different file
    stream
  merge-tree: support saving merge messages to a separate file
  merge-tree: provide an easy way to access which files have conflicts

 Documentation/git-merge-tree.txt |  32 +++++--
 builtin/merge-tree.c             | 152 ++++++++++++++++++++++++++++---
 git.c                            |   2 +-
 merge-ort.c                      |  85 ++++++++++-------
 merge-ort.h                      |  12 +++
 t/t4301-merge-tree-real.sh       | 108 ++++++++++++++++++++++
 6 files changed, 333 insertions(+), 58 deletions(-)
 create mode 100755 t/t4301-merge-tree-real.sh


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1114%2Fnewren%2Fmerge-into-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1114/newren/merge-into-v1
Pull-Request: https://github.com/git/git/pull/1114
-- 
gitgitgadget
