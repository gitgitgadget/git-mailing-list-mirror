From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] give "nbuf" strbuf a more meaningful name
Date: Sun, 31 Jan 2016 06:59:47 -0500
Message-ID: <20160131115947.GA5438@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
 <20160131112526.GA5116@sigill.intra.peff.net>
 <alpine.DEB.2.20.1601311245170.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 13:00:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqgD-0002JZ-4J
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 13:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292AbcAaL7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:59:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:35076 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757209AbcAaL7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:59:50 -0500
Received: (qmail 8698 invoked by uid 102); 31 Jan 2016 11:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:59:50 -0500
Received: (qmail 16070 invoked by uid 107); 31 Jan 2016 12:00:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 07:00:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:59:47 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1601311245170.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285143>

On Sun, Jan 31, 2016 at 12:54:29PM +0100, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Sun, 31 Jan 2016, Jeff King wrote:
> 
> > > It's a shame that we can't just factor out this common
> > > code, but I don't think it's quite long enough to merit
> > > the boilerplate. The interesting part of each function
> > > happens inside the loop. If C had lambdas, we could do
> > > something like:
> > > 
> > >   foreach_path_from(stdin, nul_term_line) {
> > >         /* now do something interesting with "buf"
> > >            and some other local variables */
> > >   }
> 
> Technically, we do not have to do lambdas for that paradigm, we could
> introduce a new data type and a reader, i.e. something like this:
> [...]
> And then the repeated code could be replaced by something like this:
> 
> 	struct path_reader path_reader = PATH_READER_INIT;
> 
> 	while (read_next_path(&reader, stdin, 1)) {
> 		... [work with reader->path.buf] ...
> 	}
> 
> 	cleanup_path_reader();

Yeah, you're right. I was thinking of lifting the loop completely out of
the call-sites, but simplifying it to a single line loop condition is
just as good.

I still think this crosses my line of "too much boilerplate to be worth
it", though.

-Peff
