From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [0/5] Parsers for git objects, porting some programs
Date: Mon, 18 Apr 2005 16:12:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504181558180.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504181126480.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcXn-0008EP-V3
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVDRUMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDRUMU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:12:20 -0400
Received: from iabervon.org ([66.92.72.58]:18694 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262198AbVDRUMC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 16:12:02 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNcbB-0000tT-00; Mon, 18 Apr 2005 16:12:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504181126480.15725@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Daniel Barkalow wrote:
> >
> > This series introduces common parsers for objects, and ports the programs
> > that currently use revision.h to them.
> > 
> >  1: the header files
> >  2: the implementations
> >  3: port rev-tree
> >  4: port fsck-cache
> >  5: port merge-base
> 
> Ok, having now looked at the code, I don't have any objections at all. 
> Could you clarify the "fsck" issue about reading the same object twice? 
> When does that happen?

Currently, the fsck-cache code is unpacking the objects to find out what
type they are, and the old code would pass the unpacked objects to the
parsing code. The new code doesn't take the unpacked objects, so it
unpacks them again. (I.e., fsck-cache will look at each object exactly
twice). The right solution is to have the internals reorganized slightly
such that a "parse_object" method, which does what fsck-cache wants (i.e.,
parse this object regardless of what type it is, and tell me the type),
could be fit in efficiently. But it doesn't affect the header file
interface, and it's only relevant to fsck-cache, which wants to look at
random junk that it doesn't have a reference to.

	-Daniel
*This .sig left intentionally blank*

