Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E2460F43
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhIFNgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242515AbhIFNgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 09:36:12 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A06C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 06:35:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q3so8738112iot.3
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fko4D56w5d3vW4Dsu+9juYeEsGS6DvXYrNeS2TrZiCU=;
        b=B0QlIj45G/UzgjJi3NrVgAkk8KKpafmicM6jwxvt+OVw1lA3yR5Oz0FrJDjR0TMnQw
         uDpLW/86ukFIaHIFY2OlKh+8JU2jsw9edEhauO9lL7LloltRde4a3IrZGnBFH6mOgZ1s
         2F0me2Wph/BDCQoFtDRuGQ8tkAJ8rf0gqjLudAhe0Z+2LXuQASOchXgQG7pGPIibgtrp
         nE29NLG8LD92stva8zhWmiwz4PTpNvfrpXXQtQrYRgQEBsJ2I7nZq3QZNveJYS27Q/Ij
         gesS4hK8mTFd5t9ID1Dm2RvlcfiG0tNNKCHrv0x4Yne9wx13T+q6JDxs9t+npja4ua6j
         Nf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fko4D56w5d3vW4Dsu+9juYeEsGS6DvXYrNeS2TrZiCU=;
        b=pP8GGyYiA7Qvhm3t85ITFCnzb5Gr5eepefpB1VPuPJ6gO77HMr8/pcZ3MO8Vnoe0La
         LoUBFruXJsS/vaEqzqk9V8G8gtLuEHVuh4imhwptOKUHxuZyFUMsDbDYyBLDfs/T7GEs
         tmMOJ2KxOLUfYqU1pZo7atEikIWWph93KcdiRYP7dRlghlBtVk/+BA6GiLdC/hGfXKyp
         azDpC321jlOqPopSuWKjdEVI9QD6CqHmAHdOvDmFj1UVza2/maQJoCLPgJIPHRnO06xi
         d0UCImqEWALoxlukAp980+2gjYh+j+8Zmu6gWcS6utMjE7a/mhsW0Ylv/rul7uNfa65F
         rG6Q==
X-Gm-Message-State: AOAM531WBy30HVICh6DhXj7v3NZ9cYLhCLoBguAI7allD2rTlgzwq3j9
        d8R1BSqr8WPN61vJHFt7ux0L32KYWqrk0vioTmIeWEWQdyCaH3wTKJ4=
X-Google-Smtp-Source: ABdhPJx3o1t1hsrYS+71emReHcM64Asye/57YBURyik+o0n+Je0faNZP7lqpyvyVtkXNlInbGbbVVvv8IQAGj9mvtNo=
X-Received: by 2002:a5d:8484:: with SMTP id t4mr9518721iom.126.1630935307207;
 Mon, 06 Sep 2021 06:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNps0YBOaRNvPzk@coredump.intra.peff.net>
 <CAOLTT8QYe3PBPxSH8CYY+FatSfT7C5m6nccR2xMZ1yxSDFh5OQ@mail.gmail.com> <YTTBCWlsC1cBZMio@coredump.intra.peff.net>
In-Reply-To: <YTTBCWlsC1cBZMio@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 6 Sep 2021 21:34:56 +0800
Message-ID: <CAOLTT8QqLXdvL5Y8OkEzuctGgnDHA1DQu8ZaxQGnfHPBqNVm4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: implement "quick" formats
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=885=E6=97=A5=E5=91=
=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Sep 05, 2021 at 04:20:07PM +0800, ZheNing Hu wrote:
>
> > > +       case REF_FORMAT_QUICK_OBJECTNAME_REFNAME:
> > > +               printf("%s %s\n", oid_to_hex(oid), refname);
> > > +               return 0;
> > > +       }
> > > +       BUG("unknown ref_format_quick value: %d", format->quick);
> > > +}
> > > +
> >
> > So as a fast path, we actually avoided format_ref_array_item() when we =
are using
> > %(objectname) and %(refname). But the problem is that it=E2=80=99s not =
very elegant
> > (using string compare), and it is no optimization for other atoms that
> > require in-depth
> > parsing. I remember the "fast path" used by =C3=86var last time, and it
> > seems that Junio doesn't
> > like them. [1][2]
>
> Yes, I did say it was "pretty horrible". :)
>
> It was mostly meant as a proof-of-concept to see where the time was
> going, and what was possible. It _could_ be used as a stop-gap while
> improving the general performance, but it's gross enough that it's
> probably not a good idea (it's increased maintenance, but also it
> dis-incentivizes fixing the real problems).
>

Agree. Like you said, these performance gaps are caused by the used_atom
system.

> -Peff

Thanks.
--
ZheNing Hu
