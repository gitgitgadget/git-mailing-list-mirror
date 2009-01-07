From: Jeff King <peff@peff.net>
Subject: Re: Comments on Presentation Notes Request.
Date: Wed, 7 Jan 2009 01:36:29 -0500
Message-ID: <20090107063629.GB22616@coredump.intra.peff.net>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 07:37:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKS36-0002tN-Pd
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbZAGGgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 01:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbZAGGgc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 01:36:32 -0500
Received: from peff.net ([208.65.91.99]:49734 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbZAGGgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 01:36:31 -0500
Received: (qmail 12912 invoked by uid 107); 7 Jan 2009 06:37:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Jan 2009 01:37:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jan 2009 01:36:29 -0500
Content-Disposition: inline
In-Reply-To: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104763>

On Tue, Jan 06, 2009 at 05:33:02PM -0500, Tim Visher wrote:

> ** Advantages of SCM
> *** One Source to Rule Them All.
> *** Unlimited Undo/Redo.
> *** Safe Concurrent Editing.
> *** Diff Debugging

I would add to this metadata and "software archeology": finding the
author of a change or piece of code, the motivation behind it, related
changes (by position within history, by content, or by commit message),
etc.

I think people who have not used an SCM before, and people coming from
SCMs where it is painful to look at history (like CVS) undervalue this
because it's not part of their workflow.  But having used git for a few
years now, it is an integral part of how I develop (especially when
doing maintenance or bugfixes).

You touch on this in "Diff Debugging", but I think bisection is just a
part of it.

> * SCM Best Practices
>
> ** Commit Early, Commit Often
> ** Don't Commit Broken Code (To the Public Tree)

People talk a lot about using their SCM on a plane, but I think these
two seemingly opposite commands highlight the _real_ useful thing about
a distributed system for most people: commit and publish are two
separate actions.

So I think it might be better to say "Commit Early, Commit Often" but
"Don't _Publish_ Broken Code". Which is what you end up saying in the
discussion, but I think using that terminology makes clear the important
distinction between two actions that are convoluted in centralized
systems.

> *** Backup Becomes A Separate Process
> Because there is only a single repository, you need a back-up strategy
> or else you are exposing yourself to a single point of failure.
> [...]
> *** Natural Backup
> Because every developer has a copy of the repository, every developer
> you add adds an extra failure point.  The more developers you have,
> the more backups you have of the repository.

The "natural backup" thing gets brought out a lot for DVCS. And it is
sort of true: instead of each developer having a backup of the latest
version (or some recent version which they checked out), they have a
backup of the whole history. But they still might not have everything.
Developers might not clone all branches. They might not be up to date
with some "master" repository. Useful work might be unpublished in the
master repo (e.g., I am working on feature X which is 99% complete, but
not ready for me to merge into master and push).

So yes, you are much more likely to salvage useful (if not all) data
from developer repositories in the event of a crash. But I still think
it's crazy not to have a backup strategy for your DVCS repo.

> ** Fast
> 
> Git's implementation just happens to be wickedly fast.  It's faster
> than mercurial, it's faster than bazaar, etc.  Everything, committing,
> merging, viewing history, branching, and even updating and and pushing
> are all faster.

A lot of people say "So what? System X is fast enough for me already."
And I used to be one of them. But one point I have made in similar talks
is that it isn't just about shaving a few seconds off your task. It's
about being able to ask fundamentally different questions because they
can be answered in seconds, not minutes or hours. I haven't benchmarked,
but I shudder at the thought of pickaxe (git log -S), code movement in
blame, or bisecting in CVS.

> ** Excellent Merge algorithms
> 
> Git has excellent merge algorithms.  This is widely attributed and
> doesn't require much explanation.  It was one of Git's original design
> goals, and it has been proven by Git's implementation.  Merging in Git
> is _much_ less painful than in other systems.

Actually, git has a really _stupid_ merge algorithm that has been around
forever: the 3-way merge. And by stupid I don't mean bad, but just
simple and predictable. I think the git philosophy is more about making
it easy to merge often, and about making sure conflicts are simple to
understand and fix, than it is about being clever.

Which isn't to say there aren't systems with less clever merge
algorithms. CVS doesn't even do a 3-way merge, since it doesn't bother
to remember where the last branch intersection was.

BTW, I think Junio's 2006 OLS talk has some nice pictures of a 3-way
merge which help to explain it (see slides 23-32):

  http://members.cox.net/junkio/200607-ols.pdf


That's just my two cents from skimming over your notes. Hope it helps.

-Peff
