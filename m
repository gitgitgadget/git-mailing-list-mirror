From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/6] git-check-attr: Demonstrate problems with relative paths
Date: Thu,  4 Aug 2011 06:47:45 +0200
Message-ID: <1312433268-11385-4-git-send-email-mhagger@alum.mit.edu>
References: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoprD-0000n2-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab1HDEsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:48:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39753 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1HDEsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:48:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744ltPY029942;
	Thu, 4 Aug 2011 06:47:57 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178696>


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
