From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: update documentation with CAVEATS section
Date: Wed, 22 Aug 2007 23:26:31 -0700
Message-ID: <20070823062631.GD4417@hand.yhbt.net>
References: <20070816085645.GA3159@soma> <7v4piri44r.fsf@gitster.siamese.dyndns.org> <853aybkwsc.fsf@lola.goethe.zz> <20070823053009.GC4978@muzzle> <85r6luiydb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 08:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO6Yc-0004qN-Nk
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXHWGwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXHWGwj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:52:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37808 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbXHWGwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 02:52:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E41092DC08D;
	Wed, 22 Aug 2007 23:26:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <85r6luiydb.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56461>

David Kastrup <dak@gnu.org> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > David Kastrup <dak@gnu.org> wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >> > Eric Wong <normalperson@yhbt.net> writes:
> >> >
> >> >>   I've been meaning to do this for a while, hopefully this cuts
> >> >>   down on the redundant mailing list traffic about these subjects.
> >> >> ...
> >> >> +CAVEATS
> >> >> +-------
> >> >> +
> >> >> +For the sake of simplicity and interoperating with a less-capable system
> >> >> +(SVN), it is recommended that all git-svn users clone, fetch and dcommit
> >> >> +directly from the SVN server, and avoid all git-clone/pull/merge/push
> >> >> +operations between git repositories and branches.  The recommended
> >> >> +method of exchanging code between git branches and users is
> >> >> +git-format-patch and git-am, or just dcommiting to the SVN repository.
> >> >> +
> >> >> +Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
> >> >> +plan to dcommit from.  Subversion does not represent merges in any
> >> >> +reasonable or useful fashion; so users using Subversion cannot see any
> >> >> +merges you've made.
> >> >
> >> > Ok, my ruling before 1.5.3 is to take this patch, and encourage
> >> > interested parties to help Eric adding reliable support for the
> >> > feature after that, if such is possible.
> >> 
> >> Couldn't we at least get a _documentation_ of the current behavior
> >> when actually using git for branch work?  Knowing what will fail how
> >> and when is not as good as things just working as one would expect,
> >> but it certainly beats obscure warnings.
> >> 
> >> For example, I consider it rather unacceptable that nowhere is
> >> documented just _how_ git-svn chooses one Subversion branch to commit
> >> to.
> >
> > dcommit always chooses the last SVN branch it branched off from.
> 
> No, it doesn't.  That's the problem.  If I do
> git-merge master
> in a side branch, and do git-svn dcommit afterwards, the commit
> goes to the master branch.
> 
> Which is utterly unexpected.

Oops, sorry I only read your response and forgot about the original
topic.  Yes, merging between SVN branches in git breaks dcommit badly,
which is why I advise against using it.  I'll try to fix it when I've
got more free time.

> This is already a _large_ help for avoiding clobbering the central
> repository.  But I stress that it would be much better if git-svn
> dcommit/rebase stayed exclusively on the branch that is associated
> with it/fetching in the "svn" config section, like git does in general
> with remotes.  No random branch jumping after merges or (to be
> _really_ avoided) rebases and certainly after cherry-picking within
> git.

I think I see where you're coming from, now.  git-svn doesn't ever
associate remotes with local branches in the .git/config like regular
git-clone.

I just cloned git.git from kernel.org again to see that .git/config
associates a local branch with a remote branch like this:

----------------------------------------------------------------
[branch "master"]
        remote = origin
        merge = refs/heads/master
----------------------------------------------------------------

I used git before this feature ever existed, and got used to git without
ever needing it myself.  I've always had a good idea of where I branched
off from last, or I can ask with "gitk --all" otherwise.

So yes, I'll shamefully admit that I've never used this feature of git
and in my very quick (and sleepy) evaluation of it, it seems quite
limiting...

-- 
Eric Wong
