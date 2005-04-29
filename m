From: Russell King <rmk@arm.linux.org.uk>
Subject: Next problem: cg-commit
Date: Fri, 29 Apr 2005 21:51:18 +0100
Message-ID: <20050429215118.D30010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 22:55:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcWC-000200-30
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVD2Uyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVD2Uw3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:52:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7437 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262939AbVD2UvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:51:23 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRcSF-0004wo-Pg
	for git@vger.kernel.org; Fri, 29 Apr 2005 21:51:20 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DRcSE-0002on-Uf
	for git@vger.kernel.org; Fri, 29 Apr 2005 21:51:18 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Unfortunately, cg-commit seems to return wrong exit status, returning
1 on success.  Eg:

$ cg-commit
arch/arm/mach-ixp2000/pci.c
include/asm-arm/arch-ixp2000/platform.h
Enter commit message, terminated by ctrl-D on a separate line:
blah blah blah
Committed as fafb525292acc9c0818b91b1d8e58cf770616542.
$ echo $?
1

It appears that [ "$merging" ] towards the end of cg-commit is the
cause of this odd behaviour.  Force zero exit status, since we
successfully completed.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

--- cg-commit.old	2005-04-26 04:02:01.000000000 +0100
+++ cg-commit	2005-04-29 21:47:57.161333483 +0100
@@ -114,6 +114,7 @@
 	echo "Committed as $newhead."
 	echo $newhead >.git/HEAD
 	[ "$merging" ] && rm .git/merging .git/merging-sym .git/merge-base
+	exit 0
 else
 	die "error during commit (oldhead $oldhead, treeid $treeid)"
 fi


-- 
Russell King

