From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 09/16] contrib/git-credential-gnome-keyring.c: use gnome helpers in keyring_object()
Date: Mon, 23 Sep 2013 11:49:10 -0700
Message-ID: <1379962157-1338-10-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBD0-0007oY-8f
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab3IWSt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14685 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B52408d0e0000>; Mon, 23 Sep 2013 11:48:46 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:45:52 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 23 Sep 2013 11:45:52 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:25 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235228>

From: Brandon Casey <drafnel@gmail.com>

Rather than carefully allocating memory for sprintf() to write into,
let's make use of the glib helper function g_strdup_printf(), which
makes things a lot easier and less error-prone.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c           | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 43b19dd..b692e1f 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -112,21 +112,13 @@ static inline char *xstrdup(const char *str)
 /* create a special keyring option string, if path is given */
 static char* keyring_object(struct credential *c)
 {
-	char* object = NULL;
-
 	if (!c->path)
-		return object;
-
-	object = (char*) malloc(strlen(c->host)+strlen(c->path)+8);
-	if (!object)
-		die_errno(errno);
+		return NULL;
 
 	if (c->port)
-		sprintf(object,"%s:%hd/%s",c->host,c->port,c->path);
-	else
-		sprintf(object,"%s/%s",c->host,c->path);
+		return g_strdup_printf("%s:%hd/%s", c->host, c->port, c->path);
 
-	return object;
+	return g_strdup_printf("%s/%s", c->host, c->path);
 }
 
 static int keyring_get(struct credential *c)
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
