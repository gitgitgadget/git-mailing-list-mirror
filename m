Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AEAEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 18:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjFNSqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFNSqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 14:46:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0CF2120
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 11:46:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25bbaa393aaso2731677a91.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686768371; x=1689360371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwfRYH4UJ8AOWuRFnWsHLV+N3Zv2LfZyE1H5R4Y+eMU=;
        b=3689va4EH3KgWHhCSIy9E5hjHCLNhyBJr2gCp/27+7K7LE8cQ2XdFMaqQOVC856IIb
         MTm5EuBvabVR+Qm6IqK4DGtGY1sxtLBnqsI+6Lv75SSAnUAc9GCdaLjSNmDPKZXKHiZ8
         /WF5D9ZGt98p5n7M4kvU2zSZjNqa9MV/xIzaotZQBiapsnYiXMGuZwqj/pWln8N3rykV
         lXLQFeiZaXJUBt0ML2Bpl3VBBED+BeEyv7Z0zrDycIY54AVA2E/51AYEVS2xSlZ8ArIG
         y937C+ZBZ+MsQTDMygumZTe1nHqIPL/ydjtewVSkjsrjMjorcOS0Mr4uQUtOLcwukfYH
         hyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768371; x=1689360371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwfRYH4UJ8AOWuRFnWsHLV+N3Zv2LfZyE1H5R4Y+eMU=;
        b=Rao2HutFT24s5tpWPoFR1Op2Z48D814V3w6UEgAzwMoZDxGFOR2bmJ7WCnQ70H1/6s
         Lav2v8dhHgWy6EM+csAxBIvYJyw4n0xAA+O8hLNBTVcQqD3adcmsKvN+TwbHvvlUcc4l
         ybwJKrLnMLdBF2IxrFwMPuWttyygiw46GDEppl0YaL4tGJ4I0qH33lN2Duw5aDieIsuK
         OpV3ifvUfbJiGZCFR8tZTrL7xeHxOZrS3gkf9A6usHzBRq63wX5SVRhBk7MEnDUQXmbX
         Lrfg2tg+YnbCzMpkYaOhY0ZPcAUtQ1F8euut/bn+gO0hH2HG9IWpVewjyavxj+bhr5Cq
         F7cA==
X-Gm-Message-State: AC+VfDwQdGNJQt3ns017LHdmIdYcJlbfhoF0ipNd4o5KTIf7PDYKMBIy
        Zg/Xzpuu45eHv4cX9TCkgrbkBums7Npxi/LU4Ik3uA==
X-Google-Smtp-Source: ACHHUZ4W7ymYVnbK7EqcReGY/Vk+Ppvw27W1fDulnYcmOFp3UODF7NHu6wL7s3F0cMln2K48Mc9sbMJwsBkFaqlfOK4=
X-Received: by 2002:a17:90a:1a53:b0:25b:e0f8:7dbb with SMTP id
 19-20020a17090a1a5300b0025be0f87dbbmr2009229pjl.6.1686768370785; Wed, 14 Jun
 2023 11:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230614041626.2979067-2-sokcevic@google.com> <xmqqedmezfn9.fsf@gitster.g>
In-Reply-To: <xmqqedmezfn9.fsf@gitster.g>
From:   Josip Sokcevic <sokcevic@google.com>
Date:   Wed, 14 Jun 2023 11:45:59 -0700
Message-ID: <CAJiyOii3RDur7fwMfG5LKHdApADqKxtQoJ-nMiKWEtY8L3UxnQ@mail.gmail.com>
Subject: Re: [PATCH] diff-lib: honor override_submodule_config flag bit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for everyone's input, in this thread and two others! I realized
each patch version has its own thread so apologies for that - it's my
first time contributing to git and I didn't realize I'm using the
send-email wrong.

Best,

-- 
Josip Sokcevic
