From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn 1.5.3 does not understand grafts?
Date: Fri, 7 Sep 2007 22:01:46 -0700
Message-ID: <20070908050146.GA28855@soma>
References: <1189183276.14841.10.camel@gentoo-jocke.transmode.se> <1189183934.14841.18.camel@gentoo-jocke.transmode.se> <1189196635.14841.24.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Sep 08 07:01:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITsS9-00063u-3P
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 07:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbXIHFBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 01:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXIHFBr
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 01:01:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35148 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbXIHFBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 01:01:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 70CD92DC08D;
	Fri,  7 Sep 2007 22:01:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1189196635.14841.24.camel@gentoo-jocke.transmode.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58100>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Fri, 2007-09-07 at 18:52 +0200, Joakim Tjernlund wrote:
> > On Fri, 2007-09-07 at 18:41 +0200, Joakim Tjernlund wrote:
> > > svnadmin create /usr/local/src/TM/svn-tst/7720-svn/
> > > svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk -m "Add trunk dir"
> > > svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp -m "Add swp dir"
> > > 
> > > In my git repo I do
> > > git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> > > git-svn fetch
> > > git branch svn remotes/git-svn
> > > #make remotes/git-svn parent to the initial commit in my git tree
> > > graftid=`git-show-ref -s svn`
> > > echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
> > > #da783... is the initial commit in my git tree.
> > > git-svn dcommit
> > > 
> > > fails with:
> > > Committing to file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp ...
> > > Commit da783cce390ce013b19f1d308ea6813269c6a6b5
> > > has no parent commit, and therefore nothing to diff against.
> > > You should be working from a repository originally created by git-svn
> > 
> > Using filter-branch helps, but git-svn isn't too happy:
> > 
> > git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> > git-svn fetch
> > git branch svn remotes/git-svn
> > #make remotes/git-svn parent to the initial commit in my git tree
> > graftid=`git-show-ref -s svn`
> > echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
> > #da783... is the initial commit in my git tree.
> > git filter-branch $graftid..HEAD
> > git-svn dcommit
> > 
> > Now I get alot of complaints, but it commits to svn.
> > It takes forever though:
> > r3 = 55a489bd4f66dd1f641a4676359d7b8911dc7d83 (git-svn)
> > W: HEAD and refs/remotes/git-svn differ, using rebase:
> > :100644 100644 f85ae11af7715a224015582724cb2bab87ec914a

I haven't used filter-branch myself, but you probably need to remove all
.rev_db* files in $GIT_DIR after running it (git-svn can recreate them
unless you use the svmRevProps or noMetadata options.

> [SNIP]
> 
> Just wanted to add that 1.5.2.2 works with grafts and 
> that I suspect sub read_commit_parents in git-svn, but as I don't
> do perl I am stuck.

Crap, it looks like I completely forgot about the existence
of grafts while doing this function.

>      Jocke
> Oh, Eric W. CC:ed as well this time

Thanks.

-- 
Eric Wong
