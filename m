From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 14:52:57 -0400
Message-ID: <20150916185256.GA2654@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
 <20150916094814.GB13966@sigill.intra.peff.net>
 <xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHpP-00083X-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbbIPSxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:53:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:60234 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752169AbbIPSxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:53:05 -0400
Received: (qmail 18849 invoked by uid 102); 16 Sep 2015 18:53:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 13:53:05 -0500
Received: (qmail 21555 invoked by uid 107); 16 Sep 2015 18:53:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 14:53:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 14:52:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278048>

On Wed, Sep 16, 2015 at 11:24:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Sep 15, 2015 at 11:19:21PM -0400, Eric Sunshine wrote:
> >
> >> >                 strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
> >> > -               sprintf(ownbuf[stage], "%o", ce->ce_mode);
> >> > +               xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
> >> 
> >> Interesting. I wonder if there are any (old/broken) compilers which
> >> would barf on this. If we care, perhaps sizeof(ownbuf[0]) instead?
> >
> > Good point. I've changed it to sizeof(ownbuf[0]).
> 
> Panda brain is lost here.  What's the difference, other than that we
> will now appear to be measuring the size of the thing at index 0
> while using that size to stuff data into a different location?  All
> elements of the array are of the same size so there wouldn't be any
> difference either way, no?

Correct. The original is sane and gcc does the right thing. The question
is whether some compiler would complain that "stage" is not a constant
in the sizeof() expression. I don't know if any compiler would do so,
but it is easy enough to be conservative.

-Peff
