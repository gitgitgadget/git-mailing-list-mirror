From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Makefile: allow building without perl
Date: Sat, 4 Apr 2009 19:39:36 -0400
Message-ID: <20090404233936.GB26906@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193220.GC5547@coredump.intra.peff.net> <20090404T224109Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 01:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFUh-0002JY-NZ
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 01:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbZDDXjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 19:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbZDDXjz
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 19:39:55 -0400
Received: from peff.net ([208.65.91.99]:38516 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbZDDXjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 19:39:54 -0400
Received: (qmail 13019 invoked by uid 107); 4 Apr 2009 23:40:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 04 Apr 2009 19:40:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2009 19:39:36 -0400
Content-Disposition: inline
In-Reply-To: <20090404T224109Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115604>

On Sat, Apr 04, 2009 at 03:47:29PM -0700, Robin H. Johnson wrote:

> On Fri, Apr 03, 2009 at 03:32:20PM -0400, Jeff King wrote:
> > For systems with a missing or broken perl, it is nicer to
> > explicitly say "we don't want perl" because:
> Part of the patch got missed. In the case of missing perl, we can detect it,
> originally we had a compare of PERL_PATH for emptiness.

Thanks. I was hesitant on this at first because I think the behavior
should be the same as with TCLTK_PATH, but I didn't realize that
TCLTK_PATH already automagically sets NO_TCLTK in the same way.

> +ifeq ($(wildcard $(PERL_PATH)),)
> +PERL_PATH =
> +NO_PERL = NoThanks
> +NO_PERL_MAKEMAKER = NoThanks
> +export NO_PERL NO_PERL_MAKEMAKER
> +endif

The TCLTK code is just:

  ifeq ($(TCLTK_PATH),)
  NO_TCLTK=NoThanks
  endif

I'm not sure what you're trying to accomplish with the wildcard, unless
it is "PERL_PATH = /usr/*/perl" or similar, but that seems a bit crazy
to me. It should probably behave the same as TCLTK_PATH, though (so if
there is a good use case, TCLTK_PATH should be enhanced).

I don't think there is a point in setting NO_PERL_MAKEMAKER if NO_PERL
is set, and I believe the export is pointless, as I described in an
earlier email.

-Peff
