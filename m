From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 09:06:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509220826460.2553@g5.osdl.org>
References: <E1EISTu-0000MI-Gz@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 18:09:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EITaZ-0000Zo-0p
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 18:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbVIVQGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 12:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVIVQGU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 12:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751468AbVIVQGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 12:06:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MG6DBo001103
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 09:06:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MG691w005757;
	Thu, 22 Sep 2005 09:06:11 -0700
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EISTu-0000MI-Gz@jdl.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9133>



On Thu, 22 Sep 2005, Jon Loeliger wrote:
> 
>     - Where some of the Git Frustration still lies

Btw, I'd love to have more "this frustrates me" stories. I used to ask for 
them from the (few) people that used git early on, just to see what the 
problems were.

I can't really help you with documentation, and would just hope that 
people who figure out a problem they had would actually document it so 
that others don't have to figure it out the hard way.

But if there is some usage pattern that doesn't make sense, post about it,
and I can try to at least say why it happens that way (and then it's back
to the "please send a patch to the documentation" case above ;). 

Alternatively, maybe it is something that doesn't need to happen at all, 
and it's just git being stupid, and we can just fix it.

So to look at your care.

>     OK, so I have a git tree that looks like this:
> 
>     241 % git show-branch --more=5
>     * [jdl] Merge with rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>      ! [master] Merge branch 'master' of /home/src/linux-2.6/
>       ! [origin] Merge branch 'master' of /home/src/linux-2.6/
>        ! [paul] Merge with rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>     ----
>     +  + [jdl] Merge with rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>     ++++ [master] Merge branch 'master' of /home/src/linux-2.6/
>     ++++ [master~1] NTFS: Fix ntfs_{read,write}page() to cope with concurrent truncates better.
>     ++++ [master~2] NTFS: Fix handling of compressed directories that I broke in earlier changeset.
>     ++++ [master~3] NTFS: Fix various bugs in the runlist merging code.  (Based on libntfs
>     ++++ [master~4] vc: Use correct size on buffer copy in vc_resize
>     +  + [jdl~1] Merge rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge
>     +  + [jdl^2] ppc32: Allow user to individual select CHRP/PMAC/PREP config
>     +  + [jdl^2~1] powerpc: Merge simplified sections.h into asm-powerpc
>     +  + [jdl^2~2] powerpc: Remove section free() and linker script bits
>     +  + [jdl^2~3] powerpc: Remove sections use from ppc64 and drivers
>     +  + [jdl^2~4] powerpc: Remove sections use from ppc
>     +  + [jdl^2~5] ppc32: Removed non-inlined versions of local_irq* functions
>     ++++ [jdl~2] Merge master.kernel.org:/home/rmk/linux-2.6-arm
> 
>     I have current, modified, non-committed files in my working tree
>     in the "jdl" branch.  I don't want to commit them now (yet).
> 
>     I now know that Linus has updated his tree with new -rc2 parts.
>     I want it.  In fact, I want it on the "origin" or "master" branch.
>     (Or both.  And I don't know which.)
> 
>     How do I get Linus' updates and merge them into the "origin" branch
>     without changing to that branch first?
> 
>     How do I get Paul's updates and merge them into the "paul" branch
>     without changing to that branch first?
> 
>     I think I can fetch the Linus updates by doing something like this:
> 
> 	git fetch origin

Yes, this works. This will fetch the new objects, and automatically update
the right branch (ie it will also update the "origin" branch).

> 	git fetch rsync://....path/to/linus-2.6-git

This will _not_ work. Or rather, it will "work" in the sense that it 
fetches the objects, but without a place to put them into, it won't update 
any of the branches, so it's kind of pointless.

>     That will just grab the Objects and throw them into my .git/objects.
> 
>     But how to do the merge?  I think that the merges all require
>     the "target branch" to be the "active"/checkedout branch, right?
>     I don't know how to now say "Merge-up those new Objects on the
>     origin branch".

The first one should have done that already.

You can also specify _precisely_ what branches you want to use as a source 
and as a destination.

Ie

	git fetch rsync:..../linus-2.6-git <src>:<dst>

will fetch the <src> branch (ie you'd usually use "master") from my tree 
and write it to the <dst> branch on your tree.

And it's not a "merge" - it's just an update. A merge implies that you 
take two trees that have had development on them and try to join them 
together. A "git fetch" does _not_ merge anything: it just _fetches_ the 
other side, and writes the objects (and top branch).

>     I think what's confusing me still is that the previous
>     World View According to CVS was essentially that you have
>     this import branch into which you dragged all the external
>     updates.  Then you merged that over to your working branch.
>     And, you could easily have views of _both_ of those
>     branches simultaneously.

Hmm.. I'm not sure exactly what you want, but

	git fetch origin

will fetch my stuff without touching your changes AT ALL, and then you can 
do things like

	gitk --all

to see both your development series _and_ my stuff at the same time. And 
yes, it works fine even if you have "dirty state" in your tree.

>     However, I _could_ just stick in my "jdl" working branch and
>     directly pull-in and merge the linus changes.  I mean, my next
>     step after pulling those changes into the so-called import
>     branch was going to be to merge them to my branch anyway.

And indeed, if you just did

	git pull origin

then now you're doing a _pull_ instead of a fetch, which means that you do 
both the fetch _and_ the merge.

In fact, if you use the shorthand with a named branch, the above really 
_will_ do a "git fetch origin" first, ie it will actually _update_ the 
"origin" branch before merging it into your current branch. So you'll have 
_both_.

You can see that (again) with

	gitk --all

where you can actually see that "origin" got updated, and also merged into 
whatever branch you were working on.

>     OK, so let's say I did pull linus' update into the jdl branch.
>     And they merge up nicely.  How do I now propogate _just_ the
>     linus changes to the origin branch?  Again, I don't think I
>     can without first checking out the "origin" branch.

The "origin" branch was already updated automatically if you used

	git pull origin

However, if you used

	git pull rsync:..../linus-2.6.git

then git would only have fetched the objects, and _not_ updated the 
"origin" branch (because you didn't tell it about the "origin" branch). 

But you can trivially fix that by doing

	git fetch origin

at this point, which will end up doing the equivalent of

	git fetch rsync:..../linus-2.6.git master:origin

(depending on what the contents of your .git/remotes/origin are, of 
course, the above is just an example).

>     Am I missing something here?  Fighting against the tool?

No, you just didn't realize how "git pull" and "git fetch" worked. Git
should actually do what you want to do very naturally. Its' really how 
it's designed to work, you just didn't realize ;)

>     So, you will all be pleased to know that I tried
>     some stuff and was not successful.  In the "jdl"
>     branch, I did a "git pull linus".  It happily went
>     out and grabbed all the new objects from his tree.
>     Spiffy.  It then announced that my branch of the
>     working tree was "dirty" and quit.

Ok, it really depends on what your ".git/remotes/linus" looks like.

For example, it _may_ just contain something like

	URL: rsync:..../linus2.6.git

in which case there is no explicit heads specified. In that case, you 
really should specify _which_ of the heads you want to pull, and what the 
target should be. For example, you can do that with

	git fetch linus master:linus

which says: "fetch the branch 'master' from the repository described by 
'linus' (.git/remotes/linus) into _my_ branch 'linus'".

NOTE! This really is a _fetch_. It will fetch the objects, and _overwrite_ 
the old value of the branch "linus".

Now, you can specify that this is what you _always_ want to do, and 
actually set the branches in the ".git/remotes/linus" file explicitly. You 
can make your .git/remotes/linus file look like this instead:

	URL: rsync:..../linus2.6.git
	Pull: master:linus

and now you've told it that whenever you fetch (or pull) from "linus", you
want to fetch the "master" branch from the remote end, and you always want
to store it in the "linus" branch in the local repository.

NOTE NOTE NOTE! Your branch-name does _not_ have to match the shorthand 
name. So you can make the "Pull:" line say "master:linus-branch", and that 
will mean that when you do "git fetch linus", it will update the 
"linus-branch" instead.

Still with me?

Finally (or _instead_ of the "fetch"), we can do

	git pull linus

now. It will do the fetch, and since you now specify a destination in your 
"remotes/linus" file, it will always update the "linus" part (it a "git 
pull" is a _superset_ of what "git fetch" does). But in _addition_ to 
fetching the "linus" branch, it will then try to merge it.

Now, this is where "dirty" comes in. The merge will fail if you have 
changed any files that the merge wants to modify. So do a

	git diff --name-only HEAD

to see if there are any changes, and commit them - or undo them - if so.  
Then try to pull again.
	
		Linus
