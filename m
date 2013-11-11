From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 3/7] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Sun, 10 Nov 2013 23:05:08 -0500
Message-ID: <1384142712-2936-4-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:08:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfinF-0004Di-0n
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab3KKEIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:08:00 -0500
Received: from smtp.bbn.com ([128.33.1.81]:38558 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab3KKEH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:07:59 -0500
Received: from socket.bbn.com ([192.1.120.102]:44756)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfin8-000JVI-80; Sun, 10 Nov 2013 23:07:58 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7F5113FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237600>

Change 'git push' to 'git push -u <remote> <branch>' in one of the
test-bzr.sh tests to ensure that the test continues to pass when the
default value of push.default changes to simple.

Also, explicitly set push.default to simple to silence warnings when
using --verbose.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-bzr.sh | 5 ++++-
 contrib/remote-helpers/test-hg.sh  | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 094062c..ea597b0 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -28,6 +28,9 @@ check () {
 
 bzr whoami "A U Thor <author@example.com>"
 
+# silence warnings
+git config --global push.default simple
+
 test_expect_success 'cloning' '
 	(
 	bzr init bzrrepo &&
@@ -379,7 +382,7 @@ test_expect_success 'export utf-8 authors' '
 	git add content &&
 	git commit -m one &&
 	git remote add bzr "bzr::../bzrrepo" &&
-	git push bzr
+	git push -u bzr master
 	) &&
 
 	(
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index dbe0eec..53f2bba 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -102,6 +102,9 @@ setup () {
 	GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0230" &&
 	GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE" &&
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+
+	# silence warnings
+	git config --global push.default simple
 }
 
 setup
-- 
1.8.5.rc1.207.gc17dd22
