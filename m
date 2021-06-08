Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62961C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420F360234
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFHGsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:48:43 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35723 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFHGsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:48:43 -0400
Received: by mail-pf1-f178.google.com with SMTP id h12so12133908pfe.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jYM5zpmCMbXxP0DyvFmHz8QsxszTcaV4X2/GgeTSio=;
        b=GuaIOCeUaQYapueKwjKTFtozXeh9T5cc3g3RkpjRLK6mbfK9BMFYNPeIWEDBSWbSAF
         FLDMWXau5qMTikSRBGWRIme2oIXUNXJt7ZycZ3DNXyvqP117YR9hP9fZi5Fm4wL+71I9
         J+GSC2M6ppz4jWaB4FhiC5Piqk3RylpO455e5ccH3yqyjBsONJRxetJ+xU4u0JIU74XG
         KsuzABo0QVwADWI/3qWTkEl0tyXXPstehaVsKR2fFdEbO41LwmjYFyBU3loBTpVlXDdq
         9UHHreWv93h0+JRD/kxzjJFOuhPs0rs1ovfwyr1X52BVEpJBY9fxtZGTFR/bGsysaCxB
         hGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jYM5zpmCMbXxP0DyvFmHz8QsxszTcaV4X2/GgeTSio=;
        b=hY3SfPBdbDNKHETyR+G6pjHEnY83h9JRKrbwlkc7HsFyIuK2266sRtbFdm3oZ4iuXJ
         zNb1bNN1C0K2dQbcHAiDhaOap4ehojLjwL/6cyM70z8hKKF+OsAuO1WrWSci4vHfkOZd
         aWyTkcEhgtEsvXcujzyiveg5oDZerbgBkfOJe3K+duV1xAUAwDD+u3bGXhePHfU4hB0n
         Jb44YJX1sPOWYbkHqScf9za770nv/0cKAT0UdzVDy88E3WgR66ABqSlHIsZo4slWPNO9
         aDu308rPTW0xSPIDGWC5/n8BBxHHiu83rETnGq8e5/+LzGYmcTBf45RqB6CwAhu0LOf0
         zw1w==
X-Gm-Message-State: AOAM532VoSV7cgPhTthlqmHV9PgCp50EXdFrFkVk+y7e7FiWieIDcMtM
        wvcfE3dAnE/kpFIONGWLTW91rQNxQlMvMg==
X-Google-Smtp-Source: ABdhPJw1H5JobJiX2wrZqi96P6EwlF4LX+GEE+KqVqCwAnvHgu2SA6TMvLzRpgY8LZZg4rPIh+YMNQ==
X-Received: by 2002:aa7:9706:0:b029:2f2:4481:1e17 with SMTP id a6-20020aa797060000b02902f244811e17mr2582643pfg.53.1623134740756;
        Mon, 07 Jun 2021 23:45:40 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id r28sm10434859pgm.53.2021.06.07.23.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:45:40 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:45:38 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn
Message-ID: <YL8SEnS9QWu/qvnb@danh.dev>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210607004838.15235-1-congdanhqx@gmail.com>
 <xmqqk0n6wkrr.fsf@gitster.g>
 <YL8PsmLaU+MpWv58@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL8PsmLaU+MpWv58@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-08 02:35:30-0400, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 07, 2021 at 10:01:12AM +0900, Junio C Hamano wrote:
> 
> > >> I kind of wonder if trying "C.UTF-8" would be a reasonable fallback so
> > >> that people don't even have to set this extra Makefile knob. But I'm not
> > >> sure if we have a good way of testing if that locale works (if we can't
> > >> find the "locale" binary).
> > >
> > > I also think we should fallback to "C.UTF-8" instead of not testing those
> > > tests.  However, I don't know if there're any systems that not have "C.UTF-8"
> > > locale.
> > 
> > I do share the feeling, but have a hunch that systems lacking
> > "locale -a" may be either superset of, or has at least large overlap
> > with, those lacking "C.UTF-8", and the new mechanism introduced here
> > will cover both of them, so I think it is OK to stop here, at least
> > for now.
> 
> Yeah, I think it is OK to stop here, too. I'd worry that we'd make life
> unnecessarily complicated for people testing on platforms that lack
> "locale" and C.UTF-8, for little gain.

Argh, reading this and my patch again, I figured out a regression with
my patch when either LC_ALL and LANG is set but to something not
ending with utf-8 will ignore "locale -a" completely. I'll send
a reroll later. (With this reroll, we'll ignore the dumb ":", too.

> 
> The v4 patch looks good to me.
> 
> -Peff

-- 
Danh
