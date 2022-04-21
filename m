Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A6FC433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 10:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388067AbiDUKH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiDUKH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 06:07:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21713F29
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 03:05:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y10so8921654ejw.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9HAjynk1YeKcaIWWgCRERTsbThmOOI/0n0cIWDL65I=;
        b=c2Lh2j4yfvALf/XdCTg/IYtxgc6uGnz14ESDjvQsMRL5WFJwfI5QhEkErhWfdHKEnd
         UJdzndzDjb7Ti+y299BmA0JJha2sruWnFjobVkdn1381lUx6oFajaV7qDUywEomxr6cW
         N7OgS08g0W9Cof9c6uDA4DMH2nt1exfFCdBVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9HAjynk1YeKcaIWWgCRERTsbThmOOI/0n0cIWDL65I=;
        b=6+KqvI0/uccDpYzEvpJ4QXcJYPH67xmn1Jcf4GUsGgxXscKkW1x4mZ60B/TxcSmeMB
         GA8i+j2lnJUYxho0ZL3EjHkeyHy1Cj1ntHTKN3j9SGMnpHoUhdYcrSUd7C6S9JkgtRmg
         k1hYBWDSM5amAS3taj0ci4zNDZ46ceHnFkCq3frboan1kzMLQKjjlKvHq1yP9okHSIa9
         KnoI1H+MOCbBuOmcrDtqu7vTeRNXj1MIINYCCU+CzeIhDWIEzOy+F3CZglH5+cZF7HBd
         OTtRW5iwlzS8SKJn0TbPBrRNT6Mv0B/tZ1SnoBLTXeTUTcl8zthUMTjue4zuNc+O2ZVc
         2iwQ==
X-Gm-Message-State: AOAM530/+ATDWIyRZvZrASVJa1LZi4Z0tPxsLgfcKiv3pC3pUUv2tnb5
        se/lGgJfMLQ2uQkxq/0J4bPACd4cj55ovSGMKk28cQ==
X-Google-Smtp-Source: ABdhPJwNSuOi9Q95/LOK3+2ByY13D/WR9kqSmsa71KuwyP2tLBc07q9+0WrUpAgJrfosxh7F2JyzNx0X5yPjw+Ru/Bs=
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id
 nd41-20020a17090762a900b006da79534df0mr22054311ejc.316.1650535506264; Thu, 21
 Apr 2022 03:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
 <xmqqczhbr6pv.fsf@gitster.g> <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
 <xmqqlevzkxrf.fsf@gitster.g>
In-Reply-To: <xmqqlevzkxrf.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 21 Apr 2022 12:04:54 +0200
Message-ID: <CAPMMpoiCD+fG=bs2j4Rin5Pvip9Mre9iqLcOb2LYnDQK9cuRxw@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 3:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > If they branched from a different-name remote branch (they created an
> > new / independent local branch), then no remote tracking relationship
> > will have been set up, and instead of the "fatal: The upstream branch
> > of your current branch does not match
> > the name of your current branch" error and advice, they will get a
> > much simpler error and advice:
> >
> > ---
> > fatal: The current branch whatevs has no upstream branch.
> > To push the current branch and set the remote as upstream, use
> >
> >     git push --set-upstream origin whatevs
> > ---
> >
> > When they follow those instructions, they will be in the "simple"
> > setup same as if they had just branched from same-name.
>
> Which means that they need to see an error once, offered to either
> set push.default or branch.autosetupmerge (it is not "and/or", but
> "or", because you want to tell them to set "instead of push.default,
> set branch.autosetupmerge"), and if they follow the latter, they have
> to then hit a different error and be told to do the "set-upstream"
> individually.

They don't *have* to hit that error, they can set --set-upstream
pre-emptively, but if they're "just following prompts" then that's
what happens, yes.

> I am wondering if that is more irritating than it is
> worth.  Instead, if you tell them to use branch.autosetupmerge=simple
> and use push.default to something better than simple, wouldn't that
> cover more cases and give fewer roadblocks to the end-user with
> unnecessary errors?

I think you're on to something I missed here.

Unfortunately, I'm not sure what "something better than simple" for
push.default actually is, in the current system.

The most obvious option is to set it to "current", so:
- you only get branch-time tracking for same-name branches because of
branch.autosetupmerge=simple, and
- you always get same-name pushes regardless of whether there is an
upstream or not thanks to push.default, so you never see a "do this
other thing to push" message...

But then you have a new problem: While new branches push consistently,
they never have an upstream tracking ref! This in turn means these
no-tracking-ref branches, although they push smoothly, do not show
ahead/behind state in "git status", and simply don't support a regular
"git pull". That's not "simple".

Where I think you're onto something, is that I believe there *should*
be a way to say "if I request a default push and there is *no* remote
tracking branch, then just push to the first remote, using the same
branch name, *and set up tracking*". Now that would be simple.

I don't know whether that behavior would require yet another
push.default value, or if there's a better way of integrating it into
the existing options/behaviors. I'm also not sure what should happen,
in this scheme, if I happened to clash/overlap with an existing remote
tracking branch. But this does seem like where I would like to end up.

>
> >> Setting the latter to 'simple'
> >> means there are *MORE* branches that do not have .remote/.merge set
> >> up, doesn't it?  Which in turn means that we are relying more on
> >> what push.default is set to, right?
> >
> > No
>
> Why no?  if setupauto is yes, then any new branch forked from a
> remote-tracking branch will get .remote/.merge set up, and with these
> specific configuration they can "push" back to the configured place.
> If it is set to simple, only new branches forked from a remote-tracking
> branch that happens to have the same name will get it, and others do
> not get .remote/.merge set up.

But as long as push.default is set to "simple", *which is the only way
you get the above message ever*, those cases where the new setupauto
option avoids a tracking branch altogether simply change the error
message from "your remote branch name does not match - you have lots
of options" to "you do not have a remote branch yet - push like this
(and you'll be all set for this branch henceforth)".

Insofar as you can only ever get the "you might want to set setupauto
to simple" message when push.default is set to simple, the set of
cases where you get an error on push ends up being the exact same set
of cases - you just get a clearer more sensible error.

> Which means user's "git push" will then
> consult push.default settings, and setting it right becomes more
> important, no?

If there were another push.default option that led to more automatic
*and* correct outcomes, I would agree - and I believe that pursuing
the existence of such an option makes sense.

Do you agree that none of the push.default options available today are
"right" for this flow? Do you have a preference or opinion as to
whether:
* push.default=current should be changed to set up tracking when absent, or
* push.default=simple should be changed to "simply" push and set up
tracking when there is no tracking, or
* a new push.default option should be introduced for this behavior, or
* some other configuration should be introduced to specify "and set up
tracking on default push if missing" (and if so, under what
circumstances should it kick in?)
