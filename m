From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv8 2/4] t7512-status-help.sh: better advices for git status
Date: Tue,  5 Jun 2012 22:21:25 +0200
Message-ID: <1338927687-29822-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 22:21:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc0G2-0001OH-BI
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 22:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab2FEUVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 16:21:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48853 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab2FEUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 16:21:32 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q55KChVx003108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 22:12:43 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q55KLR2L029660;
	Tue, 5 Jun 2012 22:21:27 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q55KLRsx029937;
	Tue, 5 Jun 2012 22:21:27 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q55KLRdC029936;
	Tue, 5 Jun 2012 22:21:27 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Jun 2012 22:12:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55KChVx003108
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339531963.68998@scwq+6JU1v9gbdBgMg4Z9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199287>

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
The structure of the tests are changed so that they are now independant
with each other.

 t/t7512-status-help.sh |  372 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100755 t/t7512-status-help.sh

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
new file mode 100755
index 0000000..3714e8e
--- /dev/null
+++ b/t/t7512-status-help.sh
@@ -0,0 +1,372 @@
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
+test_expect_success 'prepare for conflicts' '
+	test_commit init main.txt init &&
+	git branch conflicts &&
+	test_commit on_master main.txt on_master &&
+	git checkout conflicts &&
+	test_commit on_conflicts main.txt on_conflicts
+'
+
+
+test_expect_success 'status when conflicts unresolved' '
+	test_must_fail git merge master &&
+	cat >expected <<-\EOF &&
+	# On branch conflicts
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status when conflicts resolved before commit' '
+	git reset --hard conflicts &&
+	test_must_fail git merge master &&
+	echo one >main.txt &&
+	git add main.txt &&
+	cat >expected <<-\EOF &&
+	# On branch conflicts
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'prepare for rebase conflicts' '
+	git reset --hard master &&
+	git checkout -b rebase_conflicts &&
+	test_commit one_rebase main.txt one &&
+	test_commit two_rebase main.txt two &&
+	test_commit three_rebase main.txt three
+'
+
+
+test_expect_success 'status when rebase in progress before resolving conflicts' '
+	test_when_finished "git rebase --abort" &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status when rebase in progress before rebase --continue' '
+	git reset --hard rebase_conflicts &&
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'prepare for rebase_i_conflicts' '
+	git reset --hard master &&
+	git checkout -b rebase_i_conflicts &&
+	test_commit one_unmerge main.txt one_unmerge &&
+	git branch rebase_i_conflicts_second &&
+	test_commit one_master main.txt one_master &&
+	git checkout rebase_i_conflicts_second &&
+	test_commit one_second main.txt one_second
+'
+
+
+test_expect_success 'status during rebase -i when conflicts unresolved' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i rebase_i_conflicts &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status during rebase -i after resolving conflicts' '
+	git reset --hard rebase_i_conflicts_second &&
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i rebase_i_conflicts &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status when rebasing -i in edit mode' '
+	git reset --hard master &&
+	git checkout -b rebase_i_edit &&
+	test_commit one_rebase_i main.txt one &&
+	test_commit two_rebase_i main.txt two &&
+	test_commit three_rebase_i main.txt three &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'prepare am_session' '
+	git reset --hard master &&
+	git checkout -b am_session &&
+	test_commit one_am one.txt "one" &&
+	test_commit two_am two.txt "two" &&
+	test_commit three_am three.txt "three"
+'
+
+
+test_expect_success 'status in an am session: file already exists' '
+	git checkout -b am_already_exists &&
+	test_when_finished "rm Maildir/* && git am --abort" &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expected <<-\EOF &&
+	# On branch am_already_exists
+	# You are in the middle of an am session.
+	#   (fix conflicts and then run "git am --resolved")
+	#   (use "git am --skip" to skip this patch)
+	#   (use "git am --abort" to restore the original branch)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status in an am session: file does not exist' '
+	git reset --hard am_session &&
+	git checkout -b am_not_exists &&
+	git rm three.txt &&
+	git commit -m "delete three.txt" &&
+	test_when_finished "rm Maildir/* && git am --abort" &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expected <<-\EOF &&
+	# On branch am_not_exists
+	# You are in the middle of an am session.
+	#   (fix conflicts and then run "git am --resolved")
+	#   (use "git am --skip" to skip this patch)
+	#   (use "git am --abort" to restore the original branch)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status in an am session: empty patch' '
+	git reset --hard am_session &&
+	git checkout -b am_empty &&
+	test_when_finished "rm Maildir/* && git am --abort" &&
+	git format-patch -3 -oMaildir &&
+	git rm one.txt two.txt three.txt &&
+	git commit -m "delete all am_empty" &&
+	echo error >Maildir/0002-two_am.patch &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expected <<-\EOF &&
+	# On branch am_empty
+	# You are in the middle of an am session.
+	# The current patch is empty.
+	#   (use "git am --skip" to skip this patch)
+	#   (use "git am --abort" to restore the original branch)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status when bisecting' '
+	git reset --hard master &&
+	git checkout -b bisect &&
+	test_commit one_bisect main.txt one &&
+	test_commit two_bisect main.txt two &&
+	test_commit three_bisect main.txt three &&
+	test_when_finished "git bisect reset" &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status when rebase conflicts with statushints disabled' '
+	git reset --hard master &&
+	git checkout -b statushints_disabled &&
+	test_when_finished "git config --local advice.statushints true" &&
+	git config --local advice.statushints false &&
+	test_commit one_statushints main.txt one &&
+	test_commit two_statushints main.txt two &&
+	test_commit three_statushints main.txt three &&
+	test_when_finished "git rebase --abort" &&
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'prepare for cherry-pick conflicts' '
+	git reset --hard master &&
+	git checkout -b cherry_branch &&
+	test_commit one_cherry main.txt one &&
+	test_commit two_cherries main.txt two &&
+	git checkout -b cherry_branch_second &&
+	test_commit second_cherry main.txt second &&
+	git checkout cherry_branch &&
+	test_commit three_cherries main.txt three
+'
+
+
+test_expect_success 'status when cherry-picking before resolving conflicts' '
+	test_when_finished "git cherry-pick --abort" &&
+	test_must_fail git cherry-pick cherry_branch_second &&
+	cat >expected <<-\EOF &&
+	# On branch cherry_branch
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
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status when cherry-picking after resolving conflicts' '
+	git reset --hard cherry_branch &&
+	test_when_finished "git cherry-pick --abort" &&
+	test_must_fail git cherry-pick cherry_branch_second &&
+	echo end >main.txt &&
+	git add main.txt &&
+	cat >expected <<-\EOF &&
+	# On branch cherry_branch
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
+	test_i18ncmp expected actual
+'
+
+
+test_done
-- 
1.7.8
