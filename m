Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C90C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7E22072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLGHrfdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFJVTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgFJVTg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E2C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so3943937wrv.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UiozAg8WLzzoRbR215SaN5W4WbBkTjUqCBTzLr6sKag=;
        b=aLGHrfdbx6qQnd7kELgxcFqIGI7sztCVqUv1MaVWVSVWvIkJA177onur6w0lDJHGbI
         k0Zas4O3HKGaod/Ros4MZxcmXcKalotxFOfKUL6yupOp1gVLEVRifFnm0h2+Xzr2tJd3
         F3umGs0DWom+bLyImM8C52ONwVsWMKiBZ2AhWBrPwkeJ+Z5l9Ep4GU6DPz7Rw/nTUGV3
         5prpGeDOtl5fLIGf9dObeDpjkmy2p2duawTLtNKNu53x2hMXi/jmut4OuRmjSvecUxmY
         6pY+WSpLY3q8WDYvMw9avq0q5IB34zHWctnhTbKX3mGIT+Ee2R3m4YO8opZy9Wppe5LB
         KJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UiozAg8WLzzoRbR215SaN5W4WbBkTjUqCBTzLr6sKag=;
        b=AcVRG0gz5bFnSu9z4qI3ZPHonAMZinOxpRrtfoDnEVxmuxm3YNEmJANb1RuhZd28HI
         zbmd/d4+KmoOTyBF0Joei8k4zm8sW067Rj5hSa+x1+b0FAuOCv25C/mWnTUDFrFXsuAn
         lINxG4woqhsfNbqQ01fkCl87wGjRZsOjcAL8vLquXmpkSiw0fwyuLsYQDh9SLWVxrk/T
         TyfL/zap4i0MH8aU8ikXktB30zmQvcfu0BQqsBvqqaUoddsbcdotLcoe3ejO8z7CkmYC
         fcaMJVjQlL4RM85Z06m2vJmSgp3IA8iX3YuXJ53wqxRgz0hrOOYkEMwo0zsYWcyGieQX
         yLgg==
X-Gm-Message-State: AOAM530AIRwUm5YWsa8A9lfb04pz4Cb1RNBhNKercsyMIZ7iebBP4qNv
        abRCT8CTHHG4RbcUZoP5GTp/BNYf
X-Google-Smtp-Source: ABdhPJzMR8udlpVdjwrSyNrGthBuuDrah7V+KXb5ZdpDnW2ZLr3uK33JP+22FEXZHZ9FMNDehMIVuQ==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr5457057wrq.385.1591823972619;
        Wed, 10 Jun 2020 14:19:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm1548997wru.33.2020.06.10.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:31 -0700 (PDT)
Message-Id: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:21 +0000
Subject: [PATCH 0/9] Allow overriding the default name of the default branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A growing number of open source projects aims to avoid the branch name 
master due to its negative connotation. See [1] for an existing discussion
on this. The links [2], [3], and [4] describe community-driven ways for
users to rename their default branches or use template edits to set a new
default branch name.

[1] 
https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/

[2] https://twitter.com/mislav/status/1270388510684598272

[3] 
https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterToMain.aspx

[4] https://github.com/ethomson/retarget_prs

By necessity, existing repositories require a lot of manual work to move
away from that branch name, but it should be much easier for new
repositories.

This patch series allows overriding the branch name being used for new
repositories' main branch. The main way to do this is the new 
core.defaultBranchName config option. This first patch was contributed by
newcomer Dan Goodman-Wilson. Thanks for the contribution!

The other patches follow other places where "master" is hard-coded and use
the new git_default_branch_name() method to consume the config option before
falling back to "master".

The last patch updates documentation only after the config option is ready
to apply to all of these scenarios.

This series DOES NOT change the default automatically, but only provides an
opt-in mechanism for interested users. It also presents a way forward for
such a transition, if and when we decide to do so. Specifically, the new
GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
test scripts on an individual basis instead of all-at-once.

Don Goodman-Wilson (1):
  init: allow overriding the default branch name for new repositories

Johannes Schindelin (8):
  remote: respect `core.defaultBranchName`
  send-pack/transport-helper: respect `core.defaultBranchName`
  testsvn: respect `core.defaultBranchName`
  submodule: use the (possibly overridden) default branch name
  clone: learn about the possibly-configured default branch name
  fmt-merge-msg: learn about the possibly-configured default branch name
  fast-export: respect the possibly-overridden default branch name
  Document how the default branch name can be overridden

 Documentation/config/core.txt |  4 ++++
 builtin/clone.c               | 14 +++++++++++---
 builtin/fast-export.c         | 10 +++++++---
 builtin/init-db.c             |  8 +++++---
 builtin/submodule--helper.c   | 10 ++++++++--
 fmt-merge-msg.c               |  6 ++++--
 refs.c                        | 34 ++++++++++++++++++++++++++++++++++
 refs.h                        |  6 ++++++
 remote-testsvn.c              | 11 ++++++++---
 remote.c                      | 12 ++++++++----
 send-pack.c                   |  6 +++++-
 t/README                      |  4 ++++
 t/t0001-init.sh               | 20 ++++++++++++++++++++
 t/t5609-clone-branch.sh       |  9 +++++++++
 t/t6200-fmt-merge-msg.sh      |  8 ++++++++
 transport-helper.c            |  6 +++++-
 16 files changed, 146 insertions(+), 22 deletions(-)


base-commit: 0313f36c6ebecb3bffe6f15cf25a4883100f0214
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-656%2Fdscho%2Fdefault-branch-name-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-656/dscho/default-branch-name-option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/656
-- 
gitgitgadget
