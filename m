From: Ingo Molnar <mingo@elte.hu>
Subject: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 15:15:28 +0200
Message-ID: <20050416131528.GB19908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 16 15:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMn5u-0003sb-0k
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 15:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVDPNPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 09:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVDPNPt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 09:15:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12743 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262657AbVDPNPg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 09:15:36 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id AFACC320374
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 15:14:53 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 7312D1FC2; Sat, 16 Apr 2005 15:15:31 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


i've converted the Linux kernel CVS tree into 'flat patchset' format, 
which gave a series of 28237 separate patches. (Each patch represents a 
changeset, in the order they were applied. I've used the cvsps utility.)

the history data starts at 2.4.0 and ends at 2.6.12-rc2. I've included a 
script that will apply all the patches in order and will create a 
pristine 2.6.12-rc2 tree.

it needed many hours to finish, on a very fast server with tons of RAM, 
and it also needed a fair amount of manual work to extract it and to 
make it usable, so i guessed others might want to use the end result as 
well, to try and generate large GIT repositories from them (or to run 
analysis over the patches, etc.).

the patches contain all the existing metadata, dates, log messages and 
revision history. (What i think is missing is the BK tree merge 
information, but i'm not sure we want/need to convert them to GIT.)

it's a 136 MB tarball, which can be downloaded from:

   http://kernel.org/pub/linux/kernel/people/mingo/Linux-2.6-patchset/

the ./generate-2.6.12-rc2 script generates the 2.6.12-rc2 tree into 
linux/, from scratch. (No pre-existing kernel is needed, as 2.patch 
generates the full 2.4.0 kernel tree.) The patching takes a couple of 
minutes to finish, on a fast box.

below i've attached a sample patch from the series.

note: i kept the patches the cvsps utility generated as-is, to have a 
verifiable base to work on. There were a very small amount of deltas 
missed (about a dozen), probably resulting from CVS related errors, 
these are included in the diff-CVS-to-real patch. Also, the patch format 
cannot create the Documentation/logo.gif file, so the script does this 
too - just to be able to generate a complete 2.6.12-rc2 tree that is 
byte-for-byte identical to the real thing.

	Ingo

---------------------
PatchSet 1234 
Date: 2002/04/11 18:29:07
Author: viro
Branch: HEAD
Tag: (none) 
Log:
[PATCH] crapectomy in include/linux/nfsd/syscall.h

Removes an atavism in declaration of sys_nfsservctl() - sorry, I should've
remove that junk when cond_syscall() thing was done.

BKrev: 3cb5c7e3phTYgiz1YLsjQ_McTo9pOQ

Members: 
	ChangeSet:1.1234->1.1235 
	include/linux/nfsd/syscall.h:1.3->1.4 

Index: linux/include/linux/nfsd/syscall.h
===================================================================
RCS file: /home/mingo/linux-CVS/linux/include/linux/nfsd/syscall.h,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- linux/include/linux/nfsd/syscall.h	15 Mar 2002 23:06:06 -0000	1.3
+++ linux/include/linux/nfsd/syscall.h	11 Apr 2002 17:29:07 -0000	1.4
@@ -132,11 +132,7 @@
 /*
  * Kernel syscall implementation.
  */
-#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 extern asmlinkage long	sys_nfsservctl(int, struct nfsctl_arg *, void *);
-#else
-#define sys_nfsservctl		sys_ni_syscall
-#endif
 extern int		exp_addclient(struct nfsctl_client *ncp);
 extern int		exp_delclient(struct nfsctl_client *ncp);
 extern int		exp_export(struct nfsctl_export *nxp);
