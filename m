Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6948C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3F061421
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEKUXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKUXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:23:34 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20310C06175F
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:22:26 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so1991035ood.2
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SRGiNN6alw3KT0gFSSTelD7pweqWu+xBhkA4qYCxDS8=;
        b=LPQKhMQ7QqfhEOonX7n7ZY/e11PJXodwEA2IqUFAIi2RfJBRNbVLbecYErY4B0apkc
         OeTqye6m2Mf+ybldOE8QjanxPrkJnDfctvD8XZOlkgmbS2HXd61Whff2Dyfbjpg5CCym
         sQSLhEQA7KfvTFrt58UEZH9/WlQgbRTwHltEnGtcWWJtBO8Hu0BA56dIxlQeSCm66/Hi
         FA0YP09CM1dIwzDZEZ4WOn8J0/GTO4EKX33vE8I5SjYPvEadk/w3ksP2r8ObTCNutTts
         HIcm3Ykq7X0VSbjZaACphjynxBiYR/ig/tWXKlmgQkxPPkLP02TWZXIXGGVsYzvo16Dn
         ckkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SRGiNN6alw3KT0gFSSTelD7pweqWu+xBhkA4qYCxDS8=;
        b=LmdeGe8kb9E+OB2ENedpAQ7pVRe7kiJgdta478N2gnCO95KlUAh0KFmfqPmp0PU71G
         w6lXZKng4i6+m1LE8UJ0dIXLLjOwSiI19b/KfcKbSxLyMq4U0V9+/yPYFHNb5PMQPD4l
         0ysnrhyURYl2aCGJH2S2O45FRjSaCPB/0hysfXlfk2YLXD45ZwtsrHdR32S98wNsrmYg
         JJo/s3skQJ+TomV2RGzB6NYSAY7jfZNTv797Y2ufuZxHAbWhdMPkn2sFjlcO/cnwO4u5
         ceNxg0Abnmta/yZe9FwRx3BfbYJqX5qyq/a50L3AmLSPfSDPiKcj2ik/pD4DTuXsgqZn
         dUdw==
X-Gm-Message-State: AOAM533Kp+awcnapWtsEK4wP0dLoqCout4rEI1SvRWNXqbpnVs8gDYP1
        bHF3JHKmIprF3dd5Cz4BzP8=
X-Google-Smtp-Source: ABdhPJzSG0ykWOF8LRQQzX7FoAEIg0LQKDkQjPM8guR9nPbOCoU1pPvRBz7806fNpDw4u5lK9sRevQ==
X-Received: by 2002:a4a:250e:: with SMTP id g14mr24959529ooa.31.1620764545469;
        Tue, 11 May 2021 13:22:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id g11sm4017652otk.11.2021.05.11.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:22:24 -0700 (PDT)
Date:   Tue, 11 May 2021 15:22:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <609ae77fc684e_6064920816@natae.notmuch>
In-Reply-To: <YJrWXfmaNVIL/TzT@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
 <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
 <609a3a5a7aa08_5d5d32088@natae.notmuch>
 <877dk5tovj.fsf@evledraar.gmail.com>
 <609ad46776dec_6011e208d7@natae.notmuch>
 <YJrWXfmaNVIL/TzT@coredump.intra.peff.net>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 11, 2021 at 02:00:55PM -0500, Felipe Contreras wrote:
> 
> > > > > It's not too hard to install an updated gem, but not quite as nice
> > > > > as using the system package (it also makes things weird for
> > > > > building the stable Debian package itself, which would want to
> > > > > rely only on other packages; but of course any proposed change to
> > > > > the doc toolchain would be for new versions, and would not get
> > > > > backported there anyway).
> > 
> > Doing `gem install` solves the problem for whomever wants to build the
> > latest git in Debian stable.
> > 
> > Building Debian stable packages is something else.
> 
> Perhaps I wasn't clear with the "but of course" part of my statement. It
> was meant to rebut the earlier half of the parenthetical. I.e., drawing
> that same distinction as "we don't have to worry about packaging Debian
> stable here".

Ah, I undesrstood wrong there, it seems we are in agreement.

Semicolons in English are similar to semicolons in computer languages:
when I read ($a; $b), $a needs to stand on its own. If $b is really
important I would do ($a, but $b). But this is like splitting hairs of
splitted hairs.

I've seen too much discussion and too few patches, I'll send the mockup
I did a few days ago to see if it sticks.

Cheers.

-- 
Felipe Contreras
