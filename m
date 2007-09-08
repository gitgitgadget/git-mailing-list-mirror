From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn 1.5.3 does not understand grafts?
Date: Sat, 8 Sep 2007 19:43:27 +0200
Message-ID: <045501c7f23f$c359c450$5267a8c0@Jocke>
References: <20070908050146.GA28855@soma>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 08 19:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU4LY-0005Xz-C6
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 19:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbXIHRnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 13:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbXIHRnp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 13:43:45 -0400
Received: from mail.transmode.se ([83.241.175.147]:41052 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754651AbXIHRno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 13:43:44 -0400
Received: from Jocke ([84.217.81.206]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 8 Sep 2007 19:43:42 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acfx1V30C1PJ9m2zSSudL0zr1q0HMwAafTww
In-Reply-To: <20070908050146.GA28855@soma>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
X-OriginalArrivalTime: 08 Sep 2007 17:43:42.0251 (UTC) FILETIME=[CBFC27B0:01C7F23F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58130>

 

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
> 
> > [SNIP]
> > 
> > Just wanted to add that 1.5.2.2 works with grafts and 
> > that I suspect sub read_commit_parents in git-svn, but as I don't
> > do perl I am stuck.
> 
> Crap, it looks like I completely forgot about the existence
> of grafts while doing this function.

hmm, I think git-cat-file is to blame.
git-cat-file commit da783cce390ce013b19f1d308ea6813269c6a6b5 does
not list list any parent even though I did
graftid=`git-show-ref -s remotes/git-svn`
echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts

 Jocke
