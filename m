Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C177220196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbcGLWMV (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:12:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:43790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751176AbcGLWMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:12:20 -0400
Received: (qmail 25004 invoked by uid 102); 12 Jul 2016 22:12:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 18:12:10 -0400
Received: (qmail 7407 invoked by uid 107); 12 Jul 2016 22:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 18:12:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 18:12:06 -0400
Date:	Tue, 12 Jul 2016 18:12:06 -0400
From:	Jeff King <peff@peff.net>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot
 notations
Message-ID: <20160712221205.GA9390@sigill.intra.peff.net>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
 <20160711202518.532-5-philipoakley@iee.org>
 <5784F43E.3080400@xiplink.com>
 <37D91D4F45C6444792E9B9205EF88BE1@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37D91D4F45C6444792E9B9205EF88BE1@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 10:41:35PM +0100, Philip Oakley wrote:

> > > +The '{caret}' (caret) notation
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   To exclude commits reachable from a commit, a prefix '{caret}'
> > >   notation is used.  E.g. '{caret}r1 r2' means commits reachable
> > >   from 'r2' but exclude the ones reachable from 'r1'.
> > 
> > All of these headings render poorly in the manpage, at least for me
> > (Ubuntu 16.04).  Only the first word appears in bold; the '-quoted text
> > is not bold but underlined, and the rest of the header is plain.
> 
> Which doc package is that with? It had formatted OK for the html web pages.

I get the same with:

  make gitrevisions.7
  man -l gitrevisions.7

Asciidoc 8.6.9, docbook-xsl 4.5 if it matters.

Rendering single-quotes as underline is normal in this case (though it's
not great for punctuation like this, as it kind of blends with the dots;
I know we use it elsewhere in this document, though).  The failure to
continue the bold through the end of line looks like a bug, though.

The generated XML (from asciidoc) looks reasonable:

  <title>The <emphasis>..</emphasis> (two-dot) range notation</title>

The roff looks like:

  .SS "The \fI\&.\&.\fR (two\-dot) range notation"

The "\fR" switches us back to "Roman" from italics, which is presumably
the problem. We really want to say "switch back what we were using
before \fI".

Switching it to "\fP" fixes it, but it's not clear to me if that's
actually portable, or a groff-ism. I don't know roff very well and
documentation seems to be quite hard to find. So it's either a bug in
docbook, or an intentional decision they've made because roff can't
portably do better. I'm not sure which.

-Peff
