From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7] merge-recursive: use find_commit_subject() instead of
	custom code
Date: Thu, 22 Jul 2010 15:18:34 +0200
Message-ID: <20100722131836.2148.12472.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obvvv-0005i6-6p
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759420Ab0GVNeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:46 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:62011 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759060Ab0GVNen (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:43 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 012068000D19;
	Thu, 22 Jul 2010 15:34:43 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id E82D28000E97;
	Thu, 22 Jul 2010 15:34:42 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 3EC148000D19;
	Thu, 22 Jul 2010 15:34:31 +0200 (CEST)
X-ME-UUID: 20100722133434257.3EC148000D19@mwinf2f18.orange.fr
X-git-sha1: 2e6cd78b9cc50d10ab12cbf4f06b8eaf7ccb4238 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151455>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 merge-recursive.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 529d345..08f666a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -136,16 +136,10 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 		if (parse_commit(commit) != 0)
 			printf("(bad commit)\n");
 		else {
-			const char *s;
-			int len;
-			for (s = commit->buffer; *s; s++)
-				if (*s == '\n' && s[1] == '\n') {
-					s += 2;
-					break;
-				}
-			for (len = 0; s[len] && '\n' != s[len]; len++)
-				; /* do nothing */
-			printf("%.*s\n", len, s);
+			const char *title;
+			int len = find_commit_subject(commit->buffer, &title);
+			if (len)
+				printf("%.*s\n", len, title);
 		}
 	}
 }
-- 
1.7.2.rc3.267.g400b3
