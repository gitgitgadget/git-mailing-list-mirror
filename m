From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement https public key pinning
Date: Fri, 12 Feb 2016 13:37:10 -0500
Message-ID: <20160212183710.GC19973@sigill.intra.peff.net>
References: <20160211225437.GA33955@mitoraj.siccegge.de>
 <alpine.DEB.2.20.1602120030120.5268@tvnag.unkk.fr>
 <87oabmg24u.fsf@mitoraj.siccegge.de>
 <20160212100226.GB13775@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christoph Egger <christoph@christoph-egger.org>,
	Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIan-0000Cl-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbcBLShR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 13:37:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:41131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752504AbcBLShN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:37:13 -0500
Received: (qmail 13219 invoked by uid 102); 12 Feb 2016 18:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:37:13 -0500
Received: (qmail 18207 invoked by uid 107); 12 Feb 2016 18:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:37:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 13:37:10 -0500
Content-Disposition: inline
In-Reply-To: <20160212100226.GB13775@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286066>

On Fri, Feb 12, 2016 at 11:02:26AM +0100, Thomas Gummerer wrote:

> > Also some people suggested that git should fail if this option is
> > requested in the config but not supported by the libcurl version instead
> > of falling back to just not pin the key. I'm undecided about that.
> 
> This seems to have been suggested off list (or at least I can't find
> the message).  FWIW I do agree with failing or as a bare minimum
> warning the user if the config option is set, but not supported by the
> libcurl version.  Otherwise we risk giving the user a false sense of
> security when the option is set, which is arguably worse than not
> having the security option at all.

We can't do this perfectly, because older versions of git do not yet
know about the option, and will therefore just silently ignore it. And
for consistency there, we usually do the same for features that we know
about but are unsupported.

But I agree for something with security implications like this, we are
better off warning when we know support is not built in. That's not
perfect, but it's better than nothing.

I wonder if there are other options which should get the same treatment.
Most of the obvious ones I could think of (e.g., http.sslverify) do not
need it, because either they always have support built, or they
fail-closed, or both.

-Peff
