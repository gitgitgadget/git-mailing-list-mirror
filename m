From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Makefile: allow building without perl
Date: Sat, 4 Apr 2009 19:56:36 -0400
Message-ID: <20090404235636.GA27354@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193220.GC5547@coredump.intra.peff.net> <20090404T224109Z@curie.orbis-terrarum.net> <20090404233936.GB26906@coredump.intra.peff.net> <20090404T234556Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 01:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFkn-00052S-NU
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 01:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbZDDX4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 19:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755385AbZDDX4y
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 19:56:54 -0400
Received: from peff.net ([208.65.91.99]:50211 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344AbZDDX4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 19:56:54 -0400
Received: (qmail 13092 invoked by uid 107); 4 Apr 2009 23:57:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 04 Apr 2009 19:57:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2009 19:56:36 -0400
Content-Disposition: inline
In-Reply-To: <20090404T234556Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115607>

On Sat, Apr 04, 2009 at 04:51:48PM -0700, Robin H. Johnson wrote:

> On Sat, Apr 04, 2009 at 07:39:36PM -0400, Jeff King wrote:
> > > +ifeq ($(wildcard $(PERL_PATH)),)
> > I'm not sure what you're trying to accomplish with the wildcard, unless
> > it is "PERL_PATH = /usr/*/perl" or similar, but that seems a bit crazy
> > to me. It should probably behave the same as TCLTK_PATH, though (so if
> > there is a good use case, TCLTK_PATH should be enhanced).
> No. The ifeq ($(wildcard $(PERL_PATH)),) is entirely correct.
> It's one of the few ways to detect the existence of a file from within
> Make, without any exec calls. If you give it a non-expandable path,
> /usr/bin/perl in this case, it checks only that path, and either returns
> it or an empty string. This enables us to check that /usr/bin/perl
> exists, and take suitable action if it does not.

Ah, I see. You are not asking "was PERL_PATH blank" but rather "does
PERL_PATH exist". And I think that is not the right thing for the
Makefile, as it is unlike any other part of the git Makefile, which
generally does what it is told with the minimum of magic. That sort of
magic generally goes into configure.ac.

> > I don't think there is a point in setting NO_PERL_MAKEMAKER if NO_PERL
> > is set, and I believe the export is pointless, as I described in an
> > earlier email.
> From further down the Makefile:
> ifdef NO_PERL_MAKEMAKER
>     export NO_PERL_MAKEMAKER
> endif

So NO_PERL_MAKEMAKER is _already_ exported, and I don't think there is
any reason to export NO_PERL in the environment (see patch 4/4, which
exports it via GIT-BUILD-OPTIONS).

-Peff
