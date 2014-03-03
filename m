From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Mon,  3 Mar 2014 13:17:55 +0530
Message-ID: <1393832875-29096-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNcj-0001ZU-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbaCCHss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:48:48 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41714 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaCCHss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:48:48 -0500
Received: by mail-pa0-f53.google.com with SMTP id ld10so3459530pab.40
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 23:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9Zr5jzmpurmeydBI5Ut5ws4e8y4FiUWsNKT2kutMQL4=;
        b=07qzRbwmky5e5jcFB//8kixqLTuX6gfBs+U8NKPpGOqNWWxAdcciXcccpCDnw1N8H1
         k9vSfTIpzC1kwzuM5j3lvluu2kR2GLGLrgsJzmztoVbaVcAvvkEPoDK/oY9MhukY1RrY
         kqjMtsDb2hCirh3zgDjlD9UiMhkCVUoGNO8P2A7P4LeZTDIOnqnK6bWFyO1z7o6jMiAL
         aPRGGM6Q80/C/MbhEk0gU+yLCjPhUE524+Kh5KfQnD5SS9Oe3of7EVJ9jEM7rzCEpWjk
         KUiNrgZCb76uw8ePPv+W9c/dBJp3ZGGySwL6UhrKxHFgMQ1bZ/TX15a4Gy/GsStDHUjz
         A/nQ==
X-Received: by 10.66.149.7 with SMTP id tw7mr18205489pab.72.1393832927682;
        Sun, 02 Mar 2014 23:48:47 -0800 (PST)
Received: from localhost.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id vx10sm78844192pac.17.2014.03.02.23.48.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Mar 2014 23:48:47 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243194>

Replace with skip_prefix(), which uses the inbuilt function
strcmp() to compare.

Other Places were this can be implemented:
commit.c : line 1117
commit.c : line 1197

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..1e181cf 100644
--- a/commit.c
+++ b/commit.c
@@ -552,6 +552,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	char *buffer = NULL;
 	struct ident_split ident;
 	char *date_end;
+	char *flag_sp; /* stores return value of skip_prefix() */
 	unsigned long date;
 
 	if (!commit->buffer) {
@@ -566,7 +567,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		if ((flag_sp = skip_prefix(buf, "author ")) == NULL) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
-- 
1.9.0.138.g2de3478
