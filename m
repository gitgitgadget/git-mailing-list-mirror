From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/4] t5510: refactor bundle->pack conversion
Date: Thu, 1 Mar 2012 22:40:48 +0100
Message-ID: <c8e641fe6f33a4ed795da8d40f5be743a2e5c45d.1330637923.git.trast@student.ethz.ch>
References: <cover.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3DkT-0007ba-U0
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096Ab2CAVk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:40:56 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:24475 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965004Ab2CAVkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:40:55 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:51 +0100
Received: from thomas.inf.ethz.ch (129.132.210.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:53 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <cover.1330637923.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191975>

It's not so much a conversion as a "strip everything up to and
including the first blank line", but it will come in handy again.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t5510-fetch.sh |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 79ee913..6df24b2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -14,6 +14,14 @@ test_bundle_object_count () {
 	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | wc -l)
 }
 
+convert_bundle_to_pack () {
+	while read x && test -n "$x"
+	do
+		:;
+	done
+	cat
+}
+
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
@@ -206,13 +214,7 @@ test_expect_success 'unbundle 1' '
 
 test_expect_success 'bundle 1 has only 3 files ' '
 	cd "$D" &&
-	(
-		while read x && test -n "$x"
-		do
-			:;
-		done
-		cat
-	) <bundle1 >bundle.pack &&
+	convert_bundle_to_pack <bundle1 >bundle.pack &&
 	git index-pack bundle.pack &&
 	test_bundle_object_count bundle.pack 3
 '
@@ -229,13 +231,7 @@ test_expect_success 'bundle does not prerequisite objects' '
 	git add file2 &&
 	git commit -m add.file2 file2 &&
 	git bundle create bundle3 -1 HEAD &&
-	(
-		while read x && test -n "$x"
-		do
-			:;
-		done
-		cat
-	) <bundle3 >bundle.pack &&
+	convert_bundle_to_pack <bundle3 >bundle.pack &&
 	git index-pack bundle.pack &&
 	test_bundle_object_count bundle.pack 3
 '
-- 
1.7.9.2.467.g7fee4
