From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 6/6] Documentation: reset: add some tables to describe the
	different options
Date: Tue, 08 Dec 2009 08:56:15 +0100
Message-ID: <20091208075616.4475.78725.chriscool@tuxfamily.org>
References: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:05:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHv4Q-00014T-CY
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbZLHIE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 03:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbZLHIE4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:04:56 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38924 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927AbZLHIEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 03:04:48 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 81F068180CC;
	Tue,  8 Dec 2009 09:04:42 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 29F78818082;
	Tue,  8 Dec 2009 09:04:40 +0100 (CET)
X-git-sha1: f2646114ef113307e36b4c156a099124186a0d4a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134836>

This patch adds a DISCUSSION section that contains some tables to
show how the different "git reset" options work depending on the
states of the files in the working tree, the index, HEAD and the
target commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |   73 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index a6c080e..8bc8808 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -72,6 +72,79 @@ linkgit:git-add[1]).
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
+reset options (`--keep-local-changes` is abreviated --k-l-c)
+depending on the state of the files.
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    D     --soft   A       B     D
+                                --mixed  A       D     D
+                                --hard   D       D     D
+                                --merge (disallowed)
+                                --k-l-c (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    C     --soft   A       B     C
+                                --mixed  A       C     C
+                                --hard   C       C     C
+                                --merge (disallowed)
+                                --k-l-c  A       C     C
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    D     --soft   B       B     D
+                                --mixed  B       D     D
+                                --hard   D       D     D
+                                --merge  D       D     D
+                                --k-l-c (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    C     --soft   B       B     C
+                                --mixed  B       C     C
+                                --hard   C       C     C
+                                --merge  C       C     C
+                                --k-l-c  B       C     C
+
+In these tables, A, B, C and D are some different states of a
+file. For example, the last line of the last table means that if a
+file is in state B in the working tree and the index, and in a
+different state C in HEAD and in the target, then "git reset
+--keep-local-changes target" will put the file in state B in the
+working tree and in state C in the index and HEAD.
+
+The following tables show what happens when there are unmerged
+entries:
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    B     --k-l-c  X       B     B
+                                --merge  X       B     B
+                                --hard   B       B     B
+                                --mixed  X       B     B
+                                --soft  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    A     --k-l-c  X       A     A
+                                --merge (disallowed)
+                                --hard   A       A     A
+                                --mixed  X       A     A
+                                --soft  (disallowed)
+
+X means any state and U means an unmerged index.
+
 Examples
 --------
 
-- 
1.6.5.1.gaf97d
