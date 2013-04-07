From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 2/2] t5704: Test prerequisites with empty commit messages
Date: Sun,  7 Apr 2013 13:53:16 +0200
Message-ID: <1365335596-19917-2-git-send-email-git@cryptocrack.de>
References: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 13:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOoA4-0007Nr-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 13:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585Ab3DGLxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 07:53:21 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:40824 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933558Ab3DGLxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 07:53:20 -0400
Received: from localhost (p57B429B9.dip.t-dialin.net [87.180.41.185])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 107f014d
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Sun, 7 Apr 2013 13:53:17 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
In-Reply-To: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220308>

While stating that commit messages of prerequisites are optional in
bundles, we used to disallow prerequisite lines consisting of an object
name only. This behavior made `git bundle verify` and `git bundle
unbundle` reject bundles that contain prerequisites without any commit
message.

Add a test to reproduce this behavior.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 t/t5704-bundle.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 9e43731..a45c316 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -58,4 +58,14 @@ test_expect_success 'ridiculously long subject in boundary' '
 	grep "^-[0-9a-f]\\{40\\} " boundary
 '
 
+test_expect_success 'prerequisites with an empty commit message' '
+	: >file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit --allow-empty-message -m "" &&
+	test_commit file2 &&
+	git bundle create bundle HEAD^.. &&
+	git bundle verify bundle
+'
+
 test_done
-- 
1.8.2.675.gda3bb24.dirty
