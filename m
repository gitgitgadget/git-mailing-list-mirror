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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DECAC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B08F60FE6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhIMLIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbhIMLIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:08:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0235C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:07:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso6619873wme.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=aSPnRDY1QYqVh8j8bp7hOHoqqyZTMNeH7iIbFe4Y4o8=;
        b=RvKkLuLTDWMpkol3fRvP19RqzGNL+j5vIJyb7OWhwlyR4p2i8NWftSKBUlepNREoHg
         OnOQcA2Ky93cvv/R/flSWKCcS24qFVv50EGlTdMykmdKOHaUPK8m5CaWon4MgeLuZN3Y
         oRnEZro/N0CEtMy/IV+VVW2zCIP2mkBFz9Wa2qUa+xYXmMjJBa0CdDIyNU8ZMo8WWEAP
         d3EOlu8xlmAcuc+nIxfbiqC8wpU5plPGUplg/zWUgzMOi/DyNQfQcmwnulg1xCu/EvpL
         siFQTTJlYXGGQVx7cpjjct4Kg0SDnV/BvV5lqv9B1Z9NGrPGIzfJQvSj0BpAtiP9ymth
         MUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aSPnRDY1QYqVh8j8bp7hOHoqqyZTMNeH7iIbFe4Y4o8=;
        b=6EfRdATQuG86ALN8GlZHCXY+NmHWwZd2CIJrv5CPN2+Nx+eRyE3Oz9Qt+naEwrcBke
         P7lQ6mK4XIguQ+ZRMUTjGrVaTeM1ylZKw+dwuSPSGo1uJ7YVIj1M5DIpxNc/TXxD3bkx
         f2Nnrb8N+gQcIKQCL7UAvAEbffumy9G4tEH/7Zc73cAHIC4QTWx4b/hD0HZUvATemvBJ
         K8jj6qZvTlu2t+FBE/CCP1+eDSnxXRG3fnEODBXztfXCdQ505yBDikywMCneuX3/NgDc
         AoxR+oG+4qBgEFuYw6DcWICuSc7i7AfeliRQeeepS/1KjSFbelki59WfoXiBLqAMcvv5
         MxBg==
X-Gm-Message-State: AOAM531pQN058fv+ho5jQ7IEuW0eBpiQORWH+qX+ohl/MAy0JwCLwV37
        HIQcyzMUWV3/qxVEMvb1YMsHiGkEK7M=
X-Google-Smtp-Source: ABdhPJyU0Hv4EIxucKj4yQ5B4m/yI1luf2fABbbQ1Pbn86uMidw+R79G7+R1rSn1Z55Q9/E9dZR2NQ==
X-Received: by 2002:a1c:2943:: with SMTP id p64mr10478242wmp.107.1631531220202;
        Mon, 13 Sep 2021 04:07:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm3739343wrr.10.2021.09.13.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:06:59 -0700 (PDT)
Message-Id: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 11:06:56 +0000
Subject: [PATCH 0/2] documentation: handle non-existing html pages and document 'git version'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches are grouped as one patch series, because they arose from
the same Git for Windows issue [1], but they can be reviewed or applied
independent from one another.

[1] https://github.com/git-for-windows/git/issues/3308

Matthias Aßhauer (2):
  help: make sure local html page exists before calling external
    processes
  documentation: add documentation for 'git version'

 Documentation/git-version.txt | 35 +++++++++++++++++++++++++++++++++++
 builtin/help.c                |  9 ++++++++-
 t/t0012-help.sh               |  7 +++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-version.txt


base-commit: 8463beaeb69fe0b7f651065813def4aa6827cd5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1038%2Frimrul%2Fdoc-version-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1038/rimrul/doc-version-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1038
-- 
gitgitgadget
