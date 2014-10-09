From: Jeff King <peff@peff.net>
Subject: Re: git-archive doesn't support --date= option for %ad & %cd
 format:<string>'s
Date: Thu, 9 Oct 2014 15:24:28 -0400
Message-ID: <20141009192428.GB415@peff.net>
References: <CAMsgyKaHoZtAidWKD_YTggt_Xo0J7krFKHr2eFeg3XJ6H0bBXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:24:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJKE-0002Lt-KW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbaJITYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:24:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:56904 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751170AbaJITYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:24:30 -0400
Received: (qmail 766 invoked by uid 102); 9 Oct 2014 19:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 14:24:30 -0500
Received: (qmail 27258 invoked by uid 107); 9 Oct 2014 19:24:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 15:24:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Oct 2014 15:24:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMsgyKaHoZtAidWKD_YTggt_Xo0J7krFKHr2eFeg3XJ6H0bBXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 09, 2014 at 11:19:36AM -0500, Derek Moore wrote:

> PRETTY FORMATS' format:<string> documentation says, "%ad: author date
> (format respects --date= option)", and similarly for %cd.
> 
> But git-archive does not support the --date= option for changing the
> date format in $Format:%ad$ or $Format:%cd$ substitution strings.

Correct. You can use %ai, %aD, etc to pick a format. But...

> Relatedly, I want a short RFC date, not a short ISO date, but there is
> only --date=short, which is ISO.

If you start adding new formats, we are likely going to run out of
reasonably-memorable letters.

We've discussed something like "%ad(rfc822)" in the past, and I even had
a patch:

  http://article.gmane.org/gmane.comp.version-control.git/168512

but it got bogged down in a discussion on potentially expanding the
placeholder syntax to something more regular (probably
"%(authordate:rfc822"), like for-each-ref does. That's from 2011, and I
doubt anybody is working on it now.

> Would introducing --date=shortrfc and --date=shortiso be feasable,
> with --date=short aliasing to --date=shortiso. With a shortrfc, I
> could recreate SVN $Date$'s, which would be equivalent to $Format:%ai
> (%ad)$ when used with "git archive --date=shortrfc".

I don't see a big problem with that. But I wonder if we would do better
to introduce arbitrary strftime-like formatting, so we do not have to
keep adding new formats.

-Peff
