From: Jeff King <peff@peff.net>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 21:35:48 -0500
Message-ID: <20140117023548.GB13023@sigill.intra.peff.net>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52D88F30.4000807@rawbw.com>
 <20140117021320.GA12444@sigill.intra.peff.net>
 <20140117022921.GU18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yuri <yuri@rawbw.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zHm-0002Zc-IZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaAQCfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:35:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:33929 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751584AbaAQCfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:35:50 -0500
Received: (qmail 9824 invoked by uid 102); 17 Jan 2014 02:35:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 20:35:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 21:35:48 -0500
Content-Disposition: inline
In-Reply-To: <20140117022921.GU18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240564>

On Thu, Jan 16, 2014 at 06:29:21PM -0800, Jonathan Nieder wrote:

> > +	/*
> > +	 * We know that "more" does not pass through colors at all.
> > +	 */
> > +	if (!strcmp(pager, "more"))
> > +		return 0;
> 
> I seem to remember that on some systems "more" is the name of the
> full-featured pager that knows how to scroll forward and backward and
> handle color.  (My memory could be faulty.  A search in the makefile
> for DEFAULT_PAGER=more only finds AIX, which is not the platform I was
> thinking of.)

Yeah, my "we know" here was still guessing. According to Yuri, FreeBSD
is the system you are thinking of. :)

> On a stock Debian system "more" is especially primitive, which means
> that it passes colors through, too.  It being so primitive also means
> it is not a particularly good choice for the PAGER setting, though,
> so probably that's not too important.

Yeah, colors do get passed through on Debian. It's possible that other
primitive "more" implementations are OK, too (and certainly we have
defaulted to "on" for them until now).

I think we should make an effort to set MORE=R on FreeBSD. We can
perhaps just set it unconditionally, and assume that primitive "more"
will ignore it. And then assume that "more" will handle colors (either
because of the R setting, or because it is too dumb to escape it).

I can prepare a patch series, but I happily no longer have any antique
systems to test this kind of stuff on.

-Peff
