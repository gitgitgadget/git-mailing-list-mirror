From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv7 2/4] t7512-status-help.sh: better advices for git status
Date: Mon,  4 Jun 2012 19:19:57 +0200
Message-ID: <1338830399-31504-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:20:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbax2-0008WC-UR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab2FDRUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:20:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33902 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab2FDRUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:20:10 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54HBRhX001145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 19:11:27 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q54HK0hQ014339;
	Mon, 4 Jun 2012 19:20:00 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q54HK0Xa031621;
	Mon, 4 Jun 2012 19:20:00 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q54HK0OR031620;
	Mon, 4 Jun 2012 19:20:00 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 19:11:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54HBRhX001145
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339434688.74806@1dz0KdPosT7JxYpu8MM+Tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199153>

The following tests include several cases in which the user needs to
run 'git status' to know his current situation, whether there're
conflicts or he's in rebase/bisect/am/cherry-pick progress.

One of the test is about the set of the advice.statushints config key
to 'false' in .git/config.

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
The form of the tests has been modified.

 t/t7512-status-help.sh |  346 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100755 t/t7512-status-help.sh

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
new file mode 100755
index 0000000..53d0e05
--- /dev/null
+++ b/t/t7512-status-help.sh
@@ -0,0 +1,346 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
+#		     Thomas Nguy, Khoi Nguyen
+#		     Grenoble INP Ensimag
+#
+
+test_description='git status advices'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success 'status when conflicts unresolved' '
+	test_commit init main.txt init &&
+	git branch second_branch &&
+	test_commit on_master main.txt on_master &&
+	git checkout second_branch &&
+	test_commit on_second_branch main.txt on_second_branch &&
+	test_must_fail git merge master &&
+	cat >expected <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths.
+	#   (fix conflicts and run "git commit")
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when conflicts resolved before commit' '
+	test_when_finished "
+		git commit -m "end_merge" &&
+		git checkout master &&
+		git branch -D second_branch &&
+		echo >main.txt
+	" &&
+	echo one >main.txt &&
+	git add main.txt &&
+	cat >expected <<-\EOF &&
+	# On branch second_branch
+	# All conflicts fixed but you are still merging.
+	#   (use "git commit" to conclude merge)
+	#
+	# Changes to be committed:
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when rebase in progress before resolving conflicts' '
+	test_commit one_rebase main.txt one &&
+	test_commit two_rebase main.txt two &&
+	test_commit three_rebase main.txt three &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing.
+	#   (fix conflicts and then run "git rebase --continue")
+	#   (use "git rebase --skip" to skip this patch)
+	#   (use "git rebase --abort" to check out the original branch)
+	#
+	# Unmerged paths:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when rebase in progress before rebase --continue' '
+	test_when_finished "git rebase --abort" &&
+	echo three >main.txt &&
+	git add main.txt &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing.
+	#   (all conflicts fixed: run "git rebase --continue")
+	#
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status during rebase -i when conflicts unresolved' '
+	test_commit one_unmerge main.txt one_unmerge &&
+	git branch second_branch &&
+	test_commit one_master main.txt one_master &&
+	git checkout second_branch &&
+	test_commit one_second main.txt one_second &&
+	test_must_fail git rebase -i master &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing.
+	#   (fix conflicts and then run "git rebase --continue")
+	#   (use "git rebase --skip" to skip this patch)
+	#   (use "git rebase --abort" to check out the original branch)
+	#
+	# Unmerged paths:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status during rebase -i after resolving conflicts' '
+	test_when_finished "
+		git rebase --abort &&
+		git checkout master &&
+		git branch -D second_branch
+	" &&
+	git add main.txt &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing.
+	#   (all conflicts fixed: run "git rebase --continue")
+	#
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when rebasing -i in edit mode' '
+	test_when_finished "git rebase --abort" &&
+	test_commit one_rebase_i main.txt one &&
+	test_commit two_rebase_i main.txt two &&
+	test_commit three_rebase_i main.txt three &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	git rebase -i HEAD~2 &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status in an am session: file already exists' '
+	test_when_finished "
+		git am --abort &&
+		rm -r Maildir/
+	" &&
+	test_commit one_am main.txt "one  " &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expected <<-\EOF &&
+	# On branch master
+	# You are in the middle of an am session.
+	#   (use "git am --abort" to restore the original branch)
+	#   (use "git am --skip" to skip this patch)
+	#   (when you have fixed this problem run "git am --resolved")
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status in an am session: file does not exist' '
+	test_when_finished "
+		git am --abort &&
+		rm -r Maildir/
+	" &&
+	test_commit two_am main.txt "two" &&
+	git rm main.txt &&
+	git commit -m "delete main.txt" &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expected <<-\EOF &&
+	# On branch master
+	# You are in the middle of an am session.
+	#   (use "git am --abort" to restore the original branch)
+	#   (use "git am --skip" to skip this patch)
+	#   (when you have fixed this problem run "git am --resolved")
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status in an am session: empty patch' '
+	test_when_finished "
+		git am --abort &&
+		rm -r Maildir/
+	" &&
+	test_commit one_am_empty one.txt "one" &&
+	test_commit two_am_empty two.txt "two" &&
+	test_commit three_am_empty three.txt "three" &&
+	git format-patch -3 -oMaildir &&
+	git rm one.txt two.txt three.txt &&
+	git commit -m "delete all am_empty" &&
+	echo error >Maildir/0002-two_am_empty.patch &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expected <<-\EOF &&
+	# On branch master
+	# You are in the middle of an am session.
+	# The current patch is empty.
+	#   (use "git am --abort" to restore the original branch)
+	#   (use "git am --skip" to skip this patch)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when bisecting' '
+	test_when_finished "git bisect reset" &&
+	test_commit one_bisect main.txt one &&
+	test_commit two_bisect main.txt two &&
+	test_commit three_bisect main.txt three &&
+	git bisect start &&
+	git bisect bad &&
+	git bisect good one_bisect &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently bisecting.
+	#   (use "git bisect reset" to get back to the original branch)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when rebase conflicts with statushints disabled' '
+	test_when_finished "
+		git rebase --abort &&
+		git config --local advice.statushints true
+	" &&
+	git config --local advice.statushints false &&
+	test_commit one_statushints main.txt one &&
+	test_commit two_statushints main.txt two &&
+	test_commit three_statushints main.txt three &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing.
+	#
+	# Unmerged paths:
+	#	both modified:      main.txt
+	#
+	no changes added to commit
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'status when cherry-picking before resolving conflicts' '
+	git checkout -b cherry_branch &&
+	test_commit one_cherry main.txt one &&
+	test_commit two_cherries main.txt two &&
+	test_commit three_cherries main.txt three &&
+	git checkout master &&
+	test_must_fail git cherry-pick two_cherries &&
+	cat >expected <<-\EOF &&
+	# On branch master
+	# You are currently cherry-picking.
+	#   (fix conflicts and run "git commit")
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'status when cherry-picking after resolving conflicts' '
+	test_when_finished "
+		git cherry-pick --abort
+		git branch -D cherry_branch
+	" &&
+	echo end >main.txt &&
+	git add main.txt &&
+	cat >expected <<-\EOF &&
+	# On branch master
+	# You are currently cherry-picking.
+	#   (all conflicts fixed: run "git commit")
+	#
+	# Changes to be committed:
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
+test_done
-- 
1.7.8
