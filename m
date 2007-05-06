From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make --color available to git-status
Date: Sun, 6 May 2007 16:53:43 -0400
Message-ID: <20070506205343.GA9670@coredump.intra.peff.net>
References: <11783866694076-git-send-email-Matthieu.Moy@imag.fr> <Pine.LNX.4.64.0705051956200.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 06 22:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hknjq-0004Ht-C8
	for gcvg-git@gmane.org; Sun, 06 May 2007 22:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbXEFUxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 16:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbXEFUxr
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 16:53:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4703 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbXEFUxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 16:53:46 -0400
Received: (qmail 21467 invoked from network); 6 May 2007 20:53:38 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 6 May 2007 20:53:38 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2007 16:53:43 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705051956200.4015@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46374>

On Sat, May 05, 2007 at 07:58:45PM +0200, Johannes Schindelin wrote:

> AFAIR there have been attempts to enable this by default, when git-status 
> is run interactively (i.e. its output is not piped). However, this proved 
> to be remarkably complex, given that the output of runstatus _is_ piped.

I have been running with "status.color" set to "auto" for months, and it
works fine. git-status sends the output of runstatus to stdout; only
git-commit saves it in a file. However, that is irrelevant here since
git-commit explicitly turns off color anyway. The reason for this is
that the result ends up in the user's editor and in the commit object.
In the editor, it is more elegant to do syntax highlighting at that
level (otherwise you have to edit around the escape codes). For the
commit object, we would have to put in code to strip the colorization.

My biggest complaint is that git-commit shows the runstatus output to
the user if there is nothing to commit, but it isn't colorized (because
we created it with the intent of running the editor on it). This could
be fixed at the expense of slightly more CPU by simply re-running
runstatus instead of using the saved copy.

> IMHO the proper solution would be to go the full nine yards, and teach 
> runstatus about the remaining parts of git-status. Then, automatic color 
> works automatically.

When I rewrote runstatus in C, it was always my intent that it just be a
first step in turning git-status into a C builtin (with the ultimate
goal of improving the output by parallel walking the HEAD, index, and
working tree).  Unfortunately, I don't seem to have gotten around to
it...

-Peff
