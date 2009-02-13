From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 14:27:24 -0500
Message-ID: <20090213192724.GA6782@coredump.intra.peff.net>
References: <1234529920-9694-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0902131418230.10279@pacific.mpi-cbg.de> <200902131437.49293.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 13 20:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY3iZ-0000Qa-Kt
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 20:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZBMT11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 14:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZBMT11
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 14:27:27 -0500
Received: from peff.net ([208.65.91.99]:42168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbZBMT11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 14:27:27 -0500
Received: (qmail 25724 invoked by uid 107); 13 Feb 2009 19:27:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 14:27:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 14:27:24 -0500
Content-Disposition: inline
In-Reply-To: <200902131437.49293.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109773>

On Fri, Feb 13, 2009 at 02:37:39PM +0100, Thomas Rast wrote:

> > How about making this an option, and passing it in rev_opts instead?  This 
> > option could then be defaulted to in git-log, when the user said 
> > --abbrev-commit.
> 
> But the 'git_config(git_log_config, NULL);' that sets the new variable
> to false is only called from cmd_{log,show,whatchanged,reflog}.  I
> should have indicated this in the commit messaged, sorry.

We use that technique elsewhere in git, and personally I am not a fan of
it, as it comes down to setting a global variable. That worked fine when
we had a lot of one-shot programs that read the config, did a defined
piece of work, and then exited.

But more and more we are performing multiple actions in a single run
(especially as many scripts become builtin porcelains), and those
globals are applied to all actions. So a porcelain trying to do a
plumbing-ish thing can run into problems.

I can't recall the exact details, but I remember dealing with something
like this related to external diff. Using an ALLOW_EXTERNAL diffopt
ended up being more reliable, _and_ easier to read and follow in the
code.

Now I don't think this is probably a big problem for this particular
option, but I'd rather not see the technique propagated.

-Peff
