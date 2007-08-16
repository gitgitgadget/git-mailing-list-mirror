From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Thu, 16 Aug 2007 01:21:10 -0700
Message-ID: <20070816082110.GB16849@muzzle>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 10:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaba-0003em-FX
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762589AbXHPIVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765664AbXHPIVO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:21:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35679 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761758AbXHPIVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:21:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1B3782DC08D;
	Thu, 16 Aug 2007 01:21:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070807205543.GB27703@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55989>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Tue, Aug 07, 2007 at 08:29:23PM +0200, Matthias Kleine wrote:
> > Hi there,
> >
> > when running "git-svn dcommit" git-svn tries to find the svn-URL of the 
> > current branch int git by looking for the most recent git log-entry 
> > corresponding to a commit in svn (see working_head_info in git-svn).  In 
> > case a merge just happended this might be the URL of another branch. Would 
> > using "log --first-parent" instead of a plain "log" take care of this 
> > problem or would it have other undesirable consequences?
> >
> 
> I had this situation, too.
> 
> 
> 			a = svn branch 'a'
> 	m		b = svn branch 'b' (in my case, it was trunk)
>       /   \		m = a merge of branch 'a' and 'b', not yet commited to svn
>      a     b
> 
> So trying to dcommit m, git svn can't figure out on which branch, as 'a'
> and 'b' are both reachable. I had to use a graft file to lose one of the
> parents, which let git-svn commit to SVN.
> 
> So for a short fix to get the work done, you could create a graft file
> where you fake m to only have one parent.

Ok.  I'm regretting making 733a65aa5d33196fac708ebd12a98a1060cbf3c2 now.

It doesn't introduce the problem, but it does encourage it.  I still
happen to believe allowing git-merges in repositories that try to
interoperate with SVN is just giving rope for users to hang themselves
with.


Junio:
Would you object to having git-merge spew a big fat warning
and/or outright refuse to let git-merge run on git-svn repositories?


13c823fb520eaf1cded520213cf0ae4c3268208d was introduced to allow using
git-format-patch + git-am to apply patches from other branches in SVN,
which is the recommended way to do "merging" with git-svn.

> On the longer run, I would make sense to have an option to explicitly
> specify on which SVN branch 'git-svn dcommit' should operate.

Patches welcome :)

-- 
Eric Wong
