From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 09:55:26 -0500
Message-ID: <E1EISTu-0000MI-Gz@jdl.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 17:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EISU9-0002m1-Mb
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbVIVOzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVIVOzi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:55:38 -0400
Received: from colo.jdl.com ([66.118.10.122]:3243 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030389AbVIVOzi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 10:55:38 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EISTu-0000MI-Gz
	for git@vger.kernel.org; Thu, 22 Sep 2005 09:55:28 -0500
To: git@vger.kernel.org
In-Reply-To: 20050921.172849.103555057.davem@davemloft.net
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9124>

Dave Wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> 
> > I often have local changes in my tree that I don't want to commit but that 
> > I'm testing out. Havign them interfere with merging other peoples work 
> > would mean that I'd have to have a totally separate tree for that, which I 
> > could do, but I'm much much happier not having to.
> 
> You know, I personally was unaware that this was supported until now.
> I have been always reverting local debugging changes in order to merge
> other people's work in, then reapply the debugging changes afterwards.

So, interesting that this comes up now, as I recently had a
discussion on this topic with a few coworkers.  We concluded
that we were clueless and what would help us out a whole bunch
would be a few more Use Cases down this line added to the Tutorial.

I'll include my original (internal) question as an example
use case.  Perhaps it will illustrate two things:

    - How clueless I am about Git still
    - Where some of the Git Frustration still lies

I'd offer to write it, but I'm just flat in the dark here and
need to _read_ it first. :-)  I'll offer this instead:  If you
(someone) tells me the commands that illustrate how to do what
I'm after here, I'll make a stab at writing up the tutorial
Use Case for it.

(Yes, I know there is a Use Case very similar to this in
the Tutorial, but it is not quite the same.  And I can't
see how to intuit a step towards what I'm wanting here.)

Thanks,
jdl



    OK, so I have a git tree that looks like this:

    241 % git show-branch --more=5
    * [jdl] Merge with rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
     ! [master] Merge branch 'master' of /home/src/linux-2.6/
      ! [origin] Merge branch 'master' of /home/src/linux-2.6/
       ! [paul] Merge with rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    ----
    +  + [jdl] Merge with rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    ++++ [master] Merge branch 'master' of /home/src/linux-2.6/
    ++++ [master~1] NTFS: Fix ntfs_{read,write}page() to cope with concurrent truncates better.
    ++++ [master~2] NTFS: Fix handling of compressed directories that I broke in earlier changeset.
    ++++ [master~3] NTFS: Fix various bugs in the runlist merging code.  (Based on libntfs
    ++++ [master~4] vc: Use correct size on buffer copy in vc_resize
    +  + [jdl~1] Merge rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge
    +  + [jdl^2] ppc32: Allow user to individual select CHRP/PMAC/PREP config
    +  + [jdl^2~1] powerpc: Merge simplified sections.h into asm-powerpc
    +  + [jdl^2~2] powerpc: Remove section free() and linker script bits
    +  + [jdl^2~3] powerpc: Remove sections use from ppc64 and drivers
    +  + [jdl^2~4] powerpc: Remove sections use from ppc
    +  + [jdl^2~5] ppc32: Removed non-inlined versions of local_irq* functions
    ++++ [jdl~2] Merge master.kernel.org:/home/rmk/linux-2.6-arm

    I have current, modified, non-committed files in my working tree
    in the "jdl" branch.  I don't want to commit them now (yet).

    I now know that Linus has updated his tree with new -rc2 parts.
    I want it.  In fact, I want it on the "origin" or "master" branch.
    (Or both.  And I don't know which.)

    How do I get Linus' updates and merge them into the "origin" branch
    without changing to that branch first?

    How do I get Paul's updates and merge them into the "paul" branch
    without changing to that branch first?

    I think I can fetch the Linus updates by doing something like this:

	git fetch origin
    or
	git fetch rsync://....path/to/linus-2.6-git

    That will just grab the Objects and throw them into my .git/objects.

    But how to do the merge?  I think that the merges all require
    the "target branch" to be the "active"/checkedout branch, right?
    I don't know how to now say "Merge-up those new Objects on the
    origin branch".

    I think what's confusing me still is that the previous
    World View According to CVS was essentially that you have
    this import branch into which you dragged all the external
    updates.  Then you merged that over to your working branch.
    And, you could easily have views of _both_ of those
    branches simultaneously.

    With Git, you can't really do that in quite the same way.
    Sure, you can treat a branch as an "import branch".  But
    if you have uncommitted files over in a different branch,
    you can't change your cehckout-view to do so.

    However, I _could_ just stick in my "jdl" working branch and
    directly pull-in and merge the linus changes.  I mean, my next
    step after pulling those changes into the so-called import
    branch was going to be to merge them to my branch anyway.

    OK, so let's say I did pull linus' update into the jdl branch.
    And they merge up nicely.  How do I now propogate _just_ the
    linus changes to the origin branch?  Again, I don't think I
    can without first checking out the "origin" branch.

    Am I missing something here?  Fighting against the tool?


A coworker replied:

    > I read your message, and I read the git documentation, and I
    > scratched my head a bit, and the end result is that I still don't
    > know.  The docs really suck.  Everything you say seems to make
    > sense, but I just can't confirm that it's actually how things
    > work.  And I don't know how to do a merge like you propose.

I responded:

    So, you will all be pleased to know that I tried
    some stuff and was not successful.  In the "jdl"
    branch, I did a "git pull linus".  It happily went
    out and grabbed all the new objects from his tree.
    Spiffy.  It then announced that my branch of the
    working tree was "dirty" and quit.

    At this point, I _think_ this is where a "cg-pull"
    instead of a "git pull" would have gone on, done
    some figuring, and decided that it needed to
    rebase my current changes after merging in the
    fetched objects.

    Not sure.
