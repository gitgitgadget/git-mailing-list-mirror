From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCH 4/6] Tests for git-remote-mediawiki pull and push
Date: Tue, 12 Jun 2012 23:12:42 +0200
Message-ID: <1339535563-18958-4-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
 <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Cathebras <simon.cathebras@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 23:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYOt-0000YI-2l
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2FLVNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 17:13:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34898 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783Ab2FLVNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 17:13:06 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5CL3k4l001705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 23:03:46 +0200
Received: from Hithlum.crous-grenoble.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5CLCjpL032065;
	Tue, 12 Jun 2012 23:12:54 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 12 Jun 2012 23:03:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CL3k4l001705
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340139829.21605@eXEIBFEbwjbMEXqOmpjh0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199858>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

This patch provides a set of tests for the pull and push fonctionnality of
git-remote-mediawiki.

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh | 151 +++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh

diff --git a/contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh b/contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
new file mode 100755
index 0000000..add7c79
--- /dev/null
+++ b/contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
@@ -0,0 +1,151 @@
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
+
+test_check_precond
+
+
+test_expect_success 'Git pull works after adding a new wiki page' '
+	wiki_reset &&
+
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_1 &&
+	wiki_editpage Foo "page created after the git clone" false &&
+
+	(cd mw_dir_1 &&
+	git pull) &&
+
+	wiki_getallpage ref_page_1 &&
+	test_diff_directories mw_dir_1 ref_page_1
+'
+
+test_expect_success 'Git pull works after editing a wiki page' '
+	wiki_reset &&
+
+	wiki_editpage Foo "page created before the git clone" false &&
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_2 &&
+	wiki_editpage Foo "new line added on the wiki" true &&
+
+	(cd mw_dir_2 &&
+	git pull) &&
+
+	wiki_getallpage ref_page_2 &&
+	test_diff_directories mw_dir_2 ref_page_2
+'
+
+test_expect_success 'git pull works on conflict handled by auto-merge' '
+	wiki_reset &&
+
+	wiki_editpage Foo "1 init
+3
+5
+" false &&
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_3 &&
+
+	wiki_editpage Foo "1 init
+2 content added on wiki after clone
+3
+5
+" false &&
+
+	(cd mw_dir_3 &&
+	echo "1 init
+3
+4 content added on git after clone
+5
+" > Foo.mw &&
+	git commit -am "conflicting change on foo" &&
+	git pull &&
+	git push)
+'
+
+test_expect_success 'Git push works after adding a file .mw' '
+	wiki_reset &&
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_4 &&
+	wiki_getallpage ref_page_4 &&
+	(cd mw_dir_4 &&
+	test ! -f Foo.mw &&
+	touch Foo.mw &&
+	echo "hello world" >> Foo.mw &&
+	git add Foo.mw &&
+	git commit -m "Foo" &&
+	git push) &&
+	wiki_getallpage ref_page_4 &&
+	test_diff_directories mw_dir_4 ref_page_4
+'
+
+test_expect_success 'Git push works after editing a file .mw' '
+	wiki_reset &&
+	wiki_editpage "Foo" "page created before the git clone" false &&
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_5 &&
+
+	(cd mw_dir_5 &&
+	echo "new line added in the file Foo.mw" >> Foo.mw &&
+	git commit -am "edit file Foo.mw" &&
+	git push) &&
+
+	wiki_getallpage ref_page_5 &&
+	test_diff_directories mw_dir_5 ref_page_5
+'
+
+test_expect_failure 'Git push works after deleting a file' '
+	wiki_reset &&
+	wiki_editpage Foo "wiki page added before git clone" false &&
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_6 &&
+
+	(cd mw_dir_6 &&
+	git rm Foo.mw &&
+	git commit -am "page Foo.mw deleted" &&
+	git push) &&
+
+	test ! wiki_page_exist Foo
+'
+
+
+
+test_expect_success 'Merge conflict expected and solving it' '
+	wiki_reset &&
+
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_7 &&
+	wiki_editpage Foo "1 conflict
+3 wiki
+4" false &&
+
+	(cd mw_dir_7 &&
+	echo "1 conflict
+2 git
+4" > Foo.mw &&
+	git add Foo.mw &&
+	git commit -m "conflict created" &&
+	test_must_fail git pull &&
+	perl -pi -e "s/[<=>].*//g" Foo.mw &&
+	git commit -am "merge conflict solved" &&
+	git push)
+'
+
+test_expect_failure 'git pull works after deleting a wiki page' '
+	wiki_reset &&
+	wiki_editpage Foo "wiki page added before the git clone" false &&
+	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_8 &&
+
+	wiki_delete_page Foo &&
+	(cd mw_dir_8 &&
+	git pull &&
+	test ! -f Foo.mw)
+'
+
+test_done
-- 
1.7.10.2.552.gaa3bb87
