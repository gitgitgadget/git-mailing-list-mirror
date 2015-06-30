From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 1/4] status: factor two rebase-related messages together
Date: Tue, 30 Jun 2015 15:01:12 +0200
Message-ID: <1435669275-32102-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 15:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9vAK-0005Vo-6p
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 15:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbbF3NB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 09:01:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56307 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbbF3NBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 09:01:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UD1H0k004183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 15:01:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UD1JO3024073;
	Tue, 30 Jun 2015 15:01:19 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9vA7-0000BY-Er; Tue, 30 Jun 2015 15:01:19 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 15:01:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UD1H0k004183
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436274078.54862@VMZnT+7WhFOSNoYmHzNRKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273056>

=46rom: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr>

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 wt-status.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index eaed4fe..8c4b806 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,6 +1027,20 @@ static int split_commit_in_progress(struct wt_st=
atus *s)
 	return split_in_progress;
 }
=20
+static void print_rebase_state(struct wt_status *s,
+				struct wt_status_state *state,
+				const char *color)
+{
+	if (state->branch)
+		status_printf_ln(s, color,
+				 _("You are currently rebasing branch '%s' on '%s'."),
+				 state->branch,
+				 state->onto);
+	else
+		status_printf_ln(s, color,
+				 _("You are currently rebasing."));
+}
+
 static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
@@ -1034,14 +1048,7 @@ static void show_rebase_in_progress(struct wt_st=
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
@@ -1051,14 +1058,7 @@ static void show_rebase_in_progress(struct wt_st=
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
2.5.0.rc0.10.g7792c2a
