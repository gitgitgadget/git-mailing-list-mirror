Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500731FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 09:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdDHJbh (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 05:31:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58435 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdDHJbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 05:31:36 -0400
Received: (qmail 32222 invoked by uid 109); 8 Apr 2017 09:31:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 09:31:35 +0000
Received: (qmail 10348 invoked by uid 111); 8 Apr 2017 09:31:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 05:31:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 05:31:33 -0400
Date:   Sat, 8 Apr 2017 05:31:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
Message-ID: <20170408093133.acilrs5lc3kxzpmu@sigill.intra.peff.net>
References: <1491617750.2149.10.camel@mattmccutchen.net>
 <CA+P7+xrVe7jnqpQFvYBb25ofrNqnRspdk-M6jRuwRi5sUqCCZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrVe7jnqpQFvYBb25ofrNqnRspdk-M6jRuwRi5sUqCCZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:25:43AM -0700, Jacob Keller wrote:

> On Fri, Apr 7, 2017 at 7:15 PM, Matt McCutchen <matt@mattmccutchen.net> wrote:
> > When I'm rewriting history, "git push --force-with-lease" is a nice
> > safeguard compared to "git push --force", but it still assumes the
> > remote-tracking ref gives the old state the user wants to overwrite.
> > Tools that do an implicit fetch, assuming it to be a safe operation,
> > may break this assumption.  In the worst case, Visual Studio Code does
> > an automatic fetch every 3 minutes by default [1], making
> > --force-with-lease pretty much reduce to --force.
> >
> 
> Isn't the point of force-with-lease to actually record a "commit" id,
> and not pass it a branch name, but actually the sha1 you intend the
> remote server to be at? Sure if you happen to pass it a branch or
> remote name it will interpret it for yuou, but you should be able to
> do something like
> 
> current=$(git rev-parse origin/branch)
> <verify current is correct and then do your rewind stuff>
> git push --force-with-lease=$current
> 
> and this will work regardless of when if if you fetch in between?

That's definitely the _best way to do it (modulo using "branch:$current"
in the final command). I think Matt's point is just that the default, to
use origin/branch, is unsafe. It's convenient when you don't have extra
fetches, but that convenience may not be worth the potential surprise.

-Peff
