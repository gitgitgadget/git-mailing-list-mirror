Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C213C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 16:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1DA2082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9JS5FMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAaQQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:16:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38372 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAaQQg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 11:16:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so9307205wrh.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NDz3HBkR5ANUMKcEBIE958ycHDVXC9wwvqns6WCi360=;
        b=F9JS5FMH1dNkiCmbPo/U1d6J2dRhQPv26g4B/yc/ToaCrcmEFb/XwGAAx19q18n4LX
         DaWOzkwPLp8CtMc9nlrsK42FJXUp+XDtwvgGHZs5Yy8VVAd0jAqiogL1+ThJdUwEynBB
         U7Ar42DvKTq9E7LR/lmyMPPYYRNlHVAuiskoOLGk2J//feZIebOhjc7QmKoS/7Ib4zo8
         QMIRRxCdD/BuiPzEK/J4Zq8yr/PurR4RxermfEREeLuo0qKqaokQe2+m2iyRaYKPf7Cm
         2M+RrGTv1JX5iPYHz9WFv9FX7vSZqcZA+Xs2BbNv9KaIKpw1pue/ZUmOcjihmSpJ2YtO
         0ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NDz3HBkR5ANUMKcEBIE958ycHDVXC9wwvqns6WCi360=;
        b=CmCqaSmn0Ig2BEfHovKblZ2AM9kA8MCYc9jH4506x4+aqaJEdxwSUr6a7kASbeL6/a
         xL0JjB2nx6XHCq7ft7VLeFzWNS+dF4l++jJ8cBuIWpgTo1CIn+jpDeDsfEwP9yff80w2
         8ghNGj1e6p/tKMO4aUPkQaPSe6kMszGS1+DvHVQ0Vsr5bgK05mKeDLBgjFYXuEvQ3Dbx
         Ja2iBZeqcQv7HIzoLL2mqfeSF0O6E4a4zQJbji1dhu9X7lv1TTGhLWstk6I/wvRE17np
         KqQSrR7DMc54B4k52P8ErGkjM7wxGSkCpVhHeDfoR/y8/IwJ7qrhJssmCo9lBnMrM1SO
         K9hA==
X-Gm-Message-State: APjAAAV1Rw9PM3q+PmUn6mY13EsCyvOgG4/FCK2GTyFEPfBVNn8qCSk9
        CuA9puRQdJbneoFQcz6+URTmyUbE
X-Google-Smtp-Source: APXvYqw6I9ilKKKmjilW8P4ixzh0fq6wdfsPDCi1yEecgCGvk0oj1oKS9tpxyxJB5ZgkHgWkcdgyuA==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr12417423wrs.330.1580487393333;
        Fri, 31 Jan 2020 08:16:33 -0800 (PST)
Received: from szeder.dev (x4db61755.dyn.telefonica.de. [77.182.23.85])
        by smtp.gmail.com with ESMTPSA id z10sm10821957wmk.31.2020.01.31.08.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 08:16:32 -0800 (PST)
Date:   Fri, 31 Jan 2020 17:16:30 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
Message-ID: <20200131161630.GG10482@szeder.dev>
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev>
 <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev>
 <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev>
 <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 04:59:15PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jan 31, 2020 at 4:52 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Thu, Jan 30, 2020 at 10:37:38PM +0100, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Fri, Jan 24, 2020 at 11:41 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > > >
> > > > On Sun, Jan 12, 2020 at 08:59:04PM -0500, Eric Sunshine wrote:
> > > > > On Sun, Jan 12, 2020 at 7:14 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > > > > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > > > > > > Taking a deeper look at the code, I'm wondering it would make more
> > > > > > > sense to call wt_status_get_state(), which handles 'rebase' and
> > > > > > > 'bisect'. Is there a reason that you limited this check to only
> > > > > > > 'rebase'?
> > > > > >
> > > > > > What branch name does wt_status_get_state() return while bisecting?
> > > > > > The branch where I started from?  Because that's what 'git status'
> > > > > > shows:
> > > > > > But am I really on that branch?  Does it really makes sense to edit
> > > > > > the description of 'mybranch' by default while bisecting through an
> > > > > > old revision range?  I do not think so.
> > > > >
> > > > > It's not clear what downside you are pointing out; i.e. why would it
> > > > > be a bad thing to be able to set the branch description even while
> > > > > bisecting -- especially since `git status` affirms that it knows the
> > > > > branch?
> > > >
> > > > No, during a bisect operation 'git status' knows the branch where I
> > > > _was_ when I started bisecting, and where a 'git bisect reset' will
> > > > eventually bring me back when I'm finished, and that has no relation
> > > > whatsoever to the revision range that I'm bisecting.
> > > >
> > > > Consider this case:
> > > >
> > > >   $ git checkout --orphan unrelated-history
> > > >   Switched to a new branch 'unrelated-history'
> > > >   $ git commit -m "test"
> > > >   [unrelated-history (root-commit) 639b9d1047] test
> > > >   <...>
> > > >   $ git bisect start v2.25.0 v2.24.0
> > > >   Bisecting: 361 revisions left to test after this (roughly 9 steps)
> > > >   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
> > > >   $ git status
> > > >   HEAD detached at 7034cd094b
> > > >   You are currently bisecting, started from branch 'unrelated-history'.
> > > >     (use "git bisect reset" to get back to the original branch)
> > > >
> > > >   nothing to commit, working tree clean
> > > >
> > > > I can't possible be on branch 'unrelated-history' during that
> > > > bisection.
> > > >
> > > >
> > > > OTOH, while during a rebase we are technically on a detached HEAD as
> > > > well, that rebase operation is all about constructing the new history
> > > > of the rebased branch, and once finished that branch will be updated
> > > > to point to the tip of the new history, thus it will include all the
> > > > commits created while on the detached HEAD.  Therefore, it makes sense
> > > > conceptually to treat it as if we were on the rebased branch.  That's
> > > > why it makes sense to display the name of the rebased branch in the
> > > > Bash prompt, and that's why I think it makes sense to default to edit
> > > > the description of the rebased branch without explicitly naming it.
> > > >
> > > > With bisect that just doesn't make sense.
> > >
> > > If the range you are bisecting belongs or lead to the current branch,
> > > that still makes sense. And it's probably most of the time. So, I am
> > > not sure your objection is valid enough here.
> >
> > I'm not sure what you mean with "belongs or lead to" a branch.
> >
> > Do you mean that the range is reachable from the branch that just so
> > happened to be checked out when the bisection was started?  Well, I
> > have over 30 branches from where v2.25.0 is reachable, and all of them
> > are obviously bad candidates for editing their descriptions by default
> > while bisecting a totally unrelated issue.
> >
> 
> 
> If we take that simple example:
> 
> * (my-branch)
> *
> * bisect bad
> *
> * (HEAD)
> * bisect good
> *
> 
> It makes a lot of sense to me to edit my-branch description by
> default, even if the range good-bad happen to exist in other branches.

I still don't understand why it would make sense.

Furthermore, how do you think you could avoid choosing an obviously
bad branch to default to?

