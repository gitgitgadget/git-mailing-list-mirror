Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB3C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BBB611CA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhE1Qkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhE1Qki (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 12:40:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6CC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:39:02 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so4009616otp.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6aGFeyD3Tdep1AFTxRDPCkcVRNEKc2Ba9JuID7whXsk=;
        b=N24yzhaW4vBAArxr6RXWuB5Ydx5/KnXcZNdLxzSMqz509gOLHpw6xznw2sV4BcJb6P
         x3RQmd7WGECNHKGrtNEEJsMHdOHINVtukB1tLFidtuvli1AaIqrImaw1YR6rIbTabLse
         sSlibEIP5mBagqHxGEIrnpIBVDBC3D5aG6+mxRqGBwd7ytYnhHWFn6Zx/YhgcAv6cYqV
         ks4qjHLFWhMpTioCKVOt2RmmCUAAaB9seOSZirEkSl0oSn9DdHF2+LmiJzJGERUkvms5
         eCXRjP0+q/1fPL5Kk4IQtI94TvIUgRbPoa15miRkzTs0zPVUzQVuLDvTjVOK4zfNlJNE
         SHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6aGFeyD3Tdep1AFTxRDPCkcVRNEKc2Ba9JuID7whXsk=;
        b=bD5I4MEqvoUJvT+grmC+8RRIEFall0y5HCbAuiuTFa1IiYrMkT98yQBS8lOqYreI9g
         DfbdE+ShohUvHRHyug3SXnZIU5gqMKq4OSwWR7ubO8EBlA9YT+mIZnmuiwqLSeVDvzy5
         u5G0gOAMOg/x9urZ9S2qcztPYaOgYH1C6EERIAjuzAIe1pvLfXkCiRXOoBlN54TS2pon
         AJesmshsWNNkpu9mWsmtbqKqDhxF4WPFjpYS7/951cELfyHNp+nib/eqt1CZ33YxsALe
         1+l8ATKJGG8CSo9VHPow1hlw51M24lnHympT9LjIaiV3F6AYQu719VgDScqPPB/2p1RM
         ucdA==
X-Gm-Message-State: AOAM5337OEHd8wz8cJumyXb3nnrekhRy8RoT0QSqYfDunv7RAMJohh6Y
        QvVsomf3/Cy2Dum/OIAh8Ko=
X-Google-Smtp-Source: ABdhPJzt+ZgXnLm/Fp7aCcA7CXl/hVdVcQFPGKqZQ/vsRwYseVf86nBxoPEqm+/VeIMernyoPvOHKQ==
X-Received: by 2002:a9d:745a:: with SMTP id p26mr7909859otk.72.1622219941617;
        Fri, 28 May 2021 09:39:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v18sm1186823oos.23.2021.05.28.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:39:01 -0700 (PDT)
Date:   Fri, 28 May 2021 11:38:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60b11ca3bfdb1_4b03220842@natae.notmuch>
In-Reply-To: <CAOLTT8SLLgZnF0SV2FPPBJkB=ybeh8mamTPqc-M6CXQeepooOQ@mail.gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <xmqq1r9r8spu.fsf@gitster.g>
 <CAOLTT8SLLgZnF0SV2FPPBJkB=ybeh8mamTPqc-M6CXQeepooOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu wrote:
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:04=E5=86=99=E9=81=93=EF=BC=9A=

> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> > > +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> > > +{
> > > +     size_t i;
> > > +     const char *s1 =3D (const char *)vs1;
> > > +     const char *s2 =3D (const char *)vs2;
> > > +
> > > +     for (i =3D 0; i < n; i++) {
> > > +             unsigned char u1 =3D s1[i];
> > > +             unsigned char u2 =3D s2[i];
> > > +             int U1 =3D toupper (u1);
> > > +             int U2 =3D toupper (u2);
> >
> > Does toupper('\0') even have a defined meaning?

> Forget about this inelegant help function. As I said in my reply to Fel=
ipe,
> this is copied from gunlib...

Even if you use my modified version (which hopefully is not so
inelegant), the comment about toupper('\0') still applies.

My reading of `man toupper(3)` is that if c is neither lowercase or
uppercase it is returned as-is. As long as it's unsigned char, which
'\0' is.

So I think the behavior is indeed defined.

-- =

Felipe Contreras=
