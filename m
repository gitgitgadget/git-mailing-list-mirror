From: Jon Loeliger <jdl@freescale.com>
Subject: [BUG] git-show-branch cant show --more
Date: Sun, 18 Sep 2005 22:18:39 -0500
Message-ID: <E1EHCAx-0007xp-JW@jdl.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 05:19:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHCBI-00049t-L3
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 05:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVISDSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 23:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVISDSt
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 23:18:49 -0400
Received: from colo.jdl.com ([66.118.10.122]:920 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932123AbVISDSt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 23:18:49 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EHCAx-0007xp-JW
	for git@vger.kernel.org; Sun, 18 Sep 2005 22:18:41 -0500
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8830>


Guys,

I realize I probably dumbly expected more history out
of a partial git repository than is actually present,
but a segmentation fault wasn't a nice way to tell me. :-)

Start with just Paul's repo over here:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

And do a "git show-branch --more=10" on it.

Yeah, msg == 0.  Bad msg.  No dereferencing for you.

Thanks,
jdl


jdl.com 487 % gdb /usr/bin/git-show-branch
Using host libthread_db library "/lib/tls/libthread_db.so.1".
(gdb) run --more=10
Starting program: /usr/bin/git-show-branch --more=10
error: Could not read 628f87f3d585bd0c2b0e39df039585d7a5831cc9
* [master] ppc32: Allow user to individual select CHRP/PMAC/PREP config
 ! [origin] ppc32: Allow user to individual select CHRP/PMAC/PREP config
--
++ [master] ppc32: Allow user to individual select CHRP/PMAC/PREP config
++ [master~1] powerpc: Merge simplified sections.h into asm-powerpc
++ [master~2] powerpc: Remove section free() and linker script bits
++ [master~3] powerpc: Remove sections use from ppc64 and drivers
++ [master~4] powerpc: Remove sections use from ppc
++ [master~5] ppc32: Removed non-inlined versions of local_irq* functions
++ [master~6] powerpc: Merged ppc_asm.h
++ [master~7] powerpc: Merge kmap_types.h

Program received signal SIGSEGV, Segmentation fault.
get_one_line (msg=0x0, len=4294967294) at commit.c:347
347                     char c = *msg++;
(gdb) where
#0  get_one_line (msg=0x0, len=4294967294) at commit.c:347
#1  0x0804dfc5 in pretty_print_commit (fmt=CMIT_FMT_ONELINE, msg=0x0,
    len=4294967295, buf=0xbfc86e40 "[PATCH] powerpc: Merge kmap_types.h",
    space=128) at commit.c:416
#2  0x08049a22 in show_one_commit (commit=0x0) at show-branch.c:199
#3  0x0804a304 in main (ac=0, av=0xbfc871bc) at show-branch.c:483
