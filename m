From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/4] status: differentiate interactive from non-interactive rebases
Date: Thu,  4 Jun 2015 00:00:23 +0200
Message-ID: <1433368825-24617-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 00:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0GiQ-00030K-5k
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 00:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbbFCWAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 18:00:44 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:38666 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753381AbbFCWAj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 18:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9593C27EF;
	Thu,  4 Jun 2015 00:00:36 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OhKDlMkasuYT; Thu,  4 Jun 2015 00:00:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 837C027E9;
	Thu,  4 Jun 2015 00:00:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7D79E20E4;
	Thu,  4 Jun 2015 00:00:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1N2s6b714ngt; Thu,  4 Jun 2015 00:00:36 +0200 (CEST)
Received: from localhost.localdomain (pas38-h02-176-189-96-8.dsl.sta.abo.bbox.fr [176.189.96.8])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 09DC420DF;
	Thu,  4 Jun 2015 00:00:36 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.g726a850
In-Reply-To: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270744>

---
 t/t7512-status-help.sh | 28 ++++++++++++++--------------
 wt-status.c            |  5 ++++-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 68ad2d7..190656d 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -136,7 +136,7 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
   (use "git rebase --skip" to skip this patch)
@@ -162,7 +162,7 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
 
@@ -190,7 +190,7 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	ONTO=$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -216,7 +216,7 @@ test_expect_success 'status when splitting a commit' '
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -247,7 +247,7 @@ test_expect_success 'status after editing the last commit with --amend during a
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -277,7 +277,7 @@ test_expect_success 'status: (continue first edit) second edit' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -299,7 +299,7 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -326,7 +326,7 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -348,7 +348,7 @@ test_expect_success 'status: (amend first edit) second edit' '
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -371,7 +371,7 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -399,7 +399,7 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -423,7 +423,7 @@ test_expect_success 'status: (split first edit) second edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -448,7 +448,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -478,7 +478,7 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
diff --git a/wt-status.c b/wt-status.c
index fec6e85..c83eca5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1319,7 +1319,10 @@ void wt_status_print(struct wt_status *s)
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
 			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
-				on_what = _("rebase in progress; onto ");
+				if (state.rebase_interactive_in_progress)
+					on_what = _("interactive rebase in progress; onto ");
+				else
+					on_what = _("rebase in progress; onto ");
 				branch_name = state.onto;
 			} else if (state.detached_from) {
 				branch_name = state.detached_from;
-- 
2.4.2.342.g3cebd9b
