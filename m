From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 09/11] git-p4: test --keep-path
Date: Sat, 24 Dec 2011 21:07:38 -0500
Message-ID: <1324778860-4821-10-git-send-email-pw@padd.com>
References: <1324778860-4821-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 03:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RedY4-000189-Fx
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 03:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050Ab1LYCKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 21:10:46 -0500
Received: from honk.padd.com ([74.3.171.149]:37317 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1LYCKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 21:10:45 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 63DDC31BF;
	Sat, 24 Dec 2011 18:10:45 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 13A49315E1; Sat, 24 Dec 2011 21:10:41 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.398.gf9d11
In-Reply-To: <1324778860-4821-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187672>

Make sure it leaves the path, below //depot, in git.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9806-git-p4-options.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index cc0fd26..6b288ac 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
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
1.7.8.534.g03ab.dirty
