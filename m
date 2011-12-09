From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/4] git-p4: submit test for auto-creating clientPath
Date: Fri,  9 Dec 2011 18:48:15 -0500
Message-ID: <1323474497-14339-3-git-send-email-pw@padd.com>
References: <1323474497-14339-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZABf-0006zN-BQ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab1LIXtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:49:03 -0500
Received: from honk.padd.com ([74.3.171.149]:43995 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951Ab1LIXtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:49:02 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 4FD6EEE;
	Fri,  9 Dec 2011 15:49:01 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 21B68313BB; Fri,  9 Dec 2011 18:48:58 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.4.gc2b11.dirty
In-Reply-To: <1323474497-14339-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186707>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9807-submit.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t9807-submit.sh

diff --git a/t/t9807-submit.sh b/t/t9807-submit.sh
new file mode 100755
index 0000000..85ab0d0
--- /dev/null
+++ b/t/t9807-submit.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git-p4 submit'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1"
+	)
+'
+
+test_expect_success 'submit with no client dir' '
+	test_when_finished cleanup_git &&
+        "$GITP4" clone --dest="$git" //depot &&
+        (
+                cd "$git" &&
+                echo file2 >file2 &&
+                git add file2 &&
+                git commit -m "git commit 2" &&
+                rm -rf "$cli" &&
+                git config git-p4.skipSubmitEdit true &&
+                "$GITP4" submit
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.rc4.42.g8317d
