From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn 1.5.3 does not understand grafts?
Date: Fri, 07 Sep 2007 22:23:54 +0200
Organization: Transmode AB
Message-ID: <1189196635.14841.24.camel@gentoo-jocke.transmode.se>
References: <1189183276.14841.10.camel@gentoo-jocke.transmode.se>
	 <1189183934.14841.18.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkN1-0007Hp-Fe
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXIGUX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbXIGUX6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:23:58 -0400
Received: from mail.transmode.se ([83.241.175.147]:10827 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751409AbXIGUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:23:58 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 07 Sep 2007 22:23:55 +0200
In-Reply-To: <1189183934.14841.18.camel@gentoo-jocke.transmode.se>
X-Mailer: Evolution 2.10.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58066>

On Fri, 2007-09-07 at 18:52 +0200, Joakim Tjernlund wrote:
> On Fri, 2007-09-07 at 18:41 +0200, Joakim Tjernlund wrote:
> > svnadmin create /usr/local/src/TM/svn-tst/7720-svn/
> > svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk -m "Add trunk dir"
> > svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp -m "Add swp dir"
> > 
> > In my git repo I do
> > git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> > git-svn fetch
> > git branch svn remotes/git-svn
> > #make remotes/git-svn parent to the initial commit in my git tree
> > graftid=`git-show-ref -s svn`
> > echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
> > #da783... is the initial commit in my git tree.
> > git-svn dcommit
> > 
> > fails with:
> > Committing to file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp ...
> > Commit da783cce390ce013b19f1d308ea6813269c6a6b5
> > has no parent commit, and therefore nothing to diff against.
> > You should be working from a repository originally created by git-svn
> > 
> > 
> >  Jocke
> 
> Using filter-branch helps, but git-svn isn't too happy:
> 
> git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> git-svn fetch
> git branch svn remotes/git-svn
> #make remotes/git-svn parent to the initial commit in my git tree
> graftid=`git-show-ref -s svn`
> echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
> #da783... is the initial commit in my git tree.
> git filter-branch $graftid..HEAD
> git-svn dcommit
> 
> Now I get alot of complaints, but it commits to svn.
> It takes forever though:
> r3 = 55a489bd4f66dd1f641a4676359d7b8911dc7d83 (git-svn)
> W: HEAD and refs/remotes/git-svn differ, using rebase:
> :100644 100644 f85ae11af7715a224015582724cb2bab87ec914a
[SNIP]

Just wanted to add that 1.5.2.2 works with grafts and 
that I suspect sub read_commit_parents in git-svn, but as I don't
do perl I am stuck.

     Jocke
Oh, Eric W. CC:ed as well this time
