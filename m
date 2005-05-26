From: Linus Torvalds <torvalds@osdl.org>
Subject: git full diff output issues..
Date: Thu, 26 May 2005 12:19:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 21:17:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbNpf-0000rF-Uq
	for gcvg-git@gmane.org; Thu, 26 May 2005 21:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVEZTRl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 15:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVEZTRl
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 15:17:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:6829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261699AbVEZTR2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 15:17:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4QJHHjA025899
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 12:17:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4QJHG09007389;
	Thu, 26 May 2005 12:17:16 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


While testing my "git-apply" thing (coming along quite nicely, thanks for
asking), I've hit a case that is nasty to parse.

This is from the 2.6.12-rc4 -> 2.6.12-rc5 patch:

	diff --git a/arch/um/kernel/checksum.c b/arch/um/kernel/checksum.c
	deleted file mode 100644
	diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
	new file mode 100644
	--- /dev/null
	+++ b/arch/um/kernel/initrd.c
	@@ -0,0 +1,78 @@

and the magic here is that deleted file that was empty to begin with, so 
it didn't have a patch, just a note on deletion.

Why is that nasty? Because we don't have the file _name_ in any good 
format. The filename only exists int he "diff --git" header, and that one 
has the space-parsing issue, which makes it less than optimal.

I'd suggest we enhance the "full diff" output for new and deleted files to 
match the rename output, ie we'd give the actual filename on that line 
too, to avoid any ambiguities.

So we'd change it from

	deleted file mode 100644

to

	deleted file mode 100644 arch/um/kernel/checksum.c

in this case..

Comments?

		Linus
