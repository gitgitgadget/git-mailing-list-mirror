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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE07C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9FE64EFD
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCSMHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhCSMGm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 08:06:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37ACC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:06:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so5095780wmi.3
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+OdvbPqg2OSaPMyY8vI8Ilz9fGjeIj3s0H9vuXxFNzM=;
        b=o2pcR0y3irg9pD+tNrDtXeYpbXvnvhr25ZKrO7ZjXtbYWeMnSdBoPPLH7/cQzg3GHp
         fGLbUBWRdiIG8wSjyvrXeGqm7EDGOokSOZgXeWgEQnRW9zc4LogZf1BYIvk1powtPMTM
         DE0T4RvgjsXDYpWEldBsU4MFsxzvCO/qRRwjC1fMspLlewo2nNOoTKGeLvItl0i0AE02
         VbIq4yVcE77rj51NCQv+muHCdgKtbupUVAOKM95tt5p2LMyJZ2DBEo7ID8r4xc76YB49
         +OUPqd1Jyi4b8VrbjxwWRu0G1zzr4JYFJx6jcaHHy14+EvxkKsZNeWQv+/0hbgK/CkvM
         Jnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+OdvbPqg2OSaPMyY8vI8Ilz9fGjeIj3s0H9vuXxFNzM=;
        b=G3cUJ+54x4YI4jn8EH1eA43Ob5qRbHvVfhfwLzlpeIrN/NRpb7HBU3DQZpHiCzswhI
         5JfJDSxbbAMbWwBMyAoNM9MBKqQk4XCMfUDM0o2PxmjkItiDRqlmGZRh3ztjPC5epx5X
         T6ykpAI4GcFqeLTrWUG2eazPCUUnqneUJTYVfmQ2Cm9euH8vtzzqCBtjVNagUzykglw9
         Khuw8OxYlM6pdDlM3mL4xlpDtjZowfPjDuGJuShN6eNdxJ16zINYh2CFNNI3/ETtrpEI
         SRCV+Hf3M4/OtXVIJ9NF4z1dUdqfKLwps6WJlubMvnTwXpoYKsJq/xVztM/r72ZTtTm6
         HFuw==
X-Gm-Message-State: AOAM5308bsfuvXrne59mLdTLvcKBFAD5NRD4PxTiZfFBd6qonqb+3mBY
        2B/P/p27vL2fTLS2HHAFex6SiC4QlGE=
X-Google-Smtp-Source: ABdhPJyUZUTA4fT/gzn6Iy6wkqqtVbnzIHdBET2Mm8bKpMkuRqTFHckuwcCwBUeXZA5+P++QQLt5xg==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr3407276wmk.101.1616155600416;
        Fri, 19 Mar 2021 05:06:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm7877512wrf.41.2021.03.19.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:06:40 -0700 (PDT)
Message-Id: <pull.909.git.1616155599.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 12:06:36 +0000
Subject: [PATCH 0/3] [GSOC] commit: add own-identity option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the basis for commit --trailer in #901 and provides
--own-identity option for --trailer.

Junio's suggestion is that we can provide --trailer="@SomeOne" in the later
stages to support filling multiple identities which obtain from git log.

ZheNing Hu (3):
  [GSOC] commit: add --trailer option
  [GSOC] interpret-trailers: add own-identity option
  [GSOC] commit: add own-identity option

 Documentation/git-commit.txt             |  24 ++
 Documentation/git-interpret-trailers.txt |  13 +
 builtin/commit.c                         |  30 ++
 builtin/interpret-trailers.c             |   6 +-
 t/t7501-commit-basic-functionality.sh    |  91 ++++++
 t/t7502-commit-porcelain.sh              | 355 +++++++++++++++++++++++
 t/t7513-interpret-trailers.sh            |  12 +
 trailer.c                                |  18 +-
 trailer.h                                |   3 +-
 9 files changed, 547 insertions(+), 5 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-909%2Fadlternative%2Ftrailer_own_identity_option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-909/adlternative/trailer_own_identity_option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/909
-- 
gitgitgadget
