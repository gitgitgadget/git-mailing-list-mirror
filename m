Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B32C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 03:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7575F61106
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 03:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKDDXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 23:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhKDDXt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 23:23:49 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D180C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 20:21:08 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id v3so8301586uam.10
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 20:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kB8KqZVUJ6Z2bLiuM2ToRDBu+Rlpov+e2mFIq08IKuw=;
        b=jZvlJ1EO/ghZj5PQE7Uq40LC11jh/joaLgNCIMPXVxgQFrhbAWNFq7l8x1D7gH329B
         n8OlmgPCvj6R2+zgw7tbut1kjW/WFeA0Gf4jsE/ONN8oNbOp0CyCla6Dr5JNJ40cwZVF
         pMSelafytNLikYuMi80u7CsbU7yc/6LDScmmXulqyW7bDQ0+QNOtfkdyBHqivKK+U3K4
         +prc6Sem2+/VXVXxdK+fehVMswBNfxcfgo0CLyt/p3LF942IFdd9u31pw7CdcmG2s8lq
         QcG46lVtJunHhWDXYdRtfpJvTFVldiuZSkvvCitNZlPo7sgyh+mh6gEKOTSE+LucQcnv
         WEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kB8KqZVUJ6Z2bLiuM2ToRDBu+Rlpov+e2mFIq08IKuw=;
        b=2l4ykeWad6wNBAgnwnn4k/R1Q6OAMjQ0OnCJpAf4lgPZqef6HNFl8MmQgtE0hucryX
         7WO8T8VjNXm+9KYPcbDt30DuCP1a5Z7lq8586B8V5giMbRWmtpOY1PHeIPjHIQ0MliF2
         +J0+FNDYhq8h8jhGAi0hzGNcA2vM9LsipH/91u5YyUKCLVHVtPb1h1T7pa/Rp8vh8aQ1
         t2JnYJc51KDzqHYmIMXimS+nuP7NpvhP9ROZd8yXuaKhYBGA59n+zLPURKaQE8kOUOo0
         3ymfqEb0C6NtaX5VZl2J5tgiSKwHaKvdCNfRZy6E2+Ax0t3tDD+kGgkP71bzkY9SvIBN
         NWfg==
X-Gm-Message-State: AOAM5316X0xqRDy5413QY8pb2BBynB09VFeryLq+0j30lNo4Qgsf+lIb
        3CC2ra+WV+79XHCp6k3KLus12sGAxGoh06kmows=
X-Google-Smtp-Source: ABdhPJyA5GFKLS0mp/uxW88FeGvl6+TD3lZne3C7Qy5VP8Uf308E6lO53CR/hKPpmSq4PSQo+lrH0aE049tMWcUlAYY=
X-Received: by 2002:a67:e40d:: with SMTP id d13mr5298333vsf.11.1635996067207;
 Wed, 03 Nov 2021 20:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <CAPUEspjw4zypiywCBRc=y9uC4G5CKTE35GLVf_wDY436oO0C5w@mail.gmail.com> <YYNHb0qq2n5OWC+R@coredump.intra.peff.net>
In-Reply-To: <YYNHb0qq2n5OWC+R@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 3 Nov 2021 20:20:56 -0700
Message-ID: <CAPUEspjnu8ySiM5damzCoPWhLv+azZFxsZun5Lztjwd-fDopaw@mail.gmail.com>
Subject: Re: [PATCH] async_die_is_recursing: fix use of pthread_getspecific
 for Fedora
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 3, 2021 at 7:37 PM Jeff King <peff@peff.net> wrote:
> On Wed, Nov 03, 2021 at 07:23:23PM -0700, Carlo Arenas wrote:
> > > diff --git a/run-command.c b/run-command.c
> > > index 7ef5cc712a9..a82cf69e7d3 100644
> > > --- a/run-command.c
> > > +++ b/run-command.c
> > > @@ -1099,7 +1099,7 @@ static NORETURN void die_async(const char *err, va_list params)
> > >  static int async_die_is_recursing(void)
> > >  {
> > >         void *ret = pthread_getspecific(async_die_counter);
> > > -       pthread_setspecific(async_die_counter, (void *)1);
> > > +       pthread_setspecific(async_die_counter, &ret); /* set to any non-NULL valid pointer */
> >
> > I guess this would work, since the pointer is never dereferenced, but
> > the use of (void *)1 was hacky, and this warning seems like the right
> > time to make it less so.
> >
> > Would a dynamically allocated pthread_local variable be a better
> > option,  or even a static global, since we don't care about its value
> > so no need to worry about any races?
>
> Yeah, I had the same thought. I think what's in the patch above is OK in
> practice, but it sure _feels_ wrong to store the address of an auto
> variable that goes out of scope.
>
> I'm OK with it as a minimal fix, though, to get things unstuck. The
> commit message nicely explains what's going on, and the original (which
> it looks like blames to me ;) ) is pretty gross, too.

Agree it is OK as a minimal fix, but also AFAIK nothing is really
stuck either, so something as simple as :

  s/&ret/&async_die_counter/g

Would make it as minimal, and less likely to trigger something else in
the future (I am surprised nothing warns about local variables being
used out of scope).

Carlo
