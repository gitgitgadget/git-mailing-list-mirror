From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 9 May 2005 20:38:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org>
References: <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:32:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIfl-0004fk-S6
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVEJAjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEJAjW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:39:22 -0400
Received: from iabervon.org ([66.92.72.58]:6660 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261460AbVEJAjP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:39:15 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVIlx-00078k-00; Mon, 9 May 2005 20:38:53 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> While we're at it, it would be useful to have one for what is normally
> DB> ".git",...
> 
> If you mean the parent directory of ${SHA1_FILE_DIRECTORY}, and
> your only gripe is about git-init-db creating ".git" in the
> current working directory regardless of SHA1_FILE_DIRECTORY, I
> would agree that what git-init-db does is broken.  Not that I
> have a suggested "right behaviour" for it, though.

It could just create all missing parents of the object directory, which
would be better, at least.

> However if you also mean by ".git" the directory refs/heads and
> friends hang underneath, then I have to disagree.  That does not
> belong to core GIT, which always expects to run from the top
> level directory that has such directory directly under it, and
> at the same time corresponds to the tree structure the dircache
> describes.  There is no need for the environment variable you
> suggest, since it always is the ".git" subdirectory of such a
> directory.

So far, I have never heard of SHA1_FILE_DIRECTORY being used to target
something in .git other than objects. The only use of SHA1_FILE_DIRECTORY
I've heard about is my own in rsh.c, which sets it to [PATH]/objects,
because it has to write object files, most often, to
.../project.git/objects/. You can't really cd to /scm/git<delete> and have
.git/objects refer to the right thing.

My position is still that what refs/*/* gets used for is up to the user,
but the existance and format of the directory is a core thing. In
particular, I want to have atomic methods of modifying these files. (I.e.,
you give commit-cache a */* to write the result to, and it will make sure
that nobody writes to it or reads it expecting to write to it while you're
committing).

But even if this is up to the wrapping scripts, it would be useful to have
the same environment variable used by those scripts for whatever they want
to have in there.

> I once advocated GIT_WORKING_TREE to mean the current project
> top, which is the parent directory of ".git".  The proposal was
> shot down (see archives [*1*]).  While I still think that
> configuration (or your ".git" location proposal, which is
> essentially the equivalent) may sometimes useful, I'd rather not
> conflate this environment variable renames with that issue.
> They are pretty much independent issues.

The reason to tackle them at once is so that there doesn't have to be
multiple changeovers.

> [References]
> *1* http://marc.theaimsgroup.com/?l=git&m=111412959320946&w=2

I believe that Linus's primary gripe was about changing the expected
location of the working tree, not about changing the expected location of
the git storage. So the .git location proposal is quite different.

	-Daniel
*This .sig left intentionally blank*

