From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Comments on Presentation Notes Request.
Date: Wed, 7 Jan 2009 17:30:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901071654530.19665@iabervon.org>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com> <20090107063629.GB22616@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Visher <tim.visher@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKgwJ-0004jd-IV
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 23:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762258AbZAGWaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 17:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbZAGWaM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 17:30:12 -0500
Received: from iabervon.org ([66.92.72.58]:52123 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932474AbZAGWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 17:30:07 -0500
Received: (qmail 23250 invoked by uid 1000); 7 Jan 2009 22:30:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jan 2009 22:30:04 -0000
In-Reply-To: <20090107063629.GB22616@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104839>

On Wed, 7 Jan 2009, Jeff King wrote:

> On Tue, Jan 06, 2009 at 05:33:02PM -0500, Tim Visher wrote:
> 
> > ** Advantages of SCM
> > *** One Source to Rule Them All.
> > *** Unlimited Undo/Redo.
> > *** Safe Concurrent Editing.
> > *** Diff Debugging
> 
> I would add to this metadata and "software archeology": finding the
> author of a change or piece of code, the motivation behind it, related
> changes (by position within history, by content, or by commit message),
> etc.

If you look at the git source code, the comments in the code are almost 
never sufficient to really understand the code, because a full 
line-by-line explanation would make it hard to find the code under the 
comments. On the other hand, if you take "git blame" in one window and a 
series of "git show"s in another window, and look at the commit messages 
for the commits that introduced each of those lines, you get really 
detailed and in-depth documentation of the subtle changes.

> I think people who have not used an SCM before, and people coming from
> SCMs where it is painful to look at history (like CVS) undervalue this
> because it's not part of their workflow.  But having used git for a few
> years now, it is an integral part of how I develop (especially when
> doing maintenance or bugfixes).
> 
> You touch on this in "Diff Debugging", but I think bisection is just a
> part of it.
> 
> > * SCM Best Practices
> >
> > ** Commit Early, Commit Often
> > ** Don't Commit Broken Code (To the Public Tree)
> 
> People talk a lot about using their SCM on a plane, but I think these
> two seemingly opposite commands highlight the _real_ useful thing about
> a distributed system for most people: commit and publish are two
> separate actions.
> 
> So I think it might be better to say "Commit Early, Commit Often" but
> "Don't _Publish_ Broken Code". Which is what you end up saying in the
> discussion, but I think using that terminology makes clear the important
> distinction between two actions that are convoluted in centralized
> systems.
> 
> > *** Backup Becomes A Separate Process
> > Because there is only a single repository, you need a back-up strategy
> > or else you are exposing yourself to a single point of failure.
> > [...]
> > *** Natural Backup
> > Because every developer has a copy of the repository, every developer
> > you add adds an extra failure point.  The more developers you have,
> > the more backups you have of the repository.
> 
> The "natural backup" thing gets brought out a lot for DVCS. And it is
> sort of true: instead of each developer having a backup of the latest
> version (or some recent version which they checked out), they have a
> backup of the whole history. But they still might not have everything.
> Developers might not clone all branches. They might not be up to date
> with some "master" repository. Useful work might be unpublished in the
> master repo (e.g., I am working on feature X which is 99% complete, but
> not ready for me to merge into master and push).

It is the case that everything in the central repo (including speculative 
stuff) will also be on its author's machine, with the metadata needed to 
identify that it's not in the main history and how everything is supposed 
to be arranged. This is likely to be particularly helpful for the work 
that everybody did between the last backup and the crash.

> So yes, you are much more likely to salvage useful (if not all) data
> from developer repositories in the event of a crash. But I still think
> it's crazy not to have a backup strategy for your DVCS repo.

I think it's very important to have a backup strategy, but it's nice that 
the developers can get work done while the server is still down.

> > ** Excellent Merge algorithms
> > 
> > Git has excellent merge algorithms.  This is widely attributed and
> > doesn't require much explanation.  It was one of Git's original design
> > goals, and it has been proven by Git's implementation.  Merging in Git
> > is _much_ less painful than in other systems.
> 
> Actually, git has a really _stupid_ merge algorithm that has been around
> forever: the 3-way merge. And by stupid I don't mean bad, but just
> simple and predictable. I think the git philosophy is more about making
> it easy to merge often, and about making sure conflicts are simple to
> understand and fix, than it is about being clever.

Git is clever about finding the 3 inputs to the 3-way merge, particularly 
the common ancestor of commits that don't have a common ancestor. I think 
merge-recursive is novel to git, and may not be available anywhere else.

> Which isn't to say there aren't systems with less clever merge
> algorithms. CVS doesn't even do a 3-way merge, since it doesn't bother
> to remember where the last branch intersection was.

CVS did do 3-way merge, but only between your uncommited changes, the 
latest commit, and the common ancestor (the commit that you started 
changing). IIRC, arch actually didn't support 3-way merge at all.

	-Daniel
*This .sig left intentionally blank*
