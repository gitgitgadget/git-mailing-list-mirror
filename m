From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: newbie with broken workflow
Date: Thu, 3 Apr 2008 20:05:57 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804031957010.19665@iabervon.org>
References: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Kingston <james.kingston@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 02:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhZS8-0002L0-U0
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 02:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbYDDAGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 20:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbYDDAF7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 20:05:59 -0400
Received: from iabervon.org ([66.92.72.58]:39017 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443AbYDDAF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 20:05:59 -0400
Received: (qmail 9748 invoked by uid 1000); 4 Apr 2008 00:05:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Apr 2008 00:05:57 -0000
In-Reply-To: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78788>

On Thu, 3 Apr 2008, James Kingston wrote:

> I am a few days into git and have settled into a workflow that is
> apparently very broken, and I'd appreciate it if someone with a more
> experienced eye can point out where I went wrong.
> 
> The official SCM tool at my work is ClearCase Remote Client, and it's
> vile... pessimistic locking, huge bureaucracy just to create a branch
> (I love experimental branches), no licenses for the native client.  My
> plan was to use git (Git-1.5.4-preview20080202.exe) to track my
> clearcase view directory, and push changes into that repo when
> convenient from my working directory repo (clearcase makes
> non-checkedout files read only, which makes working directly in the
> view directory Ugly).
> 
> Here is a timeline of how I tried to do this:
> 
> /c>	cd /c/cc
> /c/cc> 	git init
> /c/cc> 	git add *
> /c/cc> 	git commit
> /c/cc> 	mkdir /c/wd
> /c/cc> 	cd /c/wd
> /c/wd>	git clone /c/cc
> /c/wd>	cd cc/
> /c/wd/cc>  ls
> /c/wd/cc>  vi config.ini
> /c/wd/cc>  git checkout -b config_changes
> /c/wd/cc>  git diff
> /c/wd/cc>  git add config.ini
> /c/wd/cc>  git commit
> /c/wd/cc>  git checkout master
> /c/wd/cc>  git merge config_changes
> /c/wd/cc>  vi config.ini
> /c/wd/cc>  git push /c/cc
> /c/wd/cc>  cd /c/cc
> /c/cc> 	vi config.ini # doesn't show the change made in experimental
> branch, though gitk shows the patch
> /c/cc> 	git status # says that config.ini has been modified
> /c/cc> 	git add config.ini # grasping as straws
> /c/cc> 	git commit # changes nothing, as far as I can tell
> /c/cc> 	git reset --hard #still changes nothing.  My diffs are there
> in the log, just out of reach
> 
> I have much to learn, but in the short term I just need to get those
> changes into clearcase so QA can pull them

So you should actually do:

/c/wd/cc> cd /c/cc
/c/cc> git pull ../wd/cc

But wouldn't that fail, because the files are read-only?

I think you'd do:

/c/cc> git fetch ../wd/cc
/c/cc> git diff --name-only HEAD FETCH_HEAD

Tell ClearCase you want to edit those files

/c/cc> git merge FETCH_HEAD

Commit your ClearCase stuff

Also, IIRC, the sort of normal workflow for dealing with foreign SCMs that 
need local working directories is actually to put them in 
.git/info/something, and use git diff to get the changes in each of your 
git commits and git apply (using it like "patch", but smarter) to modify 
the working directory.

	-Daniel
*This .sig left intentionally blank*
