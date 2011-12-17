From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 05/11] git-p4: document and test clone --branch
Date: Sat, 17 Dec 2011 13:52:16 -0500
Message-ID: <1324147942-21558-6-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzPM-0002wQ-A8
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab1LQSyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:54:53 -0500
Received: from honk.padd.com ([74.3.171.149]:58913 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab1LQSyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:54:52 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id D65811C89;
	Sat, 17 Dec 2011 10:54:43 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4C7A9314A8; Sat, 17 Dec 2011 13:54:03 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187394>

Clone with --branch will not checkout HEAD, unless the branch
happens to be called the default refs/remotes/p4/master.  The
--branch option is most useful with sync; give an example of
that.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt |   10 +++++++++-
 t/t9806-options.sh       |   11 +++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c15b3b7..a5d3d81 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -178,7 +178,15 @@ subsequent 'sync' operations.
 --branch <branch>::
 	Import changes into given branch.  If the branch starts with
 	'refs/', it will be used as is, otherwise the path 'refs/heads/'
-	will be prepended.  The default branch is 'master'.
+	will be prepended.  The default branch is 'master'.  If used
+	with an initial clone, no HEAD will be checked out.
++
+This example imports a new remote "p4/proj2" into an existing
+git repository:
+----
+    $ git init
+    $ git p4 sync --branch=refs/remotes/p4/proj2 //depot/proj2
+----
 
 --detect-branches::
 	Use the branch detection algorithm to find new paths in p4.  It is
diff --git a/t/t9806-options.sh b/t/t9806-options.sh
index 8044fb0..7e2e45a 100755
--- a/t/t9806-options.sh
+++ b/t/t9806-options.sh
@@ -27,6 +27,17 @@ test_expect_success 'clone no --git-dir' '
 	test_must_fail "$GITP4" clone --git-dir=xx //depot
 '
 
+test_expect_success 'clone --branch' '
+	"$GITP4" clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git ls-files >files &&
+		test_line_count = 0 files &&
+		test_path_is_file .git/refs/remotes/p4/sb
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.258.g45cc3c
