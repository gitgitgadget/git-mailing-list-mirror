From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 09:18:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <m31x5gob8k.fsf@telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 18:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyu3z-0005ym-MO
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 18:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVG3QTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVG3QTb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 12:19:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263053AbVG3QS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 12:18:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6UGIIjA022367
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 09:18:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6UGIH6n000925;
	Sat, 30 Jul 2005 09:18:18 -0700
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m31x5gob8k.fsf@telia.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Peter Osterlund wrote:
> 
> I have problems pulling linux kernel changes from
> 33ac02aa4cef417871e128ab4a6565e751e5f3b2 to
> b0825488a642cadcf39709961dde61440cb0731c into my local tree. At first
> I thought your patch would fix it, but it doesn't:

No, this is a merge conflict failure, and you simply have conflicts in the
tree. git did everything right, it just couldn't do an automatic merge.

> ERROR: Merge conflict in arch/um/os-Linux/elf_aux.c.
> ERROR: Merge conflict in arch/x86_64/kernel/smpboot.c.
> ERROR: Merge conflict in drivers/i2c/busses/i2c-mpc.c.
> ERROR: Merge conflict in include/asm-i386/bitops.h.
> ERROR: Merge conflict in kernel/sys.c.

We don't have any nice graphical tools to show these to you like BitKeeper 
had, although it shouldn't be fundamentally hard.

What you need to do is basically edit all those five files, and look for 
the conflicts (they are just like normal CVS conflicts:

	<<<<<<<
		orig-branch
		conflict-contents
	=======
		pulled-branch
		conflict-contents
	>>>>>>>>

and then you edit them to your liking until you have no more conflicts, 
and then you have to commit your manual resolve with

	git commit --all

which will commit the merge _and_ your manual conflict resolution.

This is something where a nice wrapper layer could do a lot better. I know 
there are graphical three-way merge programs available.

But core git is no worse (and in fact a _lot_ better) than CVS in this 
regard, so I feel that the git merge, while obviously not perfect or even 
very smart, is "sufficient" for what git is (ie it's up to porcelain to do 
anything better).

			Linus
