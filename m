From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 2/4] Documentation: reset: add some tables to describe the
	different options
Date: Wed, 30 Dec 2009 06:54:45 +0100
Message-ID: <20091230055448.4475.83629.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Dec 30 06:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrUO-0005vC-0i
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 06:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbZL3Fwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 00:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZL3Fwt
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 00:52:49 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55883 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbZL3Fwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 00:52:45 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E8840818028;
	Wed, 30 Dec 2009 06:52:35 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8FF42818039;
	Wed, 30 Dec 2009 06:52:32 +0100 (CET)
X-git-sha1: aa7c3b9495093f167016de3759059e56b5f8ef09 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135859>

This patch adds a DISCUSSION section that contains some tables to
show how the different "git reset" options work depending on the
states of the files in the working tree, the index, HEAD and the
target commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |   66 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2d27e40..c9044c9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -67,6 +67,72 @@ linkgit:git-add[1]).
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
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    C     --soft   A       B     C
+                                --mixed  A       C     C
+                                --hard   C       C     C
+                                --merge (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    D     --soft   B       B     D
+                                --mixed  B       D     D
+                                --hard   D       D     D
+                                --merge  D       D     D
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    C     --soft   B       B     C
+                                --mixed  B       C     C
+                                --hard   C       C     C
+                                --merge  C       C     C
+
+In these tables, A, B, C and D are some different states of a
+file. For example, the last line of the last table means that if a
+file is in state B in the working tree and the index, and in a
+different state C in HEAD and in the target, then "git reset
+--merge target" will put the file in state C in the working tree,
+in the index and in HEAD.
+
+The following tables show what happens when there are unmerged
+entries:
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    B     --soft  (disallowed)
+                                --mixed  X       B     B
+                                --hard   B       B     B
+                                --merge (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    A     --soft  (disallowed)
+                                --mixed  X       A     A
+                                --hard   A       A     A
+                                --merge (disallowed)
+
+X means any state and U means an unmerged index.
+
 Examples
 --------
 
-- 
1.6.6.rc2.5.g49666
