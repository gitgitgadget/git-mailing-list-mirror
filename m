Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A6C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB99206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 20:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bo4W+LNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgFHUrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFHUrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 16:47:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51E6C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 13:47:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s88so345829pjb.5
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oqG/elPEDQxBrEKBfFhZdixhqEkOJQEV0tG6d5bOFsc=;
        b=Bo4W+LNtFpYzFhj80/yM3Z2r0Z23LrYEFEW6OZCJ4HPgpKLVM/nHMBs7IHRz3glBvk
         EJC3T/KIcuoHcFqUj1TCLzuLU7HJJaJGqi5iQIZUvY83pVo/MNmQZ3onNpbjqP+y3ZD5
         zuZErs1BeZyXIo/gbEsmsUivKix1fPgJlgcnp54lGrn5J5O1tRYPtqjx6TI73+GNRYO8
         cSX8fBnUFz0naoe4O53aFSIxwuILaXeVMdCxroIOs46yVauF0NIcP323ctu7eBPxpafk
         zfZZkWWv+wSMr3mHWbpsWHBvO49QvZeKuiUL9MKTHduspFLl2oLkMAIgHpN7Oe4IxnTe
         PPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oqG/elPEDQxBrEKBfFhZdixhqEkOJQEV0tG6d5bOFsc=;
        b=LdhQdu7yc6eesBdPxNcFDgh6xJGY0BOGSWJkI8ab5wY5Wv0WDC/UHaGSJIT5yjryGs
         FqvThuLO7ZYUugSKoZZdBF4VImQjpTIisZLZh7XIsmGivY88oed5CKmFLrqXiFpJtLjb
         h3ooEzOvIXEnBWi1tCiDzFddgQO/GAj8NF8uuVyWsyTK1sNusp0itiitCHJI2nyeD7EP
         /EWwfBdnfaUEVcES4MyRH5G4qFTuEFzL6KR2WOo/q0xvKyRDEOtdFCBzhj7IFeEuOI1H
         yCRI9YCyddI0FG7heIsJ/W9pURhzJZLbn4r/N/vchEiUrDAFy+raQ/8RNCVGsoXwQzQ6
         pbOg==
X-Gm-Message-State: AOAM531uD+7TBYeObNFOm2fh8Rzxtt85c67tsd+k+P1iYTRlr33LhSOr
        M4jyOuDSG239ASXKekvgUB1Kjw==
X-Google-Smtp-Source: ABdhPJw0rf0Fbc+lRX3EZFgaHqkRLjBDgg3xwSTRxrOOrYoIB8HU1N2X714jm5mNQkvapbYeGnDy2g==
X-Received: by 2002:a17:90a:4495:: with SMTP id t21mr1051068pjg.185.1591649225073;
        Mon, 08 Jun 2020 13:47:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 140sm7994849pfv.38.2020.06.08.13.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:47:04 -0700 (PDT)
Date:   Mon, 8 Jun 2020 13:47:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: mention MyFirstContribution in more places
Message-ID: <20200608204700.GB148632@google.com>
References: <20200528234939.145396-1-emilyshaffer@google.com>
 <20200529010608.GF114915@google.com>
 <7746C7A0-F328-482C-9B19-51BA5CB17C0A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7746C7A0-F328-482C-9B19-51BA5CB17C0A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 09:36:58PM -0400, Philippe Blain wrote:
> 
> Hi Emily, 
> 
> > Le 28 mai 2020 à 21:06, Jonathan Nieder <jrnieder@gmail.com> a écrit :
> > 
> > Emily Shaffer wrote:
> > 
> >> While the MyFirstContribution guide exists and has received some use and
> >> positive reviews, it is still not as discoverable as it could be. Add a
> >> reference to it from the GitHub pull request template, where many
> >> brand-new contributors may look. Also add a reference to it in
> >> SubmittingPatches, which is the central source of guidance for patch
> >> contribution.
> >> 
> >> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> >> ---
> >> .github/CONTRIBUTING.md         | 3 +++
> >> Documentation/SubmittingPatches | 5 +++--
> >> 2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > Yay!
> > 
> >> --- a/.github/CONTRIBUTING.md
> >> +++ b/.github/CONTRIBUTING.md
> >> @@ -16,4 +16,7 @@ If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q
> >> might be useful to you as the presenter walks you through the contribution
> >> process by example.
> >> 
> >> +Or, you can follow the ["My First Contribution"](https://git-scm.com/docs/MyFirstContribution)
> >> +tutorial for another example of the contribution process.
> >> +
> >> Your friendly Git community!
> > 
> > Looks good.
> > 
> >> --- a/Documentation/SubmittingPatches
> >> +++ b/Documentation/SubmittingPatches
> >> @@ -3,8 +3,9 @@ Submitting Patches
> >> 
> >> == Guidelines
> >> 
> >> -Here are some guidelines for people who want to contribute their code
> >> -to this software.
> >> +Here are some guidelines for people who want to contribute their code to this
> >> +software. There is also an link:MyFirstContribution.html[interactive tutorial]
> >> +available which covers many of these same guidelines.
> > 
> > nit: when I see "an interactive tutorial" I imagine a "git tutor"
> > command that interacts with me to guide me through my first
> > contribution (like "vimtutor").  I think this means to just say
> > "a tutorial".
> 
> I agree. Maybe "a step-by-step tutorial" ?

Thanks for the suggestion - I like that. I'll send an update shortly.

 - Emily
