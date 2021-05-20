Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D1C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241756108C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhETCqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhETCqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:46:42 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81691C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:45:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so3058061oty.7
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AIv9iBhiyMJIQQMZMmKnhorxA9fpoO1uRhpJGX/k/7o=;
        b=IPYCvhIiFKw/kH/NiT8WS/gaofzG2fOsOiQTzxunx7RGR+t4Wz22gYZm+rbDr71UAg
         OSBrfwpG0xdGYDf7mIevB5Liwd3POwt2sdswCcBL+clpQGQ89kvBPng6uFwsuxG8CvKT
         etXG+8IGPG2ubCoMKoFgGUciR/WY0Y+qyS4QG2zW7FNsVf2N9G/O05OXGrMkZ6zErKRo
         xBq8E14r43xYONNVULltm7wgt8ah+V1PDTYwWyWIsI7vYOyGlJR+jLQjIZBx7CznClQq
         l0Bidz4RUUrI/zy/0p6fMGjM/jCq2kRBsNm4svnuJxov5qaN2fLQmbe7NyAEF70UBZJO
         7K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AIv9iBhiyMJIQQMZMmKnhorxA9fpoO1uRhpJGX/k/7o=;
        b=XCdJwKgSDM8qDsZpIpBDUDESNqUc2lwYrgxxB0mUZ8RDTapERk9sGQohyUO9wsSZqw
         pAoLC0yLjItEbRmB5N8evoucmA6ATugQhkNlvkTB51X+f94kt54oCpQPVheeXlwlG6eC
         POdjwVVBMUDHm1IoGnY8gAr3D/s34jvrY7Kd8tNIy63+3ki1buqJa4V7bjoHGBhpuRZH
         pUVWOpJxjNn2lD8LkRnffjdbD5kPsiY3R+RJzbk7kgKK38OkmVCsU8uDy7n2mIHFvnOd
         9VxPBSvWpimR5ZO1hY2/MWUBBnisVCPHFTJhXQFbzUTxvP2ObFm878fpGGCGx//TDeJG
         hY6A==
X-Gm-Message-State: AOAM530YPrVaP+6qSDZPtIF+Z2LJ3JPI+ba2hDBmYG+mXSYzPiV1TfbP
        Z3bfje9DTQwS6xUEmpNsxygu/F+fDMvH9A==
X-Google-Smtp-Source: ABdhPJxbyMizrysZsCAr/tKT22NMkIbA2FK/ZFMFfgPN6cyhYemPNseVO8QFNQykz4OSU32dhNjE3w==
X-Received: by 2002:a05:6830:3115:: with SMTP id b21mr2084997ots.291.1621478720860;
        Wed, 19 May 2021 19:45:20 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x3sm397444otj.8.2021.05.19.19.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:45:20 -0700 (PDT)
Date:   Wed, 19 May 2021 21:45:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a5cd3ed5aaf_1e275208a0@natae.notmuch>
In-Reply-To: <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
 <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-19 at 09:26:12, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
> > =

> > On Tue, May 18 2021, brian m. carlson wrote:
> > =

> > > Would you consider various projects coloring their respective manua=
l
> > > pages differently to be a desirable state of affairs?
> > =

> > I think it's an important distinction that we're not coloring any man=
ual
> > pages, it's a question of whether we invoke "man" invoked by "git hel=
p
> > <whatever>" with the exact same paramaters/options a user would get w=
ith
> > "man git-<whatever>".
> =

> Yes.  I would expect that if the man option is chosen, then we invoke
> man without modification.

Do you also expect git to call diff without options?

> The documentation says, "use the man program as usual".  "As usual"
> implies the way the user would invoke it.

The documentation can be updated.

> > I don't think it's confusing in that context if we learn to do some "=
man
> > with fancy on top" in this mode.

> It's pretty obvious that "git help commit" and "cargo help build" both
> are intended to invoke man when used in the normal way.

And I don't.

I expect the output `foo help $x` to be decided by foo.

If I do `python help len` and I get an error, that's fine.

> > But if colors only add, but don't substract information by default
> > that's not an issue for the color blind, correct? Or at least that's
> > been my understanding in helping color blind user in the past (and no=
t
> > being color blind myself).
> =

> The problem becomes if the color is indistinguishable from other
> elements.

It is not indistiguishable; a blind person would be able to distinguish
them. As much as they can without the patch.

> It is _also_ a problem if we have two colors with sufficient contrast
> between the foreground and background but those colors look the same an=
d
> there is no other distinguishing factor.

There is another distinguising factor: they are *bold*, or _underlined_.

> So, yes, if the colors only add information and they can otherwise be
> distinguished, then it's fine.

We are setting *bold*, _underlined_, and REVERSE.

Exactly in the same way as they are set already.


A truly colorblind person would see no difference at all.

> What I don't like is when a program colors text in a certain way, I
> can't read it, and then I can't read the help output or documentation t=
o
> turn it off.

If you can't read `man git`, that has absolutely nothing to do with this
patch.

> I am specifically arguing against coloring our documentation

We already already coloring our documentation.

> and help output because it leaves users with little recourse to fix
> the problem.

man git.

-- =

Felipe Contreras=
