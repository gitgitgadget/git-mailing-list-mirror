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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C7C433E1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2061A2A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCZWNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhCZWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 18:12:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0FC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o16so7064276wrn.0
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YnuYvr9aj0HCHaXB+QOVOSGhueMZrichoFn61B10LOA=;
        b=N+OFKc0hDdFbgl/Ao4xS6HbfAJ0aBGoOxX+TSY59+J9bfxHdh3+yRyaWJ7ZUQHq/fg
         3Y6RZIPucQshHhBsfDyJ0m8+1kkRJ0bBYTH2pL3/SBa6sYyukLwKGAJofOzd2Y/2gTSw
         R16LOgHY80e96azb9dNRyl/TFU3suI8G/h2brGymV8yDMAkYOxCU/trmvsf+SjtvoC/E
         Az4L9rAJ9z1wsV80F6KkoogRHUtJAyzaew9kKpmHALQvAvKB4MPpUuP2sCUQwAKlCCCn
         LrAONgThrrO8usNk5bZmBpo7A6ZKt2XEdkKIuvJApr5thnQmQh2lAq9SsiZZjSq3mj8n
         mn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnuYvr9aj0HCHaXB+QOVOSGhueMZrichoFn61B10LOA=;
        b=jAyHoksLbHqSj3W7Zdn1IZrmptSvlBtJbDpet10u7qx7TJPlBPluxeg/OB25Op7LeR
         DLyQYCt2iKNrwqrwBTvce05M2nPHSJaq8rvbqN6ugWiyLKQbTBg8pPta9fZKw8EHUGEw
         YdYDefG8PwLiCNNQbh286OtLZTQr6l3pSeON33NNVTM43W63muYKXq9Du42uWy6IVlIc
         DqH5o5Hkot8uBABCflHbbeQbNmFkMGmsP1VlLLqqrmmdqoVic/QRIkq3WwPNrZymcoyL
         CjKg/bQqnY91/HFdX1YxEprlWsCi514OjrdNUWvwwbk2fRbhuSDNeyhYRtW8ct+zyQR8
         fl1Q==
X-Gm-Message-State: AOAM533TXRNPgcFMgY/+s1UYWDlcwouvlumS3euAUpS0Mpu6nHFydylo
        Y4Mu1XacU/m1M9nu9N3MDdChGYX2yMw=
X-Google-Smtp-Source: ABdhPJzN7+OnOG5jvO4+w3PW/ePwuxo5wqmT8xyZKhYahsGblDZVajRad0nMeqwIcvVLrnqsKEOEVw==
X-Received: by 2002:adf:f742:: with SMTP id z2mr3009103wrp.130.1616796768531;
        Fri, 26 Mar 2021 15:12:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm14436995wrw.69.2021.03.26.15.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:12:47 -0700 (PDT)
Message-Id: <pull.917.git.1616796767.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 22:12:44 +0000
Subject: [PATCH 0/2] Describe Git's security policy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On GitHub, SECURITY.md files are the recommended way to describe how to
report vulnerabilities, and to set expectations how far back maintenance
tracks are updated with security bug fixes.

For example, when navigating to https://github.com/git/git/security/ users
would be guided to that SECURITY.md file. If it exists.

The purpose of this patch series is to add this file, describing Git's
security policy.

While at it, I also want to document the process how to coordinate the
ensuing embargoed releases. This is what the second patch is all about.

The reason for that is quite selfish, as I did two of them, and while I am
happy that such embargoed releases do not happen all that often, the
downside is that I keep forgetting all the details. So this document is not
only meant for knowledge sharing, but in particular to help me the next
time(s) I coordinate an embargoed release.

Many thanks to Junio who reviewed the first draft of this patch series
(where I had not yet separated out
Documentation/howto/coordinate-embargoed-releases.txt).

Johannes Schindelin (2):
  SECURITY: describe how to report vulnerabilities
  Document how we do embargoed releases

 Documentation/Makefile                        |   1 +
 .../howto/coordinate-embargoed-releases.txt   | 131 ++++++++++++++++++
 SECURITY.md                                   |  51 +++++++
 3 files changed, 183 insertions(+)
 create mode 100644 Documentation/howto/coordinate-embargoed-releases.txt
 create mode 100644 SECURITY.md


base-commit: e6362826a0409539642a5738db61827e5978e2e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-917%2Fdscho%2Fsecurity-policy-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-917/dscho/security-policy-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/917
-- 
gitgitgadget
