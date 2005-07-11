From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Mon, 11 Jul 2005 00:07:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507102337160.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0507102034460.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 06:11:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drpd8-0001BA-Sb
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 06:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVGKEKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 00:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVGKEKQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 00:10:16 -0400
Received: from iabervon.org ([66.92.72.58]:43269 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262226AbVGKEJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 00:09:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrpZW-0005Dc-00; Mon, 11 Jul 2005 00:07:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507102034460.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 10 Jul 2005, Linus Torvalds wrote:

> On Sun, 10 Jul 2005, Daniel Barkalow wrote:
> > 
> > Perhaps git-pack-objects should have the base as a optional argument,
> > with a default of the filename in $GIT_DIR/objects/pack and an option
> > for sending just the pack file to stdout?
> 
> You really _mustn't_ try to create the pack directly to the
> $GIT_DIR/objects/pack subdirectory - that would make git itself start
> possibly using that pack before the index is all done, and that would be
> just wrong and nasty.
>
> So you really should _always_ generate the pack somewhere else, and then 
> move it (pack file first, index file second).

It's currently fine ignoring index files without corresponding
pack files (sha1_file.c, line 470). Do you want to make the constraint
that the pack/ directory doesn't have index files for packs that aren't
also there? (I've been putting the index files for packs that might be
possibile to get there, and relying on the above check to make sure that
they don't affect anything if it hasn't fetched the pack.)

Of course, we should never write to files in locations that anything looks
at; we want everything to appear atomically, completely written and
verified. But there's nothing wrong with having the C code place the
objects, which is certainly going to be necessary in the case of
downloading them by HTTP, since the program will want to place them and
enable them while running.

	-Daniel
*This .sig left intentionally blank*
