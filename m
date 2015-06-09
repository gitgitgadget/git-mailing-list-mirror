From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 1/4] status: factor two rebase-related messages together
Date: Tue,  9 Jun 2015 16:42:39 +0200
Message-ID: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Tue Jun 09 16:42:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Kjx-0004Oe-0P
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbbFIOmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 10:42:52 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:54246 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932525AbbFIOmt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 10:42:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4DA3F48861;
	Tue,  9 Jun 2015 16:42:47 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwfR39jsQLWG; Tue,  9 Jun 2015 16:42:47 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3406A48800;
	Tue,  9 Jun 2015 16:42:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 2DF5620E2;
	Tue,  9 Jun 2015 16:42:47 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjs5qKOQdkIw; Tue,  9 Jun 2015 16:42:47 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-028068.grenet.fr [130.190.28.68])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 0BA9820DC;
	Tue,  9 Jun 2015 16:42:47 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.ga3499d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271184>

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---
 wt-status.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 33452f1..c239132 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1025,6 +1025,19 @@ static int split_commit_in_progress(struct wt_st=
atus *s)
 	free(rebase_orig_head);
 	return split_in_progress;
 }
+static void print_rebase_state(struct wt_status *s,
+				struct wt_status_state *state,
+				const char *color)
+{
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently rebasing branch '%s' on '%s'."),
+					 state->branch,
+					 state->onto);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently rebasing."));
+}
=20
 static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
@@ -1033,14 +1046,7 @@ static void show_rebase_in_progress(struct wt_st=
atus *s,
 	struct stat st;
=20
 	if (has_unmerged(s)) {
-		if (state->branch)
-			status_printf_ln(s, color,
-					 _("You are currently rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
-		else
-			status_printf_ln(s, color,
-					 _("You are currently rebasing."));
+		print_rebase_state(s, state, color);
 		if (s->hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git rebase --continue\")"));
@@ -1050,14 +1056,7 @@ static void show_rebase_in_progress(struct wt_st=
atus *s,
 				_("  (use \"git rebase --abort\" to check out the original branch)=
"));
 		}
 	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), =
&st)) {
-		if (state->branch)
-			status_printf_ln(s, color,
-					 _("You are currently rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
-		else
-			status_printf_ln(s, color,
-					 _("You are currently rebasing."));
+		print_rebase_state(s, state, color);
 		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
--=20
2.4.2.342.ga3499d3
