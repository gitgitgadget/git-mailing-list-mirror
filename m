Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE985C2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 11:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F82221841
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 11:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlpC6Qji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632893AbgDPL0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633123AbgDPL0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 07:26:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DAC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 04:26:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d1so1547522pfh.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cby72P0m+K3YLOJfVEJoB0l2K60m6ZTR/mzapGuHuOo=;
        b=qlpC6QjianDn2QAtT50bkTNdPnmSZBaw9P5bSlEixzX6t9RLpOHOyNBEc6/ZQ9D6XJ
         wvsmZwJXyshJCZTyCp60P8LMXuAO1AustQXOGzCEklv0n6cIu1iH+v5tPAytPEfLyQFK
         FcuIhNQI2eDZUj3ffVhVvaBhxKhhos8ZLDOrDlOo9d8neBa3KcQ+uyzGSpl60o/T7LLY
         UmFxQsYRGSHx6gwgHGIHPwqhQ5hMFowXY1GWLpcpQ2VUxoMmpzkoMDz6j+8wSVKzYVXM
         X35GQDaKIA7ELS2dsGH0g3fznk2cQgcFKehLkhoDP4Y0x/x4pyy9eyyIbPhVjWUyxWD9
         1zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cby72P0m+K3YLOJfVEJoB0l2K60m6ZTR/mzapGuHuOo=;
        b=FPB0mFjI4L1fQZay8QQNXK3jRM4zN7KnvK1I7cpyNX4bV+QVe3PFmceLtMGellosDS
         7a+52WlZN5XKe+lU9nUsjI3BlNnbUTeHFrX4LMkroaxBqfzH8pbkoeFALkv7xdPFZgym
         OOvOxpnZcAUBd7fGmJtXAftjG7TBVes9i52GE3ZvLWXdXoKZWzOA4+AXZrxJEJHbu9Gi
         DUju9401Nk2O/+9SoOEtBGKQsKSR2809RNgMbXAwRBWfR87STnWdgadXhZ02FUA2fj48
         NwV7Gpllh9+ZEYlN9qT/cM3ngh3oHr9YyKvIksj+Tz+T7OTGVuzdlgqqlnSG5zr7qr3p
         OU3w==
X-Gm-Message-State: AGi0PubOO4MsusCfRI5KdAiYs0/glUbjXpMtPHcL61KoATkhfOcZ+NxL
        +IKHKB6aRuZ0/1DaghQK25k=
X-Google-Smtp-Source: APiQypLdm/ZKiHvxNw1IPcwOnDGXjqz+ZMckl4Y/TFbWgm5eIV5awK4wrL1ASP2RG93dBA7zP9nHXg==
X-Received: by 2002:a62:92:: with SMTP id 140mr31121041pfa.186.1587036367571;
        Thu, 16 Apr 2020 04:26:07 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id i190sm14546038pfc.119.2020.04.16.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 04:26:06 -0700 (PDT)
Date:   Thu, 16 Apr 2020 18:26:05 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
Message-ID: <20200416112605.GC2285@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com>
 <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
 <xmqq1rovl54d.fsf@gitster.c.googlers.com>
 <20200410174141.GB27699@danh.dev>
 <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
 <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
 <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
 <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-15 20:45:05-0700, Elijah Newren <newren@gmail.com> wrote:
> Hi Emily,
> 
> On Wed, Apr 15, 2020 at 7:01 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > On Wed, Apr 15, 2020 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > > > Danh Doan <congdanhqx@gmail.com> writes:
> > > >
> > > >> Excerpt from build log:
> > > >>
> > > >>> fatal error C1083: Cannot open include file: 'config-list.h'
> > > >>
> > > >> It's from bugreport topic.
> > > >> I've seen this failure in the past (when testing with pu),
> > > >> then I saw it disappear.
> > > >>
> > > >> I thought it was fixed during my testing for v4.
> > > >
> > > > Is the issue something similar to 976aaedc (msvc: add a Makefile
> > > > target to pre-generate the Visual Studio solution, 2019-07-29)?
> > > >
> > > > If that is the case, perhaps something like this would help?  I'll
> > > > tentatively queue it on top of es/bugreport and merge the result to
> > > > 'pu' to see what happens.
> > >
> > > The build just passed: https://github.com/git/git/runs/590781044
> > >
> > > Emily, you may need to squash in something along the line of this
> > > change to the commit in your series that starts building and using
> > > the config-list.h file (was it the first one?).  I've queued mine
> > > as a follow-up "oops, it was wrong" patch, but that would not be
> > > kosher from bisectability's point of view.
> >
> > Hm, ok. I'll send a reroll squashing this in verbatim tomorrow unless
> > I hear otherwise from Dscho? Looks like it's indeed the first one
> > (dd763e).
> > I'm curious to know how I can check this build method for myself for next time.
> 
> Create a fork of github.com/git/git and open a pull request against
> it.  (I believe you could also fork github.com/gitgitgadget/git and do
> a pull request against it, but I switched over to /git/git a while
> ago.) Immediately upon opening the pull request, a bunch of linux,
> mac, windows, and freebsd builds will be triggered with various runs
> of the testsuite.  Has been very useful for catching issues for me
> before I sent them off to the list.

For the time being, open a Github PR will trigger Azure Pipelines to
check various things  with both Linux, macOS, and Windows.
This Azure thing doesn't have that vs-build target, yet.

We're moving to Github Actions. When that topic graduate to master,
we can simply branch out from master and push to our fork in GitHub,
it will run automatically. No need to create a PR on git.git anymore

To check that vs-build target for the time being by merging
dd/ci-swap-azure-pipelines-with-github-actions
and push to your GitHub fork.

-- 
Danh
