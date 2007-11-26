From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 23:02:05 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711252029020.9605@xanadu.home>
References: <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
 <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
 <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <20071123103003.GB6754@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711231319220.27959@racer.site>
 <20071124113814.GA17861@sigill.intra.peff.net>
 <alpine.LFD.0.99999.0711241042011.9605@xanadu.home>
 <7vtznbqx2w.fsf@gitster.siamese.dyndns.org>
 <20071125215128.GC23820@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwVAy-0002Ll-Bj
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 05:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbXKZECK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 23:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbXKZECJ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 23:02:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63911 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbXKZECI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 23:02:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS300394HVHSSE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 25 Nov 2007 23:02:06 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071125215128.GC23820@fieldses.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66039>

On Sun, 25 Nov 2007, J. Bruce Fields wrote:

> There's a very brief mention of this:
> 
> 	"As with git-fetch, git-push will complain if this does not
> 	result in a <<fast-forwards,fast forward>>.  Normally this is a
> 	sign of something wrong.  However, if you are sure you know what
> 	you're doing, you may force git-push to perform the update
> 	anyway by preceding the branch name by a plus sign:

... or use "git push -f" (is it mentioned in the manual?)

> But it'd probably be better to have a separate section.  That makes it
> possible to say a little more, and also gets a section called "what to
> do when a push fails" into the table of contents.
> 
> (Though that's a little vague--push can also fail just because you
> mispell the url or something.  A more precise reference to the
> particular error might be better, but we'll have to agree on the error
> message first....)
> 
> Anyway, here's a first draft.

I think we should devote a section of the manual to the "rebase" 
workflow compared to the "merge" workflow.  One of the public Git repo 
I currently maintain is constantly rebased, and I've provided a quick 
Git update cheat sheet along with its announcement for that case:

  http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2007-November/043147.html

I also wrote an introductory document for $job internal use.  I have a 
section where I briefly cover the main differences and implications for 
merge vs rebase.  Here it is -- please feel free to add it to the manual 
if you think it can be valuable.

----- >8

Rebase vs Merge
---------------

Merge and rebase may look like they are doing the same thing, but they act 
very differently on the repository. Merging basically takes all the 
changes in the remote branch and mix them with your local branch. 
For example, if you create a branch "mywork" from the orion/core branch, 
you will end up with something that looks like this:

	a--b--c <-- orion/master
	       \
	        A--B--C <-- mywork 

After a fetch, the remote branch might have advanced in parallel to
local changes as follows:

	a--b--c--d--e--f <-- orion/master
	       \
	        A--B--C <-- mywork 

If you later do a 'git merge orion/master', your history will look like
this, where 'M' is a merge commit:

	a--b--c--d--e--f <-- orion/master
	       \        \
	        A--B--C--M <-- mywork

A rebase, on the other hand, takes all your changes and reapplies them to 
the current state of the specified branch, and assign the result to the 
currently checked out branch. With the same example, if you were to do a 
'git rebase orion/master', you would get something like this:

	a--b--c--d--e--f <-- orion/master
	                \
	                 A'--B'--C' <-- mywork

Rebase does what the name implies and creates a new baseline for your 
branch. The benefit of this is that you end up with a cleaner history log,
especially if you have to update with the remote branch often, in both
your repository and in upstream repositories that gets updated from you.  


Tracking a rebased remote branch
--------------------------------

Let's suppose that the remote branch you're tracking is itself subject
to be rebased.  Before performing a fetch to update that remote branch,
your history might look like the previous example:

	a--b--c--d--e--f <-- orion/master
	                \
	                 A'--B'--C' <-- mywork

If the remote branch had some commit replaced, or was rebased on a
different commit (or both), then things could look like this after a
fetch:

	a---b---c'--d'--e'--f'--g <-- orion/master
	     \
	      c---d---e---f <-- orion/master@{1}
	                   \
	                    A---B---C <-- mywork

In this example, commits c, d, e and f are not present anymore in the
remote repository.  They are still reachable from your "mywork" local
branch though.  The "orion/master@{1}" is the notation used to refer to the
previous value (before the fetch) of "orion/master".

If you were to use 'git merge' to bring the new commits (c', d', e', f'
and g) into your local branch, that wouldn't get rid of the commits that
they are meant to replace, and is likely to cause a major merge conflict.

The only option in that case is to rebase your work.  Yet there is a twist
because 'rebase' moves every commit reachable from the current branch on
top of the specified branch by default, including those c-d-e-f commits.
So the --onto argument to 'git rebase' must be used to skip over those
unwanted commits as follows:

	git rebase --onto orion/master orion/master@{1} mywork

This means to rebase commits between orion/master@{1} and mywork on top of
orion/master and assing mywork to the result.  The git-rebase man page
provides more examples and a detailed explanation of how 'rebase' works
which is worth a read.

NOte: the orion Git repository is indeed rebased often.  So you'll have
to use this rebase invokation when fetching updates from it.
