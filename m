From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Database consistency after a successful pull
Date: Mon, 6 Jun 2005 12:21:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506061000531.30848-100000@iabervon.org>
References: <1118065849.8970.37.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	GIT Mailling list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:21:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfKJd-0001GS-1E
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 18:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFFQWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 12:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFFQWm
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 12:22:42 -0400
Received: from iabervon.org ([66.92.72.58]:58629 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261254AbVFFQWa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 12:22:30 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfKLn-0004Ri-00; Mon, 6 Jun 2005 12:21:19 -0400
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1118065849.8970.37.camel@jmcmullan.timesys>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 6 Jun 2005, McMullan, Jason wrote:

> Subject Was: [PATCH] pull: gracefu[PAlly recover from delta retrieval
> failure.]
> 
> [snip lots of really good information about the thinking
>  behind the design of the pull mechanisms ]
> 
> Ok, so would I be correct in the following assumptions
> about the validity of a 'consistent' .git/objects database:
> 
> ============================================================
> 
> Commits:
> 	* May have the tree they refer to in the database
> 	* Must have their parents in the database

May have their parents in the database; we want to be able to drop ancient
history from non-archival sites at some point, if nothing else.

> Trees:
> 	* Must have the blobs they refer to in the database
> 	* Must have the trees they refer to in the database

It's probably true that there's no point to having a tree available if you
don't have its contents, although that's a convenient intermediate stage,
so that you can look up the contents of the tree with the ordinary parsing
code. On the other hand, I could imagine an ARM developer completely
ignoring arch/i386 (and just having write-tree use the parent tree's value
for it).

> Deltas:
> 	* Must have the referred to object in the database

Yes. Can't unpack without them.

> Blobs:
> 	* No references to check

Right.

Also, tags reference objects of unknown type; it's probably not vital to
have the object.

My bias is to call a database consistent with only deltas having the
referents; the rest goes towards completeness, since you have and can read
everything that you have anything for (but may not be able to do some
particular operation).

	-Daniel
*This .sig left intentionally blank*


