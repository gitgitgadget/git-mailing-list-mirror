From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/7] modernize t9300: use test_must_fail
Date: Thu, 19 Nov 2015 20:09:44 +0100
Message-ID: <46b654a91df9ae0c85e406e6a17ca918b63351ee.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:10:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUbG-0006r2-R5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbbKSTKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:21 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:34797 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161150AbbKSTKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:19 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDp2mdzz5tlH;
	Thu, 19 Nov 2015 20:10:18 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 17C7229D8;
	Thu, 19 Nov 2015 20:10:18 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281484>

One test case open-codes a test for an expected failure. Replace it by
test_must_fail.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 566f7bd..e9c7602 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -630,20 +630,9 @@ from refs/heads/branch
 
 INPUT_END
 test_expect_success 'F: non-fast-forward update skips' '
-	if git fast-import <input
-	then
-		echo BAD gfi did not fail
-		return 1
-	else
-		if test $old_branch = `git rev-parse --verify branch^0`
-		then
-			: branch unaffected and failure returned
-			return 0
-		else
-			echo BAD gfi changed branch $old_branch
-			return 1
-		fi
-	fi
+	test_must_fail git fast-import <input &&
+	# branch must remain unaffected
+	test $old_branch = `git rev-parse --verify branch^0`
 '
 
 test_expect_success 'F: verify pack' '
-- 
2.6.2.337.ga235d84
