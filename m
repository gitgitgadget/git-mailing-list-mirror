From: Jeff King <peff@peff.net>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 06:36:39 -0400
Message-ID: <20150605103639.GB19033@peff.net>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
 <20150605094545.GB11855@peff.net>
 <CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 12:36:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0ozX-0001uU-9N
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 12:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbbFEKgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 06:36:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:41551 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751483AbbFEKgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 06:36:42 -0400
Received: (qmail 26326 invoked by uid 102); 5 Jun 2015 10:36:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 05:36:42 -0500
Received: (qmail 7880 invoked by uid 107); 5 Jun 2015 10:36:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 06:36:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jun 2015 06:36:39 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270823>

On Fri, Jun 05, 2015 at 05:14:25PM +0700, Duy Nguyen wrote:

> I'm more concerned about breaking object_id abstraction than C
> standard. Let's think a bit about future. I suppose we need to support
> both sha-1 and sha-512, at least at the source code level.

I think that's going to be a much bigger issue, because we are casting
out of a defined, on-disk data structure here. So I'd rather defer any
code changes around this until we see what the new data structure (and
the new code) look like.

> That might make casting tricky. Maybe we should deal with it now
> instead of delaying because if the final solution is vastly different,
> we may be redoing this conversion again. In any case, if we cast, we
> should make it grep-able (maybe hide the casting in a macro so we can
> grep the macro's name) so we can examine them when the time comes for
> us to move away from sha-1.

I think that is sensible. Something like:

  #define SHA1_TO_OBJID(sha1) ((struct object_id *)sha1)

would probably be a good start.

-Peff
