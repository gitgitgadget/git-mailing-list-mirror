From: skimo@liacs.nl
Subject: [PATCH 19/22] test for simple submodule checkout support
Date: Thu, 24 May 2007 00:23:08 +0200
Message-ID: <11799589932529-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:27:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzIg-00049z-VP
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299AbXEWWYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760279AbXEWWYe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:24:34 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33765 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756829AbXEWWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:41 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNLlD011608;
	Thu, 24 May 2007 00:23:27 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 64B547DDB1; Thu, 24 May 2007 00:23:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48208>

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
1.5.2.784.g5532e
