From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFD] Overlapping projects
Date: Tue, 10 May 2005 01:51:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505100135110.30848-100000@iabervon.org>
References: <7v8y2nsl38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:44:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVNXY-00063w-Nm
	for gcvg-git@gmane.org; Tue, 10 May 2005 07:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVEJFvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 01:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEJFvb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 01:51:31 -0400
Received: from iabervon.org ([66.92.72.58]:43782 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261551AbVEJFvW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 01:51:22 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVNe1-00024V-00; Tue, 10 May 2005 01:51:01 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y2nsl38.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> It seems to me like projects like cogito which are based on a core which
> DB> is itself a project and which is also part of other projects would benefit
> DB> from some sort of support.
> 
> I personally feel supporting that kind of development directory
> structure is backwards, and Cogito is a very bad example for it.

The directory structure is definitely awkward. I'd personally put cogito
stuff in a separate directory. But that's a matter of which paths belong
to which commit.

> Things could have been structured in such a way to have Cogito
> and core GIT in separate directories hanging from the top level,
> and Cogito can borrow pieces of GIT from the neighboring
> directory if it needed to build specialized binary using
> libgit.a.  Unless Petr makes changes to core GIT that is _too_
> specific for general use (read: does not meet Linus' taste), we
> should be able to port the nicer changes made to the core GIT
> for Cogito's use (like git-ls-files "-t" flag) back to core GIT
> and there would not be a reason for Cogito to keep carrying its
> own copy of modified core GIT.
> 
> DB> In particular, it would be nice if Linus could pull the
> DB> changes to the core without getting the wrapper programs at
> DB> all.
> 
> Yes, that is a very desirable arrangement.
> 
> However, that does not require to keep them in the same
> repository.  Cogito _could_ have been shipped this way:
> 
>                       + (top-level)
>                      / \
>                     cg git
>      (Cogito sources)   (copy of core GIT files)
>      .git/ for Cogito   .git/ for core GIT
>      only
> 
> with an instruction like:
> 
>     The tarball contains cg and git subdirectories.  cg part
>     implements Cogito, and git part is a copy of recent if not
>     latest core GIT.  Go to cg and type "make" to build both of
>     them.  Theoretically they can be independently updated to
>     the latest but preferred combination is to use at least this
>     release of core GIT to use this version of Cogito ...

But when Petr adds something to the core, intended for eventual inclusion
in the mainline, and uses it in cogito, this breaks everything, because
then people have to know to pull both the latest cogito and the latest git
from him. If the new git isn't backwards-compatible, then someone building
an old cogito would have to somehow find the matching old git.

This is far worse than just including git and sending Linus patches; the
only way to make this manageable would be to suspend cogito until git was
completely finished.

The important thing, I think, is being able to connect a Cogito with the
git it uses, while both are unstable and under active development. It
would be nice to be able to have the obvious things happen when you pull
the latest cogito and check it out, and when you commit with changes to
files from each of them, but that's less important.

	-Daniel
*This .sig left intentionally blank*

