Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4BDC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06068613B1
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbhI1XYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhI1XYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:24:49 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE61C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:23:09 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id f73so319384vkf.6
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UgQgUB5GOyhuT2gYf81zjJU4u0YP9PV2PL7QZt0rtWI=;
        b=joiAMYBjPK2yNF5WI/RXDmxXLurVnKF3TDkCQi8QvyWeuPRhrBZcDzRnD24RhYSmFD
         rKqG06hwnR1NLvBLtZzNcVF+reeVDsCk1hw75hkRwuCwRsrhUOpYFYjKGEJpqlWyydaZ
         r0ocMJNcgsaiHNOhx51RjiqA2E3ZiVZZQFLd3e7N4Mik9Vi912SRhaFFSpB24ETR2YsS
         w4m2qogQ80g5KwC4f20NZG4d7QgNht420jjzmluHmPGeXKWN9oYUt2/SpHSGt0QKoCU8
         prai+LonfmRDVdOqtDp1IoxqXzOZNThmNYNWl/5+YaQy69Hzrx/F9TroxbyebRNrkf9J
         c8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UgQgUB5GOyhuT2gYf81zjJU4u0YP9PV2PL7QZt0rtWI=;
        b=zp0vMp/E+tde0zvtrdO1jYb4PkF8xY4hcrSAr3vSnIQgOIudQha7EySqcvyfjkmNGP
         qJRfeo6OPvR6LqvPNV2+fdYzBlAWYnbzMb91F2zwiSbdxWQi7syG/o1uuqxLIyQo9vvS
         ShrK2JQJrzLGIbq2qJF3lB/9xk0lHmqTMK+/LIa1IvDHXQNX6Y2AbOtTQ0Xh6sFypLin
         v+NT3xf4Q8djaDc2MA5JaT6bZG+akNxFRDHEhhImaNMYeVVg0ZSvMTk6i2EFCXJx4dHg
         HH9kDZcobSukg6ICMCRfBaJAvXYL28fK0Y/Tls6wLdqs6jvr01xjO1uQukYND7/9I56c
         p4WA==
X-Gm-Message-State: AOAM531ZVUJdQk1eAMd5MGwR3oXclJOrdViktSspvFqb3FxtLZtLi9d6
        j2GNTE+VYkol8RlEDnyGo/U/5G6zzWpL1vnBGIo=
X-Google-Smtp-Source: ABdhPJyM4XFuIOXBQsCHf53cGxZ1KOCSiEzoTEwfULmiMJot/TLDOMdb/O1r7/wzCxnnr4UrMFLlyW6nqr2o/be5UK8=
X-Received: by 2002:a1f:1c8d:: with SMTP id c135mr7526294vkc.7.1632871388640;
 Tue, 28 Sep 2021 16:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210928091054.78895-1-carenas@gmail.com> <20210928091054.78895-3-carenas@gmail.com>
 <xmqqbl4cjt3e.fsf@gitster.g>
In-Reply-To: <xmqqbl4cjt3e.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 28 Sep 2021 16:22:54 -0700
Message-ID: <CAPUEspjvZHEb0X71tFRuFJoxK9eChajfC40OVw7iaup1R+1jZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: avoid multiple -Wall in CFLAGS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, avarab@gmail.com,
        pclouds@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 2:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > 6163f3f1a4 (config.mak.dev: add -Wall, primarily for -Wformat, to help
> > autoconf users, 2018-10-12) adds a second -Wall in config.mak.dev to
> > workaround the lack of one from config.mak.autogen.
> >
> > Since 6d5d4b4e93 (Makefile: allow for combining DEVELOPER=3D1 and
> > CFLAGS=3D"...", 2019-02-22), that variable is set instead as part of
> > DEVELOPER_FLAGS which won't be overriden by config.mak.autogen, so
> > it can be safely removed from config.mak.dev if set instead in the
> > Makefile.
>
> Hmph, don't this break non-developers, though?
>
> They now do not get -Wall that they used to?  Or am I reading the
> patch incorrectly?

It is subtle and apparently problematic as some users[1] rely on
removing -Wall to support non GNU compilers, but my change kept the
-Wall by default by making sure it got set in DEVELOPER_FLAGS instead
(which as =C3=86var points out might be a layering violation and hence
might need more planning).

Either way I'll be dropping this series for now, to make sure that the
minimal change is put forward as part of js/win-lazyload-buildfix
instead.

Carlo

[1] https://lore.kernel.org/git/CAPUEspj_hOXRc2d+c+DTvShgWX8NH+fXKD4Pk+_G=
=3Dnj9Z97VnQ@mail.gmail.com/
