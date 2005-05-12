From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 12:51:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505121218280.30848-100000@iabervon.org>
References: <7v8y2lj6u9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 18:45:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWGnR-0002yj-07
	for gcvg-git@gmane.org; Thu, 12 May 2005 18:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVELQv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVELQv7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 12:51:59 -0400
Received: from iabervon.org ([66.92.72.58]:22022 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262077AbVELQvz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 12:51:55 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWGuH-000157-00; Thu, 12 May 2005 12:51:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y2lj6u9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> My reasons for having it in the core are as follows:
> 
> DB>  - All of the porcelain layers have to, at least, agree as
> DB>  to how this is represented in order for repositories to be
> DB>  portable; since the representation is common, it might as
> DB>  well be core.
> 
> That is weak.  .git/refs/heads/master is not core, but something
> Porcelain need to agree on [*1*].

I think it is a defect of the current core that it fails to completely
specify a portable repository format. Obviously, it is not necessary to
have things in the core for this reason, but it's also not necessary to
have anything at all in the core. We could eliminate commits entirely in
favor of putting the information in special files in trees, and it would
still be as complete as it is, although it would also be unmaintainable.

> DB>  - There are currently no special files which are tracked for cogito (et 
> DB>    al) to put the information in.
> 
> I am somewhat sympathetic to this, but then there are probably
> lot other things that are more relevant than this "required
> version" thing.  One thing that immediately comes to mind is the
> dontdiff list.

The dontdiff list isn't expected to change with every commit, however.

> Also, if you consider Cogito and GIT independent projects as you said,
> you would probably need to have "require {project-name} {commit-id}",
> not "include {commit-id}".

I *don't* consider Cogito and GIT to be independant projects. GIT is
independant of Cogito, but Cogito includes GIT as part of it.

If you don't like the structure of Cogito, I have a set of projects at
work, where I have a bunch of microcontroller programs and a library of
common code. Traditionally, there are two possible arrangements: either
they are all separate projects, in which case the user has to figure out
what versions match, or they are the same project, in which case everybody
has to get everything. What I would like is to have the library consider
itself a separate project, but each program consider itself, in some
sense, the same project as the library (but not as other programs).

> Things start smelling much more like the traditional package version 
> matching issue which is outside of SCM (let alone core GIT).

Once the core portion matures to the point where it gets used without
program-specific patches, it can be done outside of SCM. But it doesn't
make sense to have an SCM require that the projects are really mature in
order to work well, since active development is supposed to be what an SCM
is for.

> DB>  - Ideally, the dependancy would only be per-commit, not
> DB>  per-tree; if Petr releases a new cogito which only merges a
> DB>  new mainline with the git-pb, the cogito tree object should
> DB>  be the same (since the cogito content didn't change). This
> DB>  means that it can't be anywhere other than the commit.
> 
> As I already said, I consider the current "overlayed" directory
> structure broken and not worth considering the toolset support

You missed my point here entirely. I think that the cogito tree including
any non-source files in it (if there are such) should be the same. So the
dependancy can't be tracked in the tree.

> DB>  - If the solution to the issue of finding the necessary
> DB>  git-pb is to store it with cogito, then the programs that
> DB>  pull from this repository need to know that they need to
> DB>  pull the git-pb portion, and fsck-cache needs to know that
> DB>  the cogito references the git-pb.
> 
> I do not think this is necessary for the same reason as I
> dismissed the third point above.

Do you have some solution to the problem of having the porcelain
layer (or the end user) find the version of git that a version of cogito
needs, in some way such that if I'm working on the project and make a
change to cogito and a matching change to git, Petr can get them.

	-Daniel
*This .sig left intentionally blank*

