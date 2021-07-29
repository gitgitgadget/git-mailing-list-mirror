Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB5C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD946052B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhG2R1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhG2R1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 13:27:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4130C0613D3
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 10:27:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q3so7924272wrx.0
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IOJFD46aeB2e7gXNGBhgQVDG0pVveIQczbsU30FLfbo=;
        b=CGRMNRZHbHU++By37YSitD1LJpFq04413tmaLqlX1HcPoFBc9a7M6Dq1aoNtcJqSW0
         VOoKJ4GPtGSy7ZTMJ+r3dCYrdzN5kTRFQ7BL1WWLZcpFKW4GWXOxaqaMf18qanSEJPKN
         sK1LTFFkmDAPoEMIIJQVQuel7Z6DVNADn00YMGOjim9M+VIBRPvGlZWINUYeLOYx6Ct6
         n71lEzXapLvvJVdqGUhXbX0/V+TYu+5RXomHWg0WaJcJGtfQNxGvWRInBtmGGNKyz5uM
         FaZtnjavU1Yx1bfpgEO+SxYb+EBIIoAWlkakIjx5GiF9zGAsxfOVnp2NYmeaoxT/075b
         L+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IOJFD46aeB2e7gXNGBhgQVDG0pVveIQczbsU30FLfbo=;
        b=ZaJjjnkrMohInhiPAHf1c70itMh3YJisFsiK/1ihI76HLzlZInNT3RXUrZdvTR4IKJ
         jprHMttX35ggbUGfD8nBP9dAc5ymT2eWnRx8UkZ/tRtDior4zuorKXED+Ty1xPfI8KJI
         k3penBKXuXofVVqlt0S4gfh4Utsl10/bLiN7WmHXKc/SoDldov6puy0f8wuAost09qr8
         8kzozEMAzxUankvjnm/08pvsQ/dccLOn7luoPNij+Faz+nFUomE9rmSSqmV0yVhn3Yqv
         xQtrwjqa8h1fUjQ77BcgeQpDYSTW1uOkifdmNvm6RkXfIcfZR/4yQ/BFJg55xso5qCJu
         D+CA==
X-Gm-Message-State: AOAM531nH0RG6OR99vKEXFnf3WAIKQvBghLCLnuXSJqBHNCYQrzRHOAW
        ZJWNfGkeuZeA90TG5iJ/GN2/dHSpAWs=
X-Google-Smtp-Source: ABdhPJx5ayLcay1p43/P716JLTy6koVbWBk2BzG+pOpQ4bSG/j1nAAto2RDeH0c7kogIMJtOuyfA1Q==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr3571923wrt.140.1627579638328;
        Thu, 29 Jul 2021 10:27:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22sm3904755wmc.16.2021.07.29.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:27:18 -0700 (PDT)
Message-Id: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 17:27:14 +0000
Subject: [PATCH 0/2] Sparse index: delete ignored files outside sparse cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My commits are technically based on ds/add-with-sparse-index, but could
apply earlier, I believe.

We launched an experimental release [1] of the sparse-index feature to our
internal users. We immediately discovered a problem due to the isolated way
in which we tested the sparse index: we were never building the project and
changing our sparse-checkout definition.

[1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp

Users who ran a build in one project and then moved to another still had
build artifacts in their worktree that lived inside the old directories.
Since the files are marked by the .gitignore patterns, these files were not
removed by the 'git sparse-checkout set' command. However, they make the
sparse-index unusable because every 'git status' command needs to expand the
sparse-directory entries in order to see if the files are tracked or not.
This made the first experimental release actually slower for all users
because of this cost.

The solution we shipped to these customers was to change the way our fork
handles these ignored files. Specifically, instead of Git completely
ignoring the files, we changed Git to understand that with cone-mode
sparse-checkout patterns, the users is asking for entire directories to be
removed from the worktree. The link [1] included earlier has this change.

I believe that this is a reasonable expectation, though I recognize that it
might look like breaking the expectations of how .gitignore files work.

To limit the scope of this change, the focus is limited to behave this way
only when the sparse-index is enabled, because otherwise the sparse index
does not behave as intended. With that restriction in mind, the
implementation can use the sparse directory entries to assist.

I imagine that when the sparse index is mature enough, we will enable it by
default when cone mode sparse-checkout is enabled, in which case this
behavior would expand to all users with cone mode sparse-checkout.

I'm interested in the community's thoughts about this change, as it seems
like one that we should make carefully and intentionally.

While the rewrite of the t7519 test seems unrelated, it is required to avoid
a test failure with this change that deletes files outside of the cone. By
moving the test into repositories not at $TRASH_DIRECTORY, we gain more
control over the repository structure.

Thanks, -Stolee

Derrick Stolee (2):
  t7519: rewrite sparse index test
  sparse-checkout: clear tracked sparse dirs

 Documentation/git-sparse-checkout.txt |  6 +++
 builtin/sparse-checkout.c             | 73 +++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 42 +++++++++++++++
 t/t7519-status-fsmonitor.sh           | 38 +++++++-------
 4 files changed, 142 insertions(+), 17 deletions(-)


base-commit: adf5b15ac3d44d92e0438451ef36631ed3ee2a63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2Fderrickstolee%2Fsparse-index%2Fignored-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derrickstolee/sparse-index/ignored-files-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1009
-- 
gitgitgadget
