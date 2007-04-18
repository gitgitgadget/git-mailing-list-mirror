From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Things that surprise naive users
Date: Wed, 18 Apr 2007 16:55:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704181503080.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 22:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHBM-0004Nn-Az
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992689AbXDRUzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992690AbXDRUzM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:55:12 -0400
Received: from iabervon.org ([66.92.72.58]:3869 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992689AbXDRUzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:55:10 -0400
Received: (qmail 30420 invoked by uid 1000); 18 Apr 2007 20:55:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2007 20:55:09 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44945>

Here's my collection of things that I think block the adoption of git by 
novices. They should be easy to fix, but non-trivial shell makes my eyes 
glaze over. I think that, if these were fixed, someone just sitting down 
with git in a corporate environment with stuff set up in advance by the IT 
department would succeed in everything they thought to try. (Once they're 
using the obvious stuff, they can exchange advanced features with each 
other.)

1. If your organization has a bunch of different projects, and there's 
   some central location holding the upstream that people regularly pull 
   from, there's no way to abbreviate this parent directory. (Equivalent 
   of CVSROOT environment variable)

   I.e., we've got file-server:/var/git/<project>.git at my work, with 
   dozens of projects, and you have to give the whole thing to git clone 
   each time. It'd be nice to have a global config option such that, if 
   the argument to git-clone doesn't have any /, it prepends the standard 
   default. (Also an environment variable for the same purpose on a shell
   session scope.)

2. There's no easy way to tell that you've made commits that you haven't 
   pushed upstream. In fact, it's impossible to tell when disconnected 
   whether you've pushed everything. This needs some command to report it,
   and also for push to update the fetch sides of remote heads it updates.

3. You can't create a new repository by pushing, even if you could 
   actually create the repository. Obviously, this will be blocked by 
   policy more often than pushing in general would be, but it's not
   always blocked. It's also harder than it should be to turn a repository 
   created locally into a repository identical in configuration to a clone
   of a newly-created remote repository. 

4. Creating new branches off of existing branches/remotes doesn't 
   configure the new branches in the obvious way (i.e., such that the 
   default update action matches the create action).

5. Still too much output from core makes it to front end users, 
   particularly on successful recursive merge. "git-pull" should say:
   fetching: (bunch of progress)
   updating "origin" (bunch of refs)
   merging "origin" <ref>
    failed: afraid local changes might be messed up in <files>
   or
    manual merge needed in <files>
   or
    success: merge made automatically
   or
    success: no local changes needed merging

   There's still a lot of "I tried this, but it didn't work, but the next 
   thing did work." People are used to programs where, if something fails,
   it is followed by a bunch of meaningless messages, and only the first
   failure output matters and needs to be corrected. (Mostly compilers, 
   but also kernel oopses, other system errors, etc.)

6. I bet people would have an easier time with remote configuration of 
   repositories (when the user is actually able to configure the 
   repository, of course). I.e., if I've set up a remote repository, and
   I have a local clone, I should be able to turn on cvsserver support
   with "git remote-config gitcvs.enabled true" in the local clone, if
   (and only if), I could just go there and use git config.

7. I think there's more useful stuff possible for remote operations on
   upstream repositories, but that's less obvious.

	-Daniel
*This .sig left intentionally blank*
