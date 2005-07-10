From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 13:03:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101228300.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org>
 <20050709225818.A31045@flint.arm.linux.org.uk> <20050709232955.B31045@flint.arm.linux.org.uk>
 <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
 <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org> <20050710075548.A11765@flint.arm.linux.org.uk>
 <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net> <20050710134624.B3279@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507100942020.17536@g5.osdl.org> <20050710201504.A22477@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 22:10:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dri7G-0000mN-Cy
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVGJUIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVGJUGD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 16:06:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262092AbVGJUDr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 16:03:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6AK3XjA009938
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 13:03:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6AK3V9s030895;
	Sun, 10 Jul 2005 13:03:31 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050710201504.A22477@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, Russell King wrote:
> 
> Ok, let's give this a go then.  However, I'm not confident in this
> working, especially after seeing the output of git-fsck-cache --full...
> and I've no idea _why_ it's complaining.

Ok, I've downloaded your objects, and it all looks fine. Nothing is 
missing.

So something is wrong with the git-fsck-cache handling of 
GIT_ALTERNATE_OBJECT_DIRECTORIES, but I don't see what. Other programs 
happily see the objects, git-fsck-cache for some reason does not, and thus 
complains. I'll try to figure it out.

However, the more I try to make "git-pack-objects" work with a partial
repository, the less happy I am about it. It works wonderfully well with
rsync:, since rsync just doesn't know that something is missing, but
generating the object list when there are objects missing is quite hard.

I can be trivial and say "missing objects aren't interesting", and it 
would _work_, but that just doesn't make me happy. So I'm almost getting 
ready to say "let's not do this thing after all".

> Could this be because cogito doesn't know how to handle this setup
> properly yet?  Have I just destroyed my git tree by trying to apply
> stuff to it?

This is definitely not a cogito problem, that fsck thing is in git itself. 

And no, you didn't destroy your tree - I just merged it, and the merged 
results look fine and fsck correctly (and I get the same diffstat you do). 
It's just a bug in fsck somewhere that makes it look bad.

That said, my inability to check the pack for completeness for a partial 
archive makes me think this partial rsync wasn't such a good idea after 
all. It _is_ convenient, though, so I'll have to think about the send-pack 
issues some more and see if I can resolve the difficulty without too much 
problems. And clearly I need to fix git-fsck-cache.

Anyway, I pushed out the merge, so don't worry about your tree. But let's 
hold off on this partial thing for a while, ok?

		Linus
