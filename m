From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCHv3 3/6] Test file for git-remote-mediawiki clone
Date: Mon, 11 Jun 2012 22:28:43 +0200
Message-ID: <1339446526-22397-3-git-send-email-simon.cathebras@ensimag.imag.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 11 22:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBF1-0007dt-OR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2FKU30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:29:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42515 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032Ab2FKU3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:29:25 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BKK73t010812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 22:20:07 +0200
Received: from Hithlum.crous-grenoble.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BKSkIV022262;
	Mon, 11 Jun 2012 22:29:08 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 22:20:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BKK73t010812
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340050810.67558@cyenK5XCtSoDWIgedh28Gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199722>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

This patch provides some tests for the clone in use by
git-remote-mediawiki.
These tests are in the file:
git/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 324 +++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh

diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
new file mode 100755
index 0000000..2b3df3f
--- /dev/null
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -0,0 +1,324 @@
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
+
+test_description='Test the Git Mediawiki remote helper: git clone'
+
+. ./test-gitmw-lib.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+TRASH_DIR="$CURR_DIR/trash\ directory.$(basename $0 .sh)"
+
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping gateway git-mw tests, '\
+		'perl not available'
+	test_done
+fi
+
+if [ ! -f $GIT_BUILD_DIR/git-remote-mediawiki ];
+then
+	skip_all='skipping gateway git-mw tests,' \
+		' no remote mediawiki for git found'
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
+# 1
+test_expect_success 'Git clone creates the git log expected with one file' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "this is not important" false -c cat -s "this must be the same" &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	git log --format=%s HEAD^..HEAD > log.tmp &&
+	echo "this must be the same" > msg.tmp &&
+	diff -b log.tmp msg.tmp &&
+	cd .. &&
+	rm -rf mw_dir
+'
+
+# 2
+test_expect_success 'Git clone creates the git log expected with multiple files' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage daddy "this is not important" false -s="this must be the same" &&
+	wiki_editpage daddy "neither is this" true -s="this must also be the same" &&
+	wiki_editpage daddy "neither is this" true -s="same same same" &&
+	wiki_editpage dj "dont care" false -s="identical" &&
+	wiki_editpage dj "dont care either" true -s="identical too" &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	git log --format=%s Daddy.mw  > logDaddy.tmp &&
+	git log --format=%s Dj.mw > logDj.tmp &&
+	echo "same same same" > msgDaddy.tmp &&
+	echo "this must also be the same" >> msgDaddy.tmp &&
+	echo "this must be the same" >> msgDaddy.tmp &&
+	echo "identical too" > msgDj.tmp &&
+	echo "identical" >> msgDj.tmp &&
+	diff -b logDaddy.tmp msgDaddy.tmp &&
+	diff -b logDj.tmp msgDj.tmp &&
+	cd .. &&
+	rm -rf mw_dir
+'
+
+# 3
+test_expect_success 'Git clone creates only Main_Page.mw with an empty wiki' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test_contains_N_files mw_dir 1 &&
+	test -e mw_dir/Main_Page.mw &&
+	rm -rf mw_dir
+'
+
+# 4
+test_expect_success 'Git clone does not fetch a deleted page' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "this page must be deleted before the clone" false &&
+	wiki_delete_page foo &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test_contains_N_files mw_dir 1 &&
+	test -e mw_dir/Main_Page.mw &&
+	test ! -e mw_dir/Foo.mw &&
+	rm -rf mw_dir
+'
+
+# 5
+test_expect_success 'Git clone works with page added' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo " I will be cloned" false &&
+	wiki_editpage bar "I will be cloned" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page &&
+	wiki_delete_page foo &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_delete_page bar
+'
+
+# 6
+test_expect_success 'Git clone works with an edited page ' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+
+	wiki_editpage foo "this page will be edited" \
+		false -s "first edition of page foo"&&
+	wiki_editpage foo "this page has been edited and must be on the clone " true &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test -e mw_dir/Foo.mw &&
+	test -e mw_dir/Main_Page.mw &&
+	wiki_getallpage mw_dir/page_ref &&
+	test_diff_directories mw_dir mw_dir/page_ref &&
+	cd mw_dir &&
+	git log --format=%s HEAD^ Foo.mw > ../Foo.log &&
+	cd .. &&
+	echo "first edition of page foo" > FooExpect.log &&
+	rm -rf mw_dir &&
+	diff FooExpect.log Foo.log
+'
+
+# 7
+test_expect_success 'Git clone works with several pages and some deleted ' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "this page will not be deleted" false &&
+	wiki_editpage bar "I must not be erased" false &&
+	wiki_editpage namnam "I will not be there at the end" false &&
+	wiki_editpage nyancat "nyan nyan nyan delete me" false &&
+	wiki_delete_page namnam &&
+	wiki_delete_page nyancat &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test -e mw_dir/Foo.mw &&
+	test -e mw_dir/Bar.mw &&
+	test ! -e mw_dir/Namnam.mw &&
+	test ! -e mw_dir/Nyancat.mw &&
+	wiki_getallpage mw_dir/page_ref &&
+	test_diff_directories mw_dir mw_dir/page_ref &&
+	rm -rf mw_dir
+'
+
+# 8
+test_expect_success 'Git clone works with one specific page cloned ' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "I will not be cloned" false &&
+	wiki_editpage bar "Do not clone me" false &&
+	wiki_editpage namnam "I will be cloned :)" false  -s="this log must stay" &&
+	wiki_editpage nyancat "nyan nyan nyan you cant clone me" false &&
+	git clone -c remote.origin.pages=namnam mediawiki::http://localhost/wiki mw_dir &&
+	test_contains_N_files mw_dir 1 &&
+	test -e mw_dir/Namnam.mw &&
+	test ! -e mw_dir/Main_Page.mw &&
+	cd mw_dir &&
+	echo "this log must stay" > msg.tmp &&
+	git log --format=%s > log.tmp &&
+	diff -b msg.tmp log.tmp &&
+	cd .. &&
+	wiki_check_content mw_dir/Namnam.mw Namnam &&
+	rm -rf mw_dir
+'
+
+# 9
+test_expect_success 'Git clone works with multiple specific page cloned ' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "I will be there" false &&
+	wiki_editpage bar "I will not disapear" false &&
+	wiki_editpage namnam "I be erased" false &&
+	wiki_editpage nyancat "nyan nyan nyan you will not erase me" false &&
+	wiki_delete_page namnam &&
+	git clone -c remote.origin.pages='"'foo bar nyancat namnam'"' mediawiki::http://localhost/wiki mw_dir &&
+	test_contains_N_files mw_dir 3 &&
+	test ! -e mw_dir/Namnam.mw &&
+	test -e mw_dir/Foo.mw &&
+	test -e mw_dir/Nyancat.mw &&
+	test -e mw_dir/Bar.mw &&
+	wiki_check_content mw_dir/Foo.mw Foo &&
+	wiki_check_content mw_dir/Bar.mw Bar &&
+	wiki_check_content mw_dir/Nyancat.mw Nyancat &&
+	rm -rf mw_dir
+'  
+
+# 10
+test_expect_success 'Mediawiki-clone of several specific pages on wiki' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "foo 1" false &&
+	wiki_editpage bar "bar 1" false &&
+	wiki_editpage dummy "dummy 1" false &&
+	wiki_editpage cloned_1 "cloned_1 1" false &&
+	wiki_editpage cloned_2 "cloned_2 2" false &&
+	wiki_editpage cloned_3 "cloned_3 3" false &&
+	mkdir -p ref_page &&
+	wiki_getpage cloned_1 ref_page &&
+	wiki_getpage cloned_2 ref_page &&
+	wiki_getpage cloned_3 ref_page &&
+	git clone -c remote.origin.pages="cloned_1 cloned_2 cloned_3" mediawiki::http://localhost/wiki mw_dir_spage &&
+	test_diff_directories mw_dir_spage ref_page &&
+	rm -rf mw_dir_spage &&
+	rm -rf ref_page
+'
+
+# 11
+test_expect_success 'Git clone works with the shallow option' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir_s_page &&
+	rm -rf ref_page &&
+	wiki_editpage foo "1st revision, should be cloned" false &&
+	wiki_editpage bar "1st revision, should be cloned" false &&
+	wiki_editpage nyan "1st revision, should not be cloned" false &&
+	wiki_editpage nyan "2nd revision, should be cloned" false &&
+	git -c remote.origin.shallow=true clone mediawiki::http://localhost/wiki/ mw_dir &&
+	test_contains_N_files mw_dir 4 &&
+	test -e mw_dir/Nyan.mw &&
+	test -e mw_dir/Foo.mw &&
+	test -e mw_dir/Bar.mw &&
+	test -e mw_dir/Main_Page.mw &&
+	cd mw_dir &&
+	test `git log --oneline Nyan.mw | wc -l` -eq 1 &&
+	test `git log --oneline Foo.mw | wc -l` -eq 1 &&
+	test `git log --oneline Bar.mw | wc -l` -eq 1 &&
+	test `git log --oneline Main_Page.mw | wc -l ` -eq 1 &&
+	cd .. &&
+	wiki_check_content mw_dir/Nyan.mw Nyan &&
+	wiki_check_content mw_dir/Foo.mw Foo &&
+	wiki_check_content mw_dir/Bar.mw Bar &&
+	wiki_check_content mw_dir/Main_Page.mw Main_Page &&
+	rm -rf mw_dir
+'
+
+# 12
+test_expect_success 'Git clone works with the shallow option with a delete page' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage foo "1st revision, will be deleted" false &&
+	wiki_editpage bar "1st revision, should be cloned" false &&
+	wiki_editpage nyan "1st revision, should not be cloned" false &&
+	wiki_editpage nyan "2nd revision, should be cloned" false &&
+	wiki_delete_page foo &&
+	git -c remote.origin.shallow=true clone mediawiki::http://localhost/wiki/ mw_dir &&
+	test_contains_N_files mw_dir 3 &&
+	test -e mw_dir/Nyan.mw &&
+	test ! -e mw_dir/Foo.mw &&
+	test -e mw_dir/Bar.mw &&
+	test -e mw_dir/Main_Page.mw &&
+	cd mw_dir &&
+	test `git log --oneline Nyan.mw | wc -l` -eq 1 &&
+	test `git log --oneline Bar.mw | wc -l` -eq 1 &&
+	test `git log --oneline Main_Page.mw | wc -l ` -eq 1 &&
+	cd .. &&
+	wiki_check_content mw_dir/Nyan.mw Nyan &&
+	wiki_check_content mw_dir/Bar.mw Bar &&
+	wiki_check_content mw_dir/Main_Page.mw Main_Page &&
+	rm -rf mw_dir
+'
+
+# 13
+test_expect_success 'Test of fetching a category' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage Foo "I will be cloned" false -c=Category &&
+	wiki_editpage Bar "Meet me on the repository" false -c=Category &&
+	wiki_editpage Dummy "I will not come" false &&
+	wiki_editpage BarWrong "I will stay online only" false -c=NotCategory &&
+	git clone -c remote.origin.categories="Category" mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page Category &&
+	test_diff_directories mw_dir ref_page
+	rm -rf mw_dir &&
+	rm -rf ref_page
+'
+
+# 14
+test_expect_success 'Test of resistance to modification of category on wiki for clone' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage Tobedeleted "this page will be deleted" false -c=Catone &&
+	wiki_editpage Tobeedited "this page will be modified" false -c=Catone &&
+	wiki_editpage Normalone "this page wont be modified and will be on git" false -c=Catone &&
+	wiki_editpage Notconsidered "this page will not appear on local" false &&
+	wiki_editpage Othercategory "this page will not appear on local" false -c=Cattwo &&
+	wiki_editpage Tobeedited "this page have been modified" true -c=Catone &&
+	wiki_delete_page Tobedeleted
+	git clone -c remote.origin.categories="Catone" mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page Catone &&
+	test_diff_directories mw_dir ref_page &&
+	rm -rf mw_dir &&
+	rm -rf ref_page 
+'
+
+test_done
-- 
1.7.10.2.552.gaa3bb87
