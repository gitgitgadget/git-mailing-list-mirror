From: Jan Veldeman <jan.veldeman@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Sun, 21 Aug 2005 11:40:59 +0200
Message-ID: <20050821094059.GA5453@fanta>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com> <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 11:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6mHx-000421-Iu
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 11:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVHUJir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 05:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVHUJiq
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 05:38:46 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:4375 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750903AbVHUJiq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 05:38:46 -0400
Received: by wproxy.gmail.com with SMTP id i2so862713wra
        for <git@vger.kernel.org>; Sun, 21 Aug 2005 02:38:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=UuvXIG7UX/GAZIlrR5PbLiSEToLQQKCGQWzTkFQSK4fW4VyVKDVMULiWFbBIcXfzqc4v6iUEo3zJn5+nrHiJu0jYzLpsF3APVFS9XQBNYudKukIPLEgyLFS4b/Z6ZzJyPyhOpT+F+rD1SMo57KBhHVK1NZCwY/m/Ixe1Oa1ivLw=
Received: by 10.54.130.12 with SMTP id c12mr931153wrd;
        Sun, 21 Aug 2005 02:38:44 -0700 (PDT)
Received: from localhost ([84.195.185.241])
        by mx.gmail.com with ESMTP id 14sm5819845wrl.2005.08.21.02.38.42;
        Sun, 21 Aug 2005 02:38:44 -0700 (PDT)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <1124572356.7512.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

> > So for example, you only tag (freeze) the history when exporting the
> > patches.  When an error is being reported on that version, it's easy to view
> > it and also view the progress that was already been made on those patches.
> 
> I agree that it is a useful feature to be able to individually tag the
> patches. The problem is how to do this best. Your approach looks to me
> like it's not following the GIT DAG structure recommendation. Maybe the
> GIT designers could further comment on this but a commit object with
> multiple parents should be a result of a merge operation. A commit with
> a single parent should represent a transition of the tree from one state
> to another. With the freeze command you proposed, a commit with multiple
> parents is no longer a result of a merge operation, but just a
> convenience for tracking the patch history with gitk.

My interpretation of parents is broader than only merges, and reading the
README file, I believe it also the intension to do so (snippet from README
file):

A "commit" object ties such directory hierarchies together into
a DAG of revisions - each "commit" is associated with exactly one tree
(the directory hierarchy at the time of the commit). In addition, a
"commit" refers to one or more "parent" commit objects that describe the
history of how we arrived at that directory hierarchy.


Another advantage of this approach is when pushing the top of your
repository to others, less rebasing would be noticed:
When pushing the top of your stack out to others, the new one won't be a
(possibly indirect) child of the previous push. This makes updating such a
head more dificult. With this approach, the new head will be a (possibly
indirect) child of the previous one (except when the top patch has been
removed, but this corner case could also be solved).

Because of this less rebasing, this aproach also facilitates co-development
on stgit patch stacks: by using a base:top id pair, the stgit patch stack
could be initialized, including its exported history. By following the
parent/child relations, 2 patch stacks could be compared and merged.

> 
> I tried your patch and test script but, if you try to reorder the
> patches, the DAG structure become quite hard to understand and that's
> only for a small set of frozen states.

I acknowledge this problem, but the solution for this would be to give
gitk another way of viewing such history: only the latest description of a
patch should be visible and the history should become more horizontal
(because the older descriptions wouldn't be shown, the history of those
patches could be viewed on the line with the latest description)

But changing gitk would only be usefull when this approach would be taken.

> 
> I think the best approach would be to keep a list of tags for each
> patch. They won't be browsable with gitk but the DAG structure would be
> clean. We might get another tool like gquilt to be able to show all the
> saved states of a patch.
> 
> Sorry for not including your patch but, while I agree with the general
> idea of frozen patch states, I disagree with its implementation.
> 

I understand your objections when limiting parents only to merges, but I see
them broader. So as you said: we indeed need a git designer to clear this up
for us.

Best regards,
Jan
