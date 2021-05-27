Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E4BC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EAF613CC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 20:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhE0Ula (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbhE0Ul1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 16:41:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25FC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 13:39:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id df21so2353166edb.3
        for <git@vger.kernel.org>; Thu, 27 May 2021 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cy3bVQWXzug3OaTAi0E9QqGko5m5F8oIDIo/pZ2RDjo=;
        b=gICJddPMAIwdRFz6qCD2+xqLZEgobrvcKprAbRSxO0PWDvK3Mmg3t3xG0hVU4k6jZ3
         ND/GCSbf4jK1I4n9O3Nb8w6Vdon0hcj7Vxrx4VonBAdWWBF9P8G+16Jjx1PtOH7OFdRs
         KUDZmoyY6tBCCZ2oPtYCCt1GTq4YVqDkGjXQYpBM66ee67cxdf0aT7C0fTfK5a3tDdtJ
         JmaHVZD2EJsLvdNm4daQSz3ZQ0g9dfNHF/rD8NVP5OL5EvN0GytTbXvlha74o59vivlB
         ROSEqpd3BYO9In2KQML/gx106uvEI7Ttlc9na/k8Xnb3AAL+Y1bvS/403VwdSdIGMOoI
         5QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cy3bVQWXzug3OaTAi0E9QqGko5m5F8oIDIo/pZ2RDjo=;
        b=EVUOaBVSt+VGuShS89kk1/KxCRdMZmcbxojq68JnY7akmFlRbwx7fAYaM+Y9oDSG5N
         xXuhocXMrsWzwGHpBR4aUbogdCchVzzqbGpyPOxwsKSMUK9kbii2+YuueSeG2aDciVQT
         5acWbSyd+0GdMSAuh0SheyNk80/5RjcTF2+Y87hQl5BNCv+Lb0ZE12g13JKJLEI+HWy4
         N00o5wrwoeBCX/Lz4hAtTmcZnuaFUn5Ef99iTqdfwYmCp/qFpmeZxiWiIaTCp/37wexC
         QqxrbbOYHBccgNuwLBPVjhfP3j2UHZf7MI7Kn9LaI7Cb6ctyeofc0g/lzVc6lOLHPPH2
         ZwHg==
X-Gm-Message-State: AOAM533Zr/lagIhc+/INCQk3CSxrdZigvk3dRAdsDWE4Yj5fSM8yuSVS
        BnfX8J5vDe6f/PDE7iPyhrKDcwycP1b7mbeBsqB458C92c0jNA==
X-Google-Smtp-Source: ABdhPJyYTTb7Aj9X1wYr0sMzcaQsosysP+nPAS07dzUqdXzsW1IVDCABv4YhJwfaYL4eyST3YdpX+jWptsO43eux464=
X-Received: by 2002:aa7:c7d3:: with SMTP id o19mr6230366eds.142.1622147990617;
 Thu, 27 May 2021 13:39:50 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 May 2021 22:39:39 +0200
Message-ID: <CAP8UFD0R9tm6ovC3VfAJLJo0nL9UXP7Zv6+O7d3AFDiQxOYSMg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 75
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Jonas Bernoulli <jonas@bernoul.li>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 75th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/05/27/edition-75/

Thanks a lot to Patrick Steinhardt, Andrew Ardill, Felipe Contreras
and Jonas Bernoulli who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/505
