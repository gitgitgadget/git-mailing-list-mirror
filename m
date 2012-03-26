From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 14:12:38 -0400
Message-ID: <20120326181238.GH7942@sigill.intra.peff.net>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120326011148.GA4428@burratino>
 <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEPU-00033H-El
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298Ab2CZSMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:12:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60062
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933241Ab2CZSMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:12:40 -0400
Received: (qmail 14974 invoked by uid 107); 26 Mar 2012 18:12:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 14:12:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 14:12:38 -0400
Content-Disposition: inline
In-Reply-To: <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193945>

On Mon, Mar 26, 2012 at 09:38:45AM -0400, Ben Walton wrote:

> > A second reaction was to wonder why the usual fixup from
> > v1.6.4-rc0~66^2~1 (Makefile: insert SANE_TOOL_PATH to PATH before
> > /bin or /usr/bin, 2009-07-08) didn't apply.  Should the git wrapper
> > prepend the same magic to $PATH that git-sh-setup.sh does to make
> > the behavior of scripted and unscripted commands a little more
> > consistent?
> 
> I did some poking at this before creating my patch as that is what I'd
> expected too.  It would likely be a good idea, but in my case, even
> that wouldn't help.
> 
> I add /opt/csw/gnu:/opt/csw/bin:/usr/xpg4/bin to the SANE_TOOL_PATH
> but set the SHELL_PATH to /opt/csw/bin/bash.  Without my patch, but
> with SANE_TOOL_PATH honoured, I'd still see /opt/csw/bin/sh forked and
> that sh is crippled too.
> 
> So that leads me to think that if we're going to fork a shell, it
> should be one that we know to be good...if the builder has provided
> that value.  I think you agree with this based on your next comment.

What is /opt/csw/bin/sh? Is it a symlink to bash (which would mean bash
running in POSIX mode)? Or is it a lightweight shell like ash? Or
something else?

The point of SHELL_PATH is to provide a POSIX shell.  Generally, bash
behavior is a superset of POSIX, so you will not run into any
incompatibilities by running things with bash. But do be aware that you
are slightly incompatible with the rest of the world (so things that
work for you, for example, might not work for people using git with the
stock "shell is /bin/sh" configuration).

-Peff
