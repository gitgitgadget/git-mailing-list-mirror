From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Thu, 05 Sep 2013 14:35:34 +0200
Message-ID: <vpqioyfwind.fsf@anie.imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 14:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHYpE-0004bN-N3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 14:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762384Ab3IEMiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 08:38:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49024 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756066Ab3IEMiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 08:38:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r85CZX8d018250
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 14:35:33 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHYmd-0000NB-3n; Thu, 05 Sep 2013 14:35:35 +0200
In-Reply-To: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 5 Sep 2013 11:50:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Sep 2013 14:35:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r85CZX8d018250
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378989339.118@HBClNnLj0wW/TP4spZc2fg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233955>

Oops, this series forgot to update t7512-status-help.sh, which now
fails.

I'll send a reroll that updates it later (patch below).

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 31a798f..0688d58 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -25,18 +25,18 @@ test_expect_success 'prepare for conflicts' '
 
 test_expect_success 'status when conflicts unresolved' '
 	test_must_fail git merge master &&
-	cat >expected <<-\EOF &&
-	# On branch conflicts
-	# You have unmerged paths.
-	#   (fix conflicts and run "git commit")
-	#
-	# Unmerged paths:
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<\EOF &&
+On branch conflicts
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -47,17 +47,17 @@ test_expect_success 'status when conflicts resolved before commit' '
 	test_must_fail git merge master &&
 	echo one >main.txt &&
 	git add main.txt &&
-	cat >expected <<-\EOF &&
-	# On branch conflicts
-	# All conflicts fixed but you are still merging.
-	#   (use "git commit" to conclude merge)
-	#
-	# Changes to be committed:
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch conflicts
+All conflicts fixed but you are still merging.
+  (use "git commit" to conclude merge)
+
+Changes to be committed:
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -76,21 +76,21 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
-	#   (fix conflicts and then run "git rebase --continue")
-	#   (use "git rebase --skip" to skip this patch)
-	#   (use "git rebase --abort" to check out the original branch)
-	#
-	# Unmerged paths:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git reset HEAD <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -103,18 +103,18 @@ test_expect_success 'status when rebase in progress before rebase --continue' '
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	echo three >main.txt &&
 	git add main.txt &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
-	#   (all conflicts fixed: run "git rebase --continue")
-	#
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
+  (all conflicts fixed: run "git rebase --continue")
+
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -135,21 +135,21 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
-	#   (fix conflicts and then run "git rebase --continue")
-	#   (use "git rebase --skip" to skip this patch)
-	#   (use "git rebase --abort" to check out the original branch)
-	#
-	# Unmerged paths:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git reset HEAD <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -161,18 +161,18 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
-	#   (all conflicts fixed: run "git rebase --continue")
-	#
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
+  (all conflicts fixed: run "git rebase --continue")
+
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -189,14 +189,14 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -215,19 +215,19 @@ test_expect_success 'status when splitting a commit' '
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -246,14 +246,14 @@ test_expect_success 'status after editing the last commit with --amend during a
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -276,14 +276,14 @@ test_expect_success 'status: (continue first edit) second edit' '
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -298,19 +298,19 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -325,14 +325,14 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -347,14 +347,14 @@ test_expect_success 'status: (amend first edit) second edit' '
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -370,19 +370,19 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -398,14 +398,14 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -422,14 +422,14 @@ test_expect_success 'status: (split first edit) second edit' '
 	git add main.txt &&
 	git commit -m "e" &&
 	git rebase --continue &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -447,19 +447,19 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git commit --amend -m "f" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -477,14 +477,14 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git commit --amend -m "g" &&
 	git rebase --continue &&
 	git commit --amend -m "h" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -504,15 +504,15 @@ test_expect_success 'status in an am session: file already exists' '
 	test_when_finished "rm Maildir/* && git am --abort" &&
 	git format-patch -1 -oMaildir &&
 	test_must_fail git am Maildir/*.patch &&
-	cat >expected <<-\EOF &&
-	# On branch am_already_exists
-	# You are in the middle of an am session.
-	#   (fix conflicts and then run "git am --continue")
-	#   (use "git am --skip" to skip this patch)
-	#   (use "git am --abort" to restore the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch am_already_exists
+You are in the middle of an am session.
+  (fix conflicts and then run "git am --continue")
+  (use "git am --skip" to skip this patch)
+  (use "git am --abort" to restore the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -526,15 +526,15 @@ test_expect_success 'status in an am session: file does not exist' '
 	test_when_finished "rm Maildir/* && git am --abort" &&
 	git format-patch -1 -oMaildir &&
 	test_must_fail git am Maildir/*.patch &&
-	cat >expected <<-\EOF &&
-	# On branch am_not_exists
-	# You are in the middle of an am session.
-	#   (fix conflicts and then run "git am --continue")
-	#   (use "git am --skip" to skip this patch)
-	#   (use "git am --abort" to restore the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch am_not_exists
+You are in the middle of an am session.
+  (fix conflicts and then run "git am --continue")
+  (use "git am --skip" to skip this patch)
+  (use "git am --abort" to restore the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -549,15 +549,15 @@ test_expect_success 'status in an am session: empty patch' '
 	git commit -m "delete all am_empty" &&
 	echo error >Maildir/0002-two_am.patch &&
 	test_must_fail git am Maildir/*.patch &&
-	cat >expected <<-\EOF &&
-	# On branch am_empty
-	# You are in the middle of an am session.
-	# The current patch is empty.
-	#   (use "git am --skip" to skip this patch)
-	#   (use "git am --abort" to restore the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch am_empty
+You are in the middle of an am session.
+The current patch is empty.
+  (use "git am --skip" to skip this patch)
+  (use "git am --abort" to restore the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -574,13 +574,13 @@ test_expect_success 'status when bisecting' '
 	git bisect bad &&
 	git bisect good one_bisect &&
 	TGT=$(git rev-parse --short two_bisect) &&
-	cat >expected <<-EOF &&
-	# HEAD detached at $TGT
-	# You are currently bisecting, started from branch '\''bisect'\''.
-	#   (use "git bisect reset" to get back to the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+HEAD detached at $TGT
+You are currently bisecting, started from branch '\''bisect'\''.
+  (use "git bisect reset" to get back to the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -597,15 +597,15 @@ test_expect_success 'status when rebase conflicts with statushints disabled' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
-	#
-	# Unmerged paths:
-	#	both modified:      main.txt
-	#
-	no changes added to commit
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
+
+Unmerged paths:
+	both modified:      main.txt
+
+no changes added to commit
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -626,19 +626,19 @@ test_expect_success 'prepare for cherry-pick conflicts' '
 test_expect_success 'status when cherry-picking before resolving conflicts' '
 	test_when_finished "git cherry-pick --abort" &&
 	test_must_fail git cherry-pick cherry_branch_second &&
-	cat >expected <<-\EOF &&
-	# On branch cherry_branch
-	# You are currently cherry-picking.
-	#   (fix conflicts and run "git cherry-pick --continue")
-	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
-	#
-	# Unmerged paths:
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<\EOF &&
+On branch cherry_branch
+You are currently cherry-picking.
+  (fix conflicts and run "git cherry-pick --continue")
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -650,18 +650,18 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 	test_must_fail git cherry-pick cherry_branch_second &&
 	echo end >main.txt &&
 	git add main.txt &&
-	cat >expected <<-\EOF &&
-	# On branch cherry_branch
-	# You are currently cherry-picking.
-	#   (all conflicts fixed: run "git cherry-pick --continue")
-	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
-	#
-	# Changes to be committed:
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch cherry_branch
+You are currently cherry-picking.
+  (all conflicts fixed: run "git cherry-pick --continue")
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+Changes to be committed:
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -669,18 +669,18 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
-	cat >expected <<-\EOF
-	# HEAD detached at atag
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF
+HEAD detached at atag
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual &&
 
 	git reset --hard HEAD^ &&
-	cat >expected <<-\EOF
-	# HEAD detached from atag
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF
+HEAD detached from atag
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -695,20 +695,20 @@ test_expect_success 'status while reverting commit (conflicts)' '
 	test_commit new to-revert.txt &&
 	TO_REVERT=$(git rev-parse --short HEAD^) &&
 	test_must_fail git revert $TO_REVERT &&
-	cat >expected <<-EOF
-	# On branch master
-	# You are currently reverting commit $TO_REVERT.
-	#   (fix conflicts and run "git revert --continue")
-	#   (use "git revert --abort" to cancel the revert operation)
-	#
-	# Unmerged paths:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      to-revert.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF
+On branch master
+You are currently reverting commit $TO_REVERT.
+  (fix conflicts and run "git revert --continue")
+  (use "git revert --abort" to cancel the revert operation)
+
+Unmerged paths:
+  (use "git reset HEAD <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      to-revert.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -716,29 +716,29 @@ test_expect_success 'status while reverting commit (conflicts)' '
 test_expect_success 'status while reverting commit (conflicts resolved)' '
 	echo reverted >to-revert.txt &&
 	git add to-revert.txt &&
-	cat >expected <<-EOF
-	# On branch master
-	# You are currently reverting commit $TO_REVERT.
-	#   (all conflicts fixed: run "git revert --continue")
-	#   (use "git revert --abort" to cancel the revert operation)
-	#
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	modified:   to-revert.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<EOF
+On branch master
+You are currently reverting commit $TO_REVERT.
+  (all conflicts fixed: run "git revert --continue")
+  (use "git revert --abort" to cancel the revert operation)
+
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   to-revert.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
 
 test_expect_success 'status after reverting commit' '
 	git revert --continue &&
-	cat >expected <<-\EOF
-	# On branch master
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF
+On branch master
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
