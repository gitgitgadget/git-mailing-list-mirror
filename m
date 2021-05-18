Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA8C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE261263
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbhERHRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbhERHRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 03:17:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2183C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 00:15:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11so5045331pjm.0
        for <git@vger.kernel.org>; Tue, 18 May 2021 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=gKanxr60/9cs9s0iN7n0zySdo2WoBl9GP+QuepqGvn4=;
        b=aQi1cbPqXiGKuA+n+1WmwMlKefh7n/ZOGQ6p4sCYLhJWfBJbD4ujaha8djEgv1Sf+F
         /8EOMRoNvesK14IrWx3qvwN3F0CmjwK+SJpPfCwPSu11RG/7yb2+RLzWdVKWkKGV6ke6
         R4JvESw73r9r5ITaUsSKdb43Cdwrr0M/NURhdT12/dng5ykTwXCztTiBLqJo6VEWi7+P
         XVjXvSEO7NAIcBUlTbZXspN1EBEvuudpmByg/TI/X52uorpa8gFK9T0GJFa1k3PZjIhm
         P2wHS8Q5P+wdXA1VuhwZ5UeU+YZwRxpfQCLpGVvlQL6gdEDU0Z5op2yDppJ3cfcNagld
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=gKanxr60/9cs9s0iN7n0zySdo2WoBl9GP+QuepqGvn4=;
        b=sFd3DZjvhX9sFqcqlxV5vORV9+5j9bn417mWg03I8FFXltiGQUS467f8M328lZCLYE
         Q+WlWId6+wOjy4OSRGVPF8gWawZ2WY5H7iE9MiT71kCyntfggdEIGzGZNTyGACoJjwqb
         KKTH6cekOdks4W6jE+2P2SQjZfkvKQM2Rz+kInScf5nCBvwouC9XfvQDB7ul73Y9f0Ph
         6+qIvcmcQ867NVH5Q0ect1VMTZhOYTVLtyp/cc9h5GjHnISbYbPp2L7hURZ8GkoNOVTc
         d0/VfT4ZET/A+lHKUzgBFPVAswzwDeqmVOCno1tSVzRVcatxutxodZfpcYRYXAj/CDHP
         XNVw==
X-Gm-Message-State: AOAM53294rGz5fq4rOvKqcBvWCeRW0Lr7DSFvl3iqXEBkPJyn0PfOogs
        lVoxScUg0ORq38zPYIdh9pRImgzPVsgjcWFa
X-Google-Smtp-Source: ABdhPJyPirnMATYogeYvm7LlhG/V6yKwR224RIX1uCnHA7jiaghk/jxKYOnIxPT9uVCyia06lQGLuA==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr3894668pjb.191.1621322149042;
        Tue, 18 May 2021 00:15:49 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id n19sm1443065pfa.97.2021.05.18.00.15.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 00:15:48 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [GSoC] An Introduction
Message-Id: <740165DC-19B3-49A0-8D70-B78B2BDF4C1D@gmail.com>
Date:   Tue, 18 May 2021 12:45:43 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        adlternative@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git Developers!

I am Atharva Raykar, a student from Bangalore, who is going to be
involved more deeply with the Git community in the coming months.

I am going to be focusing on converting Git's Submodule functionality
from shell to C, and I greatly look forward to make improve Git :)

Congratulations to ZheNing Hu for getting selected as well. I am
not surprised at all -- his volume of contributions even before his
selection has been great, and quite inspiring for me.

I look forward to helping out in any way I can and get to know the
community better. I'd also like to thank Christian, Kaartic, =C3=86var,
Junio, Johannes and Phillip who have all helped me learn and guide
me through my first few Git contributions.

Thanks again for trusting me with this work. I look forward to
contribute and help others contribute!

--
Atharva Raykar=
