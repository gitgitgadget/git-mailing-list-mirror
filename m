From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 03/19] dir.c: rename cryptic 'which' variable to more consistent name
Date: Thu, 27 Dec 2012 02:32:22 +0000
Message-ID: <1356575558-2674-4-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:34:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3II-0006l1-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2L0Cdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:33:35 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53763 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2L0Ccm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:42 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 35C262E5DB
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:41 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212188>

'el' is only *slightly* less cryptic, but is already used as the
variable name for a struct exclude_list pointer in numerous other
places, so this reduces the number of cryptic variable names in use by
one :-)

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 10 +++++-----
 dir.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 89e27a6..f31aa59 100644
--- a/dir.c
+++ b/dir.c
@@ -349,7 +349,7 @@ void parse_exclude_pattern(const char **pattern,
 }
 
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *which)
+		 int baselen, struct exclude_list *el)
 {
 	struct exclude *x;
 	int patternlen;
@@ -373,8 +373,8 @@ void add_exclude(const char *string, const char *base,
 	x->base = base;
 	x->baselen = baselen;
 	x->flags = flags;
-	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
-	which->excludes[which->nr++] = x;
+	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
+	el->excludes[el->nr++] = x;
 }
 
 static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
@@ -416,7 +416,7 @@ int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
 				   char **buf_p,
-				   struct exclude_list *which,
+				   struct exclude_list *el,
 				   int check_index)
 {
 	struct stat st;
@@ -463,7 +463,7 @@ int add_excludes_from_file_to_list(const char *fname,
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
-				add_exclude(entry, base, baselen, which);
+				add_exclude(entry, base, baselen, el);
 			}
 			entry = buf + i + 1;
 		}
diff --git a/dir.h b/dir.h
index e0869bc..680c1eb 100644
--- a/dir.h
+++ b/dir.h
@@ -127,11 +127,11 @@ extern int path_excluded(struct path_exclude_check *, const char *, int namelen,
 
 
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-					  char **buf_p, struct exclude_list *which, int check_index);
+					  char **buf_p, struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void parse_exclude_pattern(const char **string, int *patternlen, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *which);
+			int baselen, struct exclude_list *el);
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
 
-- 
1.7.11.2.249.g31c7954
