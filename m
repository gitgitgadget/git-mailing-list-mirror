Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BBC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BE764EC6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhBAWMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBAWMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:12:16 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA0C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:11:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so26766198ejf.11
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xblz3eHEv6VJ1xaUDxe8/ORDHu3f4gZv+AiPk8DEmQc=;
        b=OAHt0jguzNWnvOCtC6sID558GAr+GsAV++Cv1qY2y55wiNe/Qd/5kldDF5SwnZVQn7
         5Oa5OntHvHJInWtWxBiscj20ANRgOCnk8rPiqDeK9pGUjzXLL2y7+SB3zEfCvb2nNjYQ
         Vk/wge9I6Zqdlo5bU1rPnJ79NXFixf4gBPoiSKtmttNbodDVEOkP1GaZhdRhvs552nTd
         1AYp5tWS2KYMAcs8fjOO7yk06793SQlEb+CmGRZm5JLPKSC1GWE1Zsm6pk87fh99CGbC
         vYwwFs4KGlOaRQDtGT0/TwtFV9FCW6/juDcllvY8dCLB0GoVyU3tIvZk+vmMKwVHZDIi
         lHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xblz3eHEv6VJ1xaUDxe8/ORDHu3f4gZv+AiPk8DEmQc=;
        b=pcTO1HHCD2z/+q+5MoimxlMO9aCHpk0aBcmjt5U8xxh7QJP9YIJPKr50MgTyGLvqtu
         b96aQMOi006rAoJ31rKK9eKABzv21ywcyvzgnEacXFAJop+dqNnBzIn/ZwP7v6Pfk5zv
         RNlarClkj3W7U7mx/fqOvLU/N0ERbace6lu5xOGCwVRD/ibJbU9ZoZZX0ebRcT7xMA4A
         /VQYmNc+BmCIk9yCP8wpS9sElBnxHVze+2gdmfck6r09TTaGo6qJbqvSPYGQxLPwN4MA
         a4yBiF7+8JyBAb2PLaBis1+yGlhanrLwDCka85iBvLk2CweAMGTXHZ6yxNunhgK38ntT
         Eiyw==
X-Gm-Message-State: AOAM532gKO9mghCqkQwAaq1Tes+12cGUunA6SbisxR+/8HKqNl45+Sgb
        nLrVeJXAE5RYGse4Jor9hh4=
X-Google-Smtp-Source: ABdhPJxXH2lPCg7InNZQYzBP4q5/Ppsko8+PVfyhxEYF5n9DjrLO3Ou8cBOkocXyYC8cN/XchE59RA==
X-Received: by 2002:a17:906:80d1:: with SMTP id a17mr13538242ejx.93.1612217495008;
        Mon, 01 Feb 2021 14:11:35 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id ce7sm8506164ejb.100.2021.02.01.14.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:11:34 -0800 (PST)
Date:   Mon, 1 Feb 2021 23:11:30 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
Message-ID: <20210201221130.GA1036595@szeder.dev>
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
 <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
 <CAPig+cSWa_jgUjPXVMeOUwxQV_9Qhv0f-Wyb3odJnb1UpcOcPg@mail.gmail.com>
 <YAH/ME/YvesZBxfr@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAH/ME/YvesZBxfr@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 03:46:40PM -0500, Jeff King wrote:
> On Fri, Jan 15, 2021 at 03:07:38PM -0500, Eric Sunshine wrote:
> 
> > On Fri, Jan 15, 2021 at 3:00 PM Jeff King <peff@peff.net> wrote:
> > > > -     brew cask install --no-quarantine perforce || {
> > > > +     brew install --cask --no-quarantine perforce || {
> > >
> > > On a related note, it feels like perforce is a frequent offender for
> > > triggering spurious failures (both for homebrew setup, but I have
> > > definitely seen racy/flaky failures from it as well). I am tempted to
> > > say it is not worth the trouble, but then I do not care at all about
> > > git-p4 myself in the first place, so I may be biased.
> > 
> > To be fair to 'perforce', though, the fault of this particular problem
> > is Homebrew, which doesn't seem to be all that concerned about
> > backward compatibility, at least in my experience. The single
> > Homebrew-related automation script I wrote for personal use has been
> > broken by arbitrary Homebrew changes frustratingly often over the last
> > three years.
> 
> Yeah, sorry, I should have been more precise in my language. None of
> this is perforce's fault at all. It is homebrew in this case, and in the
> racy cases it is probably our tests. But I do not feel like trying to
> debug those races for a tool I don't care much about.
> 
> I tried to dig up some failing logs as an example, but it's actually a
> bit hard to search for,

I keep an eye out for flaky test failures, because they are much more
entertaining to hunt down than the "usual" bugs, but can't recall any
involving Perforce in the last year, since 6026aff5bb (git-p4: cleanup
better on error exit, 2020-01-29) fixed the last one I knew about.

> and it looks like logs get expired after a few
> months anyway.

Travis CI can still show our builds from mid-2016:

  https://travis-ci.org/github/git/git/builds/146233889

though I couldn't dig out our very first build.

