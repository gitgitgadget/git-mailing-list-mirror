From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 8/9] git p4 test: cleanup_git should make a new $git
Date: Mon, 25 Jun 2012 21:18:24 -0400
Message-ID: <1340673505-10551-9-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVJ-0004Kg-0N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972Ab2FZBVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:21:13 -0400
Received: from honk.padd.com ([74.3.171.149]:45540 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757788Ab2FZBVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:21:12 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 0020A2E87;
	Mon, 25 Jun 2012 18:21:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 83C0E31383; Mon, 25 Jun 2012 21:21:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200615>

For convenience, leave one in place at the end of each
test so that it is not necessary to build a new one.  This
makes it consistent with $cli.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh           | 3 ++-
 t/t9800-git-p4-basic.sh   | 1 +
 t/t9806-git-p4-options.sh | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 06d4d3a..15d2634 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -73,5 +73,6 @@ kill_p4d() {
 }
 
 cleanup_git() {
-	rm -rf "$git"
+	rm -rf "$git" &&
+	mkdir "$git"
 }
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 60c1f57..234f727 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -270,6 +270,7 @@ test_expect_success 'wildcard files submit back to p4, delete' '
 '
 
 test_expect_success 'clone bare' '
+	rm -rf "$git" &&
 	git p4 clone --dest="$git" --bare //depot &&
 	test_when_finished cleanup_git &&
 	(
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index a37c6cb..fa40cc8 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -149,7 +149,6 @@ test_expect_success 'clone --use-client-spec' '
 	cleanup_git &&
 
 	# same thing again, this time with variable instead of option
-	mkdir "$git" &&
 	(
 		cd "$git" &&
 		git init &&
-- 
1.7.11.rc2.72.gebb7ee5
