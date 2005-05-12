From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 01:19:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505120057250.30848-100000@iabervon.org>
References: <7vk6m5kpue.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 07:12:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW5zO-0005WP-Sb
	for gcvg-git@gmane.org; Thu, 12 May 2005 07:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVELFTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 01:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVELFTl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 01:19:41 -0400
Received: from iabervon.org ([66.92.72.58]:23045 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261155AbVELFTi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 01:19:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DW66L-0000DK-00; Thu, 12 May 2005 01:19:13 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6m5kpue.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Junio C Hamano wrote:

> I think that the core of your idea of recording "required
> version" of the depended project (core GIT) in the depending
> project (Cogito) is a very sound one.  GNU Arch folks do
> something similar in their "package-framework" stuff.  
> 
> I however do not think that belongs to the core GIT nor even to
> Cogito for that matter.  To me, it feels like this is a pure
> build infrastructure issue.

If you think about it as git and cogito being entirely separate projects,
where users would be expected to have the right version of git most of the
time (or ever), this is true. But I think that cogito is as closely tied
to git as the kernel is to kbuild or kconfig; the difference is that git
is not solely available with cogito, like kbuild is solely available with
the kernel.

> I think you could arrange something like that with today's core
> GIT tools, like this:
> 
>  - Tweak Cogito Makefile so that pure Cogito and core GIT are
>    housed in separate subdirectories;
> 
>  - Add "required-git-pb" file to Cogito source as a tracked
>    source file, and record the required version of git-pb there;
> 
>  - Arrange Cogito Makefile to make sure the subtree that has the
>    core GIT side meets "required-git-pb" constraints.  The
>    constraints could be "at least contains this one", "exactly
>    this one".  The policy would be differnt from a depending
>    project to another.  What happens if the requirements are not
>    met is also up to the policy of that depending project.

When a particular cogito commit is made, it is impossible to tell whether
the next git-pb will work with it; the current set of patches could be
rejected in mainline git, and different support for the same functionality
added which requires something different from cogito.

This also means that Petr can't really test changes to git before
commiting them (and a new cogito with the constraint changed), because the
cogito build system would then require him to use a version he's not
testing.

Also, either the user has to keep track of two projects without any system
support in the same directory structure and figure out how to follow the
instructions from the build system in getting the right version checked
out in the right place, or the build system is tied to a particular
wrapper layer.

I think your idea is theoretically possible, but that it is just too
impractical for anyone to ever actually use it. It's something that people
could do with CVS (and it would actually work better, due to CVS's
limitations making the issues simpler), but people don't.

	-Daniel
*This .sig left intentionally blank*

