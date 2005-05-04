From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git and symlinks as tracked content
Date: Wed, 4 May 2005 19:03:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505041854040.30848-100000@iabervon.org>
References: <4278EEC6.2090607@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:58:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTSoG-00034l-4u
	for gcvg-git@gmane.org; Thu, 05 May 2005 00:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVEDXD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 19:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVEDXD7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 19:03:59 -0400
Received: from iabervon.org ([66.92.72.58]:59141 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261948AbVEDXD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 19:03:57 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DTStp-0004oD-00; Wed, 4 May 2005 19:03:25 -0400
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <4278EEC6.2090607@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 4 May 2005, David A. Wheeler wrote:

> Once you're there, it wouldn't be hard to add logic to add options to
> (1) record the REAL permission bits, (2) record "." files, and
> (3) recover the permission bits.  That would be enough to
> store & recover in a distributed way a single person's home directory.
> THAT might be darn useful, for those of us who float between
> different systems & would like to use a single system for multiple purposes.
> That's clearly beyond the scope of a typical SCM, but since
> it's easy to get there, that'd make sense.

The status quo with respect to the permissions is actually the correct
thing for an SCM, because you want to generate the corresponding tree for
a different user (e.g., with the other user's umask applied, etc.), not
the same tree.

This is a situation in which doing 90% of one thing, and then supporting
90% of something else separately is best. What you really want is to have
a "directory" object type that stores the exact permissions, and the
uid/gid, and even xattr stuff. Then you use those for distributing your
home directory, but not for distributing source trees, where that stuff is
useless and somewhat wrong. You could probably have the same kind of
commit objects, although you still need some way of figuring out what kind
of object is desired for the directories in a commit.

(on the other hand, it might make sense for git to handle files starting
with '.', and only skip .git).

	-Daniel
*This .sig left intentionally blank*

