Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE98C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41A4611CA
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFAJrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 05:47:15 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C7C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 02:45:33 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e10so20217862ybb.7
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+03bwvIyLvxtJdz57FsxzACtfpRyJ4sOABynQC+dNzE=;
        b=KBHshkspa3tC/MsbIqp0XPXZt5ORUaEDhTcuDRKaOA5L63zYz4uxWz6q+rKrqAMElq
         xVbO5/m/IVsL6poNqL4Znfy/I95KXfhbMjjrdGyu2lTcIjsUGerTRFTpOIggHwTNjh1X
         PzkMRvBnYu6zcqDV508fWjuQQcWBLUx+kWU8P5PxZnRh54b3ZuhsoMG2N+b4vUJEcW95
         kqFJuZkKWI7+95PXqBRT8Irh7DJacndZkh9U9PHJS5rPjUZz4Mg+JMdzGxMnE3xZI712
         NQu65404PftsVvsHd3LrMEcl7LgP+muKPXPo+QyYKzxazRQbTecXBZQvxOQnpm3DRam5
         gxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+03bwvIyLvxtJdz57FsxzACtfpRyJ4sOABynQC+dNzE=;
        b=Bz0ORdyQ14rqp1gi02cXB9AN6uE/M8ZGUhxh7zQM+Oxuht6O4hbk8ZGAdOL+RnLHXc
         WnvzRp1ILHQJkJMNhhzJAYOE1TC+0V8t4WDe9b9dAeKCf+AseRod+oRkcgOo90fPP+CW
         Y3ttNBRuXbpRuBDrdrfKQfVo9l4CCtdOa0BjubheS6dRfmApWelcuL1bzlEafNTwdD5u
         n0nVnkFLv/KrgRQqWI8f7E30KjzdWMpqIoSRieF4T5K/axIEZPnPM2Rga6cwYGrXTjE0
         pKuz6SyOiI2CicLZQx2TSwxDoDKvyrWnk4428BDKTXr3HzGuwm0R0cokJQSpliMy9HZC
         Jb4A==
X-Gm-Message-State: AOAM5317gXipfUovREE+9uLIOPUjU8n8qTVrKSF126f6lu1yimILlgbI
        ImU2/80oFqRkIQsu/jIGRTZ7HESISMIS2C5Or5SIca3g
X-Google-Smtp-Source: ABdhPJwhp3xjy2S0WVg/PXl17j0H1pXFv384ye524EGPm5PHK+qlpM2fSujBSXhNa8oWlD1Gl1++iOWdrdJiDZgIlUQ=
X-Received: by 2002:a5b:5c6:: with SMTP id w6mr37071988ybp.279.1622540732574;
 Tue, 01 Jun 2021 02:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <87bl8xmipo.fsf@evledraar.gmail.com> <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
 <87tumol4tg.fsf@evledraar.gmail.com> <60aff0a416f40_265302082c@natae.notmuch>
In-Reply-To: <60aff0a416f40_265302082c@natae.notmuch>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 1 Jun 2021 17:45:21 +0800
Message-ID: <CANYiYbGLuUjUgKZzuDTB7cCaJzA3o7jdXLUTQ=_h8hBvbVmnHA@mail.gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8828=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:19=E5=86=99=E9=81=93=
=EF=BC=9A
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Thu, May 27 2021, Jiang Xin wrote:
> > > I wrote a program on macOS to check memory footprint for sed and perl=
.
> > > See:
> > >
> > >     https://github.com/jiangxin/compare-sed-perl
> >
> > Interesting use of Go for as a /usr/bin/time -v replacement :)
>
> Here's a Ruby version:
> https://dpaste.com/FYT2QKHJE

Nice, it's much simpler.

> I'm not sure if will be useful in this particular case, but Ruby code
> always ends up simpler ;)
>
> --
> Felipe Contreras
