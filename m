From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/6] archive: define MAX_ARGS where it's needed
Date: Fri, 25 Jul 2008 12:41:23 +0200
Message-ID: <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKsg-0001aq-5J
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbYGYKtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYGYKte
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:49:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:55540 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbYGYKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:49:33 -0400
Received: by india601.server4you.de (Postfix, from userid 1000)
	id 529072F819C; Fri, 25 Jul 2008 12:41:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90027>

MAX_EXTRA_ARGS is not used anymore, so remove it.  MAX_ARGS is used only
in builtin-upload-archive.c, so define it there.  Also report the actual
value we're comparing against when the number of args is too big.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.h                |    3 ---
 builtin-upload-archive.c |    3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/archive.h b/archive.h
index f6ceaeb..929368d 100644
--- a/archive.h
+++ b/archive.h
@@ -1,9 +1,6 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#define MAX_EXTRA_ARGS	32
-#define MAX_ARGS	(MAX_EXTRA_ARGS + 32)
-
 struct archiver_args {
 	const char *base;
 	size_t baselen;
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index cc37b36..a9b02fa 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -16,6 +16,7 @@ static const char deadchild[] =
 static const char lostchild[] =
 "git upload-archive: archiver process was lost";
 
+#define MAX_ARGS (64)
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
@@ -45,7 +46,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 		if (len == 0)
 			break;	/* got a flush */
 		if (sent_argc > MAX_ARGS - 2)
-			die("Too many options (>29)");
+			die("Too many options (>%d)", MAX_ARGS - 2);
 
 		if (p[len-1] == '\n') {
 			p[--len] = 0;
-- 
1.6.0.rc0.42.g186458
