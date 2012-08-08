From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] check-docs: update non-command documentation list
Date: Wed, 8 Aug 2012 16:54:56 -0400
Message-ID: <20120808205456.GB29528@sigill.intra.peff.net>
References: <20120808183132.GA24550@sigill.intra.peff.net>
 <20120808183433.GB24574@sigill.intra.peff.net>
 <7vwr19rxua.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:55:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDHZ-0002B3-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255Ab2HHUzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:55:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57672 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380Ab2HHUzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:55:02 -0400
Received: (qmail 11563 invoked by uid 107); 8 Aug 2012 20:55:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 16:55:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 16:54:56 -0400
Content-Disposition: inline
In-Reply-To: <7vwr19rxua.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203126>

On Wed, Aug 08, 2012 at 12:24:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The check-docs target looks at Documentation/git*txt and
> > complains if any entry does not have a matching command.
> > Therefore we need to explicitly ignore any entries which are
> > not meant to describe a command (like gitattributes.txt).
> > This list has grown stale over time, so let's bring it up to
> > date.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I really wonder if we would do better to match git-*.txt, since most of
> > the ignores are gitfoo(7) types of pages. We'd probably want to add back
> > in "git", "gitweb" and "gitk" explicitly, but they are already handled
> > specially above and below.
> 
> Quite possibly, yes.

Actually, my "already handled specially" is not quite accurate. That
special list is "things that are commands but are not necessarily
mentioned in the Makefile variables". But this list is "things that are
documented but do not begin with git-". The two should mostly be the
same, but the whole point of this exercise is to make sure they _are_
the same.

A better solution is to simply ask the Documentation directory what the
commands are, since it already knows (in the form of MAN1_TXT).

> Also "git gitk gitweb" may want to be made into a Makefile variable
> to be shared in the "above" and "below" (I do not know what to call
> them offhand---they are programs with special build rules that are
> not covered by ALL/SCRIPT_LIB/BUILTIN).

I couldn't think of a special name, either, but I think it is sufficient
to just create a new ALL_COMMANDS variable that includes those other
things, and then add to it.

> By the way, do we have a documentation for git-gui?  Perhaps it may
> want to be added to that "git gitk gitweb" list as a reminder that
> it lacks documentation.  One of the goals of the person who runs
> "make check-docs" should be to reduce the special case that appears
> at the beginning of that case statement.

Yes, it should be checked (and git-citool, too).

> I also wonder why "help" is not treated as a built-in?  Perhaps we
> should throw it in to "git gitk gitweb" list?  After all, it is a
> command that is available in "git foo" form, is documented, and is
> listed in the command-list.txt file.

Historically it was part of git.c, but these days it is a built-in and
does not need any special treatment from check-docs.

Patches for all to follow (on top of my previous 4).

  [5/4]: check-docs: factor out command-list
  [6/4]: check-docs: list git-gui as a command
  [7/4]: check-docs: drop git-help special-case
  [8/4]: check-docs: get documented command list from Makefile

-Peff
