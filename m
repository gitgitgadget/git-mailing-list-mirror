From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 04/19] dir.c: rename path_excluded() to is_path_excluded()
Date: Thu, 27 Dec 2012 02:32:23 +0000
Message-ID: <1356575558-2674-5-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3IH-0006l1-1F
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2L0Cdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:33:33 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53764 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab2L0Ccn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:43 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D6C4E2E5E4
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:41 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212187>

Start adopting clearer names for exclude functions.  This 'is_*'
naming pattern for functions returning booleans was agreed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=204924

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c      | 2 +-
 builtin/ls-files.c | 2 +-
 dir.c              | 4 ++--
 dir.h              | 2 +-
 unpack-trees.c     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 89dce56..c689f37 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -453,7 +453,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (path_excluded(&check, pathspec[i], -1, &dtype))
+					if (is_path_excluded(&check, pathspec[i], -1, &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 31b3f2d..ef7f99a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -203,7 +203,7 @@ static void show_ru_info(void)
 static int ce_excluded(struct path_exclude_check *check, struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return path_excluded(check, ce->name, ce_namelen(ce), &dtype);
+	return is_path_excluded(check, ce->name, ce_namelen(ce), &dtype);
 }
 
 static void show_files(struct dir_struct *dir)
diff --git a/dir.c b/dir.c
index f31aa59..f1c0abd 100644
--- a/dir.c
+++ b/dir.c
@@ -685,8 +685,8 @@ void path_exclude_check_clear(struct path_exclude_check *check)
  * A path to a directory known to be excluded is left in check->path to
  * optimize for repeated checks for files in the same excluded directory.
  */
-int path_excluded(struct path_exclude_check *check,
-		  const char *name, int namelen, int *dtype)
+int is_path_excluded(struct path_exclude_check *check,
+		     const char *name, int namelen, int *dtype)
 {
 	int i;
 	struct strbuf *path = &check->path;
diff --git a/dir.h b/dir.h
index 680c1eb..c59bad8 100644
--- a/dir.h
+++ b/dir.h
@@ -123,7 +123,7 @@ struct path_exclude_check {
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
-extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
+extern int is_path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
 
 
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
diff --git a/unpack-trees.c b/unpack-trees.c
index 33a5819..3ac6370 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1372,7 +1372,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    path_excluded(o->path_exclude_check, name, -1, &dtype))
+	    is_path_excluded(o->path_exclude_check, name, -1, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
1.7.11.2.249.g31c7954
