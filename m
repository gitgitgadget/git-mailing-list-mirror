Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF52C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 08:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiGMIVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiGMIUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD6564DC
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r14so14419087wrg.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=euDTCDnDrRZ8xbnlLkfGMoYFIpX/THPADlmnnRzkTFA=;
        b=KoaF8WD6IlQoXiMqCHi8vQE1V4V6NpuP9DC8y6sduumDPaAJ9kLENyjvbZ7y5F9uTk
         ZNlWloXW2va0Zbkk25LMhmBsQn1CYX92hLbuPhsrY55/DnnZGli3NJUlBwWupfksdwOP
         e75t+CXgFtcB8Vc8HBJC7+sIkVmLGjsXFzKkgJT+Fvs2JbwzP+4l8BvCKFCZvFYUlDmp
         nTyRuVoWXQsTYSbTqWAGq4EJZYe4ERjGMgkU5GNrM1pZ9q/NQCWQQAGijRphqkGi5afj
         kK4SqO9n6OV11vv9GLO9f2bGxhqR0U5eIRBNeOrMCWlZK9a5IGqpCEF3mNZxbcQoUElV
         sGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=euDTCDnDrRZ8xbnlLkfGMoYFIpX/THPADlmnnRzkTFA=;
        b=qPFzgnn3Z3qhPaSzwviYjJuVf4dU1PudF6s8oh5MtGAs8d6vTDuMlqIRIufu9SXa1b
         y9Lmd3CwbUHvRR4B6oAoy7k7gE0mkObpxQjKKmZw0qh8w8tOdrLYsC9kwDHV+EvAfhHq
         KFguHRpXodkCZNnQj595v6RyVADddlOszWJ5MNkqJlToJ+/g7AeZqK/1K8sxEwKuRlMy
         4M/Q0BJHhNujlElEzBN/uykjYRcvBs9H0ASO0AkDecFTwRqw9G60a+8TZ5iGuH8ZZzZc
         yPF12uJEJSRH5PosL1kya1v8IaOAcqe43MlMx5YVZJHrcvI9K2ssO/FY62bUkIhUGHzc
         46uA==
X-Gm-Message-State: AJIora9WKxoYRUbGRV5cKbsLXfh1Tv/lr15ny+MJw2/m9AaAqmKziz9Z
        CfhkmqF8bLpSnbqPTFniBg4/oRKl5S4=
X-Google-Smtp-Source: AGRyM1u1xdAig6ULx9rN41NcahYyagtPGvQsbhCb3eEmTNbIJfwQJIvZT6GMUrzoq9R4O6IDQRpGUQ==
X-Received: by 2002:a5d:4145:0:b0:21d:68ab:3bf with SMTP id c5-20020a5d4145000000b0021d68ab03bfmr1936153wrq.641.1657700239456;
        Wed, 13 Jul 2022 01:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003a2e1883a27sm1696409wmb.18.2022.07.13.01.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:17:18 -0700 (PDT)
Message-Id: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 08:17:14 +0000
Subject: [PATCH 0/3] Some improvements to safe.directory on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the semantics being substantially different from Unix, the
safe.directory feature presents its own set of problems on Windows. One
particular issue would have prevented it from working in GitHub Actions'
build agents, which we definitely rely on in the Git project itself. This
was addressed via the first two patches, which had made it already into Git
for Windows v2.35.2, and they are ready to be applied to core Git, too.

The third patch came in later, and was released as part of Git for Windows
v2.37.0, so I also have confidence that it is stable and ready to be
integrated into core Git, too.

Johannes Schindelin (3):
  Allow debugging unsafe directories' ownership
  mingw: handle a file owned by the Administrators group correctly
  mingw: be more informative when ownership check fails on FAT32

 Documentation/config/safe.txt |  6 ++++
 compat/mingw.c                | 53 +++++++++++++++++++++++++++++++++++
 setup.c                       | 14 +++++++--
 3 files changed, 71 insertions(+), 2 deletions(-)


base-commit: 3b0bf2704980b1ed6018622bdf5377ec22289688
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1286%2Fdscho%2Fsafe.directory-and-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1286/dscho/safe.directory-and-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1286
-- 
gitgitgadget
