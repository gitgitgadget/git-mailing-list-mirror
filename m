Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B45C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E99205CB
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWN/1ZNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHLHMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgHLHMj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 03:12:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40309C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 00:12:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so856533wmj.5
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AmKxZoiysrajewlB3VfBcY+qGZ0hlZlnw8B132RA6no=;
        b=XWN/1ZNv1ah5wqM1dsxHLLGEzsqm5nNKO067+AxkhiaL5ufy9d7VC6+NanSv07AHLl
         vOJFZiXyx28Mjb36gC42G2Td9hs1jyGUh0aYcH0jhiYyMWw43icHeaBRmve7OQH1uUSo
         YjkyCgZddPtpDu9JJ8Qso4fd3KqmlBJ4CaMwo25cbaZdz/zsPPXL3LEdU7ASpTNlXZFT
         gsU5rX1wUZjG3RpbNtI2nbqz9WUgBsR/hrpX1BVXHBeiZEjQmKlpqPcGkluHpwuisKQT
         atLLJyPmEccDIdkGtTMJN4mANgknDgoI8Z2VOU8LIeyGHjiHClHYm+LmJ9E6P+ZBKp4q
         TIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AmKxZoiysrajewlB3VfBcY+qGZ0hlZlnw8B132RA6no=;
        b=sPEVJP2iI8qY9J9e/YIOecAGtNnSTx63/iMKz/SaO8j2zSSxjtsfQ26j46Dh1KCf1R
         wEk7wqjUWga0UtKAht7Xvkim9EQxiUw5KZgKn/5hNbkqLkHvFpCfJnCmUKRANxxfOB9d
         /s705Qkg1jbXVKb2LkdOzpmS6VXD0UQK2NVIto6vnrTb9r4BNNzJ7xywKi3uBdTQz3vQ
         OaPIv3j6xcwXo+6toFWwsXw3VM1nGYlzbSm3JSW98it3voZ26LnMt8sM3CHCt7XZ9Kqd
         uLOzHBnULUusyshbUXNAObCOzjPBOOr//J/lMvDAefheU5wceHM8lD617eE3Sh2um09h
         o4Sw==
X-Gm-Message-State: AOAM530yL8dS08cNJcQHnh9CN+jJTMnUQzeXyBnUxKqNUjaukJgm02z2
        ocYDMZ1zC2oRbW2bGUK7FxDps1di
X-Google-Smtp-Source: ABdhPJwEOL7zQu2e3s2f/Nhnu/65iNDQjWBJS+GfX41bJkQrRdLAKRND9/oIhCHDfjg/zhugd7fO2A==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr7017866wme.171.1597216357885;
        Wed, 12 Aug 2020 00:12:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 69sm2401502wmb.8.2020.08.12.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:12:37 -0700 (PDT)
Message-Id: <pull.829.git.git.1597216356.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 07:12:34 +0000
Subject: [PATCH 0/2] Fix handling of matching nonbare repo vs. matching something under nonbare
 repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the issue reported at 
https://lore.kernel.org/git/CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com/
, a regression in git-2.27.0 (that wasn't reported until after 2.28.0). It
involves running ls-files --others with globs when nonbare repositories are
present.

Thanks to christian w for reporting, and Kyle Meyer for finding a way to
simplify the testcase and bisecting. Very helpful.

Elijah Newren (2):
  t3000: fix some test description typos
  dir: avoid prematurely marking nonbare repositories as matches

 dir.c                      |  9 ++++++---
 t/t3000-ls-files-others.sh | 24 ++++++++++++++++++++----
 2 files changed, 26 insertions(+), 7 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-829%2Fnewren%2Fls-files-wildmatch-nonbare-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-829/newren/ls-files-wildmatch-nonbare-v1
Pull-Request: https://github.com/git/git/pull/829
-- 
gitgitgadget
