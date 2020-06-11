Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AAEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE9207C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqvGRnWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgFKG7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFKG7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 02:59:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A6BC08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so4928772wrc.7
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dSpi3mdRKp8TQ6ydy1BVIX/cOb81eamndk2y307j+vs=;
        b=iqvGRnWneclkS+1lOicWGA8HdB+jCLv4tVsil3UoTleP4J7+bSj+7yTmCBcE24mgtS
         sInHvxPN7nILusCglpoFMNo+EOJqqY2hbbFQWSsfCHgOKpKbHeKv1sxenLbOjkgFKFPH
         dq0+13fvDm45j9QzDFbS25phOEDWdL6cnayb0mEBBsucHaJCI62cejVpF/Fmy1EYXn9I
         nP6VcsOqzU/XeTNbfGvITfIFELLFCJWghgVxcPUfGM6ubgbkQnhSI+K9ZE8arQxXQOcc
         siDITgh/nLp3y+HUDOycJPA2+Az33zbsBd10pdz3vITWCdVtyqo7vBaCyqVlqNv5JS1c
         NugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dSpi3mdRKp8TQ6ydy1BVIX/cOb81eamndk2y307j+vs=;
        b=IhITKgxDhRxkAFEyUGkC6FwPSWrZohMArQxsEFISjot6TGgVDvvd1PCN/NExrIIptW
         KT0xNVpuJ/nrIkOqd2PN9trlOqzRwfimvmKXbjdBTsLBGO5QDHEi6N2ByA03v15ITT8q
         fN2GZWAp8bEgOdhNOdlxU65QukEQY1pwNunhP4cc8/T7CzKlrj3QYqsl9f5D9WIzADe+
         j8OowRiTWRbbkqGud6tk8W6OhzJVMUBeHPEtN7hxHfOst9XuuSEB9rCgLVYpV2E/qTzj
         gOs58T+68jN3MCY+zUl33MSTQTdS4uccy1IYl072iOMeUmuPEwrCL8WdrLH9ZJ43P5fp
         Ivjg==
X-Gm-Message-State: AOAM530teh2GA65syQ1BZ9xaUTw5+4G5Xn86gw9FZwGwKIsDf6NoaC5t
        iOxP6fXUCWyPH75kSJbL9Ic4XsVc
X-Google-Smtp-Source: ABdhPJwuwNaxLfixN0ALZYa9g89TwbsG4NFo4qj3NLznU81GLsZnSZTj63BtHuJInznHEEDSbtDlHA==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr7888100wrc.80.1591858775576;
        Wed, 10 Jun 2020 23:59:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm2595164wmi.6.2020.06.10.23.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 23:59:34 -0700 (PDT)
Message-Id: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 06:59:29 +0000
Subject: [PATCH 0/4] Clean cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bmalehorn@gmail.com, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the performance regression reported at [1], and also performs a
few other cleanups found while investigating the issue.

[1] 
https://lore.kernel.org/git/CAJB88a23uU2WfB0mnB9NfNbtgmABhNOWNOEMBt7rRVu7uL_C9A@mail.gmail.com/

Elijah Newren (4):
  dir: fix a few confusing comments
  dir, clean: avoid disallowed behavior
  clean: consolidate handling of ignored parameters
  clean: optimize and document cases where we recurse into
    subdirectories

 builtin/clean.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
 dir.c           | 15 ++++++++++-----
 2 files changed, 48 insertions(+), 16 deletions(-)


base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-806%2Fnewren%2Fclean-cleanups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-806/newren/clean-cleanups-v1
Pull-Request: https://github.com/git/git/pull/806
-- 
gitgitgadget
