Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC8EC07E96
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 10:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C269661410
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 10:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhGDK2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGDK2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 06:28:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3978BC061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 03:26:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so9992668pjb.0
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=/dGaVsBFsWJomAM9Kh1r6yk4nTAfP4pk0pMJvTgrcwU=;
        b=AMVkqC1Y8kxJuCRU3DJlRrr10DE9DzRnHU2pL5mAjwKFF8RPpdizCfk+1MT2H64sCc
         3NUdsiR5iooWw7yAkmglqNVcfB100OdOTUd53wO2fBwlZ3tGxHs5cqn8ZBDxBZrpI/A3
         YFHW36Hnpr3Dp8w7G3/Pe+Z3EEQmISCAwZKwOakuQ5Wbp8Ml5gKgzTTVU39ZCGGH/q9B
         6s6ZywXTraUUhuK+lIs01Wiu4inYjSgqMB2sb600Sc9k3gCTjsFbG9QS+27Dsn7t3zvn
         eEgdZGzmSHEOkVOzhXLDBBzKl1Dm8u+QtWo4qVFpRdaitpF5aPTCAljnt2kNWQ+BqQe+
         J7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=/dGaVsBFsWJomAM9Kh1r6yk4nTAfP4pk0pMJvTgrcwU=;
        b=G+lIlcRScfvb3ZjuyKNMgg8mGp3EX4NSAlIHW0wYElFs/vhkk+cE3nXO2l7tRhRT1T
         F2uobom0pXds91sPSlrHLXqOb8mkLMhZQojReqAa061NRRVQOzphSoMWHI8nJmqJj95N
         5Da4ZxK3QoJFPh0XP/TssBfned1/uZ0950ntBQDGPPZ5KK4MseUxUklf0OdlyfuxXtlP
         G8Zen+o6zJcmxL6Woa8Qza2s08Lv2o7cF/2HNcPM5c/MP9TQF7ueuxm8eGwxERBLZnPo
         iTXpx6yQu8YYcwi2rC8B2pc5GRxKbEOQf8/NQACKWMYWq9N2m7uhIzFvk+MSsZNpsmNU
         BIOg==
X-Gm-Message-State: AOAM530bEvfM3vPkUfiw/kN95HuWq4ttKghw3rndhK6fOgtzQ5zhiOd/
        yhcOn+aYRd8sfZIOc1kD9Eo60xoOzTUN7A==
X-Google-Smtp-Source: ABdhPJzgkGqF3dExy9T372BOk1cTBIBry7U2hC2H6+p+R4Kwu2p9u9iisI93H5j3GzAOiVJC1f/B5g==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr9058874pjg.218.1625394370236;
        Sun, 04 Jul 2021 03:26:10 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.56])
        by smtp.gmail.com with ESMTPSA id w14sm11050943pgo.75.2021.07.04.03.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jul 2021 03:26:09 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_7?=
Message-Id: <3F42C674-B5FA-4BC1-8F8B-B15C24839929@gmail.com>
Date:   Sun, 4 Jul 2021 15:56:06 +0530
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my latest Git Dev Blog is up at:
https://atharvaraykar.me/gitnotes/week7

There's not a lot of content this week, just a quick update on my
progress with the submodule conversion, and a shout out to git-test,
a tool that helped me a lot lately :)

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

