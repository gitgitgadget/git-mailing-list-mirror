From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 3/6] git-check-attr: Demonstrate problems with relative paths
Date: Thu, 28 Jul 2011 12:37:02 +0200
Message-ID: <1311849425-9057-4-git-send-email-mhagger@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 12:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNyK-0007Q2-BR
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab1G1KhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 06:37:24 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32850 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab1G1KhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 06:37:17 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmNvm-0001Zr-DQ; Thu, 28 Jul 2011 12:35:06 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178059>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0003-attributes.sh |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 43957ea..f6cf77d 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -19,7 +19,7 @@ attr_check () {
 
 test_expect_success 'setup' '
 
-	mkdir -p a/b/d a/c &&
+	mkdir -p a/b/d a/c b &&
 	(
 		echo "[attr]notest !test"
 		echo "f	test=f"
@@ -102,6 +102,19 @@ test_expect_failure 'unnormalized paths' '
 
 '
 
+test_expect_failure 'relative paths' '
+
+	(cd a && attr_check ../f f) &&
+	(cd a && attr_check f f) &&
+	(cd a && attr_check i a/i) &&
+	(cd a && attr_check g a/g) &&
+	(cd a && attr_check b/g a/b/g) &&
+	(cd b && attr_check ../a/f f) &&
+	(cd b && attr_check ../a/g a/g) &&
+	(cd b && attr_check ../a/b/g a/b/g)
+
+'
+
 test_expect_success 'core.attributesfile' '
 	attr_check global unspecified &&
 	git config core.attributesfile "$HOME/global-gitattributes" &&
-- 
1.7.6.8.gd2879
