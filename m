Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E612203C1
	for <e@80x24.org>; Fri, 15 Jul 2016 12:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbcGOMiD (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 08:38:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:45402 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750764AbcGOMiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 08:38:02 -0400
Received: (qmail 23580 invoked by uid 102); 15 Jul 2016 12:38:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 08:38:01 -0400
Received: (qmail 15421 invoked by uid 107); 15 Jul 2016 12:38:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 08:38:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 08:37:59 -0400
Date:	Fri, 15 Jul 2016 08:37:59 -0400
From:	Jeff King <peff@peff.net>
To:	Mike Hommey <mh@glandium.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
Message-ID: <20160715123758.GA22395@sigill.intra.peff.net>
References: <20160715024254.29186-1-mh@glandium.org>
 <alpine.DEB.2.20.1607151242020.6426@virtualbox>
 <20160715123245.rdpbl4tmqscyf2tx@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715123245.rdpbl4tmqscyf2tx@glandium.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 09:32:45PM +0900, Mike Hommey wrote:

> > > +test_expect_success 'blame wholesale copy and more in the index' '
> > > +
> > > +	{
> > > +		echo ABC
> > > +		echo DEF
> > > +		echo XXXX
> > > +		echo YYYY
> > > +		echo GHIJK
> > > +	} >horse &&
> > 
> > A more common way to do this in our test scripts is by using here
> > documents. However, in this case I would suggest
> > 
> > 	test_write_lines ABC DEF XXXX YYYY GHIJK >horse
> 
> I merely copied the pattern used in other places in the same test file.
> Using test_write_lines or something else (what are "here documents"?)
> would break consistency. I can also change the other similar blocks at
> the same time, though, whichever you prefer.

A here document is this:

   cat <<-\EOF
   ABC
   DEF
   XXXX
   YYYY
   GHIJK
   EOF

The "<<" starts the here-doc. The "-" tells the shell to strip leading
tabs (so you can keep it indented with the rest of the code. The "\"
tells the shell not to interpolate (not a big deal here, but great for
more complicated input). The "EOF" tells it where to stop.

Matching surrounding style is always reasonable, though I do think this
particular file is a bit of an oddball. Most of our scripts use here
documents. Either is OK in this case, IMHO.

Personally I do not find test_write_lines particularly readable, but I
guess some people do, which is why it exists.

-Peff
