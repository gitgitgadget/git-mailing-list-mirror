Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E2C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 12:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiB1MPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiB1MPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 07:15:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961DE69CCC
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 04:15:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e13so10557191plh.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 04:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRmeMFyT7cojwug4w5cAYVhi9jg2sTHLwCQtU4SFiIY=;
        b=UbVnzTs5wNAenlLITiJn01OghSseoCsMkbeD7BNJggLkGnE5EVmR+IHIZKjnmjtZ9O
         wcRTzP2zxsJkWP/bSURJNzO+oMVhQVGJNbX87zO/4YKugJ19iTgnSiJxsMtSovYgEuy4
         OExAdoxJwqHFvR0SqjBqcWQgfStPBHJfSUMUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRmeMFyT7cojwug4w5cAYVhi9jg2sTHLwCQtU4SFiIY=;
        b=yWtWcYXo4EphV8BRQ1PvNfn+2X4QzM8LgdvqIypbqPPuIN71ouTM5zDvzjE3P7fqUA
         M716JZblrxWZJg519jOo+35qtmKa1UlHHTzUo+7qseY4cGMZSJnstKVMS6pJ6SboEI+V
         ixVpsdOSsZoRpbDqvdJUj6uDq1pXEArlBQNLe3MccB63YezllzVoI22xiCMAqKpzyngj
         RnB37I75W/nPYJfv/AcUKfFLaDwK85FbX4AgPajlqf2PNZ/gfQiYHjoELLPj/u42/rW5
         wc2lZtwvOhEL0mJ+lrFdzTS4w+YE0oFKML6xYNGPdHXu/Y66yiM537M9vOvHNuLjYWeY
         Qmnw==
X-Gm-Message-State: AOAM5309fqh71/bB39EYLiNuhWxk5pQugpbaOZrPmcec3pe5d/8KRUB8
        gwYljZw5A0ja3TBDeBVacGLrO1yTNsUEi7v0XFDoEw==
X-Google-Smtp-Source: ABdhPJym5dfVm5vpaKQg2DrGaJ2DKiL/qBBfiL9TTYEAFihqD/uFOW+R0p2WgxbmIa8310rnGKWFwdDXqaQfqNxtsXI=
X-Received: by 2002:a17:902:6bc5:b0:14f:ae30:3b6f with SMTP id
 m5-20020a1709026bc500b0014fae303b6fmr20545786plt.60.1646050505033; Mon, 28
 Feb 2022 04:15:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com> <2d817a65db55750d27986c2e2ab5b1723d17081e.1645719218.git.gitgitgadget@gmail.com>
 <xmqqwnhjfnpy.fsf@gitster.g>
In-Reply-To: <xmqqwnhjfnpy.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 28 Feb 2022 12:14:54 +0000
Message-ID: <CACf-nVe=vK=eGeiX4s4fBjEevfMp5jogP=Eq2f-kbfiNoOOfsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] fetch-pack: add repairing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 25 Feb 2022 at 06:46, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -694,6 +696,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
> >
> >       save_commit_buffer = 0;
> >
> > +     if (args->repair)
> > +             return;
> > +
>
> Reading how the original value of save_commit_buffer is saved away,
> the variable gets cleared and then gets restored before the function
> returns in the normal codepath, this new code looks wrong.  Hitting
> this early return after clearing the variable means nobody will
> restore the saved value of the variable, no?

Good spotting, thank you.

>
> > @@ -1027,9 +1032,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
> >       struct fetch_negotiator negotiator_alloc;
> >       struct fetch_negotiator *negotiator;
> >
> > -     negotiator = &negotiator_alloc;
> > -     fetch_negotiator_init(r, negotiator);
>
> I know why you want to force the "noop" negotiator while repairing,
> but it is unclear why you need to move this down in the function.

Seemed cleaner to initialise the right negotiator once, rather than
clearing and re-initialising depending on repair mode.

> Hmph.  I am debating myself if hardcoding the implementation detail
> of "when repairing, the noop negitiator is the only useful one" like
> this code does is a sensible thing to do.  If we later need to tweak
> the choice of negotiator used depending on the caller's needs,
> perhaps fetch_negotiator_init() should gain a new flags word, i.e.

To me this feels a bit hypothetical, but maybe I'm missing a use case?
The point of repairing is not to negotiate common commits and do
(effectively) a clone-style fresh fetch. If some future special
negotiator that has a repair mode arrives, or likewise a more complex
repair mode then other things will probably need adapting?

> where "Use negotiator suitable for the repairing fetch" could be a
> single bit in the flags word, making this caller more like:
>
>         negotiator = &negotiator_alloc;
>         flags = 0;
>         if (args->repair)
>                 flags |= FETCH_NEGOTIATOR_REPAIRING;
>         fetch_negotiator_init(r, negotiator, flags);
>
> perhaps.  That way, [1/8] becomes unnecessary.

With the current patch it is clear what's happening, that the user's
negotiator selection is deliberately being ignored for the purposes of
repairing. Conversely, calling negotiator_init() asking for a skipping
negotiator in repair mode and getting back a noop negotiator seems
unobvious.

Thanks,

Rob :)
