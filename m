From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 17:34:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101731330.17536@g5.osdl.org>
References: <Pine.LNX.4.21.0507101959410.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 02:39:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrmK6-0003cy-KK
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 02:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGKAfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 20:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVGKAfp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 20:35:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261198AbVGKAef (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 20:34:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6B0YRjA027370
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 17:34:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6B0YQAw009625;
	Sun, 10 Jul 2005 17:34:27 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507101959410.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, Daniel Barkalow wrote:

> On Sun, 10 Jul 2005, Linus Torvalds wrote:
> > 
> > Well, regardless, we want to be able to specify which directory to write 
> > them to. We don't necessarily want to write them to the current working 
> > directory, nor do we want to write them to their eventual destination in 
> > .git/objects/pack.
> > 
> > In fact, the main current user ("git repack") really wants to write them 
> > to a temporary file, and one that isn't even called "pack-xxx", since it 
> > ends up doing cleanup with 
> > 
> > 	rm -f .tmp-pack-*
> > 
> > in case a previous re-pack was interrupted (in which case it simply cannor
> > know what the exact name was supposed to be).
> > 
> > So the "basename" ends up being necessary and meaningful regardless. We do 
> > _not_ want to remove that capability.
> 
> Shouldn't we do the same thing we do with object files? I don't see any
> difference in desired behavior.

Well, the main difference is that pack-files can be used for many things.

For example, a web interface for getting a pack-file between two releases: 
say you knew you had version xyzzy, and you want to get version xyzzy+1, 
you could do that through webgit some way even with a "stupid" interface. 
Kay already had some patch to generate pack-files for something.

The point being that pack-files are _not_ like objects. Pack-files are 
meant for communication. Having them in .git/objects/pack is just one 
special case.

> Why not checksum it in a predictable order, either that of the pack file
> or the index? We do care that it's something verifiable, so that people
> can't cause intentional collisions (for a DoS) just by naming their packs
> after existing packs that users might not have downloaded yet.

We could sha1-sum the "sorted by SHA1" list, I guess.

		Linus
