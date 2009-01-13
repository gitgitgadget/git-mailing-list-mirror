From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 17:47:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901131729520.19665@iabervon.org>
References: <1231883002.14181.27.camel@starfruit>  <200901132253.15370.trast@student.ethz.ch> <1231884045.14181.36.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMs4Q-0007um-4T
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbZAMWre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756405AbZAMWrc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:47:32 -0500
Received: from iabervon.org ([66.92.72.58]:55831 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbZAMWrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:47:31 -0500
Received: (qmail 19263 invoked by uid 1000); 13 Jan 2009 22:47:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jan 2009 22:47:29 -0000
In-Reply-To: <1231884045.14181.36.camel@starfruit>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105557>

On Tue, 13 Jan 2009, R. Tyler Ballance wrote:

> On Tue, 2009-01-13 at 22:53 +0100, Thomas Rast wrote:
> > R. Tyler Ballance wrote:
> > > Besides a vigorous flogging, we're looking at other ways to prevent this
> > > sort of thing from happening again; the option we've settled on is to
> > > remove the "--force" flag from our internal build of v1.6.1
> > >
> > > I'm wondering if somebody could point me in the right direction to
> > > remove "--force" (safely) from the builtin-push.c and removing the
> > > "rebase" command (we've got no use for it, and would prefer it gone).
> > 
> > IMHO your update (or pre-receive) hook should just disallow
> > non-fast-forward updates.
> 
> Don't merges count as non-fast-forward updates? We generate merge
> commits with almost every merge, rarely do we actually have
> fast-forwards anymore (highly active repository)

Creating a merge is a non-fast-forward update, but sending the merge to a 
repository that is currently at one of the parents is a fast-forward.

Hopefully, you're generating merge commits with merge, not with push. :)

> > This doesn't really address git-rebase, but it will disallow pushing a
> > "harmfully" rebased branch since those are by definition non-ff.  Why
> > take away the option to correct a mistake in the last commit with 'git
> > rebase -i'?
> 
> I'm a strong proponent of revision history only moving forward, I would
> much rather see a series of revert commits than having somebody who is
> inexperienced with the tools they're using muck about an jeopardize the
> stability of our central repository. 
> 
> 
> Used correctly, both --force and `rebase` have good reason to exist in
> the Git codebase; they just haven't been used correctly, and proper
> bamboo to flog developers with will take a couple days to ship from
> Asia, so removing the options from our internal build is a lot easier
> and faster ;)

Denying non-fast-forward updates means that people can rebase, but if they 
rebase anything that they've pushed (or anyone else has pushed), they 
can't push.

You can't really disallow rebasing of private commits while still using 
git; a user can always clone the upstream repository again, get diffs from 
the repository where they don't like the history, apply them to the new 
clone, and throw away the repository with the bad history. Or they can 
call up a coworker, tell them what changes to make, commit, and push, and 
then lose their work in a hard drive crash. People can always make the 
excuse "My identical twin did stuff wrong, but I knocked him out before 
he could push and did everything right." As long as they can't say "My 
evil twin pushed the changes to the repository's evil twin, but I knocked 
him out and destoryed the evil repository, and now we've got the good 
repository."

	-Daniel
*This .sig left intentionally blank*
