From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Tue, 27 Mar 2012 01:12:00 -0400
Message-ID: <20120327051200.GA20897@sigill.intra.peff.net>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120327032917.GB17338@sigill.intra.peff.net>
 <20120327050109.GC22547@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, gitster@pobox.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:12:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCOhY-0003XR-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab2C0FMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:12:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60431
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab2C0FMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:12:06 -0400
Received: (qmail 30700 invoked by uid 107); 27 Mar 2012 05:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 01:12:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 01:12:00 -0400
Content-Disposition: inline
In-Reply-To: <20120327050109.GC22547@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194007>

On Tue, Mar 27, 2012 at 12:01:10AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Does this default ever kick in? The Makefile defaults SHELL_PATH to
> > /bin/sh, so we will always end up with at least that.
> >
> > Doing so at least makes us consistent across builds, but I wonder if we
> > should leave it as "sh" on systems that do not set SHELL_PATH manually.
> > Executing "sh" via the PATH is the normal system() thing to do.
> 
> It's more common for system() to default to /bin/sh.

Hmm, you're right. I think I was fooled by the fact that it puts "sh"
into argv[0]. It doesn't seem to actually do a PATH lookup, though (at
least not on my system).

In that case, Ben's patch is actually making us _more_ normal and
like system(), which is probably a slight benefit (although it's still a
behavior change from what we've been doing).

> I noticed the Makefile already doesn't do this sort of thing for
> mandir and htmldir, but do you think changes to SHELL_PATH should be
> tracked to force a rebuild when it changes?

Yeah, that would be nice.

In general, I wish adding these sorts of dependencies wasn't so manual
and painful. I'm not sure of a good solution short of totally retooling
our build system, though.

-Peff
