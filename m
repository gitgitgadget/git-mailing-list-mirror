From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 1/4] status: factor two rebase-related messages together
Date: Thu,  4 Jun 2015 00:00:22 +0200
Message-ID: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 00:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0GiO-00030K-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 00:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbFCWAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 18:00:39 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40219 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154AbbFCWAi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 18:00:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E66BB4885D;
	Thu,  4 Jun 2015 00:00:34 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zP6kT3zv8+Rv; Thu,  4 Jun 2015 00:00:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C90294863D;
	Thu,  4 Jun 2015 00:00:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B682220E4;
	Thu,  4 Jun 2015 00:00:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fgv34hMQB1d; Thu,  4 Jun 2015 00:00:34 +0200 (CEST)
Received: from localhost.localdomain (pas38-h02-176-189-96-8.dsl.sta.abo.bbox.fr [176.189.96.8])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4ACDB20DF;
	Thu,  4 Jun 2015 00:00:34 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.g726a850
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270743>

---
 wt-status.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 33452f1..fec6e85 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1032,7 +1032,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 {
 	struct stat st;
 
-	if (has_unmerged(s)) {
+	if (has_unmerged(s) || state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
 		if (state->branch)
 			status_printf_ln(s, color,
 					 _("You are currently rebasing branch '%s' on '%s'."),
@@ -1042,25 +1042,17 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 					 _("You are currently rebasing."));
 		if (s->hints) {
-			status_printf_ln(s, color,
-				_("  (fix conflicts and then run \"git rebase --continue\")"));
-			status_printf_ln(s, color,
-				_("  (use \"git rebase --skip\" to skip this patch)"));
-			status_printf_ln(s, color,
-				_("  (use \"git rebase --abort\" to check out the original branch)"));
+			if (has_unmerged(s)) {
+				status_printf_ln(s, color,
+					_("  (fix conflicts and then run \"git rebase --continue\")"));
+				status_printf_ln(s, color,
+					_("  (use \"git rebase --skip\" to skip this patch)"));
+				status_printf_ln(s, color,
+					_("  (use \"git rebase --abort\" to check out the original branch)"));
+			} else
+				status_printf_ln(s, color,
+					_("  (all conflicts fixed: run \"git rebase --continue\")"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
-		if (state->branch)
-			status_printf_ln(s, color,
-					 _("You are currently rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
-		else
-			status_printf_ln(s, color,
-					 _("You are currently rebasing."));
-		if (s->hints)
-			status_printf_ln(s, color,
-				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
 		if (state->branch)
 			status_printf_ln(s, color,
-- 
2.4.2.342.g3cebd9b
