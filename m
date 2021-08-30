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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E8C4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D036A60249
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhH3Otp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhH3Otp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:49:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C54C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v10so22853430wrd.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=L/qMdFIo7lhXe1I1Q+pUnpaEjzMEk7mF1X9zt2wZ2ZE=;
        b=OpK+Wvsv45STAUT+RHJxQ1R67+7K/U5YDY7ftKB9kmRaBXbQbzpiGnvERrHmZOMGXs
         yehd2GdPu8HOjiVJ/oWYB8nEvQch8DdnBDBzGKhQ7cTCk6ZIVI/KWqrajK/xElvPr89+
         Dy1qgEjdc/ACe1ouWsN+eNZbmJhkINwYaJhpwY29niYSrSMjBp+i+t+dXRgySFklQ+Yp
         ytHwasjTvgLtevQc+Dm6fdgVgXpTwLl+b1GBQBdhVniuqRAT95rWGNX3BImXTIbcyX87
         NbQITOw8PFqfh+tL5PkfQvObano1keByA5XcWGvrzAzv5jsxCJyvhBcgG+m5kUdR/hDc
         k+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/qMdFIo7lhXe1I1Q+pUnpaEjzMEk7mF1X9zt2wZ2ZE=;
        b=tptA+v2MxkN8uw+FLy+VIr3Wt9mRkO+LrqxNFFQ/yviDny1jwv7juA3ksp+M1fUKTL
         Oc1Xi0VDM31JFQHSdg1ajPL3TyrPIdqzvSmsvGF9KRw1GRN2B2Y2lnpD4cqiQ3Br714n
         Be+v/pdCKDcYEh+gISAR9tA0ao0VJNIFrHf68o6DRf+BvNa0+KwhiHuSh+wXSVpmrSI5
         rbNDpUOVOV36ZOjV2uKAgxus6n16EDUqUBLwRRlvPsvCwu6rEJO5l0SJ06NsdaIfgF0Y
         141eFrC4xmzCorw96ITEk31s/nsJdOd4BMrJu1j/0Q25LfScY6SfYygE9hkfFNtimvQx
         2OBg==
X-Gm-Message-State: AOAM533ujfD4gFD7EpW6ePbQw+ibb85B7r/xlM/6YblbpMF3pCZqI66G
        sJ4VHAkrMj3+sTTs6uzIT5njQbfh3RM=
X-Google-Smtp-Source: ABdhPJxG9vd5JTVs/g2ZWOQDc8KuHsqaviI0IpR3l8+qWCKuzvzR62ewKgbuxI8EvpFv2cWqpXsszg==
X-Received: by 2002:a5d:456d:: with SMTP id a13mr26385327wrc.364.1630334930032;
        Mon, 30 Aug 2021 07:48:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm19087167wmc.24.2021.08.30.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:48:49 -0700 (PDT)
Message-Id: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:48:44 +0000
Subject: [PATCH 0/4] Gets rid of "if reflog exists, append to it regardless of config settings"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in
CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com

Han-Wen Nienhuys (4):
  test-ref-store: tweaks to for-each-reflog-ent format
  t1400: use test-helper ref-store to inspect reflog contents
  refs: drop force_create argument of create_reflog API
  RFC: refs: reflog entries aren't written based on reflog existence.

 builtin/checkout.c             |  2 +-
 refs.c                         |  9 ++++-----
 refs.h                         |  4 ++--
 refs/debug.c                   |  5 ++---
 refs/files-backend.c           | 25 +++----------------------
 refs/packed-backend.c          |  3 +--
 refs/refs-internal.h           |  2 +-
 t/helper/test-ref-store.c      |  9 ++++-----
 t/t1400-update-ref.sh          | 21 ++++++++++++---------
 t/t1405-main-ref-store.sh      |  7 ++++---
 t/t1406-submodule-ref-store.sh |  6 +++---
 11 files changed, 37 insertions(+), 56 deletions(-)


base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1067%2Fhanwen%2Freflog-touch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1067/hanwen/reflog-touch-v1
Pull-Request: https://github.com/git/git/pull/1067
-- 
gitgitgadget
