Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99527C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E83060200
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhHYXsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:48:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92BFC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:48:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e7so1336966pgk.2
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sMfi2p4J40ZjBbYzOV5Ygmt+EFL7PMzpkTuToJ6GCcw=;
        b=ZR8wzAdLt6FUdorj0dZlsMmCapi/qS1M+/hz27OvoE9BtHvCzueqQ9NXhv9G0dL8BP
         DY1VbUa7nqVl0tCTGvlWL3aRuf41HbgF3qwyq/LZHxMH5PnCe5KPnC+mOaHcHqLlPTai
         k/u3s8+6YRPMOcObrsRUl/VYSFZpr/kDhrLeccm5ErxF+gX4OZqt9A4dQCOmUPPU7/q6
         sqWMbsRiY3RoO/7M6ZxC8Jl8p9lRmQTfGjMObnGcrsHJRdoSBhvFLgh0/utQAq/StuTf
         IlOiFqFwJ9Eav39PpCcMjbGS1F3iPBjHlsxUn9Ob6mmXElgGuDJdvyM1Mu9shOKxdRwz
         OxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sMfi2p4J40ZjBbYzOV5Ygmt+EFL7PMzpkTuToJ6GCcw=;
        b=MtKm4k8PMM3NLALndf7OjRxKzOiYJri+oJlR+clSv8PTJazJ5MQ3vgPKwqCoKu9JFW
         J6Dnlad+Yo0ibzmy3/wywFQfYKzrebWX7qsjmcFFcUN4uvTsmKHSg2oaVKrRY+qwr4WE
         R2ZeS3c7PuZyVDELF52ZyPH+SufKhxto3lH2dKL+LXEpSeqysl/1iYXL8HWbJgT3xZo1
         xRj79CB2XswTczQamZfMf8MEGYRTckejgjfd2l+aa7pATpf72vdgpHrmFq+PrmRnd8+2
         X5OVo3r4qwzso4kwFFdWispoj23mdMS+u6Ltt32ly1Qf+NtwlXWheQQvvRL3V4vyqovK
         P1Pg==
X-Gm-Message-State: AOAM530UvaIOKkky+yVc2JIhOxwcdnGsINYV8zUhGk/5Nzh7k1yciuY+
        fnANEEYJkmJGaOSd2n9DIptxJGXj6ujoA12GBx3+O7ggGkc=
X-Google-Smtp-Source: ABdhPJwcAJCIM0JKhg0eFMwvJ+/hNa/IEBKZrmbTwqls0/BCSFsolDXEDMbrL6hN+HibhCW7UEYSQjzqpmXMdc/OQgs=
X-Received: by 2002:a62:4e0f:0:b0:3ee:668d:b841 with SMTP id
 c15-20020a624e0f000000b003ee668db841mr910509pfb.48.1629935280260; Wed, 25 Aug
 2021 16:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <9896630.2IqcCWsCYL@localhost.localdomain> <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <24330338.EZKKyuarjD@localhost.localdomain>
In-Reply-To: <24330338.EZKKyuarjD@localhost.localdomain>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 25 Aug 2021 16:47:49 -0700
Message-ID: <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com>
Subject: Re: git log --encoding=HTML is not supported
To:     =?UTF-8?Q?Krzysztof_=C5=BBelechowski?= <giecrilj@stegny.2a.pl>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 4:29 PM Krzysztof =C5=BBelechowski
<giecrilj@stegny.2a.pl> wrote:
>
> Dnia =C5=9Broda, 25 sierpnia 2021 02:57:47 CEST Jeff King pisze:
> > diff --git a/pretty.c b/pretty.c
>
> Please fix the manual for git log.  It should say what encoding is recogn=
ised
> (namely if supported by iconv(1), except that POSIX character maps of
> iconv(1p) are not supported), and that an unrecognised encoding is ignore=
d.
>
> I would also like to see the HTML encoding supported independently of ico=
nv,
> which seems like a pretty easy thing to do.  Dream on, I guess?

I suspect the answer is less "Dream on" and more "Patches welcome."

>
> Chris
>
>
