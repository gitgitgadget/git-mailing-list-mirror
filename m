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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB7C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBA823A56
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbhAUWWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbhAUWVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:21:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C84C061756
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d16so2579269wro.11
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+PolgLVvOKcX5E/bN0McZeXHhlcwFDYWyeoEoo1QBlc=;
        b=OMHrrYsRkPzowjLISpEDKayORoJ4HC8OnOCF23THmMFxRbd9b0kEzVkST6LqTky7uk
         Ra4oHZ772bZujv2bIKt1B1uAq52+poXF/LWQiTj9ar25dkxat28s/Dqp1jHJP/YqyOt4
         0FaM4H5BlBVic2Gx8Vom7IdbFzuMBlziX9XGXL9WNKRu8suvB7sq4nQGrJ/taJ1nfFYn
         o6b0VnbRZZjJqAo4X5g95SeVz5sy/FA8by5knS1Pr17VCWMh2eBhzu96DLD1riTXskC+
         PDvL9EBOd2WLVItrGdRKuhP+ssb0F7eFyX8pwtnFl5shdWlahbeerk0aGOwDo5Z9dszs
         FWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+PolgLVvOKcX5E/bN0McZeXHhlcwFDYWyeoEoo1QBlc=;
        b=VdMr4ih+M3ILTfD5tekFjCV/JpopVYqrHmyiqHE9W81CrI6QvFr8ikzZFM51odN9dE
         TsK4gXH7n8xGsEenApmNTm8yGUKWWUM9RVKBrlYucWzVHAIRZU/Hy1pwhDGJ74nA4PqF
         sSlRwuuNWUqR8//W9luQ5aSP6iV8qm4p1V/4U9F4vA9s5vCvL2HeauL+lmp7EL31X88i
         JMjHjAodO4bMxCM9J4xfG1jQtXHwhTjYeGyC/It2BArB0YNHxxl2EMZk3oXuX/xVT95K
         FerFcdTYOp1PgP2ESQkzYPycsGOML3aVoVBfWhgmA/CqWJFCNVzUQS95D94tkHDxIcsO
         tptQ==
X-Gm-Message-State: AOAM532o2L1RgeZstRlw5sIKFQHjiaoYYzOShcnKM3zbepEx1otB/AY+
        PWX7MbxYeGcbfz3JrlGQebETIm6gW+w=
X-Google-Smtp-Source: ABdhPJyj/7Wg99aN8GRuTzSLt/Ou+8b9CHfCcnZpzCLTUB5rcb0XpvBYJrJHIpzI7MQteZwPrSCuhw==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr1451523wru.206.1611267640230;
        Thu, 21 Jan 2021 14:20:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm9483996wrh.78.2021.01.21.14.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:20:39 -0800 (PST)
Message-Id: <pull.841.git.1611267638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 22:20:35 +0000
Subject: [PATCH 0/3] Range diff with ranges lacking dotdot
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In
https://lore.kernel.org/git/20200306091933.mx2jmurmdnsjua4b@pengutronix.de/,
it was reported that git range-diff does not handle commit ranges like
rev^!. This patch series fixes that.

Johannes Schindelin (3):
  range-diff: refactor check for commit range
  range-diff: handle commit ranges other than A..B
  range-diff(docs): explain how to specify commit ranges

 Documentation/git-range-diff.txt | 13 +++++++++++++
 builtin/range-diff.c             | 32 ++++++++++++++++++++++++++++----
 t/t3206-range-diff.sh            |  8 ++++++++
 3 files changed, 49 insertions(+), 4 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-841%2Fdscho%2Frange-diff-with-ranges-lacking-dotdot-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-841/dscho/range-diff-with-ranges-lacking-dotdot-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/841
-- 
gitgitgadget
