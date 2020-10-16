Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16EDC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6BA207F7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgJPAXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 20:23:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:33798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbgJPAXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 20:23:55 -0400
Received: (qmail 25749 invoked by uid 109); 16 Oct 2020 00:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 00:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2961 invoked by uid 111); 16 Oct 2020 00:23:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 20:23:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 20:23:54 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [BUG?] Weird interaction between `git -C`, aliases and worktrees
Message-ID: <20201016002354.GA2932796@coredump.intra.peff.net>
References: <020EB674-6A95-4E53-B2E7-F4EEBD6324C3@gmail.com>
 <CABPp-BF2Stb_UfNEqYOBPjvm09oO8=ST685kZ0+U2PtPRz5_mg@mail.gmail.com>
 <88D2A179-806F-4321-828A-359692E646B1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88D2A179-806F-4321-828A-359692E646B1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 06:35:39PM -0400, Philippe Blain wrote:

> I found two threads [2] and [3] which are manifestations of similar (or the same ?) problems...
> 
> Maybe git-config(1) could document which variables will 
> be set in aliases that shell out, but even that might be tricky because it
> seems the answer is "it depends" (according to [2])...
> 
> I also found 57ea7123c8 (git.c: make sure we do not 
> leak GIT_* to alias scripts, 2015-12-20), in topic 'nd/clear-gitenv-upon-use-of-alias',
> which tries to clear out GIT_* variables from aliases environment,
> which I guess is defeated by the fact that I run `git -C` in my alias...
> 
> Anyway thanks for your answer.
> 
> [1] https://git-scm.com/docs/git#Documentation/git.txt---git-dirltpathgt
> [2] https://lore.kernel.org/git/20200130102933.GE840531@coredump.intra.peff.net/
> [3] https://lore.kernel.org/git/20200228190218.GC1408759@coredump.intra.peff.net/

IMHO it is still worth doing a fix similar to what I wrote earlier. But
somebody needs to figure out what's up with the failure in t5601:

 - whether it's a behavior that has to be kept, or if it's something we can
   deprecate or just publicly warn about

 - if kept, can we work around it internally within git-clone /
   git-init? If not, can we work around it with an extra environment
   variable?

I probably won't look at it anytime soon, but I'd be happy if somebody
else did. :)

-Peff
