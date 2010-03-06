From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/6] Modernize t5530-upload-pack-error.
Date: Sat,  6 Mar 2010 16:40:38 +0100
Message-ID: <40f4b185c3661e5826ec2e58124137cd735e7199.1267889703.git.j6t@kdbg.org>
References: <cover.1267889703.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15t-0004YU-6I
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab0CFPmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:42:47 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47675 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750971Ab0CFPml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:41 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C3653CDF88;
	Sat,  6 Mar 2010 16:42:39 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B8CC719F703;
	Sat,  6 Mar 2010 16:40:58 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
In-Reply-To: <cover.1267889703.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests did not use test_must_fail.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5530-upload-pack-error.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index a696b87..044603c 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -32,9 +32,9 @@ test_expect_success 'fsck fails' '
 
 test_expect_success 'upload-pack fails due to error in pack-objects packing' '
 
-	! echo "0032want $(git rev-parse HEAD)
-00000009done
-0000" | git upload-pack . > /dev/null 2> output.err &&
+	printf "0032want %s\n00000009done\n0000" \
+		$(git rev-parse HEAD) >input &&
+	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	grep "unable to read" output.err &&
 	grep "pack-objects died" output.err
 '
@@ -51,9 +51,9 @@ test_expect_success 'fsck fails' '
 '
 test_expect_success 'upload-pack fails due to error in rev-list' '
 
-	! echo "0032want $(git rev-parse HEAD)
-0034shallow $(git rev-parse HEAD^)00000009done
-0000" | git upload-pack . > /dev/null 2> output.err &&
+	printf "0032want %s\n0034shallow %s00000009done\n0000" \
+		$(git rev-parse HEAD) $(git rev-parse HEAD^) >input &&
+	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	# pack-objects survived
 	grep "Total.*, reused" output.err &&
 	# but there was an error, which must have been in rev-list
@@ -62,9 +62,9 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
 
-	! echo "0032want $(git rev-parse HEAD)
-00000009done
-0000" | git upload-pack . > /dev/null 2> output.err &&
+	printf "0032want %s\n00000009done\n0000" \
+		$(git rev-parse HEAD) >input &&
+	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	grep "bad tree object" output.err &&
 	grep "pack-objects died" output.err
 '
-- 
1.7.0.rc2.65.g7b13a
