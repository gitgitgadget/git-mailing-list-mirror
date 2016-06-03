From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/10] builtin/index-pack.c: convert trivial snprintf
 calls to xsnprintf
Date: Fri, 3 Jun 2016 13:10:01 -0400
Message-ID: <20160603171001.GB3858@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-2-gitter.spiros@gmail.com>
 <20160603085320.GC28401@sigill.intra.peff.net>
 <5751A319.1030806@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:13:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sbq-0004F4-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbcFCRKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 13:10:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:48652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932216AbcFCRKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:10:04 -0400
Received: (qmail 23742 invoked by uid 102); 3 Jun 2016 17:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:10:03 -0400
Received: (qmail 24017 invoked by uid 107); 3 Jun 2016 17:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:10:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 13:10:01 -0400
Content-Disposition: inline
In-Reply-To: <5751A319.1030806@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296353>

On Fri, Jun 03, 2016 at 04:32:41PM +0100, Ramsay Jones wrote:

> >>  		char buf[48];
> >> -		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
> >> +		int len = xsnprintf(buf, sizeof(buf), "%s\t%s\n",
> >>  				   report, sha1_to_hex(sha1));
> >>  		write_or_die(1, buf, len);
> > 
> > So it's pretty unclear here whether that 48 is big enough (it is, if you
> > read the whole function, because "report" is always a 4-char string).
> > Yuck. At least there should be a comment explaining why 48 is big
> > enough.
> 
> Agreed, again I would use something like:
> 
> 		char buf[GIT_SHA1_HEXSZ + 7]; /* 40 (sha1) + 4 (report) + 3 (\t\n\0) */

Yes, that's much better, I think.

> (and yes yuck - is report ever likely to increase? "bitmap" perhaps?)

It shouldn't. It's easy to think that's a filetype, but it really is
just "did you tell me --keep". TBH, I am not really sure that switching
it accomplishes anything.

-Peff
