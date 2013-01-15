From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 13/14] git p4 test: keep P4CLIENT changes inside subshells
Date: Mon, 14 Jan 2013 19:47:07 -0500
Message-ID: <1358210828-2369-14-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuukr-0003lR-0R
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab3AOAvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:51:33 -0500
Received: from honk.padd.com ([74.3.171.149]:40013 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803Ab3AOAvc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:51:32 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 167232F3F;
	Mon, 14 Jan 2013 16:51:32 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8144F28EC2; Mon, 14 Jan 2013 19:51:29 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213564>

Tests assume that this is set to something valid.  Make sure
that the 'clone --use-client-spec' does not leak its changes
out into the rest of the tests.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9806-git-p4-options.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 3b0000f..8d914a5 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -226,9 +226,11 @@ test_expect_success 'clone --use-client-spec' '
 		View: //depot/sub/... //client2/bus/...
 		EOF
 	) &&
-	P4CLIENT=client2 &&
 	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" --use-client-spec //depot/... &&
+	(
+		P4CLIENT=client2 &&
+		git p4 clone --dest="$git" --use-client-spec //depot/...
+	) &&
 	(
 		cd "$git" &&
 		test_path_is_file bus/dir/f4 &&
@@ -241,6 +243,7 @@ test_expect_success 'clone --use-client-spec' '
 		cd "$git" &&
 		git init &&
 		git config git-p4.useClientSpec true &&
+		P4CLIENT=client2 &&
 		git p4 sync //depot/... &&
 		git checkout -b master p4/master &&
 		test_path_is_file bus/dir/f4 &&
-- 
1.8.1.350.gdbf6fd0
