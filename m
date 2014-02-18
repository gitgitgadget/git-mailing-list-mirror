From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH 2/4] builtin/config.c: rename check_blob_write() -> check_write()
Date: Wed, 19 Feb 2014 00:58:53 +0200
Message-ID: <1392764335-13274-2-git-send-email-kirill@shutemov.name>
References: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 23:59:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtdQ-0007fp-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbaBRW7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:59:19 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:34717 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbaBRW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 17:59:15 -0500
Received: from node.shutemov.name (80.220.224.16) by jenni1.inet.fi (8.5.140.03)
        id 527750DA08F03659; Wed, 19 Feb 2014 00:59:10 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id F0B094034F; Wed, 19 Feb 2014 00:59:07 +0200 (EET)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242368>

The function will be reused to check for other conditions which prevent
write.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 builtin/config.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 92ebf23f0a9a..a7c55e68883c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -362,7 +362,7 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
 
-static void check_blob_write(void)
+static void check_write(void)
 {
 	if (given_config_blob)
 		die("writing config blobs is not supported");
@@ -572,7 +572,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		ret = git_config_set_in_file(given_config_file, argv[0], value);
@@ -582,21 +582,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], value, "^$", 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
@@ -623,7 +623,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return get_urlmatch(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_UNSET) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			return git_config_set_multivar_in_file(given_config_file,
@@ -633,14 +633,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 						      argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section_in_file(given_config_file,
 							argv[0], argv[1]);
@@ -651,7 +651,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
-		check_blob_write();
+		check_write();
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section_in_file(given_config_file,
 							argv[0], NULL);
-- 
1.9.0.rc3
