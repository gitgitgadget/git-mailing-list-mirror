Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4113C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 04:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0D422573
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 04:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbhAZE6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbhAYJPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:23 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE562C0612F2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 00:44:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e22so24926976iog.6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 00:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S5pQs9X6UMU4oRiCjXveWWhur/T7Do2C5LgjSU5qvsY=;
        b=N1zcBC02TynXGuQP39x84ZIoPQOA7SNMOqGkJtQZwHZtx1WZJ+sujBaS7QtbvSYswx
         JDjDkpgBmtkzvjg3PLmHWDBCiubC7TVLoyCsndHYmAjbJzcWmN2SYyLcRHTAvzmyMIeh
         1HYI0nfC20TbFxjupNjgsaGp39/wEZ3e2f77nHj6N3jvlQ66TjyYapQ4zABiNr0/+tGd
         zT26cfchiwuPFSkRh7MKdJ9CPCys9rI/nQZLWflo7b73w+gioY46RslCjL7ZdEQrkkwy
         kgU7Dj1CDxXD4VzxPKxxh7R8TpjR2orDLaNKBoDK7dBDJr4VTyPy0DG4145fgT75JHSn
         9yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S5pQs9X6UMU4oRiCjXveWWhur/T7Do2C5LgjSU5qvsY=;
        b=GeYBJjztg0IJqNoVlQ0Arx8L5RUzoqWHL1ljfnq7K8K4mKDfeoC7NI2K+YtWVVuAe/
         /Y/OUgTqYZtq6uUtm1OLtKJuOpY9Vntj9Lk05K49eEAFUrbQbOKTz4AL5dXExksVuqkn
         3RkPT3JClQ9jjv+H9jclG1tYKfG3wSby/spoMzqueLUdDtsnJ7B/CW7shGmyf3D0JzFT
         fzKH64F4mkNncqWAPWxBdeAXVan+qXSiyoCJE19d9bWSEE3Ro1t7aysi9hXkSELMi+5j
         yrljqn5hFZzUaoJknQXDWKowRLPnc9BochUEf9VpsNOLMYVjC2dKZue6Xc6MdXrluaP0
         FoJQ==
X-Gm-Message-State: AOAM533ejMMgEz5jiaYu5LDBdHcB6rVazec2S7ZvVthX5darRNGpYAXD
        TybLcIdhifsqfNC0kK2PpJdG0Yle6Nf226cJq+vsylxw2fs=
X-Google-Smtp-Source: ABdhPJyuPrMGwwuYbUDV49HS2Xv73iYQGedhlWm6UYpGaVLfaY/UHaxvH11CWml2DidspakVYKRnZ/WsHJPxSF+6xE0=
X-Received: by 2002:a05:6e02:12e3:: with SMTP id l3mr128865iln.24.1611564266071;
 Mon, 25 Jan 2021 00:44:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJsFKUCuvO7Y7-MJZ-GG9Jv+4-ei=-tvx4PF1PbeU61m+CV9RA@mail.gmail.com>
 <YA4ZOOccXK0YEOWu@nand.local>
In-Reply-To: <YA4ZOOccXK0YEOWu@nand.local>
From:   Christian Schilling <christian.schilling.de@gmail.com>
Date:   Mon, 25 Jan 2021 09:44:15 +0100
Message-ID: <CAJsFKUBKoD-PvroY7F7=PtF6+KYszTgUD1mndH8vZmh-fSC90g@mail.gmail.com>
Subject: Re: ls-refs protocol extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon 25. Jan 2021 at 02:04, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Jan 24, 2021 at 01:40:08PM +0100, Christian Schilling wrote:
> > Hi list,
> > I have been working on a custom git server where the sha values
> > required to respond to a ls-refs command can occasionally be expensive
> > to compute.
>
> Almost certainly the expensive part of ls-refs is actually traversing
> the references, not parsing the objects they point at and determining
> their hash.

My use case is very different. I=E2=80=99m working on a custom git server t=
hat
creates refs as well as the objects they are referring to on demand.

More specifically the references are derived from the repo url to
implement partial cloning.
So you can do:
git clone http://repository-url.git:/any/subdir/you/want.git

The server will do something similar to git-filter-branch and
deliver the result.
Due to the way my own branch filtering implementation works this is
usually fast enough for the users not to notice what is going on,
but the fact remains that the shas are only known after the filtering
is complete.
Also my server acts as a proxy with the canonical backing repository
hosted on a different machine.
So to start filtering the proxy has to first ask the upstream for the
current state of the repo and download
any new changes. I have done a lot of optimizations to make
all of this fast and in most cases it is, but for the occasional case,
for example if a completely new repo is cloned for the first time,
it leaves the users looking at a seemingly =E2=80=9Cfrozen=E2=80=9D command=
 prompt
not knowing if they made a mistake or are encountering some bug or
network problem.

At first I also thought about suggesting a protocol extension that allows
to start transferring pack data before all refs are known to reduce the
total time needed, but the slow cases are infrequent enough so that this
probably not worth it.

> Incidentally, we had a discussion recently [1] that resulted in some
> patches that make it so that ls-refs often only has to read through part
> of the refs in your repository, not all of them.

I had my own struggles with the =E2=80=9Cto many refs=E2=80=9D problem, but=
 this is
unrelated :-)

>
> > It would be a great improvement of user experience if it was possible
> > to show progress to the user while this is happening.
>
> It's possible that that might help, but honestly I'd be surprised if
> there was a real use-case that needed it (especially after the patches
> that I mentioned which should make it fast enough that you don't have to
> care :-)).

Sorry for not being clearer about what I am trying to accomplish the first =
time,
I hope I convinced you that this is a very different, but real, use case.

Thanks,
Christian

>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/20210119144251.27924-1-jacob@gitlab.com/
