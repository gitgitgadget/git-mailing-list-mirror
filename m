Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13271C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 03:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBEDq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 22:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEDqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 22:46:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69612F1B
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 19:46:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so8590467wma.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VIIfSI736xSBP7M45hg8nxOa99p+bhNWLDkYySGnSXk=;
        b=R9XnT6HOMrFb6nCOTyFAoMbo15WuhW8Vz9V2JNMymWYdYTzw7HZk7CUHtjktQ6Ju4V
         oUpj6OcV/o8nmmd8hysTswRv29dApJRIdTBbKuheKv8nEBiLZZ4n2hwBlisg9GvZislH
         2Bz/N56xHReHdpE5HFoztsc13pFHXra1XRk34GmzM48CRjmQTGtrmc9f3ASuoezYqFjy
         Pkyet+xxfj6MJf5Th3qzykXKOfnZB4hylGIjuw6aRFBPCgX1I5ZbsyLVPzRQaRi5L++O
         rHdwkvIzUNYGs+ayppBJYBRVhuGfHPgM4TY064EneXTAeCUefoEvc1cup4bO4wnUlt67
         erRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIIfSI736xSBP7M45hg8nxOa99p+bhNWLDkYySGnSXk=;
        b=apjqz7h6mwZv3mG19RwkakcXLuwLrhVY7q3mtsQFkAKUYZlrOn3kXbU5m5HpVEPrb1
         Gg3k2CeYYBu4L3UZG7SG7OhLnvlSXuDLDqAqlC9p2B2LX2OK/RKmnY4P/I/SutXrVY9p
         le5hhquEXgwB8QcZ4YHXSdf48lo1C/uzvKmzRokwVcJ36Yv2UroCNVuPovUQAqrn79n8
         0dH40xXjx0UHTR+E3w1nC/f0SUL5T7I61ZFTAnl7XPv2Az5BgaqkzNnrVNQi0V3gXR4w
         Lmu4wraOVfC1nXLMsV3uHWUZ0WMcFpx24q5iqcMNfxGeWvvIWFnboc8Wyg1Dn/fhGqql
         ocyA==
X-Gm-Message-State: AO0yUKVhl0ZFhzadsjgHDt+BROTogFIGEcmEE61857LoK/ppoLgFBeOP
        +JirQgn/yqshIqUvArvukVuSPo20Y2A=
X-Google-Smtp-Source: AK7set+CgbaemBANDWj6ILsebo/qZYAaa9YwQpnuf5sKZtMgVosersK1+bL5+DjZZECDGAIevPxwZg==
X-Received: by 2002:a05:600c:3556:b0:3db:331b:bd57 with SMTP id i22-20020a05600c355600b003db331bbd57mr14809711wmq.23.1675568782851;
        Sat, 04 Feb 2023 19:46:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n29-20020a05600c181d00b003db06224953sm6796945wmp.41.2023.02.04.19.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 19:46:22 -0800 (PST)
Message-Id: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Feb 2023 03:46:19 +0000
Subject: [PATCH 0/2] Teach diff to honor diff algorithms set through git attributes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository contains different kinds of files, it may be desirable to
use different algorithms based on file type. This is currently not feasible
through the command line or using git configs. However, we can leverage the
fact that gitattributes are path aware.

Teach the diff machinery to check gitattributes when diffing files.

John Cai (2):
  diff: consolidate diff algorithm option parsing
  diff: teach diff to read gitattribute diff-algorithm

 Documentation/gitattributes.txt |  23 +++++++
 diff.c                          | 112 ++++++++++++++++++++++----------
 diff.h                          |   2 +
 t/lib-diff-alternative.sh       |  27 +++++++-
 4 files changed, 130 insertions(+), 34 deletions(-)


base-commit: a6a323b31e2bcbac2518bddec71ea7ad558870eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1452%2Fjohn-cai%2Fjc%2Fattr-diff-algo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1452/john-cai/jc/attr-diff-algo-v1
Pull-Request: https://github.com/git/git/pull/1452
-- 
gitgitgadget
