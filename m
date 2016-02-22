From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v4 1/3] git-svn: hoist out utf8 prep from t9129 to lib-git-svn
Date: Mon, 22 Feb 2016 02:55:09 +0000
Message-ID: <1456109711-26866-2-git-send-email-normalperson@yhbt.net>
References: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Cc: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 03:55:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgez-0006ig-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 03:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcBVCze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 21:55:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39290 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbcBVCz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 21:55:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC6F20456;
	Mon, 22 Feb 2016 02:55:26 +0000 (UTC)
In-Reply-To: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286870>

We will be reusing this in t9115.

Suggested-by: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/lib-git-svn.sh                       | 12 ++++++++++++
 t/t9129-git-svn-i18n-commitencoding.sh | 12 +-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index b0ec12f..6a50b87 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -186,3 +186,15 @@ start_svnserve () {
              --listen-host 127.0.0.1 &
 }
 
+prepare_a_utf8_locale () {
+	a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
+	p
+	q
+}')
+	if test -n "$a_utf8_locale"
+	then
+		test_set_prereq UTF8
+	else
+		say "# UTF-8 locale not available, some tests are skipped"
+	fi
+}
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 39b6bcb..8dbd647 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -14,17 +14,7 @@ compare_git_head_with () {
 	test_cmp current "$1"
 }
 
-a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
-	p
-	q
-}')
-
-if test -n "$a_utf8_locale"
-then
-	test_set_prereq UTF8
-else
-	say "# UTF-8 locale not available, some tests are skipped"
-fi
+prepare_a_utf8_locale
 
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
-- 
EW
