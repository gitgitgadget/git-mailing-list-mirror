From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in run_command.c:prepare_shell_cmd
Date: Tue, 27 Mar 2012 22:46:15 -0400
Message-ID: <1332901381-sup-4406@pinkfloyd.chass.utoronto.ca>
References: <20120326182427.GA10333@sigill.intra.peff.net> <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca> <20120327032917.GB17338@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	jrnieder <jrnieder@gmail.com>,
	gitster <gitster@pobox.com> (junio),
	git <git@vger.kernel.org> (git)
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 04:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCiu2-0000HQ-E7
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 04:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab2C1CqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 22:46:19 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:53200 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab2C1CqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 22:46:18 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:34436 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCitr-0003tn-9T; Tue, 27 Mar 2012 22:46:15 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCitr-0007tc-8F; Tue, 27 Mar 2012 22:46:15 -0400
In-reply-to: <20120327032917.GB17338@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194102>

Excerpts from Jeff King's message of Mon Mar 26 23:29:17 -0400 2012:

Hi Jeff,

> > +run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH)"'
> > +
> 
> This should be $(SHELL_PATH_SQ), no?

Yes, you're right, it should be.

> > +#ifndef SHELL_PATH
> > +# define SHELL_PATH "sh"
> > +#endif
> 
> Does this default ever kick in? The Makefile defaults SHELL_PATH to
> /bin/sh, so we will always end up with at least that.

Not when using the build system, but as Hannes mentioned, there is
potential for this to be used outside of the default build system, so
I think having the fallback is a good defensive option.  Should it
maybe be set to /bin/sh though to be more consistent with system()?

> The whole SHELL_PATH and SANE_TOOL_PATH mess is about helping people
> on less-abled systems, and I do not mind bending the usual
> conventions to make things more convenient on those systems (e.g.,
> by not doing the PATH lookup of the shell name). But it would be
> nice if that bending did not affect people on more mainstream
> systems.

Given the rest of the discussion that happened, I think I understand
that my patch is actually ok with the following caveats:

1. My commit message still needs work.
2. Possibly change the default setting of the SHELL_PATH macro from
   "sh" to "/bin/sh"
3. Use the _SQ variant of SHELL_PATH.

(The tracking of changes for SHELL_PATH is considered too heavy for
now when the other _PATH items aren't tracked the same way.  This
might make a nice separate patch series though, using the idea from
the kernel where individual commands are tracked.)

Did I miss anything else?

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
