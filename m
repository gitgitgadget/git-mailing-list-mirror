From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-config: test for 'do not forget "a.b.var" already ends "a.var" section'.
Date: Sun, 13 May 2007 09:12:52 +0200
Message-ID: <1179040372405-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 09:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn8GK-00067x-OA
	for gcvg-git@gmane.org; Sun, 13 May 2007 09:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193AbXEMHMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 03:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbXEMHMy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 03:12:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:54873 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756507AbXEMHMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 03:12:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4D7CqXN014866
	for <git@vger.kernel.org>; Sun, 13 May 2007 09:12:53 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4D7Cq6o018043;
	Sun, 13 May 2007 09:12:52 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: 7vtzuhtjj6.fsf@assigned-by-dhcp.cox.net
References: 7vtzuhtjj6.fsf@assigned-by-dhcp.cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47124>

Added test for mentioned bugfix.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t1300-repo-config.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 78c2e08..91d572c 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -407,6 +407,22 @@ EOF
 test_expect_success "section was removed properly" \
 	"git diff -u expect .git/config"
 
+rm .git/config
+
+git-config gitcvs.enabled true
+git-config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite
+git-config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite
+
+cat > expect << EOF
+[gitcvs]
+	enabled = true
+	dbname = %Ggitcvs2.%a.%m.sqlite
+[gitcvs "ext"]
+	dbname = %Ggitcvs1.%a.%m.sqlite
+EOF
+
+test_expect_success 'section ending' 'cmp .git/config expect'
+
 test_expect_success numbers '
 
 	git-config kilo.gram 1k &&
-- 
1.5.1.2
