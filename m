Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DDC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9742061B42
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhKQLX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhKQLX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:23:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E3C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so3552402wml.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qGlANm+fT9VNAob2v7ft2SxczREG9TVZTPfkIxuZBpA=;
        b=nqEff+XL0SnlAiTWwhmn3GJaRz7u6jbJcWc/pkYwk2W/WtXNpUfOxuiqeI8By1JMXC
         m+F8Ncri1IBES2MZ+FUB90yN0L3Hj6+XzGrJ0ajRf9qcQR+EHm9wsrXG/cXHBEoKkHos
         RN+h7D3TNEB8VcHEd1X3pgVRJP1oHTw+p1We/G5hk21KchtLw5FM5aMNsVhAVNJW6fOj
         G9SZYhl541IMhGv0q9O0aTzp6Pap67ebBCopL7IBpEwngYes4oVLs1uxsKsi5Sr9aucr
         8IuXQ3h73VMeHJz/uWRHgeucCh8KIRH+TUWtMznykhhe8A9VRfzgYw5cJ3jfNSRH87p6
         HNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qGlANm+fT9VNAob2v7ft2SxczREG9TVZTPfkIxuZBpA=;
        b=uEfB45T2YEPnCChtC54OnOCiB5f/qVWJO7HUnz1gLRZfD+UwEjebX13qPmJf6TMyd9
         Mx6vKKoksAGpLKWW/3XtebMZrzYSWLMsRnKBBHxzqyAl1xrtzu9xCgi4jYgDDHE2Rmhl
         JH3gCFHkId6O5U9CZtnu6a2+UL5eOVkF9u8+X2LRe4EtAM3Tww+nHtgim+ZZDQkoZVF5
         gBwfUBGe8O913+ff4hrVxnrmtH6m67xheYTbhTKu3sl0saIHgNutbsVYzgemjp/ZaSpw
         iH8Dgt1tfxRLBWk/s7qWqDYehw/WcX/Ds55bqE7jGUhH1iVAZiu42xPIgfqWGi2e8KB4
         6TVQ==
X-Gm-Message-State: AOAM530+R4WrA9CjI1DezI7Ufmc/hA88mmuwVryKAknUOAD0U0bbRhij
        HYtl8Ov4/uQ+rkjeNeWfL+iOQmSrOTU=
X-Google-Smtp-Source: ABdhPJzHFSbNgkbSR+vqphu/PEIUc0O5LFvAwqDHOFmtTz2S3nN3szVrxClysQr05KAk1EXlWyE3nQ==
X-Received: by 2002:a1c:447:: with SMTP id 68mr78737976wme.69.1637148027176;
        Wed, 17 Nov 2021 03:20:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k187sm5192008wme.0.2021.11.17.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:20:26 -0800 (PST)
Message-Id: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 11:20:22 +0000
Subject: [PATCH 0/3] xdiff: speedup histogram diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Histogram is the only diff algorithm not to call xdl_classify_record().
Calling xdl_classify_record() means that it is not necessary to use
xdl_recmatch() when comparing lines, all that is necessary is to compare the
hash values. This gives a 7% reduction in the runtime of "git log --patch"
when using the histogram diff algorithm.

Phillip Wood (3):
  diff histogram: intern strings
  xdiff: avoid unnecessary memory allocations
  xdiff: simplify comparison

 xdiff/xdiffi.c     |  5 +----
 xdiff/xhistogram.c |  5 ++---
 xdiff/xprepare.c   | 35 +++++++++++++++--------------------
 3 files changed, 18 insertions(+), 27 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1079%2Fphillipwood%2Fwip%2Fhistogram-speedup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1079/phillipwood/wip/histogram-speedup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1079
-- 
gitgitgadget
