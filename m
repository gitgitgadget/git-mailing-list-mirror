Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF3EC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 20:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiC2UDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiC2UDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 16:03:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EF1A8FE3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so25242478wrc.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7aAz3qhPTWH7yY6zhaTIpiBmQsqXnuduOhN5V67zgEY=;
        b=qxtFA9/6cZhoYUGnAo/JaedPoITFi1LZEQDzOdtBV8qlQaMhdq7s0gIMJBDOCYKdq3
         +40DE4EBkwtDVCTYcrNHBAl3jvx4m8cKso5nl0Wi/zenAQUqfiZNlxNl+9w46Ml8mKxM
         sLKHHhuX70qS+MaqqY2o3kM6ytr85BtExQsC0GyPF1bpXw64GFELcq2zuZpfYmOzXGDM
         yBY2MFXfXTlvzCho67vrw6JZEyiZINN/BP96OQ6elYzFZg9qe8TnxXZ/VPdDpnLoQp0C
         wz0cTC344PxdqrZQr8RWsskgbmetApv7UKNTWgXSapURGhq0N5GoU7LavHXl6Gnkz8h+
         9KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7aAz3qhPTWH7yY6zhaTIpiBmQsqXnuduOhN5V67zgEY=;
        b=8Il/dUD6FiXPzZabiLQJFyperGXQCZq0XV6jteGqk0j8i/hmHgkAWaInA8fe0pKKQJ
         WEa4tys1i4o5uIDHd41Xl60Qb/YreeaLv90SEYW4RgXHIHkSep0+t6Xh+RYWCt4Vpnls
         Q4DKkSfpdQficYo8Vs7vXNsx3AymOFN3H3OXGBMa//1GFLNJcNn9LZktCBT9h6uqgZSl
         sFt2lF0IFXOIXR4+L5ol88DtpGxyLXdaXsMqpqeVXYiYgYIfsG61JIyXVz+KzwyjpGnQ
         EZ/iwvNsbdPrYyzJRlxR3OgLf+Kusq4fL3KLE7xyCV0AASEA+Q28EBsCVmFdhM8jLnnC
         26Fg==
X-Gm-Message-State: AOAM533oSaLx3+yzMWH3kpmADCkIgnlMlKa7dEnpfkUw6or69DeS1g6c
        jseQ0Dvj4t6AvEvqNIzmn+eE8TJ2CrE=
X-Google-Smtp-Source: ABdhPJwsoLXmsdj7ZI3w1egEPWmv1nW4UWjtz0/Sd/NhVFp3MVSdOrLWqVXeicsOzCg8IhsapajcoQ==
X-Received: by 2002:adf:f78e:0:b0:205:85d3:fa33 with SMTP id q14-20020adff78e000000b0020585d3fa33mr33586433wrp.675.1648584080648;
        Tue, 29 Mar 2022 13:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm16032240wri.4.2022.03.29.13.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:01:20 -0700 (PDT)
Message-Id: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 20:01:15 +0000
Subject: [PATCH 0/4] branch --recurse-submodules: Bug fixes and clean ups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This a catch-all series that address some bugs discovered while testing "git
branch --recurse-submodules" (patches 1-2), as well as some clean ups that
came up when "branch --recurse-submodules" was first proposed (patches 3-4).

== Patch organization

Patches 1-2 are bugfixes, 3-4 are clean ups.

 * Patch 1 fixes a bug where "git branch --recurse-submodules" would not
   propagate the "--track" option if its value was "--no-track" or
   "--track=inherit".

 * Patch 2 fixes a bug where "git branch --recurse-submodules" would give
   advice before telling the user what the problem is (instead of the other
   way around).

 * Patch 3 fixes some old inconsistencies when "git branch

--set-upstream-to" gives advice and when it doesn't.

 * Patch 4 replaces exit(-1) with exit(1).

== Outstanding concerns

Patch 4: exit(1) was suggested in
https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.com. I'm
not sure if we have a strong convention around exit codes and I'm using "1"
as "unspecified error. Perhaps others could chime in.

Glen Choo (4):
  branch: support more tracking modes when recursing
  branch: give submodule updating advice before exit
  branch --set-upstream-to: be consistent when advising
  branch: remove negative exit code

 branch.c                    | 42 ++++++++++++++++++++++++++++++-------
 builtin/submodule--helper.c |  7 ++++---
 t/t3207-branch-submodule.sh | 38 ++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 12 deletions(-)


base-commit: abf474a5dd901f28013c52155411a48fd4c09922
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1190%2Fchooglen%2Fbranch%2Frecursive-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1190/chooglen/branch/recursive-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1190
-- 
gitgitgadget
