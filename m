Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA5A20705
	for <e@80x24.org>; Thu,  8 Sep 2016 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbcIHTxF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 15:53:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:40351 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750750AbcIHTxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 15:53:04 -0400
Received: (qmail 13771 invoked by uid 109); 8 Sep 2016 19:53:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 19:53:03 +0000
Received: (qmail 17785 invoked by uid 111); 8 Sep 2016 19:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 15:53:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 15:53:00 -0400
Date:   Thu, 8 Sep 2016 15:53:00 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Use the newly-introduced regexec_buf() function
Message-ID: <20160908195300.votzp3ysxewc2mip@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <cover.1473319844.git.johannes.schindelin@gmx.de>
 <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1609080954010.129229@virtualbox>
 <20160908081024.yku2xlb3jj4rplkp@sigill.intra.peff.net>
 <20160908081446.zlcmz6ci4cw4vc2e@sigill.intra.peff.net>
 <20160908083509.ygh4flpunyyp4hua@sigill.intra.peff.net>
 <ac0f3441-d28f-fc5c-0273-f614b2cd4e07@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac0f3441-d28f-fc5c-0273-f614b2cd4e07@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 08:06:35PM +0100, Ramsay Jones wrote:

> > Actually, I take it back again. Your test case doesn't have an embedded
> > NUL in it (so we check that git finds it, but aside from the lack of
> > segfault, stock git would already find it).
> 
> This reminds me ... despite the native cygwin regex library no longer
> having the 'regex bug' (ie t0070.5 now passes), I still have NO_REGEX
> set on cygwin. This is because, when building with the native library,
> we have an "unexpected pass" for t7008.12, which looks like:
> 
> test_expect_failure 'git grep .fi a' '
>         git grep .fi a
> '
> [where the file a is set up earlier by: echo 'binaryQfile' | q_to_nul >a]
> 
> commit f96e5673 ("grep: use REG_STARTEND for all matching if available",
> 22-05-2010) introduced this test and expects ".. NUL characters themselves
> are not matched in any way". With the native library on cygwin they are
> matched, with the compat/regex they are not. Indeed, if you use the system
> 'grep' command (rather than 'git grep'), then it will also not match ... :-D
> 
> Slightly off topic, but ...

Hmm. So it sounds like the "regmatch" in grep.c could go away in favor
of Johannes's regexec_buf(), and cygwin ought to be using NO_REGEX.

-Peff
