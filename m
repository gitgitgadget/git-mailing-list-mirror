From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCHv3 4/6] Tests for git-remote-mediawiki pull
Date: Mon, 11 Jun 2012 22:28:44 +0200
Message-ID: <1339446526-22397-4-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FD654C8.6040208@ensimag.imag.fr>
 <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: simon.cathebras@ensimag.imag.fr, Matthieu.Moy@imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, gitster@pobox.com, peff@peff.net,
	Simon.Perrat@ensimag.imag.fr,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBF2-0007dt-LK
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab2FKU3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:29:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60958 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032Ab2FKU33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:29:29 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BKKJYA024638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 22:20:19 +0200
Received: from Hithlum.crous-grenoble.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BKSkIW022262;
	Mon, 11 Jun 2012 22:29:13 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 22:20:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BKKJYA024638
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340050822.14262@TzESEyuu0ggwyzG0JIoaPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199723>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

This patch provides a set of tests for the pull fonctionnality of
git-remote-mediawiki.

These tests are part of the file
git/contrib/mw-to-git/t/t9361-mw-to-git-pull.sh

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 contrib/mw-to-git/t/t9361-mw-to-git-pull.sh | 149 ++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-pull.sh

diff --git a/contrib/mw-to-git/t/t9361-mw-to-git-pull.sh b/contrib/mw-to-git/t/t9361-mw-to-git-pull.sh
new file mode 100755
index 0000000..5f26cf5
--- /dev/null
+++ b/contrib/mw-to-git/t/t9361-mw-to-git-pull.sh
@@ -0,0 +1,149 @@
+#!/bin/sh
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+# License: GPL v2 or later
+
+# tests for git-remote-mediawiki
+
+test_description='Test the Git Mediawiki remote helper: git push and git pull simple test cases'
+
+. ./test-gitmw-lib.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+TRASH_DIR="$CURR_DIR/trash\ directory.$(basename $0 .sh)"
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping gateway git-mw tests, perl not available'
+	test_done
+fi
+
+if [ ! -f $GIT_BUILD_DIR/git-remote-mediawiki ];
+then
+	skip_all='skipping gateway git-mw tests, no remote mediawiki for git found'
+	test_done
+fi
+
+if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ;
+then
+	skip_all='skipping gateway git-mw tests, no mediawiki found'
+	test_done
+fi
+
+
+test_expect_success 'Git pull works after adding a new wiki page' "
+        wiki_reset &&
+	cd $TRASH_DIR &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage Foo \"page created after the git clone\" false &&
+
+        cd mw_dir &&
+        git pull &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        test_diff_directories mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+test_expect_success 'Git pull works after editing a wiki page' "
+        wiki_reset &&
+	cd $TRASH_DIR &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+
+        wiki_editpage Foo \"page created before the git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage Foo \"new line added on the wiki\" true &&
+
+        cd mw_dir &&
+        git pull &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        test_diff_directories mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+test_expect_success 'git pull works on conflict handled by auto-merge' "
+        wiki_reset &&
+	cd $TRASH_DIR &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+
+        wiki_editpage Foo \"1 init
+3
+5
+\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        wiki_editpage Foo \"1 init
+2 content added on wiki after clone
+3
+5
+\" false &&
+
+        cd mw_dir &&
+        echo \"1 init
+3
+4 content added on git after clone
+5
+\" > Foo.mw &&
+        git commit -am \"conflicting change on foo\" &&
+        git pull &&
+        git push &&
+        cd .. &&
+
+        rm -rf mw_dir
+"
+
+test_expect_success 'Merge conflict expected' "
+        wiki_reset &&
+	cd $TRASH_DIR &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage Foo \"1 conflict
+3 wiki
+4\" false &&
+
+        cd mw_dir &&
+        echo \"1 conflict
+2 git
+4\" > Foo.mw &&
+        git add Foo.mw &&
+        git commit -m \"conflict created\" &&
+        test_must_fail git pull
+"
+
+test_expect_failure 'git pull works after deleting a wiki page' "
+        wiki_reset &&
+	cd $TRASH_DIR &&
+        wiki_editpage Foo \"wiki page added before the git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        wiki_delete_page Foo &&
+        cd mw_dir &&
+        git pull &&
+        test ! -f Foo.mw &&
+        cd .. &&
+
+        rm -rf mw_dir
+"
+
+test_done
+
-- 
1.7.10.2.552.gaa3bb87
