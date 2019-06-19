Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BA21F462
	for <e@80x24.org>; Wed, 19 Jun 2019 12:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfFSMv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 08:51:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36244 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSMv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 08:51:27 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so37887521ioh.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNMuZw7Mt88Y2T/FftyxSS9ReQDhmDWPnv5LD8BvOKU=;
        b=QQql0JhoCSMbjQsbvy63Ma5qOj1MmEf7aJtgqgPkMU69YqJtIxzcB4C5j5sUxmvW6h
         4gMzKzIHvNXiVW/5F1V4tvc7+b7QOWnKJPWG+H0EZxwO8gA+FejeYANXTc7RI8jupczm
         TWDOefLWJbdPNX0OrjIKsx3HUDDGDJvtJbc+D36J0Evs16G8TLQnHXKpC7UBipVCJoKi
         NPJ+cLAp8nLZ+Yn+ykR8P333PyWWnIs60gMKSfd17h8OjgDYJK0z4a3QF5vTW7fmHuqc
         Q5B0SBu1vElHVSw2Z1EB7ftEMwpHCio4hKyIbwDyilWD1iMQw1t4Rn2uxBjJCHUEEBGn
         wXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNMuZw7Mt88Y2T/FftyxSS9ReQDhmDWPnv5LD8BvOKU=;
        b=bLJsMv4OmKO3dbE433KmBjcpWAhLSkh7O/nq/jBug8GadTmzzYTMIAT5OyUk5HH1Zl
         Ye9FuMJ4A6U+Y66hWGSn+4ERlexl4NuZdrn39Tc2i7NU+Y+SSxzLmg71haswZm7Qezyz
         ff9m/1tR7PZ1WMMk2DjWH7F4djMZSwEp1loT0cmoRIVPp8bBfM4gCtJUykNcpTitoHjB
         ydCejF4/ExJ156VmkXbqDn0+a/OQ3OulxCL9muNti3GUWDBay8Ed7ZGGZ+o5znqtrM/C
         QwLd6wULvMDxBnmz7bBQRkBlBwizoU1yoTq1Zx1Vwbf25dhiMdturqIuovjcIQ8dkISK
         TipA==
X-Gm-Message-State: APjAAAU3kL5lBD0zvmILTzrGCBXxs4A/oJXXHyfeRbj6FqPGviN8ZjCd
        ClpwknJocChftgnWXJpxq9xttIoMKJnA5P4zjTE=
X-Google-Smtp-Source: APXvYqxjq8ncOpsz1SLIidUk12ZjJDqyxA2BhDSSfMiA3FHZbPNLFs3tpQObEnkxkQOLBX+3nknJd1R9DHyT8TVKwJs=
X-Received: by 2002:a02:3c07:: with SMTP id m7mr63477033jaa.64.1560948686480;
 Wed, 19 Jun 2019 05:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190619094630.32557-1-pclouds@gmail.com> <20190619102601.24913-1-avarab@gmail.com>
In-Reply-To: <20190619102601.24913-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Jun 2019 19:51:00 +0700
Message-ID: <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 5:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This patch is part of a WIP branch I have that's a bit of a mess. It's
> more-gc-detach-under-lock on github.com/avar/git.git. It doesn't apply
> on master because it relies on some previous test work, but for RFC
> purposes I figured it was better to send it stand-alone.
>
> But I think this sort of approach is better than Duy's proposed patch,
> because...
>
> On Wed, Jun 19 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > So let's try to avoid that. We should only need one 'gc' run after all
> > objects and references are added anyway. Add a new option --no-auto-gc
> > that will be used by those n-1 processes. 'gc --auto' will always run o=
n
> > the main fetch process (*).
> >
> > (*) even if we fetch remotes in parallel at some point in future, this
> >     should still be fine because we should "join" all those processes
> >     before this step.
>
> This is what I'm trying to fix in my version of this patch. This is
> only true for yours if you assume that the user is going to be
> invoking "fetch" in a single terminal window, IOW that we have an
> implicit global mutex of one top-level git command at a time.
>
> Wheras mine fixes e.g. the same issue for:
>
>     parallel 'git fetch {}' ::: $(git remote)
>
> Ditto for you running a "git" command and your editor running a
> "fetch" at the same time.

You could sort of avoid the problem here too with

parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
git gc --auto

It's definitely simpler, but of course we have to manually add
--no-auto-gc in everywhere we need, so not quite as elegant.

Actually you could already do that with 'git -c gc.auto=3Dfalse fetch', I g=
uess.
--=20
Duy
