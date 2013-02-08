From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] git-remote-mediawiki: use Git's Makefile to build
 the script
Date: Thu, 7 Feb 2013 23:28:00 -0500
Message-ID: <20130208042800.GB4157@sigill.intra.peff.net>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
 <1360174292-14793-5-git-send-email-Matthieu.Moy@imag.fr>
 <7vhaln7wkg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3fZb-0001Fr-CW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 05:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759965Ab3BHE2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 23:28:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39083 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759962Ab3BHE2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 23:28:03 -0500
Received: (qmail 25546 invoked by uid 107); 8 Feb 2013 04:29:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Feb 2013 23:29:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2013 23:28:00 -0500
Content-Disposition: inline
In-Reply-To: <7vhaln7wkg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215749>

On Thu, Feb 07, 2013 at 11:28:31AM -0800, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
> > The configuration of the install directory is not reused from the
> > toplevel Makefile: we assume Git is already built, hence just call
> > "git --exec-path". This avoids too much surgery in the toplevel Makefile.
> >
> > git-remote-mediawiki.perl can now "use Git;".
> >
> > Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> > ---
> 
> Continuing to the comment on 3/4, I wonder if it would be a lot
> simpler and more maintainable if you replaced 1/4 to 3/4 with a
> smaller patch to the top-level Makefile to teach it to munge
> arbitrary path/to/foo.perl to path/to/foo the same way as we do to
> other path/tool.perl that are known to the top-level Makefile
> (similarly, another target to install the resulting path/to/foo at
> an arbitrary place).  Then do something like
> 
> 	all::
> 		$(MAKE) -C ../.. \
> 			PERL_SCRIPT=contrib/mw-to-git/git-remote-mediawiki.perl \
>                         build-perl-script
> 	install::
> 		$(MAKE) -C ../.. \
> 			PERL_SCRIPT=contrib/mw-to-git/git-remote-mediawiki.perl \
>                         install-perl-script
> 
> in this step.

That seems much cleaner to me. If done right, it could also let people
put:

  CONTRIB_PERL += contrib/mw-to-git/git-remote-mediawiki

or similar into their config.mak, and just get specific contrib bits
built and installed along with the rest of git.

-Peff
