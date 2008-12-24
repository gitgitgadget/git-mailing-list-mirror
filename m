From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] builtin-shortlog.c: do not unnecessarily strdup before insertion in list
Date: Wed, 24 Dec 2008 17:34:44 +0100
Message-ID: <1230136484-12445-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 24 17:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFWuO-0000Kk-J6
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 17:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYLXQqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Dec 2008 11:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbYLXQqn
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 11:46:43 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3469
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYLXQql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 11:46:41 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 433C68027904;
	Wed, 24 Dec 2008 17:34:45 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LFWh2-0003MP-4s; Wed, 24 Dec 2008 17:34:44 +0100
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103862>

The log->list always has "strdup_strings" activated, hence strdup'ing
namebuf was unnecessary. This change also removes a latent memory leak
in the old code.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 builtin-shortlog.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 4c5d761..90e76ae 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -67,12 +67,9 @@ static void insert_one_record(struct shortlog *log,
 		snprintf(namebuf + len, room, " %.*s", maillen, boemail);
 	}
=20
-	buffer =3D xstrdup(namebuf);
-	item =3D string_list_insert(buffer, &log->list);
+	item =3D string_list_insert(namebuf, &log->list);
 	if (item->util =3D=3D NULL)
 		item->util =3D xcalloc(1, sizeof(struct string_list));
-	else
-		free(buffer);
=20
 	/* Skip any leading whitespace, including any blank lines. */
 	while (*oneline && isspace(*oneline))
--=20
1.6.0.4
