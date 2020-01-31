Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79297C35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4457420661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxEO8Btz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgAaPwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:52:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39202 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAaPwe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 10:52:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so9170758wrt.6
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 07:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gu/agncmNkZGBITubZfDcQEALaJu785v9MK3LpePjsI=;
        b=fxEO8BtzFusK3nwjU1BIYYgj7P0a5cYopDh1xeWgJpzz97wrAR5fBi4Mzesg07DVIX
         hjjFyoBRdI8hBX+p2vH9RJSludfqISNvJE1cYJNTvabnC4jqj3ooFJChkjkbIaOI/nNV
         n6wctCiinJheKuv9Ca+/94N9KXPingzheuTyXFfhc3UELOz4wgM8aGR0znajJG5cMlln
         p6wzizmpUNRk4y6zZaUlLbYO+QkMLuGdAniAaDts3ikKxWWmwvTJWJwNOyfeQyrAPULO
         FiiTbdP3mP4sgWwKFiTxsklCq9p9ULYp7Wl9kMI7WJNibpSKNRqtpM8okNKPRQSm5ITy
         2fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gu/agncmNkZGBITubZfDcQEALaJu785v9MK3LpePjsI=;
        b=NVseMYcT99ZWSj3aixOzo2Jsq48B7OWcVti3KBvIUpMWFBLsN0CsQ5rxlQf815VMsp
         n5QyY/ctu2+57RVetTrEH19xVL8QzAc6/T4zXT2DPKYzrRlgZflle5N3R8O3dd9mZWCV
         icHhD0X7bGJnfeCwAOBl3NfpMtXrjSeBmAOQRAd3Ejo9fu78lsRnIRqaisCnpNrLjSMQ
         VcFm6dyxVd9dxX+/9pHp6NvrDQcpDHdOqlYS0jBc/W9DLsrqbMak8awBDL7ig9dKuKFd
         OXsPqXnOjDrMH6y4qCbZ6XZrJdxNz0vqSuGrz85p+mOsSpRvDwFk/6zp4AVMqg6vfGgr
         DirQ==
X-Gm-Message-State: APjAAAW/JD75OigcLr83alKD6Emnobd3lUcZ7aEEvrac3xanxv9w3HKp
        TARcJuRbqYQPyztyTZjcM6s=
X-Google-Smtp-Source: APXvYqyAfCc0RUUXP+BHc4NbZFWq/Ltq3qvpkYOVvfgmCajCigY4xMaa6DDQ102l5LecjE3IABtPkw==
X-Received: by 2002:adf:ec06:: with SMTP id x6mr12363162wrn.335.1580485952212;
        Fri, 31 Jan 2020 07:52:32 -0800 (PST)
Received: from szeder.dev (x4db61755.dyn.telefonica.de. [77.182.23.85])
        by smtp.gmail.com with ESMTPSA id t10sm10792502wmi.40.2020.01.31.07.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 07:52:31 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:52:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
Message-ID: <20200131155228.GF10482@szeder.dev>
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev>
 <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev>
 <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 10:37:38PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jan 24, 2020 at 11:41 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Sun, Jan 12, 2020 at 08:59:04PM -0500, Eric Sunshine wrote:
> > > On Sun, Jan 12, 2020 at 7:14 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > > > > Taking a deeper look at the code, I'm wondering it would make more
> > > > > sense to call wt_status_get_state(), which handles 'rebase' and
> > > > > 'bisect'. Is there a reason that you limited this check to only
> > > > > 'rebase'?
> > > >
> > > > What branch name does wt_status_get_state() return while bisecting?
> > > > The branch where I started from?  Because that's what 'git status'
> > > > shows:
> > > > But am I really on that branch?  Does it really makes sense to edit
> > > > the description of 'mybranch' by default while bisecting through an
> > > > old revision range?  I do not think so.
> > >
> > > It's not clear what downside you are pointing out; i.e. why would it
> > > be a bad thing to be able to set the branch description even while
> > > bisecting -- especially since `git status` affirms that it knows the
> > > branch?
> >
> > No, during a bisect operation 'git status' knows the branch where I
> > _was_ when I started bisecting, and where a 'git bisect reset' will
> > eventually bring me back when I'm finished, and that has no relation
> > whatsoever to the revision range that I'm bisecting.
> >
> > Consider this case:
> >
> >   $ git checkout --orphan unrelated-history
> >   Switched to a new branch 'unrelated-history'
> >   $ git commit -m "test"
> >   [unrelated-history (root-commit) 639b9d1047] test
> >   <...>
> >   $ git bisect start v2.25.0 v2.24.0
> >   Bisecting: 361 revisions left to test after this (roughly 9 steps)
> >   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
> >   $ git status
> >   HEAD detached at 7034cd094b
> >   You are currently bisecting, started from branch 'unrelated-history'.
> >     (use "git bisect reset" to get back to the original branch)
> >
> >   nothing to commit, working tree clean
> >
> > I can't possible be on branch 'unrelated-history' during that
> > bisection.
> >
> >
> > OTOH, while during a rebase we are technically on a detached HEAD as
> > well, that rebase operation is all about constructing the new history
> > of the rebased branch, and once finished that branch will be updated
> > to point to the tip of the new history, thus it will include all the
> > commits created while on the detached HEAD.  Therefore, it makes sense
> > conceptually to treat it as if we were on the rebased branch.  That's
> > why it makes sense to display the name of the rebased branch in the
> > Bash prompt, and that's why I think it makes sense to default to edit
> > the description of the rebased branch without explicitly naming it.
> >
> > With bisect that just doesn't make sense.
> 
> If the range you are bisecting belongs or lead to the current branch,
> that still makes sense. And it's probably most of the time. So, I am
> not sure your objection is valid enough here.

I'm not sure what you mean with "belongs or lead to" a branch.

Do you mean that the range is reachable from the branch that just so
happened to be checked out when the bisection was started?  Well, I
have over 30 branches from where v2.25.0 is reachable, and all of them
are obviously bad candidates for editing their descriptions by default
while bisecting a totally unrelated issue.

