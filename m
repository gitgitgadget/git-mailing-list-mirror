Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62246C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbhKZWu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbhKZWs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:48:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D6C061792
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:43:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so44046727eds.10
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ViO1E5aE4/0Cf7vKreHgF1Oz/KPw51f7loaJ2vlV6uU=;
        b=PXgVgO8LiBmtJZkj57PSDACOjfgSPAouozi7kXQd+TzwMR+VXWrUvIUigB8v9OK8oN
         O9BhBV7F/p8MMSy6XCIPBX1vKyIJIOp6gpm1ATvRw2xAiAN5ddtd4qNsuJJN1KNBGAN7
         yhRQSw4TQMxIZEPi76ayHAa2Vz3+jjjabziBgaRlMvfGxSlJjVrsW8mjJup1QFnszQ7j
         0dYaxDPezvW7hhAs2v0AX9JwPyd/Ewn6WDMNAiVHPZSy2mgRFk3zdD3y092mrN8CRgU7
         TtBtck9CyACcqSJW1p7tjRNtMcne7H2pQp1mOJM0LOQuFPjncIrz/3UlHX/tHJJIHHDQ
         0Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ViO1E5aE4/0Cf7vKreHgF1Oz/KPw51f7loaJ2vlV6uU=;
        b=lShoMm68CYGLteaAaeyd/HIaIWcXizb8Gjj5EiQxXgS8vvSbrlpN2zwYAvnAd7MKTy
         MM6zAefvkxhLjNZcS4q8J/wOv5SlaNs2doEDpJ5K4NW/YFauAZVoe2d5kBRnrFT/yrF4
         Os4nKGnvQ2nj+7j4/135LnlIwy+HJwo723pRFw4WE3oi97dKftNT9PP+uHwN1kZ5vRpS
         k0Jb+1izcDEUswpYS3mMmaAf0YDYd74p+Iz9x8VWPxtlLoRAS8HzQwOhE4AokZYDxWcH
         1ekXgScNd6nE7lhXso8kd7wWj3CVpe4RW90MSioQd9iidERj58+9D9VB3lzOer7UAxfb
         IwwQ==
X-Gm-Message-State: AOAM533lxM3/26dtN/i8Gq1CzJHCfx5bFZbtTQv7WB2t7TNbVqLN/Iaz
        gr0z1qNbmRe/IH+WSmgcRCWwY5DD6E49a+QvMJFyXD/HqBE=
X-Google-Smtp-Source: ABdhPJxN1CQxsDkQvXV/eOqD/05gml0Spb9ip5/W0zKEPMBdQkYbS1bBWDb19DQ2ao54XiF8UFqN3pJaMHlw7Kd5jdc=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr42756650ejc.74.1637966635919;
 Fri, 26 Nov 2021 14:43:55 -0800 (PST)
MIME-Version: 1.0
References: <YYFEE/2g3SiM04zx@hades.panopticon> <YYFJEASSimMhEsYz@coredump.intra.peff.net>
 <YaEh+k2q+9LoLXNh@hades.panopticon> <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
 <YaFViM1tTTAc48ZG@coredump.intra.peff.net>
In-Reply-To: <YaFViM1tTTAc48ZG@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 14:43:44 -0800
Message-ID: <CABPp-BGC5DrArqWMiwwpJQgK8WucVcAxj0Ptgpi+_KRb7V7Nwg@mail.gmail.com>
Subject: Re: pull.rebase config option broken in 2.33.1
To:     Jeff King <peff@peff.net>
Cc:     Dmitry Marakasov <amdmi3@amdmi3.ru>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 1:45 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 26, 2021 at 04:44:52PM -0500, Jeff King wrote:
>
> > +cc Alex and Elijah from the original 3d5fc24dae (pull: abort if
> > --ff-only is given and fast-forwarding is impossible, 2021-07-21) in
> > case they have further thoughts, but I _think_ this is working as
> > designed.
>
> Whoops, forgot the cc. Original message in full below.

I believe this was already fixed in 2.34.1 in commit ea1954af77
("pull: should be noop when already-up-to-date", 2021-11-17).



> > On Fri, Nov 26, 2021 at 09:05:46PM +0300, Dmitry Marakasov wrote:
> >
> > > * Jeff King (peff@peff.net) wrote:
> > >
> > > > > After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> > > > > no longer works: `git pull` no longer tries to rebase (however manual
> > > > > `git pull --rebase` works fine):
> > > > >
> > > > > % git config pull.rebase
> > > > > true
> > > > > % git pull
> > > > > fatal: Not possible to fast-forward, aborting.
> > > > > % git pull --rebase
> > > > > Successfully rebased and updated refs/heads/local-fixes.
> > > > > % git pull
> > > > > fatal: Not possible to fast-forward, aborting.
> > > > > % grep -C1 rebase .git/config
> > > > > [pull]
> > > > >         rebase = true
> > > > > [rebase]
> > > > >         autostash = true
> > > > >
> > > > > After downgrade to 2.33.0:
> > > > >
> > > > > % git pull
> > > > > Current branch local-fixes is up to date.
> > > >
> > > > This looks like the same bug discussed in:
> > > >
> > > >   https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/
> > > >
> > > > There's a fix in that thread. It's currently in "next", but didn't quite
> > > > make the cutoff for the upcoming v2.34.0.
> > >
> > > For the record, the problem is still present in 2.34.1
> >
> > In the bug I linked (and what got fixed in 2.34.1), the issue is that
> > when the local branch is ahead of the remote, we don't say "up to date",
> > but complain about fast-forwards.
> >
> > It's hard to tell from the output above, but it looks like you have a
> > case where there are new commits both locally and on the remote? In
> > which case a rebase would work just fine.
> >
> > But why are we complaining about "not possible to fast-forward"? Testing
> > locally with something like:
> >
> > -- >8 --
> > git init repo
> > cd repo
> >
> > commit() {
> >       echo $1 >$1
> >       git add $1
> >       git commit -m $1
> > }
> >
> > git checkout -b local
> > commit base
> > commit local
> >
> > git checkout -b remote HEAD^
> > commit remote
> >
> > git checkout local
> > git config pull.rebase true
> > git pull . remote
> > -- >8 --
> >
> > shows that we do rebase. If I set:
> >
> >   git config pull.ff only
> >
> > then we start complaining. And that behavior did change in 2.33.1, but
> > I'm not sure it's wrong. We have two conflicting config options, and the
> > precedence for which one we pick switched.
> >
> > Do you have that option set in your config? Try:
> >
> >   git config --show-origin --show-scope --get-regexp 'pull\..*'
> >
> >
> > -Peff
