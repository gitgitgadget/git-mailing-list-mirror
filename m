From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 06/14] git p4: verify expected refs in clone --bare test
Date: Mon, 14 Jan 2013 19:47:00 -0500
Message-ID: <1358210828-2369-7-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuuia-0001jM-K4
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab3AOAtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:49:12 -0500
Received: from honk.padd.com ([74.3.171.149]:52473 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756802Ab3AOAtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:49:12 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id BBEA02F3F;
	Mon, 14 Jan 2013 16:49:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3C50328EC2; Mon, 14 Jan 2013 19:49:09 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213557>

Make sure that the standard branches are created as expected.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 8c59796..166e752 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -160,9 +160,12 @@ test_expect_success 'clone --bare should make a bare repository' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		test ! -d .git &&
-		bare=`git config --get core.bare` &&
-		test "$bare" = true
+		test_path_is_missing .git &&
+		git config --get --bool core.bare true &&
+		git rev-parse --verify refs/remotes/p4/master &&
+		git rev-parse --verify refs/remotes/p4/HEAD &&
+		git rev-parse --verify refs/heads/master &&
+		git rev-parse --verify HEAD
 	)
 '
 
-- 
1.8.1.350.gdbf6fd0
