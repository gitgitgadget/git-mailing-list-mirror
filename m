From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv6 2/4] t7512-status-help.sh: better advices for git status
Date: Sun,  3 Jun 2012 20:30:15 +0200
Message-ID: <1338748217-16440-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 20:30:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbFZL-0007Ip-71
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 20:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab2FCSaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 14:30:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41262 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab2FCSaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 14:30:21 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q53ILdiS012775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 20:21:40 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q53IUH8d013540;
	Sun, 3 Jun 2012 20:30:17 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q53IUHY6017053;
	Sun, 3 Jun 2012 20:30:17 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q53IUHtm017052;
	Sun, 3 Jun 2012 20:30:17 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 03 Jun 2012 20:21:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53ILdiS012775
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339352501.44701@IwmsQ0Duba8nsS/271Z8vA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199093>

The following tests include several cases in which the user needs to
run 'git status' to know his current situation, whether there're
conflicts or he's in rebase/bisect/am/ cherry-pick progress.

One of the test is about the set of the advice.statushints config key
to 'false' in .git/config.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
---
 t/t7512-status-help.sh |  303 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 303 insertions(+), 0 deletions(-)
 create mode 100755 t/t7512-status-help.sh

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
new file mode 100755
index 0000000..5f62262
--- /dev/null
+++ b/t/t7512-status-help.sh
@@ -0,0 +1,303 @@
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
+	git init git &&
+	cd git &&
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
+	git commit -m "one" &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
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
+	test_when_finished "cd ../ && rm -rf git" &&
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
+test_expect_success 'status when rebasing -i in edit mode' '
+	git init git &&
+	test_when_finished "rm -rf git fake-editor.sh" &&
+	(
+		cd git &&
+		test_commit one main.txt one &&
+		test_commit two main.txt two &&
+		test_commit three main.txt three &&
+		FAKE_LINES="1 edit 2" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 &&
+		cat >expected <<-\EOF &&
+		# Not currently on any branch.
+		# You are currently editing a commit during a rebase.
+		#   (use "git commit --amend" to amend the current commit)
+		#   (use "git rebase --continue" once you are satisfied with your changes)
+		#
+		nothing to commit (use -u to show untracked files)
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual &&
+		git rebase --abort
+	)
+'
+
+
+test_expect_success 'status in an am session: file already exists' '
+	git init git &&
+	test_when_finished "rm -rf git" &&
+	(
+		cd git &&
+		test_commit one main.txt "one  " &&
+		git format-patch -1 -oMaildir &&
+		test_must_fail git am Maildir/*.patch &&
+		cat >expected <<-\EOF &&
+		# On branch master
+		# You are in the middle of an am session.
+		#   (when you have fixed this problem run "git am --resolved")
+		#   (use "git am --skip" to skip this patch)
+		#   (use "git am --abort" to restore the original branch)
+		#
+		nothing to commit (use -u to show untracked files)
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'status in an am session: file does not exist' '
+	git init git &&
+	test_when_finished "rm -rf git" &&
+	(
+		cd git &&
+		test_commit one main.txt "one" &&
+		git rm main.txt &&
+		git commit -m "delete main.txt" &&
+		git format-patch -1 -oMaildir &&
+		test_must_fail git am Maildir/*.patch &&
+		cat >expected <<-\EOF &&
+		# On branch master
+		# You are in the middle of an am session.
+		#   (when you have fixed this problem run "git am --resolved")
+		#   (use "git am --skip" to skip this patch)
+		#   (use "git am --abort" to restore the original branch)
+		#
+		nothing to commit (use -u to show untracked files)
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'status in an am session: empty patch' '
+	git init git &&
+	test_when_finished "rm -rf git" &&
+	(
+		cd git &&
+		test_commit one one.txt "one" &&
+		test_commit two two.txt "two" &&
+		test_commit three three.txt "three" &&
+		git format-patch -3 -oMaildir &&
+		git rm one.txt two.txt three.txt &&
+		git commit -m "delete all" &&
+		echo error >Maildir/0002-two.patch &&
+		test_must_fail git am Maildir/*.patch &&
+		cat >expected <<-\EOF &&
+		# On branch master
+		# You are in the middle of an am session.
+		# The current patch is empty; run "git am --skip" to skip it.
+		#   (use "git am --abort" to restore the original branch)
+		#
+		nothing to commit (use -u to show untracked files)
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'status when bisecting' '
+	git init git &&
+	test_when_finished "rm -rf git" &&
+	(
+		cd git &&
+		test_commit one main.txt one &&
+		test_commit two main.txt two &&
+		test_commit three main.txt three &&
+		git bisect start &&
+		git bisect bad &&
+		git bisect good one &&
+		cat >expected <<-\EOF &&
+		# Not currently on any branch.
+		# You are currently bisecting.
+		#   (use "git bisect reset" to get back to the original branch)
+		#
+		nothing to commit (use -u to show untracked files)
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'status when rebase conflicts with statushints disabled' '
+	git init git &&
+	test_when_finished "rm -rf git" &&
+	(
+		cd git &&
+		git config --local advice.statushints false &&
+		test_commit one main.txt one &&
+		test_commit two main.txt two &&
+		test_commit three main.txt three &&
+		test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+		cat >expected <<-\EOF &&
+		# Not currently on any branch.
+		# You are currently rebasing.
+		#
+		# Unmerged paths:
+		#	both modified:      main.txt
+		#
+		no changes added to commit
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'status when cherry-picking before resolving conflicts' '
+	git init git &&
+	cd git &&
+	test_commit init main.txt init &&
+	git checkout -b second_branch &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	git checkout master &&
+	test_must_fail git cherry-pick two &&
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
+	test_when_finished "cd ../ && rm -rf git"
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
