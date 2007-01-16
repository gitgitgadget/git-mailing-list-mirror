From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 00:17:35 +0100
Message-ID: <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 17 00:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6xYu-0003Vs-82
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 00:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXAPXRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 18:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXAPXRu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 18:17:50 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:38850 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbXAPXRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 18:17:49 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 5FC7F540E;
	Wed, 17 Jan 2007 00:17:47 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7EB3B2013; Wed, 17 Jan 2007 00:17:35 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36981>

On Tue, Jan 16, 2007 at 10:42:17PM +0000, Catalin Marinas wrote:
> >The idea is that we pull our stack from one place (current base) to
> >another.  Another possiblity would have been "stg rebase", but I'm not
> >very keen on adding another command to do a very similar job.
> 
> Can you give a typical example of what <newbase> argument for --to is
> and what you repository looks like? I just want make sure I correctly
> understand the problem.

My example is quite similar to the one given by Guilhem: I had a git
branch coming from git-cvsimport, and my stgit stack forked atop that
branch.  At some point git-cvsimport fucked something, and I
regenerated a new mirror branch using it in a fresh repo.  Then I
wanted to rebase my stack on that new branch.


> I see the 'pull' command as a way to fetch the latest remote changes
> and merge them into the current branch (which would usually be a
> fast-forward). This command was meant as a stgit-aware 'git pull'.

Do you have an example of use where we would need a non-fast-forward
pull (supposing we have the "pull --to" functionality already, since I
shall find time to finish soon).


> >> As Petr suggested at the OLS last year, I added the possibility to
> >> configure the 'git pull' command so that people use whatever script
> >> they like.
> >
> >Right.  Maybe different workflows should have this option set to
> >different values in different repos ?  I'm merely trying to get the
> >best default :)
> 
> But you want to replace the call to 'git pull' with 'git fetch'. I
> think this is fine with my workflow but some people might actually
> rely on calling 'git pull' (or cg-pull).

Right, it may be possible (and I'd be interested in seeing such a
workflow).  Maybe we could keep support for git-pull as an
alternative.

This could be done, eg. by letting the user use "pullcmd=git-pull" and
introduce a new option like "fastforward=<bool>" triggering the
fast-forward needed after git-fetch, with the default being "true",
and the current behaviour being obtained by changing it to "false".

That would not add too much complexity, while setting the default to
what I believe to match the most common workflows, and allow anyone
relying on the current behaviour to get it back.


> >> I was working on a set of patches (mainly picking from other
> >> branches and minor modifications) and just committing them when
> >> finishing. Further updates from kernel.org triggered full merges
> >> with the base.
> >
> >But doing this means that you can end with a base that is not any more
> >on the parent branch, but on a local merge, right ?  I'm not sure it
> >is an easy thing to work with.
> 
> Yes, indeed, but this is probably the only way you can publish a
> branch and still partially manage it with StGIT.

Well, I'd think that automatic rebasing would be a more elegant
solution.

> >On the StGIT front, we could have "stg clone" look at
> >patches/<branch>/current or so, and then modify the
> >remote.<name>.fetch entry accordingly.  Or do you think of any
> >workflow that would break under this change ?
> 
> Currently, 'stg clone' just calls 'git clone' and initializes the
> master branch. There is no patches/<branch>/current file as there is
> no current patch.

I meant, the patches/<branch>/current in the remote repo.  If that one
exist, then we should pull it with "+" as we should do for any
rebasing remote branch.

> >Even if we would not need it here, it would be good to have those 2
> >parameters set when we can infer them.  That reminds me that "stg
> >clone" does not appear to allow selecting a specific branch in the
> >parent repo (which explains why the .merge parameter is not so
> >crucially needed yet: we always clone the main branch).
> 
> I haven't looked at 'git clone' recently, can you select a specific branch?

I had assumed so without looking, but it looks like you cannot select
much.  When using separate remotes, the HEAD in the clone is taken
from the HEAD in the remote, and bears the same name.  It is the only
ref created under heads/.

Would there be some missing functionnality in git-clone, or am I just
missing something obvious ?

Best regards,
-- 
Yann.
