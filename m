From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] block-sha1: more good unaligned memory access candidates
Date: Thu, 13 Aug 2009 00:29:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 06:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbRwe-0007QD-4q
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 06:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbZHME3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 00:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbZHME3e
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 00:29:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32439 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZHME3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 00:29:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOA00214SGQAYE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Aug 2009 00:29:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125773>

In addition to X86, PowerPC and S390 are capable of unaligned memory 
accesses.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index d3121f7..e5a1007 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -67,7 +67,10 @@
  * and is faster on architectures with memory alignment issues.
  */
 
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__) || \
+    defined(__ppc__) || defined(__ppc64__) || \
+    defined(__powerpc__) || defined(__powerpc64__) || \
+    defined(__s390__) || defined(__s390x__)
 
 #define get_be32(p)	ntohl(*(unsigned int *)(p))
 #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
