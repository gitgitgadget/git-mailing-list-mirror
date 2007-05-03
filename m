From: Yann Dirson <ydirson@altern.org>
Subject: Re: using stgit/guilt for public branches
Date: Thu, 3 May 2007 22:58:36 +0200
Message-ID: <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070425122048.GD1624@mellanox.co.il> <20070425191838.GA6267@filer.fsl.cs.sunysb.edu> <200704252337.05851.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 03 22:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjiOV-00012q-2H
	for gcvg-git@gmane.org; Thu, 03 May 2007 22:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766620AbXECU7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767171AbXECU7Q
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 16:59:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:43945 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766620AbXECU7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 16:59:14 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2055B5DF82;
	Thu,  3 May 2007 22:59:12 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id AFA1F2006; Thu,  3 May 2007 22:58:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200704252337.05851.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46106>

On Wed, Apr 25, 2007 at 11:37:05PM +0200, Robin Rosenberg wrote:
> onsdag 25 april 2007 skrev Josef Sipek:
> > On Wed, Apr 25, 2007 at 03:20:49PM +0300, Michael S. Tsirkin wrote:
> [...]
> > > I am concerned that publishing a git branch managed by stg/guilt
> > > would present problems: it seems that every time patches are re-ordered,
> > > a patch is re-written or removed, or we update from upstream,
> > > everyone who pulls the tree branch will have a hard-to-resolve conflict.
> > > 
> > > Is that really a problem? If so, would it be possible to work around this
> > > somehow?
> > 
> > I thought about this problem a while back when I was trying to decide how to
> > manage the Unionfs git repository. I came to the conclusion, that there was
> > no clean way of doing this (at least not using guilt - I can't really speak
> > for stgit, as I don't know how it does things exactly).
> 
> StGit has the same problem. Publishing such a branch is only for viewing if
> you want to publish the tip, like the pu branch in the Git repo. You shouldn't
> merge from pu either.

You are right, in that what can be done with such branches is limited.
BUT you can safely "stg branch --create" off any remote stgit stack.
Then you can "stg rebase origin/master" to port your stack to the new
tip of the remote stack.

The next stgit release will allow you to declare the pull-policy for
your stack as "rebase", so when you "stg pull" it will indeed rebase
to the new tip of the parent branch.


As for publishing, I use the following config entries to publish my
own stack of patches to stgit.  You can see at
http://repo.or.cz/w/stgit/ydirson.git that gitweb shows pretty clearly
the structure of the stack (even though things could surely be made
better).

I use "git push -f" to publish - maybe the "+" refspec syntax would
work with push, I'll try it next time :)

[remote "orcz"]
        url = git+ssh://ydirson@repo.or.cz/srv/git/stgit/ydirson.git
        push = refs/heads/master:refs/heads/master
	push = refs/patches/master/*:refs/patches/master/*

Maybe we should provide some degree of automation in stgit itself
(eg. "stg branch --publish" or something).

Hope this helps,
-- 
Yann.
