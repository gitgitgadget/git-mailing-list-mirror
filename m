From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 7/7] Documentation: reset: add some tables to describe the
	different options
Date: Sat, 12 Dec 2009 05:32:58 +0100
Message-ID: <20091212043259.3930.16467.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdp-0000Ke-7W
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761118AbZLLEbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761004AbZLLEbK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:31:10 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36870 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514AbZLLEay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:54 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F399B818073;
	Sat, 12 Dec 2009 05:30:49 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A747F81803B;
	Sat, 12 Dec 2009 05:30:46 +0100 (CET)
X-git-sha1: 1d66bffa949229444c8922a9c0fcda659818e41d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135120>

This patch adds a DISCUSSION section that contains some tables to
show how the different "git reset" options work depending on the
states of the files in the working tree, the index, HEAD and the
target commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |   72 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f8724d0..4ded9e3 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -72,6 +72,78 @@ linkgit:git-add[1]).
 <commit>::
 	Commit to make the current HEAD. If not given defaults to HEAD.
 
+DISCUSSION
+----------
+
+The tables below show what happens when running:
+
+----------
+git reset --option target
+----------
+
+to reset the HEAD to another commit (`target`) with the different
+reset options depending on the state of the files.
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    D     --soft   A       B     D
+                                --mixed  A       D     D
+                                --hard   D       D     D
+                                --merge (disallowed)
+                                --keep  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    C     --soft   A       B     C
+                                --mixed  A       C     C
+                                --hard   C       C     C
+                                --merge (disallowed)
+                                --keep   A       C     C
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    D     --soft   B       B     D
+                                --mixed  B       D     D
+                                --hard   D       D     D
+                                --merge  D       D     D
+                                --keep  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    C     --soft   B       B     C
+                                --mixed  B       C     C
+                                --hard   C       C     C
+                                --merge  C       C     C
+                                --keep   B       C     C
+
+In these tables, A, B, C and D are some different states of a
+file. For example, the last line of the last table means that if a
+file is in state B in the working tree and the index, and in a
+different state C in HEAD and in the target, then "git reset
+--keep target" will put the file in state B in the working tree
+and in state C in the index and HEAD.
+
+The following tables show what happens when there are unmerged
+entries:
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    B     --soft  (disallowed)
+                                --mixed  X       B     B
+                                --hard   B       B     B
+                                --merge  X       B     B
+                                --keep   X       B     B
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    A     --soft  (disallowed)
+                                --mixed  X       A     A
+                                --hard   A       A     A
+                                --merge (disallowed)
+                                --keep   X       A     A
+
+X means any state and U means an unmerged index.
+
 Examples
 --------
 
-- 
1.6.6.rc1.8.gd33ec
