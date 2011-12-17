From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 02/11] git-p4: test debug macro
Date: Sat, 17 Dec 2011 13:52:13 -0500
Message-ID: <1324147942-21558-3-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:54:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzOU-0002e8-VD
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab1LQSx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:53:57 -0500
Received: from honk.padd.com ([74.3.171.149]:48979 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab1LQSxn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:53:43 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 1D06B627F;
	Sat, 17 Dec 2011 10:53:41 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 21BEE314AA; Sat, 17 Dec 2011 13:53:03 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187392>

Call this from a test to have it pause and wait for you to
investigate.  It prints out its current directory and the
P4 environment variables.  It waits for ctrl-c before continuing
the test.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index a870f9a..c147bd6 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -72,3 +72,30 @@ kill_p4d() {
 cleanup_git() {
 	rm -rf "$git"
 }
+
+#
+# This is a handy tool when developing or debugging tests.  Use
+# it inline to pause the script, perhaps like this:
+#
+#    "$GITP4" clone ... &&
+#    (
+#          cd "$git" &&
+#          debug &&
+#          git log --oneline >lines &&
+#    ...
+#
+# Go investigate when it pauses, then hit ctrl-c to continue the
+# test.  The other tests will run, and p4d will be cleaned up nicely.
+#
+# Note that the directory is deleted and created for every test run,
+# so you have to do the "cd" again.
+#
+debug() {
+        echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
+        echo cd \"$(pwd)\"
+        echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
+        trap echo SIGINT
+        sleep $((3600 * 24 * 30))
+        trap - SIGINT
+}
+
-- 
1.7.8.258.g45cc3c
