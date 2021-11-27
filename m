Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A4C433EF
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 05:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhK0FcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 00:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbhK0FaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 00:30:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F0C061574
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 21:27:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e3so47128282edu.4
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 21:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmpYPeN2PTII2DpiY8fBWLBK4owTHEh4e5/8XUrG/uU=;
        b=lPNZgFG2zfb8yFdFdCUZuPMijt0sFbUWjhvQaapbZAF24VtizzkmudAPBWvzUgdXNX
         r6SNes5fQhamwK6TDyWDi2eXoKaF+xBDDYpH8v+F+h+MltAt4kipVXvjW3h22gf0JFPk
         Hlew4joXfxRP6bSKjorhpAOPiUzkVu/PTxwDy9qXAHJj1I7RoQu7nHl+28NyZ0KS0tOE
         iZC5XLvFE7wQkiNghpI1Iu/x6AFO7Aux/dpxt9ZBht3J5LKZiB+x08qqq5YJbUhJLdcl
         cf8AzYVnWljtkMJdI9rLZQbzTnjqt9y6h0z7hIc2syq7O4PRrwQA3eQemiFo46Ph/LD7
         iyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmpYPeN2PTII2DpiY8fBWLBK4owTHEh4e5/8XUrG/uU=;
        b=yffysrb54V05exqwsIi5vx5BhLaAwHlhYgSWX+h5QqJhRjCLDQNnlPQ6WlsjYQFNMk
         rBKeResBgC83WmVecHloLdUDHSdYa0yestwMLfdABO+E0bv4H5WEuv+nvXxUXsFhmmHg
         /t0l/GMp/anPQcDuglI2JsUXxYCgbMdK9QMY/Hd9aSY+xaOIPgyNR0Qd/PPtDh138fEA
         W+HitOdrrJTQ/5XrPZsE9HC1LjEV8LDIyz49Tz2ih3lWBPGE4CuzdGNGjKncZmPB6doW
         csFzZqVvvh5dMqbzegNB8FfWjVuHUBtgmUGVRROBMiUUyMfCFWLrzbjOwrmKBY8KzauP
         qmFA==
X-Gm-Message-State: AOAM531IZLp/K3iN5l7/Cg+/GSqJvIvyt5W8iaB9s6UeAmXlyIM8vgDH
        bD76iUlsXsqb3OWn3Zoqn/gk7iV2IbwM3eVtMu6hqaGJ
X-Google-Smtp-Source: ABdhPJw2umHgIuOCP+bkLKoG9hq4fB0LwGzulPIHSGchuU4mXJN/zWEti+s7xKeAg99J+J3JGIw4D2h0YsA0I81AnFQ=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr44162144ejc.520.1637990827267;
 Fri, 26 Nov 2021 21:27:07 -0800 (PST)
MIME-Version: 1.0
References: <YYFEE/2g3SiM04zx@hades.panopticon> <YYFJEASSimMhEsYz@coredump.intra.peff.net>
 <YaEh+k2q+9LoLXNh@hades.panopticon> <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
 <YaFViM1tTTAc48ZG@coredump.intra.peff.net> <CABPp-BGC5DrArqWMiwwpJQgK8WucVcAxj0Ptgpi+_KRb7V7Nwg@mail.gmail.com>
 <YaG8gUnikxtQs5zx@coredump.intra.peff.net>
In-Reply-To: <YaG8gUnikxtQs5zx@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 21:26:55 -0800
Message-ID: <CABPp-BGDFiAF=M=n8Ah7LZXk-f75NezF0F=BPD44a4fMrtsD-w@mail.gmail.com>
Subject: Re: pull.rebase config option broken in 2.33.1
To:     Jeff King <peff@peff.net>
Cc:     Dmitry Marakasov <amdmi3@amdmi3.ru>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 9:05 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 26, 2021 at 02:43:44PM -0800, Elijah Newren wrote:
>
> > On Fri, Nov 26, 2021 at 1:45 PM Jeff King <peff@peff.net> wrote:
> > >
> > > On Fri, Nov 26, 2021 at 04:44:52PM -0500, Jeff King wrote:
> > >
> > > > +cc Alex and Elijah from the original 3d5fc24dae (pull: abort if
> > > > --ff-only is given and fast-forwarding is impossible, 2021-07-21) in
> > > > case they have further thoughts, but I _think_ this is working as
> > > > designed.
> > >
> > > Whoops, forgot the cc. Original message in full below.
> >
> > I believe this was already fixed in 2.34.1 in commit ea1954af77
> > ("pull: should be noop when already-up-to-date", 2021-11-17).
>
> I thought that at first, too, but this case is a bit different:
>
> > > > In the bug I linked (and what got fixed in 2.34.1), the issue is that
> > > > when the local branch is ahead of the remote, we don't say "up to date",
> > > > but complain about fast-forwards.
> > > >
> > > > It's hard to tell from the output above, but it looks like you have a
> > > > case where there are new commits both locally and on the remote? In
> > > > which case a rebase would work just fine.
>
> I think the key thing here is that (AFAICT) the behavior is unchanged
> unless the user has set pull.ff=only explicitly.

Ah, I see there were two parts to their report, one of which is the
issue fixed in 2.34.1.  I'll respond to his original email and ask if
he has pull.ff=only set and explain how that interacts with
pull.rebase.
