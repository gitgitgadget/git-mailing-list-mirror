From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: merge vs rebase: Is visualization in gitk the only problem?
Date: Sat, 27 Oct 2007 16:59:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710271609180.7345@iabervon.org>
References: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 22:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilskv-0003vQ-PT
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 22:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbXJ0U7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 16:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXJ0U7Y
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 16:59:24 -0400
Received: from iabervon.org ([66.92.72.58]:60002 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbXJ0U7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 16:59:23 -0400
Received: (qmail 24267 invoked by uid 1000); 27 Oct 2007 20:59:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2007 20:59:21 -0000
In-Reply-To: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62511>

On Sat, 27 Oct 2007, Steffen Prohaska wrote:

> There are some discussions going on about merge vs. rebase. The
> suggestions by Dscho is to prefer rebase over merge in a
> CVS-style workflow.
> 
> Rebase has definitely benefits but not all of its details
> are obvious at a first glance. Tell a newbie to read the
> git rebase man page and explain what git reabase does and
> you know what I mean. Rebase definitely can help to create a
> cleaner history. But it rewrites history and therefore destroys
> information, for example information about the original code
> base a patch was developed against, or merge conflicts that
> were resolved. You also need to decide when to use rebase and
> when to use merge. So you need to make a choice.
> 
> Why not always use git merge?
> 
> Is the only problem of git merge that it might create loops
> in the history with potentially long running parallel lines
> that are insufficiently visualized in gitk?
>
> If so, why not improve the visualization?
> 
> Or is there any other deficiency of always using merge and
> never using rebase that I don't see?

Not all possible upstream systems support non-linear history. If upstream 
is actually svn or cvs, you need to rebase in order for the other system 
to be able to represent the result.

I think it's easier for someone from the future trying to figure out the 
historical reason for some code to be a certain way if that code isn't 
touched by a merge conflict resolution. If there is a conflict, the 
resulting content is most directly due to a commit that has no explanation 
aside from a note that there was a conflict there; it's somewhat easier to 
understand if the code is entirely attributable to the commit that 
logically introduces the change. (Although maybe we could make the display 
take care of this; linearize the history using the rerere info in the 
merge commit, and show that as the history, annotated suitably to indicate 
that the blame for some of it falls partially on the merge commit.)

It's also more familiar for many users to be asked to place their changes 
after all other committed changes, rather than leaving the ancestry pegged 
at the last time they updated before starting to work.

> Obviously you can use git merge only if you want to have _all_
> changes from the other branch. But this is often what you
> want. In a CVS-style workflow you want to merge all changes
> from the shared branch before pushing. Why going through the
> hassel of git rebase?

Unless you've got a series of changes to a section that the upstream also 
changed, it's the same amount of resolution, but rebase lets you resolve 
logical collections of conflicts (i.e., those due to a single one of your 
commits) individually. IIRC, merging my builtin-fetch topic after 1.5.3 
had 3 scattered conflicts, and rebasing had 4 conflicts, with no more than 
one per commit (so that I could test the resolutions independantly), and 
the rebase was easier.

	-Daniel
*This .sig left intentionally blank*
