From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] revert: don't print "Finished one cherry-pick." if commit
	failed
Date: Wed, 14 Jul 2010 01:28:14 +0200
Message-ID: <20100713232816.7738.202.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 11:27:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZKiz-0008Dx-GE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 11:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883Ab0GOJ1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 05:27:20 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:15008 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932878Ab0GOJ1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 05:27:16 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id DED3F8000428;
	Thu, 15 Jul 2010 11:27:15 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id D1E7B80005E7;
	Thu, 15 Jul 2010 11:27:15 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 4C2FD8000428;
	Thu, 15 Jul 2010 11:27:15 +0200 (CEST)
X-ME-UUID: 20100715092715313.4C2FD8000428@mwinf2f14.orange.fr
X-git-sha1: 2dff2d25b122f02906d49f23158885233bb8703f 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151067>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b84b5b8..ec931bd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -518,24 +518,17 @@ static int do_pick_commit(void)
 			mebuf.buf, help_msg());
 		rerere(allow_rerere_auto);
 	} else {
-		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
+		if (!no_commit)
+			res = run_git_commit(defmsg);
+		if (!res)
+			fprintf(stderr, "Finished one %s.\n", mebuf.buf);
 	}
 
 	strbuf_release(&mebuf);
 	free_message(&msg);
-
-	if (res)
-		return 1;
-
-	if (!no_commit) {
-		res = run_git_commit(defmsg);
-		free(defmsg);
-		return res;
-	}
-
 	free(defmsg);
 
-	return 0;
+	return res;
 }
 
 static void prepare_revs(struct rev_info *revs)
-- 
1.7.2.rc1.215.g2dff2.dirty
