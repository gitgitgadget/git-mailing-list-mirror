From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn 1.5.3 does not understand grafts?
Date: Sat, 8 Sep 2007 13:04:12 +0200
Message-ID: <000001c7f207$fd7562d0$5267a8c0@Jocke>
References: <20070908050146.GA28855@soma>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 08 13:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITy7B-0004gN-Iy
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 13:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbXIHLEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 07:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbXIHLEa
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 07:04:30 -0400
Received: from mail.transmode.se ([83.241.175.147]:29860 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156AbXIHLEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 07:04:30 -0400
Received: from Jocke ([84.217.81.206]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 8 Sep 2007 13:04:27 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acfx1V30U/W1iTgcSeShGvjb0ZFRrwAJvlwQ
In-Reply-To: <20070908050146.GA28855@soma>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
X-OriginalArrivalTime: 08 Sep 2007 11:04:28.0070 (UTC) FILETIME=[062E3460:01C7F208]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58118>

> -----Original Message-----
> From: Eric Wong [mailto:normalperson@yhbt.net] 
> Sent: den 8 september 2007 07:02
> To: Joakim Tjernlund
> Cc: git
> Subject: Re: git-svn 1.5.3 does not understand grafts?
> 
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > On Fri, 2007-09-07 at 18:52 +0200, Joakim Tjernlund wrote:
> > > On Fri, 2007-09-07 at 18:41 +0200, Joakim Tjernlund wrote:
> > > > svnadmin create /usr/local/src/TM/svn-tst/7720-svn/
> > > > svn mkdir  
> file:///usr/local/src/TM/svn-tst/7720-svn/trunk -m "Add trunk dir"
> > > > svn mkdir  
> file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp -m "Add swp dir"
> > > > 
> > > > In my git repo I do
> > > > git-svn init  
> file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> > > > git-svn fetch
> > > > git branch svn remotes/git-svn
> > > > #make remotes/git-svn parent to the initial commit in 
> my git tree
> > > > graftid=`git-show-ref -s svn`
> > > > echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid 
> > .git/info/grafts
> > > > #da783... is the initial commit in my git tree.
> > > > git-svn dcommit
> > > > 
> > > > fails with:
> > > > Committing to 
> file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp ...
> > > > Commit da783cce390ce013b19f1d308ea6813269c6a6b5
> > > > has no parent commit, and therefore nothing to diff against.
> > > > You should be working from a repository originally 
> created by git-svn
> > > 
> > > Using filter-branch helps, but git-svn isn't too happy:
> > > 
> > > git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> > > git-svn fetch
> > > git branch svn remotes/git-svn
> > > #make remotes/git-svn parent to the initial commit in my git tree
> > > graftid=`git-show-ref -s svn`
> > > echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > 
> .git/info/grafts
> > > #da783... is the initial commit in my git tree.
> > > git filter-branch $graftid..HEAD
> > > git-svn dcommit
> > > 
> > > Now I get alot of complaints, but it commits to svn.
> > > It takes forever though:
> > > r3 = 55a489bd4f66dd1f641a4676359d7b8911dc7d83 (git-svn)
> > > W: HEAD and refs/remotes/git-svn differ, using rebase:
> > > :100644 100644 f85ae11af7715a224015582724cb2bab87ec914a
> 
> I haven't used filter-branch myself, but you probably need to 
> remove all
> .rev_db* files in $GIT_DIR after running it (git-svn can recreate them
> unless you use the svmRevProps or noMetadata options.

havn't used it either, but I wanted to see if it makes a difference.
I will remember to remove the .rev_db* files next time I try.

filter branch is overkill if the grafts file works as git-svn will rewrite
the commits so once the first dcommit has been made, I can remove the
grafts file.

I do have another project though were I want to fix som odd parenting caused
by set-tree, there I will have to used filter-branch to make it permanet.

> 
> > [SNIP]
> > 
> > Just wanted to add that 1.5.2.2 works with grafts and 
> > that I suspect sub read_commit_parents in git-svn, but as I don't
> > do perl I am stuck.
> 
> Crap, it looks like I completely forgot about the existence
> of grafts while doing this function.

:)
Do you have to worry about grafts in git-svn? 
Can't git plumbing do this for you?

> 
> >      Jocke
> > Oh, Eric W. CC:ed as well this time
> 
> Thanks.
> 
> -- 
> Eric Wong
> 
> 
