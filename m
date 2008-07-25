From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/6] archive: declare struct archiver where it's needed
Date: Fri, 25 Jul 2008 12:41:24 +0200
Message-ID: <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:50:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKsi-0001aq-RF
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbYGYKtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbYGYKtm
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:49:42 -0400
Received: from india601.server4you.de ([85.25.151.105]:55542 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbYGYKte (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:49:34 -0400
Received: by india601.server4you.de (Postfix, from userid 1000)
	id 584382F8028; Fri, 25 Jul 2008 12:41:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90031>

Move the declaration of struct archiver to archive.c, as this is the only
file left where it is used.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |    6 +++++-
 archive.h |    6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index c4662a2..f834b5f 100644
--- a/archive.c
+++ b/archive.c
@@ -9,7 +9,11 @@ static const char archive_usage[] = \
 
 #define USES_ZLIB_COMPRESSION 1
 
-const struct archiver archivers[] = {
+const struct archiver {
+	const char *name;
+	write_archive_fn_t write_archive;
+	unsigned int flags;
+} archivers[] = {
 	{ "tar", write_tar_archive },
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
 };
diff --git a/archive.h b/archive.h
index 929368d..0b15b35 100644
--- a/archive.h
+++ b/archive.h
@@ -17,12 +17,6 @@ typedef int (*write_archive_fn_t)(struct archiver_args *);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
 
-struct archiver {
-	const char *name;
-	write_archive_fn_t write_archive;
-	unsigned int flags;
-};
-
 /*
  * Archive-format specific backends.
  */
-- 
1.6.0.rc0.42.g186458
