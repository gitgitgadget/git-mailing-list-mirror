Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3AA202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdGGJmI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:42:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:33610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbdGGJmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:42:07 -0400
Received: (qmail 9835 invoked by uid 109); 7 Jul 2017 09:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:42:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21055 invoked by uid 111); 7 Jul 2017 09:42:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:42:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:42:05 -0400
Date:   Fri, 7 Jul 2017 05:42:05 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI/?= Bjarmason <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
Message-ID: <20170707094204.kk62baddjjqrgagh@sigill.intra.peff.net>
References: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
 <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 11:24:15AM +0200, Stefan Haller wrote:

> > Let's disable the form that relies on the stability of remote-tracking
> > branches by default, and allow users who _know_ their remote-tracking
> > branches are stable to enable it with a configuration variable.
> 
> I'm wondering if people who claim they know they are safe really do.
> Elsewhere in the other thread somebody said "I only ever explicitly
> fetch, so I know I'm safe". Are you sure?
> 
> Consider this example:

Thanks, these are all really good examples.

I think another one is just:

  $ git fetch
  [time passes]
  $ git checkout branch
  $ git rebase -i
  [oops, I forgot to merge in the latest changes before rewriting]
  $ git push --force-with-lease

That doesn't even require a fetch/pull after you start working. It's
simply a mismatch between reality and what the default assumes (that
whatever you were working on incorporated the latest work from
upstream).

-Peff
