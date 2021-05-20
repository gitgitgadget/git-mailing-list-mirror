Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65537C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FE161163
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhETHPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETHPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 03:15:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C897C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 00:14:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d11so15564956iod.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E5X3sz2Wd8Uma++GCLWgZxsxo5ddBeWlCwQDFiauaE4=;
        b=rYqTJPtB5AH+agL/SVJZ/V2SHjAH+qqeMiOmDlCMG/7hVWIbtrcTPj5qLMnz8I1FdG
         RSrKA4rh5UXoRfnjmTU43PpGZI6w66/kaYzImigOiGVy0NRzWoNL/RQ1uycSIIRvHK88
         B14l4xfbKSkH6aod+McLAr9IboA111ekDZBpu5Zba5hP06GLgyhSOnFNGV4qMQ9DyFZi
         RGLnsJsg0WnX5xk9gXWSSw9+MvgCziWaJZxuIgSCj8Hdss/F7qJOaQyOGy7fgpnp4v6H
         +Aclo0TZigjB7GTMJLBz70t1HIeMpm+m8S/wZJ+R46q5B/+NkFRvw2kGSuA9HRYRN8Q9
         SOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E5X3sz2Wd8Uma++GCLWgZxsxo5ddBeWlCwQDFiauaE4=;
        b=JJSzm77G1gQDVqTuFOg2KUW2sYX5nuhNx2CuiKoRlxvchNjgncEMQVwpnlhFxwXjaM
         mcw4MLioHAV0AvODrzc5u8I9BYs+IeDaaRInVodPpBQvpy/VdtVdaZmigKEPHEzMuAJn
         AykW0odunuLqN0SbX6Eb9S64WKHBbe9HF0A3sWdYlZ9Nwb8u+k+wkeCpiP7c+lSit2eI
         NkHcr2UKnYTY/RgVmYrCRWwT82dlnrrBCAKuTBPHVnc/tzkykS22NqFenh8BHlilBFgn
         eiMu6cFHa/4lnp/2UKEMgjccQ6L21Uf0fwd8F0KrN47nN2bdZUPhO9fjQgJ5uqLwf+ti
         n7eA==
X-Gm-Message-State: AOAM530fYBMf08lDeE6/LoSZ/WbuWd+I2YXVOJI8qB56K3uKRCSMaFiZ
        tnTqxkklfjPksHLks3DN09/7U+Ncpeniq8sHDAIQEMOckwG264svBXk=
X-Google-Smtp-Source: ABdhPJyPMeuS/G6uQXJ1FyI3Ot+jz30cwaup5hb0AwWCq7PQZMwALeRt5Kthzn8YLPfKYErFqATfTDrFuiTZK+88rw8=
X-Received: by 2002:a05:6638:1242:: with SMTP id o2mr4263115jas.10.1621494862621;
 Thu, 20 May 2021 00:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
 <CAP8UFD0qQg9vfuDvjrc5amnw8w7NFBLEaJUwEksV08HBdFJ7LA@mail.gmail.com>
In-Reply-To: <CAP8UFD0qQg9vfuDvjrc5amnw8w7NFBLEaJUwEksV08HBdFJ7LA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 20 May 2021 15:14:06 +0800
Message-ID: <CAOLTT8TRqn5=SqEEnHdFaYi1U5XJXM_MrULfPVzAGPH9AjXk-w@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jiang Xin <worldhello.net@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8818=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi ZheNing,
>
> On Tue, May 18, 2021 at 8:40 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Hello=EF=BC=8CGit!
> >
> > ### Self introduction
> >
> > I'm ZheNing Hu, I am very lucky to participate in the GSoC
> > git project this year. Many people in the git community already
> > have given me a lot of help in the past few months.
> > Junio, Christian, Peff, Eric, Denton..., it's great to get along with
> > you guys! Your review and guidance have greatly benefited
> > my growth.
>
> We are very happy with your application to the GSoC with us, and with
> your work so far!
>

Thanks!

> > But for now,
> > It seems that the parsing of full-named atoms in `pretty.c` is not very=
 elegant.
> > E.g.
> >
> >    if (skip_prefix(placeholder, "(describe", &arg)) {
> >    ...
> >    }
> >
> >        if (skip_prefix(placeholder, "(trailers", &arg)) {
> >    ...
> >    }
> >
> > We should have an atom table like `valid_atom` in `ref-filter.c`,
> > but this is missing in `pretty.c`. So how do we complete the
> > unification of the two types of atoms now?
>
> Yeah, unifying pretty.c and ref-filter.c was the purpose of Hariom's
> GSoC last year, and there is still work to do on this, but you might
> want to focus on the format code used by git cat-file first, as that's
> what your project is about.
>

Oh, what you said makes sense. The refactoring of `cat-file --batch`
using `ref-filter` logic seems to have little to do with the task of lettin=
g
`ref-filter` learn short-name atoms at the time. I will shift the focus of
my work

> > 2. "50cfe1f([GSOC] ref-filter: introduce enum atom_type)" has
> > been merged into the `next` branch, should we focus on the
> > performance optimization of `ref-filter.c`? Finally, we can build a
> > `format_cat_file_item()` similar to `format_ref_array_item()`,
> > which should not be difficult. And we have to make sure that the
> > performance of `cat-file --batch` is not lower than before.
>
> I wonder if format_ref_array_item() could not just be used by
> batch_object_write() like Olga did it in:
>
> https://github.com/git/git/pull/568/commits/f911b342ae6503dc9f6f8e3c7df31=
6aa45d97bdf
>

Thanks for the tip! Olga uses `format_cat_file_item()` in
batch_object_write() , which may be the correct approach.
Before that, we have to make ref-filter support "%(contents:raw)"
(similar to Olga's "%(raw)") and "%(rest)".

> > ### The connection between Git and the file system
> >
> > I am currently studying operating system course, git as a
> > file system on top of the file system.
> > There are many differences and similarities with ordinary
> > file systems. I am very curious about this knowledge, do
> > not know if there are any relevant reading materials?
>
> You might be interested in https://ostreedev.github.io/ostree/
>
> Best,
> Christian.

Thanks!
--
ZheNing Hu
