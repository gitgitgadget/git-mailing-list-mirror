From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 14:24:27 -0400
Message-ID: <20120326182427.GA10333@sigill.intra.peff.net>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120326011148.GA4428@burratino>
 <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca>
 <20120326181238.GH7942@sigill.intra.peff.net>
 <1332785666-sup-5513@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEao-0003NK-D6
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648Ab2CZSY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:24:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60078
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932530Ab2CZSY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:24:29 -0400
Received: (qmail 15317 invoked by uid 107); 26 Mar 2012 18:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 14:24:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 14:24:27 -0400
Content-Disposition: inline
In-Reply-To: <1332785666-sup-5513@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193949>

On Mon, Mar 26, 2012 at 02:19:54PM -0400, Ben Walton wrote:

> Excerpts from Jeff King's message of Mon Mar 26 14:12:38 -0400 2012:
> 
> > What is /opt/csw/bin/sh? Is it a symlink to bash (which would mean
> > bash running in POSIX mode)? Or is it a lightweight shell like ash?
> > Or something else?
> 
> This is some version of the traditional solaris /bin/sh packaged as
> part of schilyutils (Joerg Schilling's utilities).  I'm really not
> sure why he packages it or what the differences from /bin/sh
> are...Asking him is on my todo list though.  I only just learned it
> existed when I hit this glitch.

OK, that's gross. I would argue that your SANE_TOOL_PATH is not great,
then, because the "sh" is not sane. But that being said, this is exactly
the sort of thing I was talking about in my first message, which is that
SANE_TOOL_PATH is hard to get right. If we can make things Just Work by
using SHELL_PATH, I don't see that as a bad thing.

> > The point of SHELL_PATH is to provide a POSIX shell.  Generally,
> > bash behavior is a superset of POSIX, so you will not run into any
> > incompatibilities by running things with bash. But do be aware that
> > you are slightly incompatible with the rest of the world (so things
> > that work for you, for example, might not work for people using git
> > with the stock "shell is /bin/sh" configuration).
> 
> This was a conscious choice I made early in the packaging of git for
> OpenCSW.  The idea was that we had a shell that was also under our
> packaging control and 'sane' at the same time.  I realize it's a
> superset of the POSIX functionality.  It's something I should maybe
> change, but I'd need to stage it slowly so as to avoid breakages.

It sounds like using bash is probably the least bad thing to do, and
doing anything else would not be worth the complexity. You could use
"bash -posix" (or an sh-symlink to bash), but in practice I doubt it is
really hurting anybody.

-Peff
