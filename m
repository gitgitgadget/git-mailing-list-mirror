From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 03:24:38 -0500
Message-ID: <20160226082437.GB26994@sigill.intra.peff.net>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net>
 <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
 <20160226075948.GA26994@sigill.intra.peff.net>
 <CA+P7+xpuiUQgWYRgVrwKkv27KiJGQ0COrR93cFzQzn2uVA6ypQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:25:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDhp-00008h-8K
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbcBZIYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:24:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:49895 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753578AbcBZIYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:24:45 -0500
Received: (qmail 28711 invoked by uid 102); 26 Feb 2016 08:24:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 03:24:40 -0500
Received: (qmail 32767 invoked by uid 107); 26 Feb 2016 08:24:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 03:24:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 03:24:38 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xpuiUQgWYRgVrwKkv27KiJGQ0COrR93cFzQzn2uVA6ypQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287551>

On Fri, Feb 26, 2016 at 12:15:46AM -0800, Jacob Keller wrote:

> On Thu, Feb 25, 2016 at 11:59 PM, Jeff King <peff@peff.net> wrote:
> > Right. The "git-config" program doesn't know about the semantics of
> > particular values (remember that in the early days, there were many
> > porcelains which built on top of git, and they could all store their own
> > config). Using "--get" implements "last one wins" semantics, which
> > is what most config variables want. You can use "--get-all" to see all
> > instances of a multi-valued variable.
> 
> And note that several libraries of hooks and git extensions store
> configuration there as well, not just traditional porcelain. (Though
> maybe that is considered porcelain? Not really sure on the term here).
> I do this myself for several custom git hooks.

Thanks, I meant to add "and it is unclear these days how many addons are
still using this feature".

I mentioned ugliness and backwards compatibility earlier.  I think
having a meaning-agnostic git-config command is still a reasonable thing
these days. But given how few multi-valued variables there are, it might
have been worth designing them differently, so that everything is
last-one-wins.

As an alternative, it would be nice to have some config syntax for
"clear the list". Maybe something like an empty string, which I think
has no meaning for the current multi-valued variables (at least not for
credential helpers or refspecs). That would allow something like:

  git -c credential.helper= clone ...

to do what you'd expect.

-Peff
