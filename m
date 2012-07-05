From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 03/12] git-remote-mediawiki (t9360): test git-remote-mediawiki clone
Date: Thu,  5 Jul 2012 09:36:03 +0200
Message-ID: <1341473772-28023-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgcP-0000ir-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab2GEHgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:36:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58605 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab2GEHgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZTIj029143
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgc3-0006Ww-0k; Thu, 05 Jul 2012 09:36:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgc2-0007hy-VF; Thu, 05 Jul 2012 09:36:30 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Jul 2012 09:35:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZTIj029143
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078535.28609@Q/4ODN19bGtmYPW3CLUUng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201027>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 257 +++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh

diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
new file mode 100755
index 0000000..811a90c
--- /dev/null
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -0,0 +1,257 @@
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
+
+test_check_precond
+
+
+test_expect_success 'Git clone creates the expected git log with one file' '
+	wiki_reset &&
+	wiki_editpage foo "this is not important" false -c cat -s "this must be the same" &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_1 &&
+	(
+		cd mw_dir_1 &&
+		git log --format=%s HEAD^..HEAD >log.tmp
+	) &&
+	echo "this must be the same" >msg.tmp &&
+	diff -b mw_dir_1/log.tmp msg.tmp
+'
+
+
+test_expect_success 'Git clone creates the expected git log with multiple files' '
+	wiki_reset &&
+	wiki_editpage daddy "this is not important" false -s="this must be the same" &&
+	wiki_editpage daddy "neither is this" true -s="this must also be the same" &&
+	wiki_editpage daddy "neither is this" true -s="same same same" &&
+	wiki_editpage dj "dont care" false -s="identical" &&
+	wiki_editpage dj "dont care either" true -s="identical too" &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_2 &&
+	(
+		cd mw_dir_2 &&
+		git log --format=%s Daddy.mw  >logDaddy.tmp &&
+		git log --format=%s Dj.mw >logDj.tmp
+	) &&
+	echo "same same same" >msgDaddy.tmp &&
+	echo "this must also be the same" >>msgDaddy.tmp &&
+	echo "this must be the same" >>msgDaddy.tmp &&
+	echo "identical too" >msgDj.tmp &&
+	echo "identical" >>msgDj.tmp &&
+	diff -b mw_dir_2/logDaddy.tmp msgDaddy.tmp &&
+	diff -b mw_dir_2/logDj.tmp msgDj.tmp
+'
+
+
+test_expect_success 'Git clone creates only Main_Page.mw with an empty wiki' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_3 &&
+	test_contains_N_files mw_dir_3 1 &&
+	test_path_is_file mw_dir_3/Main_Page.mw
+'
+
+test_expect_success 'Git clone does not fetch a deleted page' '
+	wiki_reset &&
+	wiki_editpage foo "this page must be deleted before the clone" false &&
+	wiki_delete_page foo &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_4 &&
+	test_contains_N_files mw_dir_4 1 &&
+	test_path_is_file mw_dir_4/Main_Page.mw &&
+	test_path_is_missing mw_dir_4/Foo.mw
+'
+
+test_expect_success 'Git clone works with page added' '
+	wiki_reset &&
+	wiki_editpage foo " I will be cloned" false &&
+	wiki_editpage bar "I will be cloned" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_5 &&
+	wiki_getallpage ref_page_5 &&
+	test_diff_directories mw_dir_5 ref_page_5 &&
+	wiki_delete_page foo &&
+	wiki_delete_page bar
+'
+
+test_expect_success 'Git clone works with an edited page ' '
+	wiki_reset &&
+	wiki_editpage foo "this page will be edited" \
+		false -s "first edition of page foo"&&
+	wiki_editpage foo "this page has been edited and must be on the clone " true &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_6 &&
+	test_path_is_file mw_dir_6/Foo.mw &&
+	test_path_is_file mw_dir_6/Main_Page.mw &&
+	wiki_getallpage mw_dir_6/page_ref_6 &&
+	test_diff_directories mw_dir_6 mw_dir_6/page_ref_6 &&
+	(
+		cd mw_dir_6 &&
+		git log --format=%s HEAD^ Foo.mw > ../Foo.log
+	) &&
+	echo "first edition of page foo" > FooExpect.log &&
+	diff FooExpect.log Foo.log
+'
+
+
+test_expect_success 'Git clone works with several pages and some deleted ' '
+	wiki_reset &&
+	wiki_editpage foo "this page will not be deleted" false &&
+	wiki_editpage bar "I must not be erased" false &&
+	wiki_editpage namnam "I will not be there at the end" false &&
+	wiki_editpage nyancat "nyan nyan nyan delete me" false &&
+	wiki_delete_page namnam &&
+	wiki_delete_page nyancat &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_7 &&
+	test_path_is_file mw_dir_7/Foo.mw &&
+	test_path_is_file mw_dir_7/Bar.mw &&
+	test_path_is_missing mw_dir_7/Namnam.mw &&
+	test_path_is_missing mw_dir_7/Nyancat.mw &&
+	wiki_getallpage mw_dir_7/page_ref_7 &&
+	test_diff_directories mw_dir_7 mw_dir_7/page_ref_7
+'
+
+
+test_expect_success 'Git clone works with one specific page cloned ' '
+	wiki_reset &&
+	wiki_editpage foo "I will not be cloned" false &&
+	wiki_editpage bar "Do not clone me" false &&
+	wiki_editpage namnam "I will be cloned :)" false  -s="this log must stay" &&
+	wiki_editpage nyancat "nyan nyan nyan you cant clone me" false &&
+	git clone -c remote.origin.pages=namnam \
+		mediawiki::'"$WIKI_URL"' mw_dir_8 &&
+	test_contains_N_files mw_dir_8 1 &&
+	test_path_is_file mw_dir_8/Namnam.mw &&
+	test_path_is_missing mw_dir_8/Main_Page.mw &&
+	(
+		cd mw_dir_8 &&
+		echo "this log must stay" >msg.tmp &&
+		git log --format=%s >log.tmp &&
+		diff -b msg.tmp log.tmp
+	) &&
+	wiki_check_content mw_dir_8/Namnam.mw Namnam
+'
+
+test_expect_success 'Git clone works with multiple specific page cloned ' '
+	wiki_reset &&
+	wiki_editpage foo "I will be there" false &&
+	wiki_editpage bar "I will not disapear" false &&
+	wiki_editpage namnam "I be erased" false &&
+	wiki_editpage nyancat "nyan nyan nyan you will not erase me" false &&
+	wiki_delete_page namnam &&
+	git clone -c remote.origin.pages="foo bar nyancat namnam" \
+		mediawiki::'"$WIKI_URL"' mw_dir_9 &&
+	test_contains_N_files mw_dir_9 3 &&
+	test_path_is_missing mw_dir_9/Namnam.mw &&
+	test_path_is_file mw_dir_9/Foo.mw &&
+	test_path_is_file mw_dir_9/Nyancat.mw &&
+	test_path_is_file mw_dir_9/Bar.mw &&
+	wiki_check_content mw_dir_9/Foo.mw Foo &&
+	wiki_check_content mw_dir_9/Bar.mw Bar &&
+	wiki_check_content mw_dir_9/Nyancat.mw Nyancat
+'
+
+test_expect_success 'Mediawiki-clone of several specific pages on wiki' '
+	wiki_reset &&
+	wiki_editpage foo "foo 1" false &&
+	wiki_editpage bar "bar 1" false &&
+	wiki_editpage dummy "dummy 1" false &&
+	wiki_editpage cloned_1 "cloned_1 1" false &&
+	wiki_editpage cloned_2 "cloned_2 2" false &&
+	wiki_editpage cloned_3 "cloned_3 3" false &&
+	mkdir -p ref_page_10 &&
+	wiki_getpage cloned_1 ref_page_10 &&
+	wiki_getpage cloned_2 ref_page_10 &&
+	wiki_getpage cloned_3 ref_page_10 &&
+	git clone -c remote.origin.pages="cloned_1 cloned_2 cloned_3" \
+		mediawiki::'"$WIKI_URL"' mw_dir_10 &&
+	test_diff_directories mw_dir_10 ref_page_10
+'
+
+test_expect_success 'Git clone works with the shallow option' '
+	wiki_reset &&
+	wiki_editpage foo "1st revision, should be cloned" false &&
+	wiki_editpage bar "1st revision, should be cloned" false &&
+	wiki_editpage nyan "1st revision, should not be cloned" false &&
+	wiki_editpage nyan "2nd revision, should be cloned" false &&
+	git -c remote.origin.shallow=true clone \
+		mediawiki::'"$WIKI_URL"' mw_dir_11 &&
+	test_contains_N_files mw_dir_11 4 &&
+	test_path_is_file mw_dir_11/Nyan.mw &&
+	test_path_is_file mw_dir_11/Foo.mw &&
+	test_path_is_file mw_dir_11/Bar.mw &&
+	test_path_is_file mw_dir_11/Main_Page.mw &&
+	(
+		cd mw_dir_11 &&
+		test `git log --oneline Nyan.mw | wc -l` -eq 1 &&
+		test `git log --oneline Foo.mw | wc -l` -eq 1 &&
+		test `git log --oneline Bar.mw | wc -l` -eq 1 &&
+		test `git log --oneline Main_Page.mw | wc -l ` -eq 1
+	) &&
+	wiki_check_content mw_dir_11/Nyan.mw Nyan &&
+	wiki_check_content mw_dir_11/Foo.mw Foo &&
+	wiki_check_content mw_dir_11/Bar.mw Bar &&
+	wiki_check_content mw_dir_11/Main_Page.mw Main_Page
+'
+
+test_expect_success 'Git clone works with the shallow option with a delete page' '
+	wiki_reset &&
+	wiki_editpage foo "1st revision, will be deleted" false &&
+	wiki_editpage bar "1st revision, should be cloned" false &&
+	wiki_editpage nyan "1st revision, should not be cloned" false &&
+	wiki_editpage nyan "2nd revision, should be cloned" false &&
+	wiki_delete_page foo &&
+	git -c remote.origin.shallow=true clone \
+		mediawiki::'"$WIKI_URL"' mw_dir_12 &&
+	test_contains_N_files mw_dir_12 3 &&
+	test_path_is_file mw_dir_12/Nyan.mw &&
+	test_path_is_missing mw_dir_12/Foo.mw &&
+	test_path_is_file mw_dir_12/Bar.mw &&
+	test_path_is_file mw_dir_12/Main_Page.mw &&
+	(
+		cd mw_dir_12 &&
+		test `git log --oneline Nyan.mw | wc -l` -eq 1 &&
+		test `git log --oneline Bar.mw | wc -l` -eq 1 &&
+		test `git log --oneline Main_Page.mw | wc -l ` -eq 1
+	) &&
+	wiki_check_content mw_dir_12/Nyan.mw Nyan &&
+	wiki_check_content mw_dir_12/Bar.mw Bar &&
+	wiki_check_content mw_dir_12/Main_Page.mw Main_Page
+'
+
+test_expect_success 'Test of fetching a category' '
+	wiki_reset &&
+	wiki_editpage Foo "I will be cloned" false -c=Category &&
+	wiki_editpage Bar "Meet me on the repository" false -c=Category &&
+	wiki_editpage Dummy "I will not come" false &&
+	wiki_editpage BarWrong "I will stay online only" false -c=NotCategory &&
+	git clone -c remote.origin.categories="Category" \
+		mediawiki::'"$WIKI_URL"' mw_dir_13 &&
+	wiki_getallpage ref_page_13 Category &&
+	test_diff_directories mw_dir_13 ref_page_13
+'
+
+test_expect_success 'Test of resistance to modification of category on wiki for clone' '
+	wiki_reset &&
+	wiki_editpage Tobedeleted "this page will be deleted" false -c=Catone &&
+	wiki_editpage Tobeedited "this page will be modified" false -c=Catone &&
+	wiki_editpage Normalone "this page wont be modified and will be on git" false -c=Catone &&
+	wiki_editpage Notconsidered "this page will not appear on local" false &&
+	wiki_editpage Othercategory "this page will not appear on local" false -c=Cattwo &&
+	wiki_editpage Tobeedited "this page have been modified" true -c=Catone &&
+	wiki_delete_page Tobedeleted
+	git clone -c remote.origin.categories="Catone" \
+		mediawiki::'"$WIKI_URL"' mw_dir_14 &&
+	wiki_getallpage ref_page_14 Catone &&
+	test_diff_directories mw_dir_14 ref_page_14
+'
+
+test_done
-- 
1.7.11.1.147.g47a574d
