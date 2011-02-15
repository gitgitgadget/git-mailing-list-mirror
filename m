From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Tue, 15 Feb 2011 01:39:03 -0500
Message-ID: <20110215063903.GA28634@sigill.intra.peff.net>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <20110213123151.GA31375@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@googlemail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 07:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpEZ8-0002mq-UA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 07:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab1BOGjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 01:39:09 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab1BOGjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 01:39:08 -0500
Received: (qmail 28587 invoked by uid 111); 15 Feb 2011 06:39:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Feb 2011 06:39:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 01:39:03 -0500
Content-Disposition: inline
In-Reply-To: <20110213123151.GA31375@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166814>

On Sun, Feb 13, 2011 at 01:31:52PM +0100, Heiko Voigt wrote:

> On Sat, Feb 12, 2011 at 02:05:38AM -0500, Jeff King wrote:
> >   1. Give some indication or warning during commit that you're in a
> >      detached state. The CLI template says "You are not on any branch"
> >      when editing the commit message, and mentions "detached HEAD" as
> >      the branch in the post-commit summary. As far as I can tell,
> >      git-gui says nothing at all.
> 
> How about something like this:
> [...]
> Subject: [PATCH] git-gui: warn when trying to commit on a detached head
> 
> The commandline is already warning when checking out a detached head.
> Since the only thing thats potentially dangerous is to create commits
> on a detached head lets warn in case the user is about to do that.

It seems a little heavy-handed to have a dialog pop up for each commit.
It's not actually dangerous to create a commit on a detached HEAD; it's
just dangerous to _leave_ without referencing your new commits.

So I think for making commits, something informational that doesn't
require a click-through would be the more appropriate level (similar to
what the CLI does; it just mentions it in the commit template). I guess
there isn't a commit template in the same way for git gui; instead, it
is always showing you the current state. And indeed, it does switch from
"Current Branch: master" to "Current Branch: HEAD" when you are on a
detached head. Maybe we should beef that up a bit to "You are not on any
branch." or something that is more self-explanatory. I dunno. I am just
guessing here about what users would want.

I do think a pop-up is appropriate when you try to check something else
out, and commits you have made on the detached HEAD are about to become
unreferenced. But this is something even the CLI doesn't do, so it would
make sense to see how the check is implemented there first before doing
anything in git-gui.

-Peff
