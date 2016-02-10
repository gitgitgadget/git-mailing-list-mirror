From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 10:40:06 -0500
Message-ID: <20160210154006.GA19867@sigill.intra.peff.net>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
 <20160210125429.GA8078@sigill.intra.peff.net>
 <CAHGBnuMMN_xEVDJ_dqWgL6QCGK08hy=ggg=6PzkSCinHr=QeFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 16:40:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTWsK-0000Y1-CL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 16:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbcBJPkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 10:40:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:39774 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751158AbcBJPkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 10:40:09 -0500
Received: (qmail 858 invoked by uid 102); 10 Feb 2016 15:40:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 10:40:08 -0500
Received: (qmail 28792 invoked by uid 107); 10 Feb 2016 15:40:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 10:40:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 10:40:06 -0500
Content-Disposition: inline
In-Reply-To: <CAHGBnuMMN_xEVDJ_dqWgL6QCGK08hy=ggg=6PzkSCinHr=QeFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285904>

On Wed, Feb 10, 2016 at 04:33:11PM +0100, Sebastian Schuberth wrote:

> > where two of the prefixes have nothing in the second slot. I expected
> > something more like:
> >
> >   file:<filename>\t</value...>
> >   blob:<blob>\t<value...>
> >   stdin\t<value...>
> >   cmd\t<value...>
> >
> > with a single delimited slot for the source, which can then be broken
> > down further if desired.  I can't think of any reason to prefer one over
> > the other rather than personal preference, though. They can both be
> > parsed unambiguously.
> 
> I also would have expected sopme like the latter, except that I'd also
> expect a colon after "stdin" and "cmd" (or "cmdline", as said above).
> I.e. the colon should be part of the prefix to mark it as such.

Yeah, I waffled on that. Having a colon means you can definitely parse
to the first ":" without looking at what the prefix is. But if you don't
know what the prefix is, I don't know what good that does you. IOW, I'd
expect it to be parsed like:

  if (/^file:(.*)/) {
    # source is file $1
  } elsif (/^blob:(.*)/) {
    # source is blob $1
  } elsif (/^stdin/) {
    # source is stdin
  } elsif (/^cmdline/) {
    # source is cmdline
  } else {
    die "eh? I don't know about $_ at all!"
  }

That's perl, but I think most languages make prefix-parsing like that
easy. I dunno. I doubt it matters all that much, and we are deep into
personal preference. There's already plenty to bikeshed on the option
name :)

-Peff
