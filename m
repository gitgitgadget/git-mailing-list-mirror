From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Fri, 17 Aug 2007 00:55:49 -0700
Message-ID: <20070817075549.GE16849@muzzle>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx> <20070816082110.GB16849@muzzle> <20070816121636.GC4499@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Matthias Kleine <matthias_kleine@gmx.de>,
	Tobias Limmer <tobias.limmer@informatik.uni-erlangen.de>,
	sommer@mail.berlios.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 09:56:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILwgu-00050q-RE
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 09:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbXHQHzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 03:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757282AbXHQHzv
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 03:55:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39516 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758649AbXHQHzu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 03:55:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5D0DC2DC08D;
	Fri, 17 Aug 2007 00:55:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070816121636.GC4499@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56049>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Thu, Aug 16, 2007 at 01:21:10AM -0700, Eric Wong wrote:
> > Peter Baumann <waste.manager@gmx.de> wrote:
> > > On Tue, Aug 07, 2007 at 08:29:23PM +0200, Matthias Kleine wrote:
> > > > Hi there,
> > > >
> > > > when running "git-svn dcommit" git-svn tries to find the svn-URL of the 
> > > > current branch int git by looking for the most recent git log-entry 
> > > > corresponding to a commit in svn (see working_head_info in git-svn).  In 
> > > > case a merge just happended this might be the URL of another branch. Would 
> > > > using "log --first-parent" instead of a plain "log" take care of this 
> > > > problem or would it have other undesirable consequences?
> > > >
> > > 
> > > I had this situation, too.
> > > 
> > > 
> > > 			a = svn branch 'a'
> > >         m		b = svn branch 'b' (in my case, it was trunk)
> > >       /   \		m = a merge of branch 'a' and 'b', not yet commited to svn
> > >      a     b
> > > 
> > > So trying to dcommit m, git svn can't figure out on which branch, as 'a'
> > > and 'b' are both reachable. I had to use a graft file to lose one of the
> > > parents, which let git-svn commit to SVN.
> > > 
> > > So for a short fix to get the work done, you could create a graft file
> > > where you fake m to only have one parent.
> > 
> > Ok.  I'm regretting making 733a65aa5d33196fac708ebd12a98a1060cbf3c2 now.
> > 
> > It doesn't introduce the problem, but it does encourage it.  I still
> > happen to believe allowing git-merges in repositories that try to
> > interoperate with SVN is just giving rope for users to hang themselves
> > with.
> > 
> > 
> > Junio:
> > Would you object to having git-merge spew a big fat warning
> > and/or outright refuse to let git-merge run on git-svn repositories?
> 
> By removing merges in git-svn, it would lose much of its 'magic'. I have
> to mainain a SVN branch and from time to time, I merge with trunk. So
> it'll totally screw me if I lose the merge history (sure, I could use
> a graft file, but a real merge is preferable, because I can clone the
> repo then).

Ok, outright refusing to merge/pull is probably too much.  But spewing
a big warning may help.

> > 13c823fb520eaf1cded520213cf0ae4c3268208d was introduced to allow using
> > git-format-patch + git-am to apply patches from other branches in SVN,
> > which is the recommended way to do "merging" with git-svn.
> > 
> Hm. What about cherry pick? I ask because a friend of mine messed up the
> SVN repo after cherry picking a commit from 'trunk' and then his next
> dcommit put everything into 'trunk' instead of his own branch (hopefully,
> I remembered correctly; but at least I know for sure a cherry pick from
> trunk was involved). I can't ask him right now, because he is on
> vacation till monday, but I'll Cc him, just in case.

Yeah, cherry-pick works, too.  I've never actually used cherry-pick
myself, because git-format-patch and git-am let me work on a series of
patches rather than one-at-a-time.

-- 
Eric Wong
