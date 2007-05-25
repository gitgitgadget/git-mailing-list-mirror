From: skimo@liacs.nl
Subject: [PATCH 3/3] test for simple submodule checkout support
Date: Fri, 25 May 2007 23:07:13 +0200
Message-ID: <1180127233176-git-send-email-skimo@liacs.nl>
References: <1180127233729-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 23:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrh0h-0008Ps-Pd
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbXEYVHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXEYVHf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:07:35 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60871 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbXEYVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:07:34 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4PL7DBd031053;
	Fri, 25 May 2007 23:07:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 64AED3C00B; Fri, 25 May 2007 23:07:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <1180127233729-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48416>

From: Martin Waitz <tali@admingilde.org>

Signed-off-by: Martin Waitz <tali@admingilde.org>
Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 t/t3041-subprojects-checkout.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100755 t/t3041-subprojects-checkout.sh

diff --git a/t/t3041-subprojects-checkout.sh b/t/t3041-subprojects-checkout.sh
new file mode 100755
index 0000000..4b3cea9
--- /dev/null
+++ b/t/t3041-subprojects-checkout.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='submodule checkout'
+. ./test-lib.sh
+
+test_expect_success 'submodule creation' \
+    '(mkdir A && cd A &&
+      git init &&
+      echo 1 > a &&
+      git add a &&
+      git commit -m "create submodule" || exit $? )'
+
+test_expect_success 'Super module creation' \
+    'git add A &&
+     git commit -m "supermodule creation" &&
+     git branch one'
+
+test_expect_success 'submodule change' \
+    '(cd A &&
+      echo 2 > a &&
+      git add a &&
+      git commit -m "create submodule" || exit $? )'
+
+test_expect_success 'supermodule change' \
+    'git add A &&
+     git commit -m "supermodule creation"'
+
+test_expect_success 'supermodule switching branch' \
+    'git checkout one &&
+     echo 1 > expected &&
+     git diff expected A/a'
+
+test_expect_success 'supermodule reset' \
+    'git reset --hard master &&
+     echo 2 > expected &&
+     git diff expected A/a'
+
+
+test_done
-- 
1.5.2.838.gbeec
