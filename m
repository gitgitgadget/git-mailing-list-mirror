From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 02:02:32 -0400
Message-ID: <20070521060231.GI3141@spearce.org>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <46502EF7.6000708@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 21 08:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq0zV-0003AG-P9
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbXEUGCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXEUGCy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:02:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56487 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbXEUGCx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:02:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq0yY-00052h-8l; Mon, 21 May 2007 02:02:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AA88920FBAE; Mon, 21 May 2007 02:02:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46502EF7.6000708@lsrfire.ath.cx>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47966>

Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> Shawn O. Pearce schrieb:
> > 
> > git-describe is more human-friendly than a SHA-1...
> 
> Yes, and the Makefile does even more than that: it adds a version file,
> a spec file and another version file for git-gui.
> 
> The first two are probably useful for most projects that actually do
> versioned releases.  We could have a simple parser that reads a
> template, replaces @@VERSION@@ with a git-describe output string and
> adds the result as a synthetic file to the archive.  It's not exactly
> trivial -- e.g., how to specify git-describe options, template file and
> synthetic name, all in one command line parameter? -- but it's doable.

Maybe something just as simple as allowing the user to specify a
shell script in-tree that we unpack and run for them?  That script
prints to stdout the content of the file to include.
 
> I'm not sure how the git-gui version file fits in.  I guess it's just a
> special case and doesn't need git-archive support?

Well, if you look at git-gui's own version script it really just
wants to do `git-describe` like git.git's script, but it cannot as
when its hosted in git.git `git-describe` gives us back Git's version
number, not git-gui's version number.  So we get cute and look for
the merge commit, and take the second parent, and describe that.
That's (by convention of how Junio works) always a true git-gui
commit.

In other words, git-gui.git gets a little whacky when Junio
distributes it in git.git.  git-gui really needs to become
a subproject.  When that happens its git-describe will become
much easier.

So now we're also really talking about, what should git-archive
do for a subproject?  Sometimes you really do want to repackage
and redistribute the subproject as part of the superproject's
tarball. Sometimes you don't.  I think in the case of git.git and
git-gui.git we want to include the subproject.  ;-)

-- 
Shawn.
