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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35406C07E9C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1683961C3F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhGFSuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhGFSuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:50:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A4C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:47:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so157212wri.4
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=n5qLaUMeK5S5gtxhi0SyR5tEs9tz8fd3st+uTiZjUUg=;
        b=WcYbIxpbNkJ34SQESS/3ZCOX7k2syB3HwgxCerb1UGTey5JfXVbJkvuZLPgmEM3In9
         ovKsczlFf7JXYs2ij89y93zv8ZMCkYNZI3EOfauayHgVzRCeJM7myPZDX3XY3Mc7HPaD
         wIvWIZy/Rj8FVXjOyXRCgOuIisvpVj9X1Li9mLaUgQxZsIjGRcQt4PYjC1G/kRgjSOQp
         lcKRDsI2f4PtkjxLaR+MkLCkFYiTKci1oeWm5T2H5PIldUDqeAjoIWc1ot1t3SFsHBCO
         VhL1fWViGYRj4++aCqJGwqSgQk34lVvCnZ2qrQdeSNa6PqH22stqU6wks6Z3mleI4Ynx
         GMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n5qLaUMeK5S5gtxhi0SyR5tEs9tz8fd3st+uTiZjUUg=;
        b=mdxRQZIlenT/Hw4Njbo8ys9UwmXDCrIyhtniSOYCdWIEoG4J5Xe6sm6LlqwKGAXrB1
         Wbj0SybHJHs8Nfp96TLq9dKitQxkha9Tme1eNpOu0MVYB8kjTsStzhURDUnFNngA4G0J
         v+w9AiCK1tvIis3Dtqp8cLgyzQloO9KpOePcyk0KdUmx9JaZA+jZ6WG5BI2iAFue1D59
         p8ThdXf7e28gWgPr/B12cwRspkYTFwLEL1R7dzaNl4kxwkNbUV/b+OcGA2so4Ei0TGoZ
         sHHrBSAWzMWopKzeNh6CMSvH6lTTclBuXdTeV69Y80AOFNblaw1h/tRrOxDej+AyKnBB
         cI/g==
X-Gm-Message-State: AOAM532yU4OabYJ9hqCyJHmS9EIE/sIiqYkAepaZ5wPivqjwuDD5HOWA
        /mG9fab1AtGGImE7+phxYxovD8MgVLI=
X-Google-Smtp-Source: ABdhPJyNtP8GIDzoSo/e+qau+QhHvZKtSS2diVgQxp2EXbUsx6DWHX1d8OrsYT6pE+G40Wb0dHa6oA==
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr23508154wru.240.1625597278477;
        Tue, 06 Jul 2021 11:47:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm13508164wrx.60.2021.07.06.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:47:58 -0700 (PDT)
Message-Id: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:47:55 +0000
Subject: [PATCH 0/2] fix 2 more test files that were accessing file system directly.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduced the number of test failures in the reftable series by a bit.

Han-Wen Nienhuys (2):
  t1415: avoid direct filesystem access for writing refs
  t7509: avoid direct file access for writing CHERRY_PICK_HEAD

 t/t1415-worktree-refs.sh     | 10 ++++------
 t/t7509-commit-authorship.sh |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1042%2Fhanwen%2Freftable-tests2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1042/hanwen/reftable-tests2-v1
Pull-Request: https://github.com/git/git/pull/1042
-- 
gitgitgadget
