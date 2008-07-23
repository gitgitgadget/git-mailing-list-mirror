From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Add test to show that show-branch misses out the 8th
 column
Date: Wed, 23 Jul 2008 01:50:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230148130.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: pasky@suse.cz, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 23 02:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSZr-0006DQ-6N
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYGWAuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbYGWAuf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:50:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:35343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752977AbYGWAuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:50:35 -0400
Received: (qmail invoked by alias); 23 Jul 2008 00:50:33 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp043) with SMTP; 23 Jul 2008 02:50:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TO1ojzELT37TTPSN6DsdcKscjanfGhHaa4XZSmp
	lPsaw7VmCLnz3b
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89581>


Noticed by Pasky.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3202-show-branch-octopus.sh |   59 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t3202-show-branch-octopus.sh

diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
new file mode 100755
index 0000000..8d50c23
--- /dev/null
+++ b/t/t3202-show-branch-octopus.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='test show-branch with more than 8 heads'
+
+. ./test-lib.sh
+
+numbers="1 2 3 4 5 6 7 8 9 10"
+
+test_expect_success 'setup' '
+
+	> file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+
+	for i in $numbers
+	do
+		git checkout -b branch$i master &&
+		> file$i &&
+		git add file$i &&
+		test_tick &&
+		git commit -m branch$i || break
+	done
+
+'
+
+cat > expect << EOF
+! [branch1] branch1
+ ! [branch2] branch2
+  ! [branch3] branch3
+   ! [branch4] branch4
+    ! [branch5] branch5
+     ! [branch6] branch6
+      ! [branch7] branch7
+       ! [branch8] branch8
+        ! [branch9] branch9
+         * [branch10] branch10
+----------
+         * [branch10] branch10
+        +  [branch9] branch9
+       +   [branch8] branch8
+      +    [branch7] branch7
+     +     [branch6] branch6
+    +      [branch5] branch5
+   +       [branch4] branch4
+  +        [branch3] branch3
+ +         [branch2] branch2
++          [branch1] branch1
++++++++++* [branch10^] initial
+EOF
+
+test_expect_failure 'show-branch with more than 8 branches' '
+
+	git show-branch $(for i in $numbers; do echo branch$i; done) > out &&
+	test_cmp expect out
+
+'
+
+test_done
-- 
1.6.0.rc0.22.gf2096d.dirty
