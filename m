Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747BC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C7A613D8
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhFBUKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:10:21 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:34626 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBUKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:10:20 -0400
Received: by mail-oo1-f43.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so857921ool.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KUJcPEOIhCvic7AIRAbId8No7hU0XJV9YLsxukYkQ7M=;
        b=FceYUPsZEy4sP14Pyc3HdU+zZ0GAfojvvl2iZ1kYNF8xHqBkBm8vJ/oEQpWx5cY3p9
         0PbapqPXILovm+adRdDxOypLDBI+6vmhypQekgomwpT4ppQ3cu46Qwiam4hN6Tn+m6+8
         4NPpooCEYKFNeaI3bYw/44cHI47h3y7a9ux6sC4D/e9h9Ik21NlcidKMk42KBEa5fGGG
         SscyyvJRP7kikK+pruNPhZHevvErPuzQ2VAVxBSS3iKbt/drKn9dmb/hwoEB1sLQSV4B
         8JTcXKSdjH4CSECNe1d0T5yoPyBxDWRYEumN7S6dKk/naFhMB1jjhZpSnJ15Tirvhlr7
         pVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KUJcPEOIhCvic7AIRAbId8No7hU0XJV9YLsxukYkQ7M=;
        b=UFJ7S7iRDpiujEPwNKOFWFXZaOlhIDkJd1xR7pWMIxJYDZZmsmw9HTDR3UXf4p8Mgi
         IZKMGpR5ManYWFWrA3ke+kZ1zx4zzokv9mXkZ7No22kQqHn67THAoIDRJWnmkwfL2jQg
         py0vZAyS2FEZvHpW/HiyyP2O07jN92VrsLcXI9+PKQXpXB/lfsLUXNG8M3NLh3I3Etzf
         q8RkhHQo6WKNxgkVM98+RxhzWXolKgalWthwYXBz4rqhOr7rcELjrKkXa1vjQYPnGlbs
         jaDCLi2KR8T0KEEMbmlzRLwGVeCyeQ5CN4vEXanRjlubon+d4fgVt63arpUsPly1iT9c
         LQZg==
X-Gm-Message-State: AOAM531ctiaF+yyI/G+njo+hVYL4MhXH4QJ9JT4XxCTUuhHd7NzZ+Sk0
        bm5vt9u58O7kRJQGh9t0Mmk=
X-Google-Smtp-Source: ABdhPJwExciP4FETKkt5l83sqP5Ycegrojg0CiUs0QGB+OQnHlHdvH8F6GnPUDBsmrv8huBebpaQIA==
X-Received: by 2002:a4a:55c1:: with SMTP id e184mr4160856oob.74.1622664445731;
        Wed, 02 Jun 2021 13:07:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f16sm172218oop.6.2021.06.02.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:07:25 -0700 (PDT)
Date:   Wed, 02 Jun 2021 15:07:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Message-ID: <60b7e4fbc1e03_167521208cb@natae.notmuch>
In-Reply-To: <CAN0heSrNzxSpq=trPvOHAYx_yT1W=WuN1XstzTRjHdZko-i+DA@mail.gmail.com>
References: <20210512064128.15411-1-bagasdotme@gmail.com>
 <xmqqtun8fncl.fsf@gitster.g>
 <609b8e214e1b6_6e4e92087e@natae.notmuch>
 <CAN0heSrNzxSpq=trPvOHAYx_yT1W=WuN1XstzTRjHdZko-i+DA@mail.gmail.com>
Subject: Re: [PATCH] INSTALL: note about make man with Asciidoctor backend
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Wed, 12 May 2021 at 10:13, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Junio C Hamano wrote:
> > > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> > >
> > > > +   You can also do "make man" using Asciidoctor's manpage backen=
d in
> > > > +   place of xmlto by passing USE_ASCIIDOCTOR_MANPAGE=3DYesPlease=
. Version
> > > > +   2.0 or later is highly recommended, as these version properly=
 handle
> > > > +   apostrophes.
> > > > +
> > >
> > > Hmph, I wasn't closely following the previous discussion, but is th=
e
> > > apostrophes the primary reason why anything below 2.0 is not usable=
?
> >
> > "Not usable"?
> >
> > I haven't been able to reproduce the original supposed problem, but e=
ven
> > if true, the man pages would be quite usable.
> =

> Even early 2.0.x had some issues [1].
> [1] https://lore.kernel.org/git/20190325190041.GM4047@pobox.com/

That issue affects only the docbook generation, not direct man pages.

So far nobody has mentioned any issues with USE_ASCIIDOCTOR_MANPAGE=3D1 i=
n
older asciidoctor, especially not regarding apostrophes.

-- =

Felipe Contreras=
