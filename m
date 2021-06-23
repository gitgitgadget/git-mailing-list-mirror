Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAF8C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51783610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFWP0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWP0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E382EC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j10so1935789wms.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sAcKnAVLMd1N2j8QGU6yF7Cg0tuBcf7X94RX3gNQu/U=;
        b=mCHv9ciVPHzWubHkEpAbcJoNz1EKuaim2vcT/4Ioq916o1GaUuJRpt1iXtFUymCfWE
         9Z7mRcdKupAkv1yalkpOegBx+y3fj7XZPYdCIyqhvJALp/UzDsEgOkhNWV6JDsEaf2cf
         i1leNWehHpItlIxKoMayiYSyxHrAvfqCvdUBEZlIHtIauu/Bvn1Dn/JgHFj/VCbZXOEP
         o8SDpwMyPzicDT/HeL4EUhpe7wIbzP3BMsVIrb1KxdOgNORzZbHeul/gJe3wemH+lg4J
         HVM44oBhw1sLpm6WD8FbV8CcyzItTBmGcFXrHsTwvcUpoZ/EJE/p7EV18YNNSDSk79rQ
         6+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sAcKnAVLMd1N2j8QGU6yF7Cg0tuBcf7X94RX3gNQu/U=;
        b=KjsXmu3deFhmevBI1V+5UyDEiFJ44C47t0G0PSFWTFYdSIq/xvZp2j1pEIWVmN0pdm
         Hx8uZOnrU0IjIInM06DULYW+mD7f0zsE+HVQkr3Rpilj7blw/oBNIS9G82KRVRUbu9fA
         9lonAKzh10/N3FWsbgmpz+5qARZIxmhkUqpMUJVBCwEuL+hlg1LIZZRjZkcuko25q/sm
         eZGstKzMGl1+rAS0+77mb0JXVzHDPw0Q7eu4hS2VAJWMOuBHgWv+5j/3JFHpcuc/P3rN
         84C1cyoBUH57wT9sb9ntKKGzY8MNO+rZSFk//OhAAKsBq07d/G0KwW5yOE0xmIo9p/6b
         9syA==
X-Gm-Message-State: AOAM5305OxDKO188WiR26NlSrrAznrF4M2NFv70REXlUyffAqCRfFQ48
        x/7WJRLNyMNYceNvk9qN5NFJXIfNfNw=
X-Google-Smtp-Source: ABdhPJwA7jxiG5+w2BgPhMMWQ/p1SeRFcp88Ad5G1LdAPRnmXvsaCjtuB6y5IZ/Bh9BTVpYk+8nfEg==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr11388142wmb.156.1624461858558;
        Wed, 23 Jun 2021 08:24:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm309174wrp.92.2021.06.23.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:18 -0700 (PDT)
Message-Id: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:10 +0000
Subject: [PATCH 0/6] ci: speed-up the Windows parts of our GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series upgrades to newer versions of a couple GitHub Actions we
use, and also streamlines the Windows jobs using the relatively new
setup-git-for-windows-sdk Action
[https://github.com/marketplace/actions/setup-git-for-windows-sdk] (Git for
Windows is running with this Action for a while now, getting all the kinks
out).

This patch series should also address the problem where seen was pushed so
rapidly that the windows-test jobs failed because they no longer checked out
the identical revision as the windows-build job.

Dennis Ameling (1):
  ci(vs-build): build with NO_GETTEXT

Johannes Schindelin (5):
  ci: use the new GitHub Action to download git-sdk-64-minimal
  ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
  ci: upgrade to using actions/{up,down}load-artifacts v2
  ci(windows): transfer also the Git-tracked files to the test jobs
  ci: accelerate the checkout

 .github/workflows/main.yml | 157 +++++++++++--------------------------
 1 file changed, 46 insertions(+), 111 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-878%2Fdscho%2Fuse-setup-git-for-windows-sdk-action-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-878/dscho/use-setup-git-for-windows-sdk-action-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/878
-- 
gitgitgadget
