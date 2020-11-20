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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE75EC2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA122100A
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0dLg5UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgKTQxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgKTQxp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 11:53:45 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A490C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so10967559wml.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uOjs4cYXkCkdeKMBejGbLlyeI1TZTCaQienOwH0kFME=;
        b=r0dLg5UL9wQlkvZqGAN+AQryndk6xJGgDsVJ7Q9Hob4g7QkvH2TMOoJmxzBzqMWmVS
         e2u7o6aeamJvE2nqn/CRF0TruAfjQsKjU2t+3FxiHGk7lNQb6w06JlpWdBopRxdt0YyN
         38en304912DElum5YedhQSQZYp2XUmzoH1d9a1r0D8wZzyfb6zFz1nfJfyK+ND1IxUVD
         MgPmupa0Ae+zxgpIsnv2YRqzDsvrhrBa6aDYPfri7BAWzFqjbd4PObsbApDXaIZuWilS
         Yu/unvEEQF9ZxvNYdWK+FQSrsjapVkwgkTfwaYOypQ4SXGXC5RJ1tJ21LQU6Q9qn2NFU
         XWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uOjs4cYXkCkdeKMBejGbLlyeI1TZTCaQienOwH0kFME=;
        b=clf8hvlfaUIldKPB9vIx4ALPjshdQnWH7GwRTTwrn/28dSdlCeieiiT7qxax3kdVgy
         uiaMSp4ouxNIt9NfI5Gxk0+rntJnZVq2B4nbWNi9VKgDz3tb03Kjl+OyZmEJRIcFPGbM
         lRULSk0zj78Htj9JGQ+7ctRXcFw0I1lr7jeiay8BwiI2mr0ENJyDUDwMOcn1YHwa+7+c
         ey2BBXriE7vyjZ9ReSZSxbfC+aXtCgJ2+NU2A3xMVSKGZjEIy/dBV9Xe36H6FM+bdesv
         VXXZhGIx86Bo2d/qeLelilTz9SMCZ+uKQEcyBHSjLKfrpmulP3/LTeqeeUzwM99uwgu6
         DSCg==
X-Gm-Message-State: AOAM531ZumUDYs8YUMWb70Bk5cF4bpdK6GWhCP54lzs4ohm++irThTw9
        tbxL+P5hLdnoVp5+A3a6CWYBjaTzXpc=
X-Google-Smtp-Source: ABdhPJxbe2iBxCdFcHCkkeo3tjiv9vddTwYIno5ElnSl8+sIz1k8ZikTAUC/rYgIokshOd67Td2b7g==
X-Received: by 2002:a1c:a548:: with SMTP id o69mr10376293wme.23.1605891223904;
        Fri, 20 Nov 2020 08:53:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a144sm5145510wmd.47.2020.11.20.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:53:43 -0800 (PST)
Message-Id: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Nov 2020 16:53:39 +0000
Subject: [PATCH 0/3] Fix stash apply in sparse checkouts (and a submodule test)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heavier usage of sparse-checkouts at $DAYJOB is commencing. And an issue
with git stash apply was found.

git stash's implementation as a pipeline of forked commands presents some
problems, especially when implemented atop of three commands that all behave
differently in the presence of sparse checkouts. Add a testcase
demonstrating some issues with git stash apply in a repository with a
different set of sparse-checkout patterns at apply vs create time, clean up
the relevant section of git stash code, and incidentally fix a submodule
testcase unrelated to sparse checkouts. Provide some detailed commit
messages explaining the issues along the way.

NOTE: I found a couple minor issues with other commands in sparse checkouts
while debugging this issue, but I don't yet have fixes for them and I can
submit them separately.

Elijah Newren (3):
  t7012: add a testcase demonstrating stash apply bugs in sparse
    checkouts
  stash: remove unnecessary process forking
  stash: fix stash application in sparse-checkouts

 builtin/stash.c                  | 130 +++++++++++++++++++++----------
 t/lib-submodule-update.sh        |  16 ++--
 t/t7012-skip-worktree-writing.sh |  88 +++++++++++++++++++++
 3 files changed, 184 insertions(+), 50 deletions(-)


base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-919%2Fnewren%2Fsparse-checkout-fixups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-919/newren/sparse-checkout-fixups-v1
Pull-Request: https://github.com/git/git/pull/919
-- 
gitgitgadget
