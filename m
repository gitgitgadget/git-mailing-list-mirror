From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC] log-tree: let format-patch not indent notes
Date: Thu, 25 Sep 2014 18:10:09 +0200
Message-ID: <1411661409-24562-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 18:10:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXBci-0006yd-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 18:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbaIYQKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 12:10:22 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58317 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaIYQKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 12:10:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1XXBcY-0007Ne-N4; Thu, 25 Sep 2014 18:10:18 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.84)
	(envelope-from <ukl@pengutronix.de>)
	id 1XXBcY-0006Oo-Lu; Thu, 25 Sep 2014 18:10:18 +0200
X-Mailer: git-send-email 2.1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257479>

Commit logs as shown by git-log are usually indented by four spaces so
here it makes sense to do the same for commit notes.

However when using format-patch to create a patch for submission via
e-mail the commit log isn't indented and also the "Notes:" header isn't
really useful. So consequently don't indent and skip the header in this
case. This also removes the empty line between the end-of-commit marker
and the start of the notes.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
This commit changes the output of format-patch (applied on this commit)=
 from:

	...
	case.

	Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
	---

	Notes:
	    This commit changes the output of format-patch (applied on this co=
mmit) from:

to

	...
	case.

	Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
	---
	This commit changes the output of format-patch (applied on this commit=
) from:

which I consider to be more useful.

 log-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index bcee7c596696..c1d73d8fecdf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -585,7 +585,8 @@ void show_log(struct rev_info *opt)
 		int raw;
 		struct strbuf notebuf =3D STRBUF_INIT;
=20
-		raw =3D (opt->commit_format =3D=3D CMIT_FMT_USERFORMAT);
+		raw =3D (opt->commit_format =3D=3D CMIT_FMT_USERFORMAT) ||
+			(opt->commit_format =3D=3D CMIT_FMT_EMAIL);
 		format_display_notes(commit->object.sha1, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message =3D notebuf.len
--=20
2.1.1.274.gb3e1830.dirty
