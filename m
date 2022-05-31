Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5DC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 23:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348628AbiEaXMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiEaXMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 19:12:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7778FF9C
        for <git@vger.kernel.org>; Tue, 31 May 2022 16:12:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so60482wrb.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=54I663FBgT4zEggR1g2JmLapRz6e75EJzQ9mUOdIyB8=;
        b=HnqHML4ZAZ83PyRD7WttIhfi/e5KpfQyCXipqSsAECfX1+hhcKbc6/lflO5o3IBU/t
         MYeYtBebmIPoS+vGvnStUdvFTh2EQRsnwQNCAgDBT8fce0oc93xHZ5sSpI56TA9LEhD3
         GS1QmVn7NOlYnT1jzggUh7o1bqWsB+DlAIIJtTnDvUY7LUIzlvAnvrIVh8EXZvgS6xP3
         ciELluR7m0kg/JxHIJB3XqSM090gfASDZWj1RzXkkeP5czv27ZGvOXV2bEoGzjszMjhp
         XtUPEZwg6ApgBSb3+9rVNuUJ1gc7mN00nh3myD0fOW8cgpwmfC7R/LWfM5TTBr2duxRS
         LVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=54I663FBgT4zEggR1g2JmLapRz6e75EJzQ9mUOdIyB8=;
        b=qbAY3dwVjtYjqr2rqS1UVfrm9BXrDNag3X34ksnbflS7pIMEdagK8tqdOjoHOMSkd5
         Y/chRCX7MFSCATCNcvvw/H7UHTgwnWNZHORu9iIX1nrCkpN5Im2ccUsU2fA90q1uANkX
         FpaNIRggnGRUNVPSHYXnmRRpQLJjYqoiz45skQiWQ3H3DEFWks8LhQahYgODY/0No1LB
         b6nZm/wfjTRft0Nbhx6SW5sdBRIU2f/gduNPrkDcZWKCCnCO34qzw68iPEiVaJqbpNvf
         zSZeTCT+CIBYr73QQ5qRlvDKKm6U9u3nk/gS9Kb6kcOJebb8hkrDUhD7KFl08Ey8eXVS
         ziEw==
X-Gm-Message-State: AOAM532Quxw0zl0YTkND7UXuXBX8mYUI0ikIl0YZLSdvfB5NqqNSsh1O
        5Xj59D21dSi0DMKGsR9f5iaK+UNXRlc=
X-Google-Smtp-Source: ABdhPJwcA2oHzmSw+681og633n3SHRDj5QxxV1+Ug4rBFcEQXxpEIWrx3GeRH4NUul//MmO4UK4dnA==
X-Received: by 2002:a05:6000:2cd:b0:20f:d035:84f8 with SMTP id o13-20020a05600002cd00b0020fd03584f8mr40635811wry.263.1654038756242;
        Tue, 31 May 2022 16:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b00397342e3830sm5474538wms.0.2022.05.31.16.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 16:12:35 -0700 (PDT)
Message-Id: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 May 2022 23:12:32 +0000
Subject: [PATCH 0/2] remote.c: reject 0-length branch names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the regression reported in [1], where Git may fail if it
encounters multiple "branch." keys with no subsection, e.g.

[branch ""] remote = foo merge = bar

Prior to 4a2dcb1a08 (remote: die if branch is not found in repository,
2021-11-17), we silently ignored such keys. But that commit had an
inconsistency in how we read and write to the branches hash map, causing us
to BUG() (see Patch 1/2 for more details).

This small series does two things

 * Fix the inconsistency in 4a2dcb1a08 that caused the bug.
 * Make Git fail if we find such keys (because we'll never use them anyway).

[1] https://lore.kernel.org/git/24f547-6285e280-59-40303580@48243747

Glen Choo (2):
  remote.c: don't BUG() on 0-length branch names
  remote.c: reject 0-length branch names

 remote.c              | 10 ++++++----
 t/t5516-fetch-push.sh | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)


base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1273%2Fchooglen%2Fremote%2Fhandle-0-length-branch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1273/chooglen/remote/handle-0-length-branch-v1
Pull-Request: https://github.com/git/git/pull/1273
-- 
gitgitgadget
