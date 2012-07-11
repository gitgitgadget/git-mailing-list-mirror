From: marcnarc@xiplink.com
Subject: [PATCH 5/6] Test that plain "git fetch" uses remote.default when on a detached HEAD.
Date: Wed, 11 Jul 2012 11:34:00 -0400
Message-ID: <1342020841-24368-6-git-send-email-marcnarc@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoywB-0006Ma-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab2GKPem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:34:42 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:42550 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758101Ab2GKPek (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 11:34:40 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q6BFY4Ue029776;
	Wed, 11 Jul 2012 11:34:06 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201308>

From: Marc Branchaud <marcnarc@xiplink.com>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 t/t5510-fetch.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d7a19a1..8ecd996 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -69,6 +69,23 @@ test_expect_success "fetch test" '
 	test "z$mine" = "z$his"
 '
 
+test_expect_success "fetch test detached HEAD uses default remote" '
+	cd "$D" &&
+	git clone -o foo . default-remote &&
+	git checkout -b detached &&
+	test_commit update1 &&
+	(
+		cd default-remote &&
+		git checkout HEAD@{0} &&
+		git fetch &&
+		test -f .git/refs/remotes/foo/detached &&
+		mine=`git rev-parse refs/remotes/foo/detached` &&
+		his=`cd .. && git rev-parse refs/heads/detached` &&
+		test "z$mine" = "z$his"
+	) &&
+	git checkout master
+'
+
 test_expect_success "fetch test for-merge" '
 	cd "$D" &&
 	cd three &&
-- 
1.7.11.1
