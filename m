From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Support SPARSE in Makefile, better SPARSE_FLAGS
Date: Thu, 29 Sep 2005 16:46:05 -0400
Message-ID: <1128026765.24397.46.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 22:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5IG-0007N6-NS
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 22:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVI2UqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVI2UqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 16:46:09 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:21892 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751180AbVI2UqI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 16:46:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EL5I7-00016k-6t
	for git@vger.kernel.org; Thu, 29 Sep 2005 16:46:07 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EL5I5-0008Tv-WC
	for git@vger.kernel.org; Thu, 29 Sep 2005 16:46:06 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9505>

Support SPARSE in Makefile, better SPARSE_FLAGS

This patch makes it possible to use some other program instead of sparse
(e.g. a wrapper around sparse).  It also provides a better default for
SPARSE_FLAGS.  __BIG_ENDIAN__ should not be needed.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -66,8 +66,9 @@ INSTALL = install
 RPMBUILD = rpmbuild
 
 # sparse is architecture-neutral, which means that we need to tell it
-# explicitly what architecture to check for. Fix this up for yours..
-SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
+# explicitly what architecture to check for.
+SPARSE = sparse
+SPARSE_FLAGS = -D__$(shell uname -i)__
 
 
 
@@ -335,7 +336,7 @@ test-delta: test-delta.c diff-delta.o pa
 	$(CC) $(ALL_CFLAGS) -o $@ $^
 
 check:
-	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
+	for i in *.c; do $(SPARSE) $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
 
 
 


-- 
Regards,
Pavel Roskin
