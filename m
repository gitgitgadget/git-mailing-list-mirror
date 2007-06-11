From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 21:25:09 -0700
Message-ID: <20070611042509.GA19866@muzzle>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Mon Jun 11 06:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxbTA-0005Ix-MI
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 06:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbXFKEZN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 00:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbXFKEZN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 00:25:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51947 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbXFKEZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 00:25:12 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0A9087DC09D;
	Sun, 10 Jun 2007 21:25:09 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 21:25:09 -0700
Content-Disposition: inline
In-Reply-To: <003401c7abba$c7574300$0e67a8c0@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49814>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > -----Original Message-----
> > From: Steven Grimm [mailto:koreth@midwinter.com] 
> > Sent: den 11 juni 2007 01:37
> > To: Joakim Tjernlund
> > Cc: 'Eric Wong'; 'git'
> > Subject: Re: git-svn set-tree bug
> > 
> > Joakim Tjernlund wrote:
> > > Is there a way to tell set-tree to commit the whole "merge" branch
> > > as one svn commit?
> > > If I merge the latest kernel into my tree there will
> > > be a lot of commits that I don't want in svn.
> > >   
> > 
> > You want a "squash" merge. Something like this:
> > 
> > git checkout -b tempbranch origin/svn-branch-to-commit-merge-to
> > git merge --squash branch-with-commits-you-want-to-merge
> > git commit
> > git svn dcommit
> > 
> > The "merge" command will merge in the changes but will not commit 
> > anything; when you do the explicit "commit" command 
> > afterwards, you get 
> > the contents of the merge but from git's point of view it's just a 
> > regular commit so git-svn doesn't get confused.
> > 
> > After you do git svn dcommit, you may want to edit 
> > .git/info/grafts to 
> > tell git after the fact that this commit was a merge. It won't hurt 
> > git-svn at that point and it will mean you can do another merge later 
> > without git getting confused about what has already been merged.
> > 
> > Take a look at the script I posted a while back, which does something 
> > similar:
> > 
> > http://www.spinics.net/lists/git/msg29119.html

I must have missed this message the first time around.

> Hi Steven
> 
> That looks promising, especially Junos comment about making git-svn
> able to deal with merges. Eric, do you feel this is doable?

Doable?  Yes.  However, I think using grafts is quite hackish and
unreliable[1].  I'd rather just have users using set-tree if
they want to deal with non-linear history in the first place.

I'd personally avoid any sort of non-linear history when interacting
with SVN repositories, however.

[1] - as far as I know, graft files have no verification/protection
      against corruption.  They don't get cloned, either.

-- 
Eric Wong
