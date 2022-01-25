Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC94C4332F
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 16:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1586190AbiAYQvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586633AbiAYQuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 11:50:06 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B57C06173D
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 08:50:06 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q127so2885657ljq.2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=18W9gwjKg0F2GXKSWtzFFSoZI103NWkAR6xaTRCr++E=;
        b=T4ZQv7chzoCNBoYnsfcrfqh2Ix7YaPRUzt5w/NCOypJf/uakNpujOULauiJoQiYg8B
         myNUyOS+7dSqcjj9Yw7Sv3twsnk8twR85aNFmUQZu89H2sUfcliKR76szNxzTmT0HQ4K
         hwLtjWQ7pRN9yx8ZK/SXiWuW3Dp+CP/PRLmfM6Z0ehPxV+Vq302C0d9hHwITocmLQEkF
         SIFiRBCmdeyDkfDiaU9ejCe69kpFDKNk5gVzBSpXvpU9RheYTiFJKEVPH1MNPMyWVaME
         pe3r+H2mGfUh4DFoSwiZiSqqyesRr++3i/SPpR0aw+dUP9RgYjF2I0WQ3kioE32kEIwb
         JSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=18W9gwjKg0F2GXKSWtzFFSoZI103NWkAR6xaTRCr++E=;
        b=Xc5A6sUyh20F+XCG33IlBPXAQP7Hg9dtJVTb/jr4SH1bqndK/PkTT9COlhqZAo9dP1
         pXMRVvtwcbXuOzoDqWb36vj+bfOUsXe3CZ4HMX60FC1CSflDLExdc4SxrHMQj/YT/2aZ
         9pPI3XExSU+KDlbwmy0pUEaqwdFNrMpUnqL58TM7wkj5BpTGD3j+avbm+kJc52bq+qfs
         cnYWE3zzaQu17zkH+g2/p/fn0IRV7/ODOR0OubKYo5MHiUfZe2xjBDbAHQquxsZTe5w8
         8M8tpWKHdtKv0rvSCDXULqQWKTgxaD/dX1SALRqTnIfi/3Cbk2lLnUjQb+m/NFeh3mvs
         fVLg==
X-Gm-Message-State: AOAM532qmDkhS6zKxA8OnQNTFO2BCO3fML/TqU+ohdMHGrc9J6enOlgR
        t6s9BBmLf1bAyhZLEflqSY/2vyygVAdrVdYye/E=
X-Google-Smtp-Source: ABdhPJwEVi4XoD6THP5YxfX6YjeR8tq+oAqx937mGQK3p+fIuwu6TjSAWffiQYYOBAhgEg7pDbkSE8bpFE6Kv3o8Xzc=
X-Received: by 2002:a2e:584f:: with SMTP id x15mr7836744ljd.395.1643129404180;
 Tue, 25 Jan 2022 08:50:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com> <xmqqk0eo1zhu.fsf@gitster.g>
In-Reply-To: <xmqqk0eo1zhu.fsf@gitster.g>
From:   Bojun Chen <bojun.cbj@gmail.com>
Date:   Wed, 26 Jan 2022 00:49:52 +0800
Message-ID: <CADuS7Aov-J4LjAm_e_DOHaAba9JHFFV-2trxBywzL4vtwuvr4Q@mail.gmail.com>
Subject: Re: [PATCH] receive-pack: purge temporary data if no command is ready
 to run
To:     Junio C Hamano <gitster@pobox.com>
Cc:     BoJun via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C 07:32=E5=86=99=E9=81=93=EF=BC=9A
>
> > +     /*
> > +      * If there is no command ready to run, should return directly to=
 destroy
> > +      * temporary data in the quarantine area.
> > +      */
> > +     for (cmd =3D commands; cmd && cmd->error_string; cmd =3D cmd->nex=
t);
>
> Write the empty body of the loop like this:
>
>         for (...)
>                 ; /* nothing */
>
> to make it stand out.
>

Thanks for the suggestion, this is more readable.

> > +     if (!cmd)
> > +             return;
> > +
>
> > -mk_empty () {
> > +mk_empty() {
> >       repo_name=3D"$1"
> >       rm -fr "$repo_name" &&
> > -     mkdir "$repo_name" &&
> > -     (
> > -             cd "$repo_name" &&
> > -             git init &&
> > -             git config receive.denyCurrentBranch warn &&
> > -             mv .git/hooks .git/hooks-disabled
> > -     )
> > +             mkdir "$repo_name" &&
> > +             (
> > +                     cd "$repo_name" &&
> > +                             git init &&
> > +                             git config receive.denyCurrentBranch warn=
 &&
> > +                             mv .git/hooks .git/hooks-disabled
> > +             )
> >  }
>
> Documentation/CodingGuidelines.  As far as I can tell, the above
> does not change anything the function does, and the only change in
> the patch is to violate the style guide badly.  Why?

Sorry. I'll roll back these formatting issues. Jiang Xin reminded me to
look at this document, but I did miss an important part. At the same
time, I used a wrong range-diff command in the review I sent internally
earlier, which made my changes look like "mk_empty() {"
to "mk_empty () {". So this problem was not detected in time.
