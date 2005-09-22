From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Unexpected behavior in git-rev-list
Date: Thu, 22 Sep 2005 17:04:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509221617300.23242@iabervon.org>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
 <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org> <20050918175847.GA10427@ebar091.ebar.dtu.dk>
 <20050921164948.GB23525@ebar091.ebar.dtu.dk> <Pine.LNX.4.58.0509211022180.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIYAb-0005P3-3v
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 22:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVIVU7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 16:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVIVU7u
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 16:59:50 -0400
Received: from iabervon.org ([66.92.72.58]:50948 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751188AbVIVU7u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 16:59:50 -0400
Received: (qmail 17213 invoked by uid 1000); 22 Sep 2005 17:04:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Sep 2005 17:04:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509211022180.2553@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9141>

On Wed, 21 Sep 2005, Linus Torvalds wrote:

> Anyway, I've seriously considered adding a mode to "git-rev-list" that
> automatically avoids following the parents that aren't relevant for a
> certain set of files.
> 
> Ie if you did
> 
> 	git-rev-list rev1 rev2 ^rev3 ^rev4 .. pathname
> 
> it would only show the revisions that actually _change_ the pathname.
>
> It's not entirely trivial. The biggest bummer is that we'd have to fake
> out the parent info (ie the "parent" would have to be the previous entry
> that changes it, not the real one).

How about a program that made the fake thing real? That is, actually wrote 
to the database the entire history with only those paths included, and 
only commits that change those paths.

This would be exactly the right thing for the people who want kbuild to be 
a separate project from the kernel, because "the kbuild project", with 
full history, could be automatically generated.

For that matter, Sam could actually use that repository for maintaining 
kbuild, because if mainline merges that instead of merging the present 
kbuild-in-kernel repository, it'll be exactly the same. He could pick up 
stuff from the mainline by subsetting mainline.

In fact, this operation would allow Junio to push gitk changes upstream, 
as well; "git subset -w heads/gitk gitk" would generate the gitk 
repository, with the addition of any changes to gitk made and committed in 
the git repository.

I think the only problem with this scheme would be that, if someone does a 
commit that changes both gitk and something else, the commit message might 
be a bit confusing in the gitk tree.

(I'm not sure, but this might also generate just the right thing for 
driver maintainers who want to distribute the latest version of their 
drivers as an out-of-tree module)

	-Daniel
*This .sig left intentionally blank*
