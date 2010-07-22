From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] bisect: use find_commit_subject() instead of custom code
Date: Thu, 22 Jul 2010 15:18:33 +0200
Message-ID: <20100722131836.2148.55405.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObvvC-0005JP-O1
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390Ab0GVNea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:30 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:60035 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759370Ab0GVNe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:29 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 6CDF680025BC;
	Thu, 22 Jul 2010 15:34:28 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 5F06780010C8;
	Thu, 22 Jul 2010 15:34:28 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 4E77380027DC;
	Thu, 22 Jul 2010 15:34:22 +0200 (CEST)
X-ME-UUID: 20100722133424321.4E77380027DC@mwinf2f18.orange.fr
X-git-sha1: fb16b4bb1fd9dea21e48481a3a53c64bbe0fd663 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151453>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index b556b11..060c042 100644
--- a/bisect.c
+++ b/bisect.c
@@ -141,7 +141,8 @@ static void show_list(const char *debug, int counted, int nr,
 		enum object_type type;
 		unsigned long size;
 		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
-		char *ep, *sp;
+		const char *subject_start;
+		int subject_len;
 
 		fprintf(stderr, "%c%c%c ",
 			(flags & TREESAME) ? ' ' : 'T',
@@ -156,13 +157,9 @@ static void show_list(const char *debug, int counted, int nr,
 			fprintf(stderr, " %.*s", 8,
 				sha1_to_hex(pp->item->object.sha1));
 
-		sp = strstr(buf, "\n\n");
-		if (sp) {
-			sp += 2;
-			for (ep = sp; *ep && *ep != '\n'; ep++)
-				;
-			fprintf(stderr, " %.*s", (int)(ep - sp), sp);
-		}
+		subject_len = find_commit_subject(buf, &subject_start);
+		if (subject_len)
+			fprintf(stderr, " %.*s", subject_len, subject_start);
 		fprintf(stderr, "\n");
 	}
 }
-- 
1.7.2.rc3.267.g400b3
