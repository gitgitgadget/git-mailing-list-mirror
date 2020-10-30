Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD2C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3963A2224A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMfyttUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgJ3K4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3K4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 06:56:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD1AC0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 03:56:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j24so7931987ejc.11
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n4xIzugEYGkBNqEnZYb33t2pSGdkXnjyfPpLWJDdN80=;
        b=iMfyttUGUYKJb+X4uZL1HcFeWT/eiOQkCfYO5eMdvqDmNZuvVFh+DTxcYzHOzc1j5R
         akrwbfGaxcQup1l7B+1LGmw0avIfHsPukHe43i3ZF7eRHSI5qASayZwjbel579kIZmpe
         mu37kyR/Og+XYi5sEZewVgWrs6kuSyHIWpJaHsSuABfl5ocPLBR38NlLDZqMQt3HenYC
         PbdeRpuiwLKYyX83IgyDxw4xaCsmyWXhu9N0uCspExzxXQrGonAIO583/nD0DoXhBuAw
         c1S5qa6tMqKBMhoREP70HzCdyUcvslVr0M5GsajzQ6wQhhSCZHtVJLarcb1ZjIiHO5hU
         Qkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n4xIzugEYGkBNqEnZYb33t2pSGdkXnjyfPpLWJDdN80=;
        b=cRLCEB3Xk7VlPHLg2Pb99wxHZSBkksBWxcP25YGqCe0E8mqqtKsceIHEXuwmAv0LzJ
         18PyCce0rXlZYSNFwOAdO9ylzruLmMUp4zaS2zl1bt8BnOS/l20BCw1Th+wCp4mbSjNO
         mr7cPPXhC2GkPRCnyoj82Uxcat0XGZkUjPwKO0mbODj4mdhgvy8fmFwvRwd+DqA37k5R
         nu/MbBnaPsLRRSKVVnJU4r+sgDoYnRuSyVX0lfiGRIYQrew9LX0QUAwsj1gc6qyzX++C
         fdmE1bykxDxWlDpDnMrQT1mEupq4UzzMZ7lKbJD15dnI3HPdc6vv+zXB/1NSUfeVQuGI
         Resg==
X-Gm-Message-State: AOAM533c3zak/RuIyLNQwSEmLAD6q7MlVvkG0xHYCIt6HgMyZYUPvgIu
        Hu6lcRgmAVBmgh8r15a5ju0jDRcfYTIAlj5E3CRpEJ/miPBIGg==
X-Google-Smtp-Source: ABdhPJxVFcmMeWWFsOw4tTjxPWgaKyMVeuucut7fhMy3mbAp+KZfAcAB0ko0xiGv5lbhnrwPP9y6JKpbxupURJKoDac=
X-Received: by 2002:a17:906:2b06:: with SMTP id a6mr1906420ejg.283.1604055404151;
 Fri, 30 Oct 2020 03:56:44 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Oct 2020 11:56:33 +0100
Message-ID: <CAP8UFD2_WxCvnnMH=HfDDdaffzvNf4R1c7W35Y-aZxWb3=BfWg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 68
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 68th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/10/30/edition-68/

Thanks a lot to Matheus Tavares Bernardino who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/463
