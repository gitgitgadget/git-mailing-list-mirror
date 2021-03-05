Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4624C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05F564F59
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCEAzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCEAzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE3C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k66so236493wmf.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mi4s6b9v7J5sJ53JMWGHJeB5TFeTzJ+nCtcSp9RsiVY=;
        b=i+OGoAPVfO3UP/3RJ/05CgYzBlztDKtkMsFtkvcZoQqhhgn8fCczKIaEM1crDW1jrB
         RynYSig1itKBoZBscXNkLdinLwm7Ruj3ndd9sC/SVsjJSIOnM/aRTiGCS1yEzBWFrM24
         yeGZsgHq+xkEgwOarLr/GIzFHG7580p6Wl67kFqPgI+DrJbt1W4My8ScakVPrBoKMYSD
         wa3FaHTHMTw4tqbLn/iwReXLrYMbtqvkuUVvyCS5GJSzWdF4RFHkUaL1XrvSeTYS/gM+
         mtLcvu0EoWdsyq5eB3reqHcozpcTj4gsCUuqjr/tgu1lelrA05ZmzLscvh7DZPXz4FrI
         xOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mi4s6b9v7J5sJ53JMWGHJeB5TFeTzJ+nCtcSp9RsiVY=;
        b=sw4SiEHtZnn55/vu65Jdox0Q2jjjH51w3CK+HJt/BZW1nwoqRMxv+xTz1d7EnZvarE
         RNXwaInx5Lca0QKw5uhwNNOkDjW+y+JwFEVHGhQsRXxLcoa+fTz22Ct8DVSiZ9RNniBv
         C5Cmc/RjxVZqCQ4L45Suob/MYuhdmIATUE5fb8AkKePSQhKGFP17OWbVD7QyL9c6PSLz
         1xtBompPWb9KKODi4DBvBo9WMXViTwwsSaYye2/h//NqxqV8LntsAeOcpWAjSa5d0Nca
         LeWc9GKaZC9eTIicZf8g4MCPpj3U0gIWkTFXnJNAHhlodcmHa0P6CVBDaV5ounfbocKs
         eWRg==
X-Gm-Message-State: AOAM530Ws4P0J5Ay324hpHQSinokg+J7FsEWmciM1Ch6StKAT6lP0OEr
        Tjn57HCIiLySrxASi0X58Tmb7qWWz7w=
X-Google-Smtp-Source: ABdhPJw0s8Sslh9vMjRqDJJg02SXY05VOI+gE00G4Hm/QirDK0KrthJRNsbuSr8XCZzHSjmSSt4mMw==
X-Received: by 2002:a05:600c:2cd8:: with SMTP id l24mr188084wmc.88.1614905739372;
        Thu, 04 Mar 2021 16:55:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c128sm13215852wme.3.2021.03.04.16.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:39 -0800 (PST)
Message-Id: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:26 +0000
Subject: [PATCH 00/11] Complete merge-ort implementation...almost
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to help Ævar test his tree-walk changes against merge-ort[1], this
series completes the merge-ort implementation and cleans up testsuite
failures...EXCEPT for some t6423 failures. It also leaves out a lot of
performance work, which incidentally will fix the t6423 failures and is
being reviewed independently[2].

This 11-patch series could be submitted as 7 independent series, 1-4 patches
in length each, but it's probably easier for Ævar if we can merge just one
more thing and it's only 11 total patches. This series sub-divides as
follows:

 * Patch 1: Fix bug in already-merged portion of merge-ort affecting
   rename/rename conflicts on platforms where qsort isn't stable. (Could be
   considered for merging before 2.31 since it is a new bug in the 2.31
   cycle that I just learned of last night, but not sure it matters since
   merge-ort wasn't complete anyway and we're not even mentioning merge-ort
   in the release notes.)
 * Patches 2-5: Add support for renormalization
 * Patch 6: Add support for subtree shifting
 * Patch 7-8: Add test and support for conflicts affecting sparse-checkout
   entries
 * Patch 9: Update submodule related merge tests to note the ones that
   merge-ort fixes relative to merge-recursive
 * Patch 10: New feature -- allow "git diff AUTO_MERGE" during conflict
   resolution to let user review changes they made since
   merge/rebase/cherry-pick/revert stopped and informed them of conflicts
 * Patch 11: Add comments noting various bugs in merge-recursive

The last two patches aren't needed by Ævar, so they could be left out and
submitted later. I just figured that it was only two more patches and they
were part of "completing the merge-ort implementation" in my view.

[1] https://lore.kernel.org/git/877dmmkhnt.fsf@evledraar.gmail.com/ [2] See
https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.com/;
there are five more waiting after that -- viewable by the curious at
https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch

Elijah Newren (11):
  merge-ort: use STABLE_QSORT instead of QSORT where required
  merge-ort: add a special minimal index just for renormalization
  merge-ort: add a function for initializing our special attr_index
  merge-ort: have ll_merge() calls use the attr_index for
    renormalization
  merge-ort: let renormalization change modify/delete into clean delete
  merge-ort: support subtree shifting
  t6428: new test for SKIP_WORKTREE handling and conflicts
  merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
  t: mark several submodule merging tests as fixed under merge-ort
  merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
  merge-recursive: add a bunch of FIXME comments documenting known bugs

 branch.c                                      |   1 +
 builtin/rebase.c                              |   1 +
 merge-ort.c                                   | 230 ++++++++++++++++--
 merge-recursive.c                             |  37 +++
 path.c                                        |   1 +
 path.h                                        |   2 +
 sequencer.c                                   |   5 +
 t/t3512-cherry-pick-submodule.sh              |   9 +-
 t/t3513-revert-submodule.sh                   |   7 +-
 t/t5572-pull-submodule.sh                     |   9 +-
 t/t6428-merge-conflicts-sparse.sh             | 158 ++++++++++++
 t/t6437-submodule-merge.sh                    |   5 +-
 t/t6438-submodule-directory-file-conflicts.sh |   9 +-
 13 files changed, 449 insertions(+), 25 deletions(-)
 create mode 100755 t/t6428-merge-conflicts-sparse.sh


base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-973%2Fnewren%2Fort-remainder-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-973/newren/ort-remainder-v1
Pull-Request: https://github.com/git/git/pull/973
-- 
gitgitgadget
