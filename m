From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git fork removal?
Date: Wed, 27 Apr 2005 22:47:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504272221030.30848-100000@iabervon.org>
References: <20050428021237.GA8612@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:42:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyyg-0003M1-Mn
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVD1Cre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVD1Cre
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:47:34 -0400
Received: from iabervon.org ([66.92.72.58]:39687 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261818AbVD1CrX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 22:47:23 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQz3k-0004lQ-00; Wed, 27 Apr 2005 22:47:24 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428021237.GA8612@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Apr 2005, Petr Baudis wrote:

> Dear diary, on Thu, Apr 28, 2005 at 03:31:18AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > I saw that "fork" was removed when going to the cg- scripts, and the
> > replacements don't do the symlinked trees thing. I found the symlinked
> > trees thing vital to my workflow, so I'm going to want to reintroduce
> > them, or something similar. Is there some reason you went to hardlinked
> > object files instead of symlinked directories?
> 
> The user. ;-)
> 
> Apparently, too many people were confused by the local/remote branches
> distinctions, and even I ceased to like it gradually (BTW, Cogito still
> supports working with them - it just does not offer any interface for
> manipulation with them). The current scheme is much simpler and I
> believe more clear.

I don't really like having local branches and remote repositories be
treated the same. But I like each of them being available concepts
separately.

> Also, the forked repositories were not truly independent - people
> actually got burnt by forking and then removing the original repository.

Ah, okay. I'm actually personally using a original repository called
"REPOSITORY" without a head or anything, with symlinks to that, so I don't
worry about accidentally killing the real thing from some branch. I've
really got a storage area per project, plus a set of links and tracking
stuff for each fork. I also back up the REPOSITORY on occasion,
particularly if I'm about to do something potentially destructive to the
database (like git-prune-script or convert-cache). I structure my
filesystem like:

  /working
    ... other projects
    /git
      /REPOSITORY (with only .git, non-symlink version)
      /linus
      /pasky
      /barkalow
      /cog-barkalow
      /diff
      ...

> If this breaks your workflow, could you please describe it? Perhaps we
> could find a good semantics to support both.

The part that I'm worried about is the way I turn a mass of debugging and
little local commits into a clean patch series. I've got a working fork
"barkalow", which is the result of a bunch of stuff and a dozen
commits. It is derived from "linus". I want to split up the changes and
make a series of commits, each of which will be a patch to submit.

1) I fork "linus" into "for-linus". I go into "for-linus".

2) I do "git diff this:barkalow > patch". This gives me the complete set
   of changes I want to submit.

3) I cut down the diff to a single logical change by removing all of the
   other hunks.

4) I do "git apply < patch". I do "git commit". I describe the logical
   change.

5) I go back to step 2, unless I'm done.

6) For each of the commits between "linus" and "for-linus", I do 
   "git patch <commit>", and send out the result.

The thing that I think requires the symlinks is step 2, which requires
that there be somewhere I can run git and have it able to see a pair of
unrelated local heads and the relevant trees.

	-Daniel
*This .sig left intentionally blank*

