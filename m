Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CFC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351077AbiCKTXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 14:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCKTXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 14:23:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1531CA5D3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 11:22:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b28so5036265lfc.4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PWyMah2ZOZztxCJWngv/Q+Jf8wgWVtKrz+k6w2WvPiY=;
        b=ImHuFaiyl0ZwfI9eJPg2jD69rp5HjEwJjKAPRX2YpFuQ7PRPLlrBm9UxWhwWl3Cpak
         Pj4/LQLKLEjSZC7PkAZjkq9UUqztltkTShX3eWEbw/vWaA/3PylOTeAj3co/8owNKlrm
         aMFctgoNkwjcr2ybbkxzpoYCY4vQ8OQ+Ax5l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PWyMah2ZOZztxCJWngv/Q+Jf8wgWVtKrz+k6w2WvPiY=;
        b=DIJ6c2DhJzwpP4r2986cmuj5a/aYjGarRAmAY4abLIc40lVkR9xdHD/5tNQ5+vHD9T
         pxvQBtM6EV203A6Mx5A9GUUagJ2xvUrwuef0mcyZ14AO9/mzURPgbxPu0EzwRJamGjlj
         VcRWBcQTlZPT4+NliM3zMvWjQYAH0WkjR+3gSALQbPNlnDArVu8j5dx/vnnPyQzNsyks
         UEAkqyyVaAt+G+rOQIDQ+PjUFT3kk0jPo/XSrVh/MeBXKajGOOGCQLygUOPWNZIyBfxx
         OPGEV/jgrM64YvYU3khHJvBtXQtVs6k7oDshfX5XlyygWXjFCbXuINcTvWfczZ2oci5j
         Pagw==
X-Gm-Message-State: AOAM532/L0CLbRC2uNOIWnxsK+JF2RqpB6sBXP2uZsW7qfWPcIToOBFM
        sqjIrch9ao5N1RulHqH08Jbls1WTt8M57KtF56A=
X-Google-Smtp-Source: ABdhPJz1Pdd11v5BnxxKJJAuJOUno8A+r/gM6fCEcKXiN1RreWD9TqM+Uy5UDzjqXGCrIJDygdyfRg==
X-Received: by 2002:a19:f701:0:b0:448:6bcb:f80b with SMTP id z1-20020a19f701000000b004486bcbf80bmr4005615lfe.7.1647026526159;
        Fri, 11 Mar 2022 11:22:06 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b0044830bd2d35sm1768329lfj.278.2022.03.11.11.22.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:22:05 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id q10so13339047ljc.7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 11:22:05 -0800 (PST)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr7073299lfj.449.1647026126777; Fri, 11
 Mar 2022 11:15:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
 <xmqqo82dd0qv.fsf@gitster.g> <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
 <xmqqfsnpcxdm.fsf@gitster.g> <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
 <CAHk-=wj0ZfmTEhc4iPJSbn_FxzU94qZfK9WcgujKUcZK9a2UvQ@mail.gmail.com> <220311.867d90j2vj.gmgdl@evledraar.gmail.com>
In-Reply-To: <220311.867d90j2vj.gmgdl@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 11:15:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgT9=3V60koHO40omnubeBK3bD8kX8WAx+gUHTWoNCn4Q@mail.gmail.com>
Message-ID: <CAHk-=wgT9=3V60koHO40omnubeBK3bD8kX8WAx+gUHTWoNCn4Q@mail.gmail.com>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 11, 2022 at 12:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> If it's not too much trouble inline patches like those you send to the
> LKML would be preferred :)

Heh. When I send patches to LKML inline I end up doing whitespace
damage to them.

Part of the problem is that gmail - which is what I use for normal
email - makes it quite hard to send patches with the legacy tools I
have when you have set your account up to have all the security
measures (2FA etc).

In fact, I think these days gmail actively blocks any clients it
doesn't trust, even if you were to do the special app key thing (which
I have occasionally done).

Despite that, I find gmail very convenient for my workflow, but  the
two issues I have:

 (a) I'd like to have "inline attachments" for the web interface so
that I could attach a text file that would *not* get whitespace
damaged

 (b) the mobile client should have a "no html" mode (for when I'm on
the road and reply to lkml)

And I know a lot of people inside of google, but I gave up trying to
get the message through to the gmail people (everybody I knew said
"it's a different group and we have our own issues with them")

Yes, yes, I could use other tools - and other email setups - for
sending out patches, but realistically these days I never actually
send out patches any more. These kinds of very occasional git patches
are the exception, not the rule.

So, for example, I could trivially use "torvalds@kernel.org" to send
out patches, but I've tried to avoid having multiple active email
accounts and confusing people with different names etc.

My lkml patches are invariably examples (ie "how about we do it this
way") and then I actually mostly *prefer* that they be
whitespace-damaged so that people won't apply them mindlessly. In
fact, I often explicitly indent the patch to make it really obvious
that "yes, this is a patch, but it's meant to be thought about, not
used mindlessly".

> FWIW the reason... [...]
> ..you needed to do that is because we pass PARSE_OPT_KEEP_UNKNOWN
> parse_options() there, which turns off our abbreviation discovery logic,
> i.e. where we'll take a --foo, --foob, --fooba if we have a --foobar
> option defined.

Yeah, I had gotten to the PARSE_OPT_KEEP_UNKNOWN part, and then
decided I didn't understand why the option parsing code did that, and
I wasn't going to touch it.

I saw your patch to fix it, and it looked sane to me. Thanks.

> We really should just teach those callsites to "grab" the revisions.c
> options and do the parse in one pass,

I was assuming the two-pass thing to avoid doing any callbacks before
deciding the option is unambiguous.

Not that I see why that would be a big deal as long as you just error
out anyway, but maybe some users end up ignoring errors?

You know that code better than I do in any case.

> Of course that also makes --new and --old work (even --ne and --ol), but
> we generally accept that in other places, so... :)

I do wonder if abbreviation should have some limit (ie single-letter
abbreviation sounds very suspect even if they are unique, and even
two-letter ones sound odd), but it probably doesn't matter.

> I see this interacts nicely with the -I option, at least in my testing,
> i.e. (with my change applied) this will ignore the first hunk of your
> patch:
>
>     --new -p -I'sign|return'

So it wasn't really intentional - I saw it _purely_ as a "filter
output" thing, not as a "filter the patch generation".

In fact, I like the part where it often shows patch hunks that have no
actual changes, because the only changes in that hunk were removals.
To me, that's a feature - it shows the end result of the patch in that
place.

But it also means:

> What this doesn't interact "well" with, or perhaps it's what we actually
> want is e.g. -G:

Yeah, exactly because I saw it as purely a "filter the final output of
the patch" thing, it means that things that filter on the *contents*
of the patch aren't affected.

So that was my mental model, but yes, if your mental model is that
"-G" acts on the output, then it's a mis-feature.

IOW, to me, this would be a bigger decision about what kinds of
semantics you want.

Now, the *real* downside of "--new" to me is that it really doesn't
work very well with --word-diff. That's where I think it would really
make sense to still work just fine. Particularly with
"--word-diff=3Dcolor" I think "--new" (and "--old") would make a lot of
sense, but my patch very much did *not* change the word-diff output
machinery to take the output_indicators into account.

A big reason for that is that while I occasionally use --word-diff
(and find it very useful when I do), I've never touched that code, so
it's entirely unfamiliar to me.

                      Linus
