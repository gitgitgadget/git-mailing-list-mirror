From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Thu, 26 May 2016 00:51:05 -0400
Message-ID: <20160526045105.GC6756@sigill.intra.peff.net>
References: <20160520103708.38308-1-gitter.spiros@gmail.com>
 <20160520103708.38308-2-gitter.spiros@gmail.com>
 <xmqqlh34cvmd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, ramsay@ramsayjones.plus.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 06:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5nGM-00037t-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 06:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbcEZEvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 00:51:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:44450 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750714AbcEZEvI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 00:51:08 -0400
Received: (qmail 6031 invoked by uid 102); 26 May 2016 04:51:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:51:08 -0400
Received: (qmail 16921 invoked by uid 107); 26 May 2016 04:51:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:51:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 00:51:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlh34cvmd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295630>

On Fri, May 20, 2016 at 01:39:06PM -0700, Junio C Hamano wrote:

> > +{
> > +	size_t i;
> > +	struct strbuf out = STRBUF_INIT;
> > +	unsigned int width = 80;
> 
> In a few places Git limits the width of the output, like using function
> name in hunk header lines and drawing diffstat in "diff --stat", we
> do default to limit the total width to 80 display columns.
> 
> Given that this routine prefixes each and every line with a short
> heading like "=> Send header: " that costs at around 15-20 columns,
> and the loop we see below only counts the true payload without
> counting the heading, you would probably want to reduce this
> somewhat so that the whole thing would fit within 80 columns.

I think that may be a losing battle. Remember that we are getting the
usual trace header on top of this, which I think leaves only about 20
characters for actual data on each line.

I kind of doubt people will manually read the body data. In my
experience, debugging git-over-http you want either:

  1. Just the request/response headers to see what was said.

  2. A complete dump of each body with no other formatting (e.g., so you
     can replay it with curl).

This trace output gives you (1). You can in theory generate (2) from it
with a perl snippet, but the non-printing characters have been
irreversibly transformed.

So I dunno. I do not mind having the body stuff there for completeness,
but I doubt I'd use it myself. And I don't care much either way about
how long its lines are.

-Peff
