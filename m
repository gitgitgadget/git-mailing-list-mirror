From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: preview of "What's cooking" (topics)
Date: Thu, 4 Jan 2007 00:08:35 +0100
Message-ID: <17820.14195.22000.103176@lapjr.intranet.kiel.bmiag.de>
References: <7virfopfuo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 00:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2FE7-0000WU-H9
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 00:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXACXIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 18:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbXACXIw
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 18:08:52 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:32859 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbXACXIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 18:08:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 9E0B13AEE2;
	Thu,  4 Jan 2007 00:08:48 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01677-04; Thu, 4 Jan 2007 00:08:48 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 2D4223AEE0;
	Thu,  4 Jan 2007 00:08:46 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 1F3D03ADCB;
	Thu,  4 Jan 2007 00:08:46 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29561-05; Thu, 4 Jan 2007 00:08:42 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 43B753ADCA;
	Thu,  4 Jan 2007 00:08:38 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virfopfuo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35897>

Junio C Hamano writes:
 >  - J=FCrgen's git-status improvements are mostly in 'next' but
 >    one of them is queued in 'pu', waiting for comments.

Here is a more detailed breakdown of the reasoning behind the
remaining change in (slightly massaged) git-log format. Especially
the usage of 'cached' and 'unstage' might not be that helpful.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Add "cached" to cached content header in status output
   =20
    Since we direct the user to use git-rm --cached this might be a goo=
d way to
    clarify it without loosing many words.
   =20
diff --git a/wt-status.c b/wt-status.c
index 8696e5b..e6355c6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -56,7 +56,7 @@ void wt_status_prepare(struct wt_status *s)
 static void wt_status_print_cached_header(const char *reference)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# Changes to be committed:");
+	color_printf_ln(c, "# Cached changes to be committed:");
 	if (reference) {
 		color_printf_ln(c, "#   (use \"git reset %s <file>...\" and \"git rm=
 --cached <file>...\" to unstage)", reference);
 	} else {

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Add unstaging hint to status output
   =20
    If reference commit name is provided advertise git-reset otherwise =
instruct the
    user to use git-rm --cached. The latter case is needed to handle th=
e initial
    commit.
   =20
    Note that git-rm --cached is currently needed even if we have a ref=
erence
    commit, since git-reset cannot remove freshly added files from the =
index (yet).
   =20
diff --git a/wt-status.c b/wt-status.c
index 82b76d5..8696e5b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -57,6 +57,11 @@ static void wt_status_print_cached_header(const char=
 *reference)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
 	color_printf_ln(c, "# Changes to be committed:");
+	if (reference) {
+		color_printf_ln(c, "#   (use \"git reset %s <file>...\" and \"git rm=
 --cached <file>...\" to unstage)", reference);
+	} else {
+		color_printf_ln(c, "#   (use \"git rm --cached <file>...\" to unstag=
e)");
+	}
 	color_printf_ln(c, "#");
 }
=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Simplify cached content header in status output
   =20
    Replace awkward "Added but not yet committed (will commit)" by a si=
mple
    "Changes to be committed".
   =20
diff --git a/wt-status.c b/wt-status.c
index 1959238..82b76d5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -56,8 +56,7 @@ void wt_status_prepare(struct wt_status *s)
 static void wt_status_print_cached_header(const char *reference)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# Added but not yet committed:");
-	color_printf_ln(c, "#   (will commit):");
+	color_printf_ln(c, "# Changes to be committed:");
 	color_printf_ln(c, "#");
 }
=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Refactor printing of cached content header of status output
   =20
    Since this header is printed in two different code paths and the na=
me of the
    reference commit will be needed for the future unstaging hint, prov=
ide a new
    printing function.
   =20
diff --git a/wt-status.c b/wt-status.c
index db42738..1959238 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -53,6 +53,14 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked =3D 0;
 }
=20
+static void wt_status_print_cached_header(const char *reference)
+{
+	const char *c =3D color(WT_STATUS_HEADER);
+	color_printf_ln(c, "# Added but not yet committed:");
+	color_printf_ln(c, "#   (will commit):");
+	color_printf_ln(c, "#");
+}
+
 static void wt_status_print_header(const char *main, const char *sub)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
@@ -147,8 +155,7 @@ static void wt_status_print_updated_cb(struct diff_=
queue_struct *q,
 		if (q->queue[i]->status =3D=3D 'U')
 			continue;
 		if (!shown_header) {
-			wt_status_print_header("Added but not yet committed",
-					"will commit");
+			wt_status_print_cached_header(s->reference);
 			s->commitable =3D 1;
 			shown_header =3D 1;
 		}
@@ -179,8 +186,7 @@ void wt_status_print_initial(struct wt_status *s)
 	read_cache();
 	if (active_nr) {
 		s->commitable =3D 1;
-		wt_status_print_header("Added but not yet committed",
-				"will commit");
+		wt_status_print_cached_header(NULL);
 	}
 	for (i =3D 0; i < active_nr; i++) {
 		color_printf(color(WT_STATUS_HEADER), "#\t");
