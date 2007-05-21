From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 02:29:53 -0400
Message-ID: <20070521062953.GL3141@spearce.org>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com> <20070520163026.GA7387@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon May 21 08:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1PK-00077A-BS
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXEUGaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbXEUGaI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:30:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56908 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbXEUGaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:30:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq1P1-0005nS-3G; Mon, 21 May 2007 02:29:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F14D520FBAE; Mon, 21 May 2007 02:29:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070520163026.GA7387@cip.informatik.uni-erlangen.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47971>

Thomas Glanzmann <thomas@glanzmann.de> wrote:
> so this output is useless if you don't have tagged the commit which
> isn't the case. But thanks for the awareness.

Thanks for not quoting Brian's reply.  Because I had to go and
quote it manually, so I can say its *NOT* useless...

> Brian Gernhardt <benji@silverinsanity.com> wrote:
> > For version information it is far more useful to use --tags or no
> > options (annotated tags only) instead of --all.
> > 
> > # On git.git's master this morning:
> > $ git describe HEAD
> > v1.5.2

Here whatever HEAD's commit is is exactly the commit that the tag
v1.5.2 points at.  This commit is definately v1.5.2.

> > $ git describe HEAD^^
> > v1.5.2-rc3-97-g03f6db0

Here whatever commit is 2 commits earlier than HEAD is 97 commits
*after* v1.5.2-rc3 was tagged.  That's a good deal of information
right there.  I know its v1.5.2-rc3 plus a bunch of additional
commits (97 to be exact).  Add another commit and that 97 will
go to 98.  Wow, look, an automatic version counter!  No user
intervention required!

Sometimes I don't even bother tagging git-gui fixes, for exactly
that reason.  The output of git-describe is giving me a count along
my maint branch, or my master branch.

Now that g03f6db0 suffix is also very useful, it means its the
commit whose SHA- starts with 03f6db0.  That abbreviated SHA-1
is unique at the time that git-describe ran.  At 8 hex digits it
will probably also stay unique for quite some time, even in large
projects like the kernel.

And even if that isn't unique later on, I doubt there will be another
commit with the same leading hex digits that is also 97 commits
after v1.5.2, as counted by `git-rev-list v1.5.2..$it | wc -l`.
So even in the case of a later duplicate, we can get back a full
SHA-1.

And did you know that Git knows how to parse those, and can checkout
that commit?

  $ git checkout v1.5.2-rc3-97-g03f6db0
  Note: moving to "v1.5.2-rc3-97-g03f6db0" which isn't a local branch
  If you want to create a new branch from this checkout, you may do so
  (now or later) by using -b with the checkout command again. Example:
    git checkout -b <new_branch_name>
  HEAD is now at 03f6db0... Merge branch 'maint' to synchronize with 1.5.1.6

Wow.  Magic!  Not useless!

-- 
Shawn.
