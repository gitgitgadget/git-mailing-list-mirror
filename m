Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7133C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 10:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982A320726
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 10:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Kcv2Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgBGKCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:02:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35022 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGKCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 05:02:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so1935364wrt.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MiCoMWaN0SG4AfLsUL1ie77g0praqz1AAwafadiJ7O0=;
        b=Z6Kcv2BlmddXGBuhazQmtJc9wwaCpX6maL40JgDsbi8CQavac3b3oC8tqS5R5/bmzX
         eZ0yeFz/8eQkcxrUxx01Dnsum8aZRbr2y2pZQd/kQq6t01PcbcuZo9qF/f/uypm9U+Xe
         OXPtu6hPRT4pb51O2k01+RGTFLCkVfg3ii4IPF4HRQm3/AfNQC9MpCRHyWV7xKTKpkUr
         7Vq5+lt//WypJPZYb1wZZV1O1qvh+zwEnI4M3Ol/0O5KgoAr0gmR0wnto3TML+K1uVLi
         Gp8jJjoXf7nvrzwWkJvnufHjA7J5DyVN8BADfY61jTu0W7S9UAgevn3wa89lwceDPKCQ
         A0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MiCoMWaN0SG4AfLsUL1ie77g0praqz1AAwafadiJ7O0=;
        b=jaJpa2qPKl5zRvkID6fUnD3gVnHlnXYxdT8apRO8Xmd77pHnmFnGXE6DYa58A6d72H
         II7I99WaUK4JS8GHWYm8XOnsa67wOSaZTBcUKhe2Oa0aRfpjS0K88AP2YTOeXApmsjwH
         tSeOfAdudrZIVNMIg2bQTt7hqjpBQX6Bujd5U/St9Ea2qDcc6twFiLOffu0ok0gf/BPx
         oAkdDxZtzTfS6rhTJBOVxJFw8p4WoUFzsK/6lr011QKpMGjSmNzO2UV/eMVqVXX5vo5t
         yYTgHUDck2PYMpLF4ziwTH9Uke+3NwoMyp0QXR9kYIJNQT9jlnmmwY8LhZk5ymkUeClW
         JHDQ==
X-Gm-Message-State: APjAAAVfAj1kFqALr+ocm8no4/v2tm5jUeKpOGEdQ69OkdPFt8txB7Wt
        3vdUZoOj4siH9Fchc30OZCA=
X-Google-Smtp-Source: APXvYqwZL3ZGcw1iUL1GD8o1pR1Ih98iecBF9nL8S2LJE4tUpD8znQIYs7QIw9UZ27Sbx7evXqW34w==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr3988466wru.170.1581069772997;
        Fri, 07 Feb 2020 02:02:52 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id b18sm2714024wru.50.2020.02.07.02.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 02:02:51 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:02:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
Message-ID: <20200207100247.GA1111@szeder.dev>
References: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev>
 <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev>
 <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev>
 <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
 <20200131161630.GG10482@szeder.dev>
 <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 11:26:56PM +0100, Marc-André Lureau wrote:
> > > > > > > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > > > > > > > > Taking a deeper look at the code, I'm wondering it would make more
> > > > > > > > > sense to call wt_status_get_state(), which handles 'rebase' and
> > > > > > > > > 'bisect'. Is there a reason that you limited this check to only
> > > > > > > > > 'rebase'?
> > > > > > > >
> > > > > > > > What branch name does wt_status_get_state() return while bisecting?
> > > > > > > > The branch where I started from?  Because that's what 'git status'
> > > > > > > > shows:
> > > > > > > > But am I really on that branch?  Does it really makes sense to edit
> > > > > > > > the description of 'mybranch' by default while bisecting through an
> > > > > > > > old revision range?  I do not think so.
> > > > > > >
> > > > > > > It's not clear what downside you are pointing out; i.e. why would it
> > > > > > > be a bad thing to be able to set the branch description even while
> > > > > > > bisecting -- especially since `git status` affirms that it knows the
> > > > > > > branch?
> > > > > >
> > > > > > No, during a bisect operation 'git status' knows the branch where I
> > > > > > _was_ when I started bisecting, and where a 'git bisect reset' will
> > > > > > eventually bring me back when I'm finished, and that has no relation
> > > > > > whatsoever to the revision range that I'm bisecting.
> > > > > >
> > > > > > Consider this case:
> > > > > >
> > > > > >   $ git checkout --orphan unrelated-history
> > > > > >   Switched to a new branch 'unrelated-history'
> > > > > >   $ git commit -m "test"
> > > > > >   [unrelated-history (root-commit) 639b9d1047] test
> > > > > >   <...>
> > > > > >   $ git bisect start v2.25.0 v2.24.0
> > > > > >   Bisecting: 361 revisions left to test after this (roughly 9 steps)
> > > > > >   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
> > > > > >   $ git status
> > > > > >   HEAD detached at 7034cd094b
> > > > > >   You are currently bisecting, started from branch 'unrelated-history'.
> > > > > >     (use "git bisect reset" to get back to the original branch)
> > > > > >
> > > > > >   nothing to commit, working tree clean
> > > > > >
> > > > > > I can't possible be on branch 'unrelated-history' during that
> > > > > > bisection.
> > > > > >
> > > > > >
> > > > > > OTOH, while during a rebase we are technically on a detached HEAD as
> > > > > > well, that rebase operation is all about constructing the new history
> > > > > > of the rebased branch, and once finished that branch will be updated
> > > > > > to point to the tip of the new history, thus it will include all the
> > > > > > commits created while on the detached HEAD.  Therefore, it makes sense
> > > > > > conceptually to treat it as if we were on the rebased branch.  That's
> > > > > > why it makes sense to display the name of the rebased branch in the
> > > > > > Bash prompt, and that's why I think it makes sense to default to edit
> > > > > > the description of the rebased branch without explicitly naming it.
> > > > > >
> > > > > > With bisect that just doesn't make sense.
> > > > >
> > > > > If the range you are bisecting belongs or lead to the current branch,
> > > > > that still makes sense. And it's probably most of the time. So, I am
> > > > > not sure your objection is valid enough here.
> > > >
> > > > I'm not sure what you mean with "belongs or lead to" a branch.
> > > >
> > > > Do you mean that the range is reachable from the branch that just so
> > > > happened to be checked out when the bisection was started?  Well, I
> > > > have over 30 branches from where v2.25.0 is reachable, and all of them
> > > > are obviously bad candidates for editing their descriptions by default
> > > > while bisecting a totally unrelated issue.
> > > >
> > >
> > >
> > > If we take that simple example:
> > >
> > > * (my-branch)
> > > *
> > > * bisect bad
> > > *
> > > * (HEAD)
> > > * bisect good
> > > *
> > >
> > > It makes a lot of sense to me to edit my-branch description by
> > > default, even if the range good-bad happen to exist in other branches.
> >
> > I still don't understand why it would make sense.
> >
> > Furthermore, how do you think you could avoid choosing an obviously
> > bad branch to default to?
> 
> It uses the same branch that git status displays. In your example:
> 
> You are currently bisecting, started from branch 'unrelated-history'.

Yes, that's the problem: it shows "started from branch", not "On
branch".  Conceptually a huge difference.

> So it's not completely off to pick that branch by default for
> --edit-description.
> 
> But again, I think you are focusing on a rather rare case, please
> consider the most common case.

I do focus on the most common case: I'm on branch 'foo' built on top
of current master, when a bugreport comes in, and I start bisecting on
the range v2.12.0..v2.16.0.  It can not possibly be considered that
during the bisect I'm on the branch 'foo' during the bisection, they
are totally unrelated.


