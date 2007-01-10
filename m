From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH] Provide better feedback for the untracked only case in status output
Date: Wed, 10 Jan 2007 23:25:03 +0100
Message-ID: <11684679032630-git-send-email-j.ruehle@bmiag.de>
References: <1168452977.19643.57.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?J=C3=BCrgen_R=C3=BChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Wed Jan 10 23:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4lsz-00035I-Gr
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 23:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbXAJWZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 17:25:28 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbXAJWZ2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 17:25:28 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:32780 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965119AbXAJWZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 17:25:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id DE1433AED7;
	Wed, 10 Jan 2007 23:25:24 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01676-01; Wed, 10 Jan 2007 23:25:24 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 2D5AD3AED2;
	Wed, 10 Jan 2007 23:25:16 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 7341B3ADC8;
	Wed, 10 Jan 2007 23:25:15 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 24534-07; Wed, 10 Jan 2007 23:25:10 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id BB3353ADC6;
	Wed, 10 Jan 2007 23:25:06 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g525e
In-Reply-To: <1168452977.19643.57.camel@ibook.zvpunry.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36534>

=46rom: J=C3=BCrgen R=C3=BChle <j-r@online.de>

Since 98bf8a47c296f51ea9722fef4bb81dbfb70cd4bb status would claim that
git-commit could be useful even if there are no changes except untracke=
d files.

Since wt-status is already computing all the information needed go the =
whole
way and actually track the (non-)emptiness of all three sections separa=
tely,
unify the code, and provide useful messages for each individual case.

Thanks to Junio and Michael Loeffler for suggestions.

Signed-off-by: J=C3=BCrgen R=C3=BChle <j-r@online.de>
---
  This is a resend of the nothing-to-commit improvement patch (hopefull=
y)
  without corruption. This also includes some changes due to feedback f=
rom
  Michael Loeffler.

  Still missing:

   - Further changes to the other messages (as discussed on the list)

   - Patches to other files that contain these messages verbatim

     (AFAICS this affects only the git-reset man page, tutorial-2 and t=
he VIM
      syntax highlighting)

 wt-status.c |   21 ++++++++++++---------
 wt-status.h |    6 ++++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c48127d..1dc2fdc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -47,10 +47,11 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference =3D "HEAD";
 	s->amend =3D 0;
 	s->verbose =3D 0;
-	s->commitable =3D 0;
 	s->untracked =3D 0;
=20
-	s->workdir_clean =3D 1;
+	s->commitable =3D 0;
+	s->workdir_dirty =3D 0;
+	s->workdir_untracked =3D 0;
 }
=20
 static void wt_status_print_cached_header(const char *reference)
@@ -176,7 +177,7 @@ static void wt_status_print_changed_cb(struct diff_=
queue_struct *q,
 	struct wt_status *s =3D data;
 	int i;
 	if (q->nr) {
-		s->workdir_clean =3D 0;
+		s->workdir_dirty =3D 1;
 		wt_status_print_header("Changed but not added", use_add_msg);
 	}
 	for (i =3D 0; i < q->nr; i++)
@@ -263,7 +264,7 @@ static void wt_status_print_untracked(struct wt_sta=
tus *s)
 				continue;
 		}
 		if (!shown_header) {
-			s->workdir_clean =3D 0;
+			s->workdir_untracked =3D 1;
 			wt_status_print_header("Untracked files", use_add_msg);
 			shown_header =3D 1;
 		}
@@ -311,12 +312,14 @@ void wt_status_print(struct wt_status *s)
 	if (!s->commitable) {
 		if (s->amend)
 			printf("# No changes\n");
-		else if (s->workdir_clean)
-			printf(s->is_initial
-			       ? "nothing to commit\n"
-			       : "nothing to commit (working directory matches HEAD)\n");
-		else
+		else if (s->workdir_dirty)
 			printf("no changes added to commit (use \"git add\" and/or \"git co=
mmit [-a|-i|-o]\")\n");
+		else if (s->workdir_untracked)
+			printf("nothing added to commit but untracked files present (use \"=
git add\" to track)\n");
+		else if (s->is_initial)
+			printf("nothing to commit (create/copy files and use \"git add\" to=
 track)\n");
+		else
+			printf("nothing to commit (working directory clean)\n");
 	}
 }
=20
diff --git a/wt-status.h b/wt-status.h
index 892a86c..cfea4ae 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -12,11 +12,13 @@ struct wt_status {
 	int is_initial;
 	char *branch;
 	const char *reference;
-	int commitable;
 	int verbose;
 	int amend;
 	int untracked;
-	int workdir_clean;
+	/* These are computed during processing of the individual sections */
+	int commitable;
+	int workdir_dirty;
+	int workdir_untracked;
 };
=20
 int git_status_config(const char *var, const char *value);
--=20
1.5.0.rc0.g525e
