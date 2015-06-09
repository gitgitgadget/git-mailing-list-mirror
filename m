From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/4] status: differentiate interactive from non-interactive rebases
Date: Tue,  9 Jun 2015 16:42:40 +0200
Message-ID: <1433860962-13222-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 16:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Kjx-0004Oe-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbbFIOmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 10:42:53 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:54801 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932470AbbFIOmu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 10:42:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 404D048866;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hf3B1q-z8UzA; Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 261CD48800;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 23A1020E2;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9+C6XePISzu; Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-028068.grenet.fr [130.190.28.68])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 0BCBF20DC;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.ga3499d3
In-Reply-To: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271185>

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---
 t/t7512-status-help.sh | 28 ++++++++++++++--------------
 wt-status.c            |  5 ++++-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 68ad2d7..190656d 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -136,7 +136,7 @@ test_expect_success 'status during rebase -i when c=
onflicts unresolved' '
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
   (use "git rebase --skip" to skip this patch)
@@ -162,7 +162,7 @@ test_expect_success 'status during rebase -i after =
resolving conflicts' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
=20
@@ -190,7 +190,7 @@ test_expect_success 'status when rebasing -i in edi=
t mode' '
 	ONTO=3D$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''rebase_i_=
edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -216,7 +216,7 @@ test_expect_success 'status when splitting a commit=
' '
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''split_c=
ommit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -247,7 +247,7 @@ test_expect_success 'status after editing the last =
commit with --amend during a
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''amend_las=
t'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -277,7 +277,7 @@ test_expect_success 'status: (continue first edit) =
second edit' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -299,7 +299,7 @@ test_expect_success 'status: (continue first edit) =
second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -326,7 +326,7 @@ test_expect_success 'status: (continue first edit) =
second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -348,7 +348,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit' '
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -371,7 +371,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -399,7 +399,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -423,7 +423,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -448,7 +448,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -478,7 +478,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
diff --git a/wt-status.c b/wt-status.c
index c239132..2339000 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1326,7 +1326,10 @@ void wt_status_print(struct wt_status *s)
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
 			if (state.rebase_in_progress || state.rebase_interactive_in_progres=
s) {
-				on_what =3D _("rebase in progress; onto ");
+				if (state.rebase_interactive_in_progress)
+					on_what =3D _("interactive rebase in progress; onto ");
+				else
+					on_what =3D _("rebase in progress; onto ");
 				branch_name =3D state.onto;
 			} else if (state.detached_from) {
 				branch_name =3D state.detached_from;
--=20
2.4.2.342.ga3499d3
