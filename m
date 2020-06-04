Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF81AC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A364C206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCB/bLXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFDHuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFDHuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:50:12 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D80AC05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:50:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e12so3903574eds.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RK2Q9Qto2mhbbwr1wegE3I1heFlowE6/sHr8Ej40w78=;
        b=YCB/bLXLiTqvoqMrB+abLrDT3HDrx1dQcPvGMFzaicdnvyzy+gVCBG1CFJLg1ooyj4
         QJXULIBqh+Vgb3ppExQ9QtpPbTeoyZK8+rrc1ENoJRX9tjVMkwYnv7f8LTo2ukEWuJ3H
         zVepRDzR8PKxQtCJRwYTFwEheVzUiM1rL0gL7LkOggi8CQWnv/qcaQPp/GpU5UjD+Lg7
         HEpFibcf1zEJ14Vo9cMjOaNceX61j3/UpdIWtnxBoDmjcq7XUjfead/EQ7AVd4DAEzor
         1xLgbGM/ex6XY3pXFdJBOApuznvHo1m+nRsQ7TywP3BpKyGM4HaJRDXf3yIUPXul2fGl
         T1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RK2Q9Qto2mhbbwr1wegE3I1heFlowE6/sHr8Ej40w78=;
        b=cU5X3NXe9LnQPMTaNp6292kKIC2ze62KOaQFixVqmYU58uvOO2+ZB1SEAfF/h569c9
         +JtEbPXLgE0V5MZmd4BAcy490rVrLzmoAQY3Msn+tuumd/iHksQ7ZTaLb+Bude5gpLaq
         hm42fbCnzeaPwLKy+Hof78b+1EbX0qw2SerKlF6+2sSnNanTNIpjXUI+/Zklo0/JlNRx
         Sdciox8oWH00IWBF6HxOIuUhwCaKywJZ8FqaNsFn/BSSRU3fjCWamRY71ecZYGiVbVuy
         GST9LrK7ORkYdENuF1+WV/A0pWOGRahom4HpZtN1wMlcaBhFVQFMwu8uBrNAJewJ0xuh
         AVUA==
X-Gm-Message-State: AOAM530WB4/HFdIMsd4NFFmnO3Bb3D+ChWrClh0Tojum9S9th4MYffno
        Onv/MkpRDMsl2N5y+CL7x8QcB+HFf19tY0pWmc4=
X-Google-Smtp-Source: ABdhPJzIP2LadrZoiWt+yIAXdVApwsObTsBihmX82AfokD2xx6JDuwJeFi29Ar3cQREADapGkVnLX3Nbg2NWt7em5Ac=
X-Received: by 2002:a50:954b:: with SMTP id v11mr3109632eda.273.1591257010735;
 Thu, 04 Jun 2020 00:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com> <xmqqzh9ls622.fsf@gitster.c.googlers.com>
 <20200603001225.GB2222@danh.dev> <xmqqtuzrrk8r.fsf@gitster.c.googlers.com> <20200604071719.GC8686@konoha>
In-Reply-To: <20200604071719.GC8686@konoha>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Jun 2020 09:49:59 +0200
Message-ID: <CAP8UFD17VRnmtf8LUcXGZ9bqOt72Fww8B4Jp0yf6t0PAT3Q=bw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 9:17 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> On 03/06 01:02, Junio C Hamano wrote:
> > I'd expect that when that day with no scripted parts of "git
> > submodule" remains comes, the main entry point functions in
> > builtin/submodule--helper.c (like module_list(), update_clone(),
> > module_set_branch(), etc.) will become helper functions that live in
> > submodule-lib.c and would be called from builtin/submodule.c.  And
> > the conversion would rip out calls to parse_options() in each of
> > these functions that would migrate to submodule-lib.c
> >
> >     Side note: instead of adding submodule-lib.c, you could add them
> >     directly to submodule.c if they are small enough.  I am however
> >     modeling after how the "diff" family was converted to C; the
> >     diff-lib.c layer is "library-ish helpers that get pre-parsed
> >     command line arguments and performs a single unit of work" that
> >     utilizes service routines at the lower layer that are in diff.c
> >     and submodule-lib.c and submodule.c will be in a similar kind of
> >     relationship.
>
> There does exist a `submodule.c` outside of `builtin/` which has various
> helper functions. Will that require renaming to `submodule-lib.c`?

No, as Junio says that "submodule-lib.c and submodule.c will be in a
similar kind of relationship" as diff.c and diff-lib.c.

> BTW
> `set-branch` is a subcommand of `git submodule` so do we have to put it
> into `submodule-lib.c` if there were to be one?
> What is the motivation behind modelling it on the diff-family?

Maybe to separate helper functions for submodules from other submodule
functions.
