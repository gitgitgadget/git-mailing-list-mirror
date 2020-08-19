Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22FC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0AA206B5
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiwOtYwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHSMwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgHSMwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 08:52:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E65C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:52:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so21407654wrc.7
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pdKHxpxjj+zK+hlAXyBN0jLkA8i5WDn+hf50HX73oOg=;
        b=tiwOtYwR6JyL0/+vORw2GdyMzhbCFrTYXYOxJAdu5R4Uw/vMvgmD1QIjsCbXRita+c
         XoawYUeUhfY3wd/kazSPIuiFSEqp7KUZCMRavkCAPQ4thIWrHyXNnZK3lti0wXZNEdU8
         38HJKrkgZfR2Q6j7TJWZ8PdB+Nl8Zm2byGbYpGuYRfZhtnIokfAvZpdheA330kxDmfK1
         PQAdREXSQ1w5i2fCTg/wJDse6LugjSJnRwEHvnLgVVUwH4wwMNgtalnSnU6AKFZ2L43x
         w5cgo6Q3mVqrooWwfP8n+yLqGkDhaZIj4GEyE+THsvf6meAS4lcGnkS3GyUie9Seweab
         xOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pdKHxpxjj+zK+hlAXyBN0jLkA8i5WDn+hf50HX73oOg=;
        b=E+hzO0gVW61laTRO74b/F03kXE7Vc2VDm/5AInbUXBZgOBODLG8sX6jX2h+f4sCi2G
         /alRa9BrxNmt7jxCWgbVEsIpD9ntEgcBdlyk1zZVq8tZVUp9BG/HC+s/9fAzwtIw//8a
         U9yXMS6TF+ezUi+0o59dUBtb+OVz9Tc0uT7FgHXxY9a0toJgbgAYd8mgm+ASBvVDXFde
         zmL9r2QOI5fiOFL6zzRjNIV1C1fg2qTFtksP3Zh30AJYPFFKxEroe1f11iDzZiYCeVcv
         5R2rRsq9EkEs/DmbR4lCVbxztHrtMDAmq9chuy5PYd3bnyqtIS40K4MH0Uh+vCC7oP1Q
         JeMQ==
X-Gm-Message-State: AOAM532KEbhzrkyUJLztB/BwnRkTi/0gumrMfEXzvdvboyIxFMnQjgWD
        7Iu8pGnnmg0b2zWcAeTzch4CrpkChSw=
X-Google-Smtp-Source: ABdhPJz13O1Lk5DqAIoEzjZ78oLRlebRiTAu6x/GBe0LhnbRs2zus3MnY774op1gOdETuzVPi6ajug==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr24499862wrv.248.1597841552676;
        Wed, 19 Aug 2020 05:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p25sm5259413wma.39.2020.08.19.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:52:32 -0700 (PDT)
Message-Id: <pull.707.git.1597841551.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 12:52:29 +0000
Subject: [PATCH 0/2] Fix trailers atom bug and improved tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a bug in 'contents' atom. It does not show any error
if used with modifier 'trailers' and semicolon is missing before trailers
arguments. This small patch series is focused on fixing that bug and also
unified 'trailers' and 'contents:trailers' tests. Thus, removed duplicate
code from t6300 and made tests more compact.

Hariom Verma (2):
  t6300: unify %(trailers) and %(contents:trailers) tests
  ref-filter: 'contents:trailers' show error if `:` is missing

 ref-filter.c            | 21 +++++++++++++++---
 t/t6300-for-each-ref.sh | 49 +++++++++++++----------------------------
 2 files changed, 33 insertions(+), 37 deletions(-)


base-commit: 2befe97201e1f3175cce557866c5822793624b5a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-707%2Fharry-hov%2Ffix-trailers-atom-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-707/harry-hov/fix-trailers-atom-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/707
-- 
gitgitgadget
