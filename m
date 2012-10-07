From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 7 Oct 2012 19:07:03 -0400
Message-ID: <20121007230703.GC3490@sigill.intra.peff.net>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:07:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzwO-000344-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769Ab2JGXHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:07:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44078 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2JGXHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:07:06 -0400
Received: (qmail 19444 invoked by uid 107); 7 Oct 2012 23:07:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 19:07:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 19:07:03 -0400
Content-Disposition: inline
In-Reply-To: <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207213>

On Sun, Oct 07, 2012 at 03:40:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Oct 07, 2012 at 01:39:32PM -0700, Junio C Hamano wrote:
> > ...
> >> but it is not so far-fetched to imagine that Windows users may want to
> >> omit manpages with
> >> 
> >>     $ DEFAULT_DOC_TARGET=html make doc
> >
> > That use case makes a lot more sense to me (or more likely setting it in
> > config.mak).
> 
> I actually had "ifeq ($(uname_S),Windows)" at the top-level in mind,
> not config.mak.  I think that is far more important use case than
> going down to Documentation yourself and run make there (which is
> not a workflow I deeply care about in the first place).

Hmm. Unfortunately that does not work from within Documentation, because
Documentation/Makefile never gets to see our default-system tweaks (it
sees only config.mak).

I know it is a case you do not care about (and nor do I; if I use this
at all, it would be to limit my build by setting the variable in my
config.mak), but it highlights a subtle issue. The subdir Makefiles
receive their config from config.mak.autogen and config.mak, but never
get to see any of the default tweaks we do based on $(uname). Which the
contents of config.mak could very well depend on, if somebody were
trying to be very clever.

Would it make sense to pull all of our platform-specific tweaks out into
a config.mak.platform (right before config.mak.autogen)? That would be
less surprising for cases like this, and I think it would make the
Makefile a lot more readable.

-Peff
