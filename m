From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Thu, 12 May 2011 04:04:25 -0400
Message-ID: <20110512080425.GA11870@sigill.intra.peff.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
 <4DCB88C1.20105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Pisoni <dpisoni@gmail.com>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 12 10:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKQsx-0000U5-EO
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab1ELIEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 04:04:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51826
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab1ELIE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 04:04:28 -0400
Received: (qmail 10941 invoked by uid 107); 12 May 2011 08:06:25 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 04:06:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 04:04:25 -0400
Content-Disposition: inline
In-Reply-To: <4DCB88C1.20105@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173445>

On Thu, May 12, 2011 at 09:14:09AM +0200, Michael J Gruber wrote:

> This is yet another incarnation of
> 
> foo.bar = true
> 
> meaning that command "git foo" defaults to "git foo --bar". (Admittedly,
> this is about subcommands of foo.)
> 
> It has the same problems (possibly breaking scripts). But more
> importantly, it inflates the code with every such incarnation we add.
> Have we really agreed that we introduce these one-by-one rather than
> doing something generic like
> 
> uiopts.<cmd> = <optionlist>
> 
> with which you would do
> 
> uiopts.stash = "--index"
> 
> and hopefully be script-safe (again, ignoring the subcommand issue)?

I would love to see something like this, but have we yet figured out all
of the issues, like:

  1. How do scripts wanting to call git programs suppress expansion of
     uiopts when they want predictable behavior?

  2. Depending on the solution to (1), how do scripts specify that they
     _do_ want to allow uiopts (e.g., because they know they are
     presenting the output to the user) for certain commands?

  3. Depending on (1) and (2), how do scripts differentiate when some
     options are OK in uiopts, but others are not? For example, it may
     be desirable for an invocation of diff-tree to have renames turned
     on by the user, but not for them to change the output format.

As much as it sucks to have a config option for each individual option,
there is at least some oversight of which options will not cause too
much of a problem when triggered automatically.

-Peff
