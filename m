Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046FAC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99B761003
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFMHFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:05:44 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35674 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMHFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:05:43 -0400
Received: by mail-ot1-f52.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so2190023oti.2
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcK0E1f4Hr239tHBCgcpEiCeY9d4zDh+xxYwX7RPYaY=;
        b=S2dztKY1Mn2w/DhRU3OdA7ef2aBvIwdcac+ykh6JQVG0xHuY6iXtcIteO3kYLO5+yB
         Iqy486TMplmA5x5dDjl7pT36qsH/lW2NAonbImlaPGvBmeCpJFNY8F6DD6FfnTMjxrN0
         Iv8v/+f/D9ACOx2WMZ180c7dRaY4DKxHQpiW4gdtonMWqpJaCdVPOxOb79nRKcsct9GU
         VSWK6T0R4roLUZqPkWuLBL77N08qHqkIGhUwnDgiBQtUWk39TcFOMeArNGYnXEGgtn48
         rvDh39Xcygt1OtA2OeFujn+F7XnrxylpKwmeG+txdPnf1GzE1Qskrz9kZf/BC0nEOaxP
         3qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcK0E1f4Hr239tHBCgcpEiCeY9d4zDh+xxYwX7RPYaY=;
        b=RcpsfDAscepolA+CjZdFsKvw6l4puYQIOopRAs9TlIf+gT7/imvUsr2U/lpUPxxmXZ
         NpEGyoTINPq6JgOk4/rHD3fHSWKUd5xBBJ1j1Af4BRM/irP07ZF0yrLhFforTHL/0EaU
         +bXeckGLMIZa3sZMfjnQmOZtULJJiTZRLJ+KTYIoh3JFlPnmTy42PptM9d3dgAc26wIg
         cV9VBSdtl6FvledwaZo9rvmtxYz3UhsL23ZQybu/i4aFBkmmgV9rTMLYkY8+qhx7nfz6
         FZp86k3le1yiIjSiS0Saypyx+nGuuhfawyrudUO6o6e1SFXdSE6hIZrGL6bMMHnxYC7c
         7YdQ==
X-Gm-Message-State: AOAM533417qNYhfQGDuCDnHNgdbL7IySKSvjqG9MRp5zT5hZj7t1Y1uf
        lDET82H6m2qCQxhxjDeHLADTV09T6H36j6/Dq30=
X-Google-Smtp-Source: ABdhPJxrl7Fa+TYTYx0+sW5KQ5yY4LXBFJGfTOAtYgbErYuaiRjwaTykFVbFKN/3dGGFxBCPH7XMl2sx4KctBYO3nBQ=
X-Received: by 2002:a9d:426:: with SMTP id 35mr9006900otc.162.1623567749424;
 Sun, 13 Jun 2021 00:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com> <60c588d452750_3d86c2085c@natae.notmuch>
In-Reply-To: <60c588d452750_3d86c2085c@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 13 Jun 2021 00:02:18 -0700
Message-ID: <CABPp-BE4r=Nhw2sJS++7Eh1K5rpyWgg+f8vDTf92JBayt1B_cA@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 9:25 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Eric Sunshine wrote:
> > On Sat, Jun 12, 2021 at 8:44 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > > The original explanation didn't seem clear enough to some people.
> > >
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > ---
> > > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > > @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
> > > +For example, if you have a linear history like this:
> > >
> > > +    ---A---B---C---D---E---F
> > >
> > > +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> > > +commits, but doing A..F B..E will not retrieve two revision ranges
> > > +totalling 8 commits. Instead the starting point A gets overriden by B,
> > > +and the ending point of E by F, effectively becoming B..F, a single
> > > +revision range.
> >
> > s/overriden/overridden/
> >
> > For what it's worth, as a person who is far from expert at revision
> > ranges, I had to read this revised text five or six times and think
> > about it quite a bit to understand what it is saying,
>
> Can you explain why?

I tend to agree with Eric.  I think the example you chose is likely to
be misinterpreted and your wording magnifies it.  A..F B..E simplifies
to B..F which is *almost* the union of A..F and B..E, it's only
missing A.  Off-by-one errors are easy to miss.  You make it more
likely that they'll miss it, because there are only 6 commits total in
the union, and you are trying to explain why listing A..F B..E while
not be 8 commits, which readers can easily respond with, "Well, of
course it's not 8 commits.  There's only 6.  When you do the union
operation, of course the duplicates go away", and miss the actual
point that A got excluded.

Junio's wording and example just seemed better to me here.

>
> This is the context: commands don't generally take two ranges:
>
>  1. Unless otherwise noted, all git commands that operate on a set of
>     commits work on a single revision range.
>
>  2. Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
>     commits, but doing A..F B..E will not retrieve two revision ranges
>     totalling 8 commits.
>
> At this point what isn't clear? Isn't it clear that `A..F B..E` aren't
> two revision ranges?
>
>  3. Instead the starting point A gets overridden by B, and the ending
>     point of E by F, effectively becoming B..F, a single revision range.
>
> What isn't clear about that? A gets superseded by B because it's higher
> in the graph. And if you do `git log D E F` it's clear that doing
> `git log F` will get you the same thing, isn't it?
>
> > Also, if this explanation is aimed at newcomers, then saying only
> > "doing A..F will retrieve 5 commits" without actually saying _which_
> > commits those are is perhaps not so helpful.
>
> It doesn't matter which specific commits are retrieved, the only thing
> that matters is that `X op Y` is not additive.
>
> --
> Felipe Contreras
