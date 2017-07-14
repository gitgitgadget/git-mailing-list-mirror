Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9D020357
	for <e@80x24.org>; Fri, 14 Jul 2017 17:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbdGNRkF (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 13:40:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:40940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753486AbdGNRkF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 13:40:05 -0400
Received: (qmail 30740 invoked by uid 109); 14 Jul 2017 17:40:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 17:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12923 invoked by uid 111); 14 Jul 2017 17:40:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 13:40:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 13:40:02 -0400
Date:   Fri, 14 Jul 2017 13:40:02 -0400
From:   Jeff King <peff@peff.net>
To:     astian <astian@eclipso.at>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
Message-ID: <20170714174002.xjizkofjxlirgnaj@sigill.intra.peff.net>
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
 <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
 <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
 <20170714153015.crklfqaa2qc573zo@sigill.intra.peff.net>
 <xmqqh8yfq8pr.fsf@gitster.mtv.corp.google.com>
 <1d79b017-38b3-e1cb-a4bf-1153dc4fdbca@eclipso.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d79b017-38b3-e1cb-a4bf-1153dc4fdbca@eclipso.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 05:26:00PM +0000, astian wrote:

> FWIW, I don't like 2, I don't like the irregularity in the invocation:

Without quoting, it took me a second to figure out what you meant. But I
think "2" here is the "mental model 2" I mentioned in my earlier email.

>   $ git branch
>   * master
>   $ git BRANCH
>   git: 'BRANCH' is not a git command. See 'git --help'.
>   $ git config alias.br 'branch -v'
>   $ git br
>   * master 51c785c initial
>   $ git BR
>   * master 51c785c initial
> 
> There is also this:
> 
>   $ git branch
>   * master
>   $ git BRANCH
>   git: 'BRANCH' is not a git command. See 'git --help'.
>   $ git config alias.branch 'branch -v'
>   $ git branch
>   * master
>   $ git BRANCH
>   * master 51c785c initial

That is an interesting side effect, especially the latter BRANCH/branch
one. We usually do not allow overrides of actual git commands, but this
"fools" that check.

I agree it's an unexpected fallout. On the other hand, unless you are
_trying_ to do something funny, I don't think you'd ever hit on this
behavior. And if you are trying to do something funny, I think this
behaves in a reasonable and predictable manner.

-Peff
