Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A49202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 08:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbdI0IJs (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 04:09:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751787AbdI0IJb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 04:09:31 -0400
Received: (qmail 30315 invoked by uid 109); 27 Sep 2017 08:09:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 08:09:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13389 invoked by uid 111); 27 Sep 2017 08:10:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 04:10:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 04:09:29 -0400
Date:   Wed, 27 Sep 2017 04:09:29 -0400
From:   Jeff King <peff@peff.net>
To:     Sabelo Mhlambi <sabelo@sabelo.io>
Cc:     git@vger.kernel.org
Subject: Re: Speeding up history traversals with caches
Message-ID: <20170927080928.g76qjnohm3645w3o@sigill.intra.peff.net>
References: <CAGdZCnE-5CUxc-1PSSYagfXE9HMhu9k8xpo8rwM1K_urmY8gHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGdZCnE-5CUxc-1PSSYagfXE9HMhu9k8xpo8rwM1K_urmY8gHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 05:28:43PM -0700, Sabelo Mhlambi wrote:

> Hi Jeff (and the Git community),
> 
> As my intro to open source contributions I'd like to attempt the "Speeding
> up history traversals with caches" as outlined here
> https://git.github.io/Outreachy-15/.
> 
> It seems like a challenging and worthwhile problem. May I have more
> information on the project and on how to get get started on the application.
> 
> Thanks!

Hi Sabelo, welcome to Git!

Unfortunately your message didn't make it to the mailing list, because
the list software is strict about messages not including any HTML parts.
It looks like you're using Gmail; you'll need to ask it to send
plain-text emails.

The general idea of the project is: a lot of git commands need to access
commit objects to walk the history graph, but they're expensive to
access because we have to inflate the whole commit object from disk.
What I'd like to have instead is a compact representation that we can
quickly use to get the main interesting data out of a commit message
without having to inflate all of the bytes.

I did a prototype of this a few years ago:

  https://public-inbox.org/git/20130129091434.GA6975@sigill.intra.peff.net/

Compared to those patches, there are a lot of possible things to work
on:

  - the code needs cleaned up and ported to a more modern git

  - the implementation is a bit complex; it was anticipating having
    several types of auxiliary files, but probably we really just need
    one

  - we've also discussed storing computed data about the graph, such as
    generation numbers, which can help speed up some traversals

  - we may be able to cache some interesting tree data (e.g., bitmaps of
    which paths are touched by a particular commit).

I wouldn't expect us to cover all of that during the internship period,
but it gives a sense of the possible directions.

That thread may work as a starting point for understanding the problem
space. You can also probably find some interesting discussions if you
search for "generation number" in the mailing list archive at
https://public-inbox.org/git.

The first step is probably to get comfortable with building Git and
submitting a small patch. Christian posted some advice on finding a
topic to work on:

  https://public-inbox.org/git/CAP8UFD3vPQHJZNt1+egKkshiyqrGKiJp7eWU-Es6bTLgvXe1Kg@mail.gmail.com/

Let us know if you get stuck or if you have any questions!

-Peff
