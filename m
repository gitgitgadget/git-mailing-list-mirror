From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 17:30:14 -0400
Message-ID: <20150902213013.GB21612@sigill.intra.peff.net>
References: <20150831204444.GA4385@sigill.intra.peff.net>
 <20150831204831.GB10338@sigill.intra.peff.net>
 <xmqq37ywoh0x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 23:30:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXFbr-0000pF-6I
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 23:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbbIBVaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 17:30:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54006 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755027AbbIBVaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 17:30:16 -0400
Received: (qmail 22166 invoked by uid 102); 2 Sep 2015 21:30:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Sep 2015 16:30:16 -0500
Received: (qmail 4435 invoked by uid 107); 2 Sep 2015 21:30:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Sep 2015 17:30:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2015 17:30:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37ywoh0x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277126>

On Wed, Sep 02, 2015 at 10:41:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	/* historical alias */
> > +	if (!strcmp(format, "local"))
> > +		format = "default-local";
> > +
> > +	mode->type = parse_date_type(format, &p);
> > +	mode->local = 0;
> > +
> > +	if (skip_prefix(p, "-local", &p)) {
> > +		if (mode->type == DATE_RELATIVE)
> > +			die("relative-local date format is nonsensical");
> > +		mode->local = 1;
> > +	}
> 
> I notice that we give something funny like this:
> 
>     $ git show --date=short-locale
>     fatal: unknown date-mode modifier: e

Yeah, that's not ideal.

> What is the intention here?  In other words, what kind of things can
> plausibly follow "--date=short-local" in enhanced versions of Git in
> the future?  "--date=short-local:some other magic"?

I had assumed it would be "short-local-othermagic", since ":" is already
the separator for "format:". But I admit I have no idea what other
modifiers would be interesting.

I think the error message would be a lot nicer if we indicate that "-"
is syntactically interesting, and say:

  fatal: unknown date-mode modifier: locale

-Peff
