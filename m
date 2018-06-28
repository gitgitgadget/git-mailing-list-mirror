Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C1A1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965719AbeF1RrY (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:47:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:58638 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964854AbeF1RrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:47:23 -0400
Received: (qmail 22132 invoked by uid 109); 28 Jun 2018 17:47:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 17:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23408 invoked by uid 111); 28 Jun 2018 17:47:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 13:47:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 13:47:21 -0400
Date:   Thu, 28 Jun 2018 13:47:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: fix the "built from commit" code
Message-ID: <20180628174721.GD31766@sigill.intra.peff.net>
References: <pull.7.git.gitgitgadget@gmail.com>
 <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com>
 <20180628132314.GA14026@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet>
 <xmqqa7reyg6z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7reyg6z.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 10:27:32AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I.e.:
> >> 
> >>   FOO='with spaces'
> >>   BAR=$FOO sh -c 'echo $BAR'
> >> 
> >> works just fine.
> >
> > 	$ x="two  spaces"
> >
> > 	$ echo $x
> > 	two spaces
> >
> > Maybe we should quote a little bit more religiously.
> 
> Both of you are wrong ;-)
> 
> Of course, the lack of dq around echo's argument makes shell split
> two and spaces into two args and feed them separately to echo, and
> causes echo to show them with a single SP in between.  Peff's
> exampel should have been
> 
> 	BAR=$FOO sh -c 'echo "$BAR"'

Yes, that's a better example. I was primarily trying to show that the
outer shell did not barf with "spaces: command not found".

> But that does not have much to do with the primary point Peff was
> talking about, which is that in this sequence:
> 
> 	$ x="two  spaces"
> 	$ y="$x"
> 	$ z=$x
> 	$ echo "x=<$x>" "y=<$y>" "z=<$z>"
> 
> assignment to y and z behave identically, i.e. dq around "$x" when
> assigning to y is not needed.

I actually had to test it to convince myself that one-shot assignments
behaved the same way, but they do.

-Peff
