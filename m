From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/5] t/test-lib-functions.sh: allow to specify the tag name to test_commit
Date: Wed, 14 Nov 2012 17:37:50 -0800
Message-ID: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:38:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoPN-0006ju-1F
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992542Ab2KOBiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:38:07 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:42040 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992516Ab2KOBiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:38:05 -0500
Received: by mail-ye0-f174.google.com with SMTP id m12so243438yen.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rK4DcRhxaMPQuqW28xv07x2w86Zo8iCwZCOhcdzLHqA=;
        b=yzAlmge10u8lzbj60ZnObrPz2BDb/bgV355H8WSQzevDtFTnuXHS820yqYKMkKmjQ0
         4sNFAth1+pRTb7jZPt7EBAMD2yTV+eauSXOrVoQ4jxkgFt+gczVMpkNDlh1rWNRM+GUq
         i/oKvs+loIHDPSe2LLfbDYHFcwsSX95/jkHsUFylFIFfrxg1oSbeAOxoVNq+isF6gW/a
         KLZjCQ+k+MNceroSm32OkaqcC2G/gwNZkGIdgAD+Sw0VMKWSI+hSLHR8syVz4Z/DkqYK
         FIMOdx7jU0bSmPSNuso3aYe/NuPD85xgvJthDiKaQBGDML9kMmOxzAqAaTDABwlSLWin
         1SmA==
Received: by 10.236.78.106 with SMTP id f70mr18635861yhe.51.1352943484494;
        Wed, 14 Nov 2012 17:38:04 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id y9sm4775632anh.20.2012.11.14.17.38.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:38:03 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209781>

The <message> part of test_commit() may not be appropriate for a tag name.
So let's allow test_commit to accept a fourth argument to specify the tag
name.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/test-lib-functions.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8889ba5..4d6057e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -135,12 +135,13 @@ test_pause () {
 	fi
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message.  It will also add a tag with <message> as name unless <tag> is
+# given.
 #
-# Both <file> and <contents> default to <message>.
+# Both <file> <contents> and <tag> default to <message>.
 
 test_commit () {
 	notick= &&
@@ -168,7 +169,7 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
-	git tag "$1"
+	git tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
1.8.0
