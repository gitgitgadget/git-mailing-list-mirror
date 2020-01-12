Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4954C32771
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ED121744
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 12:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZiwtrzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbgALMOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 07:14:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39434 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732726AbgALMOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 07:14:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so5854076wrt.6
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 04:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HuAfVlM9+/knOrt1lf1rAilNurcggdYdYEtoMtbs4i4=;
        b=XZiwtrzYk/h2rv052P8NJRAcMYOnwaOfuDZq8L9Dc8dNempnR3gcMHFC6p0qPjXQLF
         SC5+BEocgAfRjEB/hdsfrTkIbFU12XW77phpj8bFKQmyGNf/YLKqZIPiHBuE0FBI/FOh
         1S2gvp3nQWq1zCVlEAI9hTcC5yxmS1XgcmmXz0racFa0UtkWT4ii2RToVgLk/B1yYUPE
         lbGMJsSpdsqEdHNVNGm6YVz6GYIRGP4yM+sUnHcv1ox2QXnd7krpPf74EXCLcYewAS9P
         ElFsR/KjmR1tCEqXy7I2mMVJ/ktSnyoPYwlNIy+v0Qr1hbL5n92mfsYSNN1XWeEPu3Dn
         7iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HuAfVlM9+/knOrt1lf1rAilNurcggdYdYEtoMtbs4i4=;
        b=eoQigFNdUx+5iMfmdqhN4thbMGqckQtREKyZTzQG2T669zruuNckXCWrk89plBvxFR
         UCQkOd+5FJQAfeFw6qLwrxvYZ4D70yqXuczRM/9X2r0PJO96jlGezWV2646DZniKtWvU
         HVhCEkNoXOhUz8eAM7r2bEXstBKgUnV6Ko482OKxOEMfAau0CrU/BeFWFYF6WvDozUs1
         iEq94qwqQBPgkZJOVjdrsAH2aURvUvg6WKfLjd1L4JiViYmFNnTXxSzlZh6/wuS9SSmg
         C4/UPc8ctWAp2pxP7qJDWi9WwmMucLLV26Al//zX8qcUxiVfXa0/FUsqOWsS2KbQeWGm
         AlLg==
X-Gm-Message-State: APjAAAWT/AAi18bnJ7M9gnyTNGllMqTr/udEYKUZPVRHqRDMaLlogWl3
        fQx3wtE/mwBgLKvcC6+XppY=
X-Google-Smtp-Source: APXvYqxMABiWpeF1zO77KcG6Z7+lDIga7qASbseq51T5txeXcDdia08x74U8MCNAEPq+AdLebB+mKg==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr12935227wrw.313.1578831246471;
        Sun, 12 Jan 2020 04:14:06 -0800 (PST)
Received: from szeder.dev (x4dbd0e19.dyn.telefonica.de. [77.189.14.25])
        by smtp.gmail.com with ESMTPSA id t81sm9773842wmg.6.2020.01.12.04.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 04:14:05 -0800 (PST)
Date:   Sun, 12 Jan 2020 13:14:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
Message-ID: <20200112121402.GH32750@szeder.dev>
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> On Sat, Jan 11, 2020 at 9:55 AM Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
> > On Sat, Jan 11, 2020 at 5:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Sat, Jan 11, 2020 at 7:36 AM <marcandre.lureau@redhat.com> wrote:
> > > > +                               if (wt_status_check_rebase(NULL, &state)) {
> > > > +                                       branch_name = state.branch;
> > > > +                               }
> 
> Taking a deeper look at the code, I'm wondering it would make more
> sense to call wt_status_get_state(), which handles 'rebase' and
> 'bisect'. Is there a reason that you limited this check to only
> 'rebase'?

While I do think that defaulting to edit the description of the
rebased branch makes sense, I'm not sure how that would work with
bisect.

What branch name does wt_status_get_state() return while bisecting?
The branch where I started from?  Because that's what 'git status'
shows:

  ~/src/git (mybranch)$ git bisect start v2.21.0 v2.20.0
  Bisecting: 334 revisions left to test after this (roughly 8 steps)
  [b99a579f8e434a7757f90895945b5711b3f159d5] Merge branch 'sb/more-repo-in-api'
  ~/src/git ((b99a579f8e...)|BISECTING)$ git status 
  HEAD detached at b99a579f8e
  You are currently bisecting, started from branch 'mybranch'.
    (use "git bisect reset" to get back to the original branch)
  
  nothing to commit, working tree clean

But am I really on that branch?  Does it really makes sense to edit
the description of 'mybranch' by default while bisecting through an
old revision range?  I do not think so.

> > > >                 if (edit_branch_description(branch_name))
> > > >                         return 1;
> > > > +
> > > > +               free(branch_name);
> > >
> > > That `return 1` just above this free() is leaking 'branch_name', isn't it?
> >
> > right, let's fix that too
> 
> Looking at the code itself (rather than consulting only the patch), I
> see that there are a couple more early returns leaking 'branch_name',
> so they need to be handled, as well.

'git branch --edit-description' is a one-shot operation: it allows to
edit only one branch description per invocation, and then the process
exits right away, whether the operation was successful or some error
occurred.  I'm not sure free()ing 'branch_name' is worth the effort
(and even if it does, I think it should be a separate preparatory
patch).
