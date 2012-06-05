From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Tue,  5 Jun 2012 15:25:56 +0200
Message-ID: <1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr>
 <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, Simon.Perrat@ensimag.imag.fr,
	peff@peff.net, gitster@pobox.com,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 15:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbtmD-0004Zt-UI
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 15:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090Ab2FEN0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 09:26:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43732 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933964Ab2FEN0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 09:26:15 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55DHOsn014318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 15:17:24 +0200
Received: from Hithlum.grenet.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q55DPvHf027034;
	Tue, 5 Jun 2012 15:26:00 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 15:17:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55DHOsn014318
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339507048.41818@SoJ9Mi7dN1KUHH+sO4WdPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199241>

From: Charles Roussel <charles.roussel@ensimag.fr>

Those scripts test the functions of git-remote-mediawiki.
t9360: test cases for git clone. Including tests of cloning just a category, just a precise set of page and a classical use of clone on the whole wiki.
In addition, this file provide now some fonction du manipulate sections on wiki.
We can now create a page or edit it, to put it in a given category of the wiki.
t9361: test cases for git pull (add page, edit page, delete page) and git push (add file, edit file, delete file).

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 t/t9360-git-mediawiki.sh | 265 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t9361-git-mediawiki.sh | 213 +++++++++++++++++++++++++++++++++++++
 2 files changed, 478 insertions(+)
 create mode 100755 t/t9360-git-mediawiki.sh
 create mode 100755 t/t9361-git-mediawiki.sh

diff --git a/t/t9360-git-mediawiki.sh b/t/t9360-git-mediawiki.sh
new file mode 100755
index 0000000..c13d63b
--- /dev/null
+++ b/t/t9360-git-mediawiki.sh
@@ -0,0 +1,265 @@
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
+test_description='Test the Git Mediawiki remote helper: git clone'
+
+. ./test-gitmw-lib.sh
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping gateway git-mw tests, '\
+		'perl not available'
+	test_done
+fi
+
+if [ ! -f /$GIT_BUILD_DIR/git-remote-mediawiki ];
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
+# clone a empty wiki and check that the repository contains only Main_Page.mw
+test_expect_success 'git clone only create  Main_Page.mw with an empty wiki' '
+        wiki_reset &&
+        git clone mediawiki::http://localhost/wiki mw_dir &&
+        test_expect_code 0 ls mw_dir | wc -l | grep 1 &&
+        test_expect_code 0 test -e mw_dir/Main_Page.mw &&
+        rm -rf mw_dir
+'          
+
+# clone a wiki where a page has been added and then deleted
+# check that the page no longer exists
+test_expect_success 'git clone only create Main_Page.mw with a wiki with no other pages ' '
+        wiki_reset &&
+        wiki_editpage foo "this page must be delete before the clone" false &&
+        wiki_delete_page foo &&
+        git clone mediawiki::http://localhost/wiki mw_dir &&
+        test `ls mw_dir | wc -l` -eq 1 &&
+        test -e mw_dir/Main_Page.mw &&
+        test ! -e mw_dir/Foo.mw &&
+        rm -rf mw_dir
+'
+
+# clone a wiki with a new page on it
+# check that the file corresponding to the page is in the repository
+test_expect_success 'git clone works with page added' '
+	wiki_reset &&
+	wiki_editpage foo " I will be cloned" false &&
+	wiki_editpage bar "I will be cloned" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page &&
+	git_diff_directories mw_dir ref_page &&
+	wiki_delete_page foo &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_delete_page bar
+'
+
+
+# clone a wiki after a page has been added then edited once
+# check that the content is correct
+test_expect_success 'git clone works with an edited page ' '
+        wiki_reset &&
+        wiki_editpage foo "this page will be edited" false &&
+        wiki_editpage foo "this page has been edited and must be on the clone " false &&
+        git clone mediawiki::http://localhost/wiki mw_dir &&
+        test -e mw_dir/Foo.mw &&
+        test -e mw_dir/Main_Page.mw &&
+        wiki_getallpage mw_dir/page_ref &&
+        git_diff_directories mw_dir mw_dir/page_ref &&
+        rm -rf mw_dir
+'          
+
+# clone a wiki with several pages where some were delete
+test_expect_success 'git clone works with several pages and some deleted ' '
+        wiki_reset &&
+        wiki_editpage foo "this page will not be deleted" false &&
+        wiki_editpage bar "I must not be erased" false &&
+        wiki_editpage namnam "I will not be there at the end" false &&
+        wiki_editpage nyancat "nyan nyan nyan delete me" false &&
+        wiki_delete_page namnam &&
+        wiki_delete_page nyancat &&
+        git clone mediawiki::http://localhost/wiki mw_dir &&
+        test -e mw_dir/Foo.mw &&
+        test -e mw_dir/Bar.mw &&
+        test ! -e mw_dir/Namnam.mw &&
+        test ! -e mw_dir/Nyancat.mw &&
+        wiki_getallpage mw_dir/page_ref &&
+        git_diff_directories mw_dir mw_dir/page_ref &&
+        rm -rf mw_dir
+'          
+
+
+
+
+# clone only one page of the wiki
+# check that it is the only page cloned
+# check that the page and the clone a identical
+test_expect_success 'git clone works one specific page cloned ' '
+        wiki_reset &&
+        wiki_editpage foo "I will not be cloned" false &&
+        wiki_editpage bar "Do not clone me" false &&
+        wiki_editpage namnam "I will be cloned :)" false &&
+        wiki_editpage nyancat "nyan nyan nyan you cant clone me" false &&
+        git clone -c remote.origin.pages=namnam mediawiki::http://localhost/wiki mw_dir &&
+        test `ls mw_dir | wc -l` -eq 1 &&
+        test -e mw_dir/Namnam.mw &&
+        test ! -e mw_dir/Main_Page.mw &&
+        wiki_check_content mw_dir/Namnam.mw Namnam &&
+        rm -rf mw_dir
+'   
+
+
+# clone multiple specific pages of the wiki
+# check that there are the only page cloned
+# check that the pages and the clone a identical
+test_expect_success 'git clone works multiple specific page cloned ' '
+        wiki_reset &&
+        wiki_editpage foo "I will be there" false &&
+        wiki_editpage bar "I will not disapear" false &&
+        wiki_editpage namnam "I be erased" false &&
+        wiki_editpage nyancat "nyan nyan nyan you will not erase me" false &&
+        wiki_delete_page namnam &&
+        git clone -c remote.origin.pages='"'foo bar nyancat namnam'"' mediawiki::http://localhost/wiki mw_dir &&
+        test `ls mw_dir | wc -l` -eq 3 &&
+        test ! -e mw_dir/Namnam.mw &&
+        test -e mw_dir/Foo.mw &&
+        test -e mw_dir/Nyancat.mw &&
+        test -e mw_dir/Bar.mw &&
+        wiki_check_content mw_dir/Foo.mw Foo &&
+        wiki_check_content mw_dir/Bar.mw Bar &&
+        wiki_check_content mw_dir/Nyancat.mw Nyancat &&
+        rm -rf mw_dir
+'  
+
+# Tests that cloning some specific pages from a larger wiki works properly
+test_expect_success 'mediawiki-clone of several specific pages on wiki' '
+	wiki_reset &&
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
+	git_diff_directories mw_dir_spage ref_page &&
+	rm -rf mw_dir_spage &&
+	rm -rf ref_page
+'
+
+
+# use git clone with the shallow option
+# check that only the last revisions are cloned
+# i.e the log only contains 1 commit per page
+test_expect_success 'git clone works with the shallow option' '
+        wiki_reset &&
+        wiki_editpage foo "1st revision, should be cloned" &&
+        wiki_editpage bar "1st revision, should be cloned" &&
+        wiki_editpage nyan "1st revision, should not be cloned" &&
+        wiki_editpage nyan "2nd revision, should be cloned" &&
+        git -c remote.origin.shallow=true clone mediawiki::http://localhost/wiki/ mw_dir &&
+        test `ls mw_dir | wc -l` -eq 4 &&
+        test -e mw_dir/Nyan.mw &&
+        test -e mw_dir/Foo.mw &&
+        test -e mw_dir/Bar.mw &&
+        test -e mw_dir/Main_Page.mw &&
+        cd mw_dir &&
+        test `git log --oneline Nyan.mw | wc -l` -eq 1 &&
+        test `git log --oneline Foo.mw | wc -l` -eq 1 &&
+        test `git log --oneline Bar.mw | wc -l` -eq 1 &&
+        test `git log --oneline Main_Page.mw | wc -l ` -eq 1 &&
+        cd .. &&
+        wiki_check_content mw_dir/Nyan.mw Nyan &&
+        wiki_check_content mw_dir/Foo.mw Foo &&
+        wiki_check_content mw_dir/Bar.mw Bar &&
+        wiki_check_content mw_dir/Main_Page.mw Main_Page &&
+        rm -rf mw_dir
+'
+
+# use git clone with the shallow option
+# check that only the last revisions are cloned
+# i.e the log only contains 1 commit per page
+# in this case we have a delete page
+test_expect_success 'git clone works with the shallow option with a delete page' '
+        wiki_reset &&
+        wiki_editpage foo "1st revision, will be deleted" &&
+        wiki_editpage bar "1st revision, should be cloned" &&
+        wiki_editpage nyan "1st revision, should not be cloned" &&
+        wiki_editpage nyan "2nd revision, should be cloned" &&
+        wiki_delete_page foo &&
+        git -c remote.origin.shallow=true clone mediawiki::http://localhost/wiki/ mw_dir &&
+        test `ls mw_dir | wc -l` -eq 3 &&
+        test -e mw_dir/Nyan.mw &&
+        test ! -e mw_dir/Foo.mw &&
+        test -e mw_dir/Bar.mw &&
+        test -e mw_dir/Main_Page.mw &&
+        cd mw_dir &&
+        test `git log --oneline Nyan.mw | wc -l` -eq 1 &&
+        test `git log --oneline Bar.mw | wc -l` -eq 1 &&
+        test `git log --oneline Main_Page.mw | wc -l ` -eq 1 &&
+        cd .. &&
+        wiki_check_content mw_dir/Nyan.mw Nyan &&
+        wiki_check_content mw_dir/Bar.mw Bar &&
+        wiki_check_content mw_dir/Main_Page.mw Main_Page &&
+        rm -rf mw_dir
+'
+
+
+# clone a category
+# check that only this category has been cloned
+test_expect_success 'test of fetching a category' '
+	wiki_reset &&
+	wiki_editpage Foo "I will be cloned" false Category &&
+	wiki_editpage Bar "Meet me on the repository" false Category &&
+	wiki_editpage Dummy "I will not come" false &&
+	wiki_editpage BarWrong "I will stay online only" false NotCategory &&
+	git clone -c remote.origin.categories="Category" mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page Category &&
+	git_diff_directories mw_dir ref_page
+        rm -rf mw_dir &&
+        rm -rf ref_page
+'
+
+# Test of cloning a category on wiki. 
+# This category has been previously edited in some ways
+# like edition of a given page and deletion of another.
+test_expect_success 'test of resistance to modification of category on wiki for clone' '
+	wiki_reset &&
+	wiki_editpage Tobedeleted "this page will be deleted" false Catone &&
+	wiki_editpage Tobeedited "this page will be modified" false Catone &&
+	wiki_editpage Normalone "this page wont be modified and will be on git" false Catone &&
+	wiki_editpage Notconsidered "this page will not appears on local" false &&
+	wiki_editpage Othercategory "this page will not appears on local" false Cattwo &&
+	wiki_editpage Tobeedited "this page have been modified" true Catone &&
+	wiki_delete_page Tobedeleted
+	git clone -c remote.origin.categories="Catone" mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page Catone &&
+	git_diff_directories mw_dir ref_page &&
+	rm -rf mw_dir &&
+	rm -rf ref_page 
+'
+
+test_done
diff --git a/t/t9361-git-mediawiki.sh b/t/t9361-git-mediawiki.sh
new file mode 100755
index 0000000..a44978c
--- /dev/null
+++ b/t/t9361-git-mediawiki.sh
@@ -0,0 +1,213 @@
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
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping gateway git-mw tests, perl not available'
+	test_done
+fi
+
+if [ ! -f /$GIT_BUILD_DIR/git-remote-mediawiki ];
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
+# Create a new file foo.mw in a freshly cloned wiki. Commit and push
+# this file and then check that all files of the repository are similar to
+# the wiki pages.
+test_expect_success 'git push works after adding a file .mw' "
+        wiki_reset &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_getallpage ref_page &&
+
+        cd mw_dir &&
+        test ! -f Foo.mw && # Foo.mw should not exist after wiki_reset &&
+        touch Foo.mw &&
+        echo \"hello world\" >> Foo.mw &&
+        git add Foo.mw &&
+        git commit -m \"Foo\" &&
+        git push &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_diff_directories mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Create a new page Foo in an empty wiki. Clone the wiki and edit
+# the file foo.mw corresponding to the page Foo. Commit and push
+# then check that all files of the repository are similar to the wiki
+# pages.
+test_expect_success 'git push works after editing a file .mw' "
+        # clone an empty wiki and add a Foo page
+        wiki_reset &&
+        wiki_editpage \"Foo\" \"page just created before the git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        cd mw_dir &&
+        echo \"new line added in the file Foo.mw\" >> Foo.mw &&
+        git commit -am \"edit file Foo.mw\" &&
+        git push &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_diff_directories mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Remove the corresponding file from the
+# repository. Check that the wiki page has been actually removed.
+test_expect_failure 'git push works after deleting a file' "
+        wiki_reset &&
+        wiki_editpage Foo \"wiki page added before git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+
+        cd mw_dir &&
+        git rm Foo.mw &&
+        git commit -am \"git rm delete the wiki page Foo.mw\" &&
+        git push &&
+        cd .. &&
+
+        rm -rf mw_dir &&
+        test ! wiki_page_exist Foo
+"
+
+# Clone an empty wiki. Add a page on the wiki and pull. Check 
+# all files of the repository are similar to the wiki pages.
+test_expect_success 'git pull works after adding a new wiki page' "
+        wiki_reset &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage Foo \"page just created after the git clone\" false &&
+
+        cd mw_dir &&
+        git pull &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_diff_directories mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Edit the page foo on the wiki and pull.
+# Check that all files of the repository are similar to the wiki pages.
+test_expect_success 'git pull works after editing a wiki page' "
+        wiki_reset &&
+        wiki_editpage Foo \"page just created before the git clone\" false &&
+        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_dir &&
+        wiki_editpage Foo \"new line added on the wiki\" true &&
+
+        cd mw_dir &&
+        git pull &&
+        cd .. &&
+
+        rm -rf ref_page &&
+        wiki_getallpage ref_page &&
+        git_diff_directories mw_dir ref_page &&
+        rm -rf ref_page &&
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Edit both the page Foo on the wiki and the file
+# Foo.mw on git, then check that merge conflict is properly coped with.
+test_expect_success 'git pull works on conflict handled by auto-merge' "
+        wiki_reset &&
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
+# The two following tests generate a merge conflict, and then handle it
+# manually
+test_expect_success 'Merge conflict expected' "
+        wiki_reset &&
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
+        git commit -m \"conflict\" &&
+        test_must_fail git pull
+"
+
+test_expect_success 'Conflict solved manually' "
+        cat Foo.mw | sed '/[<=>][^$]*/ d' > Foo.mw~ &&
+        cat Foo.mw~ > Foo.mw &&
+        git commit -am \"merge conflict\" &&
+        git push &&
+
+        cd .. &&
+        rm -rf mw_dir
+"
+
+# Clone a wiki with a page Foo. Remove the wiki page and pull.
+# Check that the corresponding file in the repository has been actually removed.
+test_expect_failure 'git pull works after deleting a wiki page' "
+        wiki_reset &&
+        wiki_editpage Foo \"wiki page added before git clone\" false &&
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
