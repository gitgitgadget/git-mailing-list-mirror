From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 10:03:43 -0400
Message-ID: <20080511140343.GA11248@mit.edu>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet> <4826EEDF.4010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 16:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvCAP-0006By-6h
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 16:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYEKODy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 10:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYEKODy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 10:03:54 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:35351 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752785AbYEKODx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 10:03:53 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JvCC0-0008KM-AB; Sun, 11 May 2008 10:06:24 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JvC9Q-0006Cw-BE; Sun, 11 May 2008 10:03:44 -0400
Content-Disposition: inline
In-Reply-To: <4826EEDF.4010404@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81775>

On Sun, May 11, 2008 at 04:04:31PM +0300, Dima Kagan wrote:
> > The uncommitted changes survived the branch change and are still in the
> > working tree, in svn just like in git.
> > 
> 
> Yes, I am aware of that, except one rarely works in one directory on
> multiple svn branches, because the branches are not private. Git's
> branches can be private, so perhaps this behavior should be
> different from SVN?

So if you *want* to use separate working directories for different
branches, you can do that in git too.  Some people find that more
convenient.  Other people don't.  

Keep in mind, the other difference between git and svn is that until
commits are published, they can be freely altered.  So many developers
who use git tend to commit their changes on the "scratch branches",
and then if they need to modify them, use either "git commit --amend"
or "git commit --interactive" as necessary to modify the commits on
the branches until they are just the way they want them.

I will often have several different features "in progress" at
different times, and they are all on scratch branches.  By keeping
them all on scratch branches, I can test them by creating a new
scratch integration branch, and merge the various "in progress"
features together to see how they work together, then go back to the
individual feature branches to clean them up some more.   

When I'm satisified with a particular branch, I'll use "git rebase
master" to rebase the work so that it is based off of the head of the
development branch, and then do a fast forward merge to merge it into
to development branch.

> BTW, Is there a way to do 'svn checkout -b new_branch' into a new directory?

Not as a single step operation, no.  If you put the following in a
script, it will basically do what you want, though.

cp -rl $old_repo $new_repo
cd $new_repo
git checkout $new_branch

It does require that your editor save files by renaming the old file
out of the way to file~ and then writing file as a new file, instead
of opening the existing file and then doing an O_TRUNC (since that
will smash the file on the other repo), but as long as your editor is
hard link friendly, this should work just fine, with minimal disk
space cost.

Or you can just drop the hard link and just copy the whole repostory
using "cp -r" --- after all, svn is horribly wasteful of disk space,
with each repository taking twice the amount of space as the working
directory, and so if you're used to paying that disk overhead cost
with SVN, then presumably you won't mind paying that price with git.
There are smarter ways of working, though, if you don't mind altering
your work flow a little.

    	       		   	     	  - Ted
