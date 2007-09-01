From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: repo.or.cz wishes?
Date: Fri, 31 Aug 2007 22:58:57 -0400
Message-ID: <20070901025857.GD18160@spearce.org>
References: <20070826235944.GM1219@pasky.or.cz> <Pine.LNX.4.64.0708270933450.28586@racer.site> <20070828041059.GK18160@spearce.org> <20070828111913.GA31120@thunk.org> <20070829041523.GS18160@spearce.org> <alpine.LFD.0.999.0708291009570.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 04:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRJCw-00050k-8q
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 04:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXIAC7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 22:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXIAC7H
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 22:59:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58462 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbXIAC7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 22:59:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRJCB-0001X2-Sk; Fri, 31 Aug 2007 22:58:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E690920FBAE; Fri, 31 Aug 2007 22:58:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708291009570.25853@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57247>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 29 Aug 2007, Shawn O. Pearce wrote:
> > 
> > Not if I already have a pointer from B to A's refs.  repo.or.cz
> > also has this same pointer:
> > 
> > 	git clone --shared A B
> > 	ln -s A/refs B/refs/forkee
> 
> Now, this doesn't work well with packed refs, I'm afraid.

No, it doesn't work well.  So I actually also avoid packing A's refs.
Which is yet another reason why my A's don't allow pushing, that
way nobody goes nuts and creates a ton of refs in there.  With only
refs/heads/master and it being unpacked its not a big deal.
 
> So I suspect that if we really want to support something like this, we'd 
> need to do more than just avoid the recursion when you cross-link.

Yes.  I've been thinking about trying to better share the ODB and
the ref database between repositories, but it has been low priority
for me.

I rely on this ref symlinking/alternate ODB trick a lot at day-job
to help me cope with an ugly situation I created across a number of
repositories.  Most of our codebase came from one Git repository,
but has been refactored and split into about 10 different Git
repositories.  I did that refactoring by just cloning and deleting
the uninteresting content, so each repository actually has a huge
block of its history in common with the other 9.

One such A is "common-crap.git" that is the shared common history.
Since its strictly history nobody changes that repository, and
everyone borrows objects from it.  This reduces my common working
set by about 900MiB, as the history lives in only one packfile and
not in 10.

There are obviously other ways to deal with this:

 - start the 10 repositories over again and use info/grafts to
   reinsert the old history when/if required;

 - just hardlink the same .keep'd packfile into the 10 repositories,
   since it is held by .keep it won't be touched during repack.

So one reason it has been low priority for me to improve upon is
because there's more than one way to solve the problem, and the
particular solution I have settled upon may not be the best solution
for anyone.

Though I think we can all agree that repo.or.cz's use of forks
is increasingly more popular, and one of the more powerful social
features of git.  Better supporting it out of the box by making it
easier to setup and manage can only be a good thing for our users.

-- 
Shawn.
