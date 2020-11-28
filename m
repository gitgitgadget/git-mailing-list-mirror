Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3988C71155
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9220221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyIXq8gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbgK1Vtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732477AbgK1TAb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:00:31 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A8C094240
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so8272368wmb.5
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JTsGwgIUMDhO6BP9Ef4dzJb1cRNLj757n0oUXN5rYpU=;
        b=OyIXq8gjIEkONuPQJNl55S9LTn46HRvK/eEj26ytZVi7uCp+GEbTUL7fdmT4KIkSun
         a+bFavDg5AcpPDTzCAyvpW/e/eHk2N+83PyBpw5hJ6dBKeypBcx8knnLzPYML/qCdxty
         6msZ/abNYAph3n/LDM46eMNEoo5Gv/9bBpFzWPYI7IuQ31MufDnyQ+9V4Nr62xV8voHm
         WgUbMb+ZgZMrFtBVfhgnKms1HXbY9HYPn28uBkcWnYTOnzYy4PhztzCECHmQ2cH7t4Rf
         8jEmOuJy261NiwtfjX8clx5a9SuZaffiMf8AcZ7Vjl4r+T/jaOO8YsnSRYxa0iTRMY92
         S13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JTsGwgIUMDhO6BP9Ef4dzJb1cRNLj757n0oUXN5rYpU=;
        b=Yu/1uqroaY/biiYlt6ILOecL2Relmu3bCmvuRYhOQKGnn5zX6zdDH2O+k3KX0Z1tI9
         EY9wRlv2F1s0E5cm3u/J5y5p/jqC9DSn02hhsk9kEKjMg2koAaBtlTrAjt51/Du+0dts
         vthUpbl8/eCho+cPodnKRDpJxndxGfqbOVeEJYBJWrKbZKXo4ZtiJWnDaHHxjqIZBbvb
         u9vepTQ2I255skW2DzHw7UFZybkkvITTsfV8HPh27kul+FrJZcdDOWxmAl5lFp0+5V3T
         OCNVoMI8okzpTa/b+xczD4BWMMCuuwAw2mRxZLkYp48KUv2VQMvy2EK/0HIPC0rN1QMV
         7Lmg==
X-Gm-Message-State: AOAM530SnHuC8gT2sSeToJb8Ht2mh1ZtCvk6u6aa9UoOqBR/CycOViqg
        T14XQb2YT7qu+/tKDs+j23NqyhLRn6U=
X-Google-Smtp-Source: ABdhPJyJDkVhMnD4TGkQ6d73XhUULPZzu3FyBWbGtOdrJjSMl3/tubIBnNdipQHm/zxMVeWdu4tEAw==
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr12584852wme.61.1606545879850;
        Fri, 27 Nov 2020 22:44:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm18231632wrp.57.2020.11.27.22.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:39 -0800 (PST)
Message-Id: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:32 +0000
Subject: [PATCH 0/6] Minimal patches to let reftable pass the CI builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches fix the PR build failures at 
https://github.com/git/git/pull/847/checks?check_run_id=1460683728, and are
designed to be squashed into the 16 patches of the libreftable v3 patch
series as submitted at 
https://lore.kernel.org/git/pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com/
.

A smaller form of the first patch was offered on the mailing list on May
4th: 
https://lore.kernel.org/git/ff60fde10919b6b8c54ecb8f38b710fac37624e3.1588599086.git.gitgitgadget@gmail.com/
. The next three patches were presented to the mailing list on October 2nd: 
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet/
, and 
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet/
. Some of the patches required slight adjustments to accommodate for context
changes.

Going forward, I would like to avoid the impression that it is the
responsibility of the Git for Windows maintainer to keep the CI build
passing on Windows. I am happy to assist in case it is unclear how to fix
certain issues. I am not happy having to implement and test those fixes
myself. How can we ensure this doesn't happen in the future?

Johannes Schindelin (6):
  fixup! reftable: rest of library
  fixup! reftable: utility functions
  fixup! reftable: rest of library
  fixup! reftable: rest of library
  fixup! reftable: rest of library
  fixup! reftable: rest of library

 contrib/buildsystems/CMakeLists.txt | 14 +++++++--
 reftable/dump.c                     | 36 ++++++++++-------------
 reftable/stack.c                    | 37 ++++++++++++++++++------
 reftable/stack_test.c               | 44 ++++++++++++++++++-----------
 4 files changed, 82 insertions(+), 49 deletions(-)


base-commit: 6229da992e43f4a2d6f4ccaccf2dbbdf11bd5a4a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-801%2Fdscho%2Freftable-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-801/dscho/reftable-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/801
-- 
gitgitgadget
