From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 09/11] git-p4: test --keep-path
Date: Sat, 17 Dec 2011 13:52:20 -0500
Message-ID: <1324147942-21558-10-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzRH-0003eL-Dc
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab1LQS4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:56:52 -0500
Received: from honk.padd.com ([74.3.171.149]:58921 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab1LQS4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:56:51 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 87EBE1C89;
	Sat, 17 Dec 2011 10:56:40 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A068E314A8; Sat, 17 Dec 2011 13:55:23 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187398>

Make sure it leaves the path, below //depot, in git.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9806-options.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t9806-options.sh b/t/t9806-options.sh
index cc0fd26..6b288ac 100755
--- a/t/t9806-options.sh
+++ b/t/t9806-options.sh
@@ -93,6 +93,30 @@ test_expect_success 'clone --max-changes' '
 	)
 '
 
+test_expect_success 'clone --keep-path' '
+	(
+		cd "$cli" &&
+		mkdir -p sub/dir &&
+		echo f4 >sub/dir/f4 &&
+		p4 add sub/dir/f4 &&
+		p4 submit -d "change 4"
+	) &&
+	"$GITP4" clone --dest="$git" --keep-path //depot/sub/dir@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_path_is_missing f4 &&
+		test_path_is_file sub/dir/f4
+	) &&
+	cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/sub/dir@all &&
+	(
+		cd "$git" &&
+		test_path_is_file f4 &&
+		test_path_is_missing sub/dir/f4
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.258.g45cc3c
