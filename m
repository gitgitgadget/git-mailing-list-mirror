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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4787C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9828D6103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhHMNID (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 09:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhHMNIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 09:08:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBAC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:07:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q6so1705301wrv.6
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=IzGEFQ3UkOqyspMbojygPPDLhbgrUZIzc3ESyv0RskI=;
        b=Esptq5p0soiBF3TDG4qncgPaWUWFJwF4qBNpFcLEfeC+YXfSCXGO6zTR/f1UKIIiPP
         vzoJEyspZPnS4F3bHpa/Qu7HpWFkqKT7nOC/TGoOG1jyp5N68SHcd9Tsi6osKRXIr/y0
         9HwMNU8zVT72/FB3VSXjpDKuICA1VvEAPiMSnWhuIy8UjP3ke2vvrrRlhjwofEq/6DL+
         pUaEfHx2iMXy1TQnVypAM1Z2SbHHAfhS0QR3k8BslU6IuKnMUtdPAaFKmgIErNiWug5p
         lr0C1E5YMS+epOmUVKzBfv08DpiR5hFVtU5ehX+sDVaw7ED+gogl1iUgZQO4u1CpilcJ
         Rnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IzGEFQ3UkOqyspMbojygPPDLhbgrUZIzc3ESyv0RskI=;
        b=Ry4/ZfdR9KPdGdav4PMDXDrL3AowqZtSYCkcjFggajSRlE+mko7RiGxHuuke1n5Sk6
         e77+f0NijfkexTNB7D9KmYuF+XSLShf6fGSBjOBj7H9/brZRBw58EG/gQMaM0e+9FJNP
         GfR+EVxcAYu8gc5NvEathgLTMTAsQcWkFC4Rfmid0BPorponBqJNafPW1VLMT3xEnFfa
         elnIr/5q1g2XYfuVQES3x/gfHwK9GRtaFdE4coU69Erc4qlG9VlphjzFBTtu2/MXrUHM
         7N7u+Ix+Uq48PytKmXK6dvu0EFdfmHgb0bYd1+das3n6Q4wAy0U+xkCJxzirzd8LDzwk
         GgOA==
X-Gm-Message-State: AOAM530pS77e2TygO73rx6/8mqN67Bt21LQ2TFw8xGF80DlEgUFJjnt2
        OtmXUV/R+jcbfec5M3jao21PRjYI8No=
X-Google-Smtp-Source: ABdhPJwqtiu1x6Aa8cslJ90iNLZXAr1RULb6/o3suBWgOJ9QGyzYmw6c6FWGkvI34MzPBaRi5kHhIA==
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr3153132wrt.246.1628860054455;
        Fri, 13 Aug 2021 06:07:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm1457278wmq.29.2021.08.13.06.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 06:07:34 -0700 (PDT)
Message-Id: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 13:07:29 +0000
Subject: [PATCH 0/4] rebase -r: some merge related fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a collection of merge related fixes for rebase -r

 * Make merge -c behave like reword.
 * When fast-forwarding a merge don't leave .git/MERGE_MSG around (reported
   by Gábor)
 * Make merge -c work when with --strategy

Phillip Wood (4):
  rebase -r: make 'merge -c' behave like reword
  rebase -i: Add another reword test
  rebase -r: don't write .git/MERGE_MSG when fast-forwarding
  rebase -r: fix merge -c with a merge strategy

 sequencer.c                   | 106 ++++++++++++++++++----------------
 t/lib-rebase.sh               |  56 ++++++++++++++++++
 t/t3404-rebase-interactive.sh |  13 +++++
 t/t3430-rebase-merges.sh      |  38 +++++++++---
 4 files changed, 155 insertions(+), 58 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1015%2Fphillipwood%2Fwip%2Fsequencer-merge-c-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1015/phillipwood/wip/sequencer-merge-c-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1015
-- 
gitgitgadget
