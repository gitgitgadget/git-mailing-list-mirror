From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Makefile: Use generic rule to build test programs
Date: Thu, 31 May 2007 00:18:24 +0100
Message-ID: <20070530232206.25366.89397.julian@quantumfyre.co.uk>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 31 01:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtXWi-0000bX-5n
	for gcvg-git@gmane.org; Thu, 31 May 2007 01:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXE3XYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 19:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbXE3XYO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 19:24:14 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44663 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659AbXE3XYN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2007 19:24:13 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D632FC6124
	for <git@vger.kernel.org>; Thu, 31 May 2007 00:24:11 +0100 (BST)
Received: (qmail 15920 invoked by uid 103); 31 May 2007 00:21:40 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3324. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024385 secs); 30 May 2007 23:21:40 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 31 May 2007 00:21:40 +0100
X-git-sha1: dd211208ea4e29c653b954d976308df3e48757eb 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48787>

Use a generic make rule to build all the test programs, rather than
specifically mentioning each one.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Tue, 29 May 2007, Junio C Hamano wrote:
> Hmmm.  One wonders if we can do something about these apparent
> similarities with all these rules...

Something like this?

 Makefile |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 7527734..cac0a4a 100644
--- a/Makefile
+++ b/Makefile
@@ -942,7 +942,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X
 
 all:: $(TEST_PROGRAMS)
 
@@ -955,26 +955,12 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
-test-date$X: test-date.c date.o ctype.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
+test-date$X: date.o ctype.o
 
-test-delta$X: test-delta.o diff-delta.o patch-delta.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+test-delta$X: diff-delta.o patch-delta.o
 
-test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
-
-test-sha1$X: test-sha1.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
-
-test-match-trees$X: test-match-trees.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
-
-test-chmtime$X: test-chmtime.c
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
-
-test-genrandom$X: test-genrandom.c
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
+test-%$X: test-%.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
-- 
1.5.2
