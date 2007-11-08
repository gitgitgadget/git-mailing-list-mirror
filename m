From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-checkout: Add a test case for relative paths use.
Date: Thu,  8 Nov 2007 14:40:52 +1100
Message-ID: <11944932524072-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 04:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpyII-0007Pw-5Z
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 04:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbXKHDmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 22:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbXKHDmF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 22:42:05 -0500
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:37312 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754123AbXKHDmE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 22:42:04 -0500
X-IronPort-AV: E=Sophos;i="4.21,387,1188743400"; 
   d="scan'208";a="223469101"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail02.adl2.internode.on.net with ESMTP; 08 Nov 2007 14:10:55 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63930>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 t/t2008-checkout-subdir.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/t2008-checkout-subdir.sh

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
new file mode 100755
index 0000000..cb9c9eb
--- /dev/null
+++ b/t/t2008-checkout-subdir.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David Symonds
+
+test_description='git checkout from subdirectories'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo base > file0 &&
+	git add file0 &&
+	mkdir dir1 &&
+	echo hello > dir1/file1 &&
+	git add dir1/file1 &&
+	test_tick &&
+	mkdir dir2 &&
+	echo bonjour > dir2/file2 &&
+	git add dir2/file2 &&
+	git commit -m "populate tree"
+
+'
+
+test_expect_success 'remove and restore with relative path' '
+
+	cd dir1 &&
+	rm ../file0 &&
+	git checkout HEAD -- ../file0 && test -f ../file0 &&
+	rm ../dir2/file2 &&
+	git checkout HEAD -- ../dir2/file2 && test -f ../dir2/file2 &&
+	rm ../file0 ./file1 &&
+	git checkout HEAD -- .. && test -f ../file0 && test -f ./file1
+
+'
+
+test_done
-- 
1.5.3.1
