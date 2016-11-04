Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C912021E
	for <e@80x24.org>; Fri,  4 Nov 2016 00:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbcKDALO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 20:11:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:38438 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933950AbcKDALN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 20:11:13 -0400
Received: (qmail 1419 invoked by uid 109); 4 Nov 2016 00:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 00:11:13 +0000
Received: (qmail 19031 invoked by uid 111); 4 Nov 2016 00:11:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 20:11:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 20:11:10 -0400
Date:   Thu, 3 Nov 2016 20:11:10 -0400
From:   Jeff King <peff@peff.net>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161104001110.r2uzfybddbq2wyn4@sigill.intra.peff.net>
References: <20161102202709.GI4611@redhat.com>
 <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
 <20161102213805.GJ4611@redhat.com>
 <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
 <20161102222901.GK4611@redhat.com>
 <20161103141848.42pg6iow24prign5@sigill.intra.peff.net>
 <20161104000351.GP4611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161104000351.GP4611@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 01:03:51AM +0100, Andrea Arcangeli wrote:

> > can see why it is confused and does what it does (the whole email is
> > inside a double-quoted portion that is never closed, so it probably
> > thinks there is no hostname portion at all).
> 
> I would see it too, if it actually sent the email to the garbled email
> address it generated, but it actually got the right email address
> (because it sent the email to the right address), but it decided to
> show a different email address in the mail header than the one it sent
> the email to. But I figure this is the wrong list for such questions :).

It has to do with the "envelope recipient" versus the RFC822 header. Git
provides the envelope recipient on the command-line, and that is what is
used in the SMTP conversation. In theory the MTA does not need to ever
even look at the contents of the message itself. Some do not, but some
have features like rewriting the in-message headers (e.g., to turn
"to: user" into "to: user@hostname"). You can probably disable that
header-rewriting feature in your config, but I don't know very much
about configuring postfix.

-Peff
