Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5575BC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259C8229C5
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgL1RdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgL1RdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 12:33:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3FC0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:32:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b73so10369302edf.13
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=E1QUu5x9OxVhzeh5NJODVyQdlO2/iQ2hHUYljRFbHxk=;
        b=oTiJorGJffUzRi1tVVMD3MkaGOy3jsMQtMk4Edx+kcb59LhuRYjl0ZuamFNi+4KZR5
         HSjNG8BjFPIbQaxvFp2FTFIseQJGZEes/o8SP2C0FYFDOiaHV+C6PybxhfRyKOvCgP8P
         2/TuuIWsZhPYU6EYbf1yJuO2YZM+6SLSfGNkcrtGMfiSVYrdc7TvRTZywRxv39Hl3H0u
         uCefLp3aFF2NOviroAKB49aK3IXefacmTrKPYmgBBfy65Lp2iG6Pew4poFBtQDtvrhjp
         bfZi2cpEjd5dXus4vVpV24Im2MxuBZfATBlrFMH3gYQqGHeljcrhM+ebX81m5CpudZRj
         zW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=E1QUu5x9OxVhzeh5NJODVyQdlO2/iQ2hHUYljRFbHxk=;
        b=RGx20h7i2GilMjul67vM3+myGVv8vYHCKEPXCl/qpCmaQ9gVP1Xmsu8X6f7S/ze7GU
         Nda2IPrjhUjNHL3+w4o61iDuevdisw/5l4KxbjWQ6AoWiEj2H1P3ACu2G4DNuMY+bcuq
         KZUDwFrubiYVYJyj804qgNLcilSXedMl96Ygnb/HqXBuxVHAMxN3OFyDZ8znj1wVFMjq
         8o+bhhMdfvXBLVc+GIUY3TIIJB9Q8s4yu47vhx5V7FtxT2pxgENe7PoQgBRdR+ScIzay
         hDXQPFLFZX45qXI3ln9rxNfEkjUBaEeiIV/E+ChL5nEdncNbz0B0Dh9TmWUbFzWr0mlB
         yv+Q==
X-Gm-Message-State: AOAM533iu3n0BkKdNr38ykJ8vjFSZvjZo7I+J8CMBT6xBADPcEYKYNQD
        HsqevsknEmB/PMZnGqA+l2chlpOXm6ffAg==
X-Google-Smtp-Source: ABdhPJzDGrrHjR4sVI4U779a2zRJGw1EyaMyW6J7e2pCLNP/f44M1rSpM9fyqkCid+wiWoyM1DV+Fg==
X-Received: by 2002:aa7:d919:: with SMTP id a25mr41921106edr.81.1609176741291;
        Mon, 28 Dec 2020 09:32:21 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ga26sm6225675ejc.61.2020.12.28.09.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:32:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] CoC: update to 2.0
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
Date:   Mon, 28 Dec 2020 18:32:19 +0100
Message-ID: <87lfdhvnto.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 28 2020, Junio C Hamano wrote:

> At 5cdf2301 (add a Code of Conduct document, 2019-09-24) we adopted
> a Code of Conduct from www.contributor-covenant.org; back then the
> version adopted, 1.4, was the latest one.
>
> Version 2.0 tightens language in examples of unacceptable behaviour,
> generalizes the audience from "contributors and maintainers" to
> "community", and enhances the enforcement section.
>
> The preamble we added to the beginning of the document has been
> kept, but the rest of the test has been replaced in full from the
> "upstream" and then the same customization for our community
> (i.e. the way to contact community leadership teams) has been
> applied.

I think the update to 2.0 makes sense. But would in general prefer less
divergence with upstream for code or documents we copy/paste.

So I submitted a v2 in
https://lore.kernel.org/git/20201228171734.30038-1-avarab@gmail.com/
whose diff to upstream is half the size of yours. Perhaps you like it
better, or not.

In any case: Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>

The thing I'm most on the fence about in 2.0 is the addition of very
specific enforcement guidelines.

They're still guidelines, so they're not a promise that we'll do things
exactly like that. I still think the sentence from Jeff's addition of
1.4 makes more sense for us as a project:

    It probably make sense _not_ to get too specific at this point, and
    deal with specifics as they come up.

E.g. the phrasing in the new "Temporary Ban" which seems to suggest that
if we were to take action based on the CoC that it's up to us to police
interaction between the parties involved on third-party social media
platforms.

I don't think it's going to be much of a practical concern. It just
seems to me the upstream 2.0 CoC makes a lot of assumptions about
projects being run in a way where they manage most of their
communications infrastructure directly in a silo'd manner.

We don't even manage the Git ML directly, and surely the main point the
CoC is to communicate to existing and new project participants what's
expected of them when it comes to interacting with the community.

If the enforcment guidelines promise something that's unlikely to be
practical in our case perhaps we'd be better off by leaving that entire
section out of the CoC update.
