From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 10/19] dir.c: rename free_excludes() to clear_exclude_list()
Date: Thu, 27 Dec 2012 02:32:29 +0000
Message-ID: <1356575558-2674-11-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hh-0006Tl-A7
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab2L0Ccv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:51 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53767 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2L0Ccr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:47 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B96722E5E6
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:46 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212173>

It is clearer to use a 'clear_' prefix for functions which empty
and deallocate the contents of a data structure without freeing
the structure itself, and a 'free_' prefix for functions which
also free the structure itself.

http://article.gmane.org/gmane.comp.version-control.git/206128

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c          | 6 +++++-
 dir.h          | 2 +-
 unpack-trees.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 16e10b0..41f141c 100644
--- a/dir.c
+++ b/dir.c
@@ -400,7 +400,11 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
 	return data;
 }
 
-void free_excludes(struct exclude_list *el)
+/*
+ * Frees memory within el which was allocated for exclude patterns and
+ * the file buffer.  Does not free el itself.
+ */
+void clear_exclude_list(struct exclude_list *el)
 {
 	int i;
 
diff --git a/dir.h b/dir.h
index dcb1ad3..5664ba8 100644
--- a/dir.h
+++ b/dir.h
@@ -135,7 +135,7 @@ extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void parse_exclude_pattern(const char **string, int *patternlen, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el);
-extern void free_excludes(struct exclude_list *el);
+extern void clear_exclude_list(struct exclude_list *el);
 extern int file_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
diff --git a/unpack-trees.c b/unpack-trees.c
index c0da094..ad621d9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1153,7 +1153,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		*o->dst_index = o->result;
 
 done:
-	free_excludes(&el);
+	clear_exclude_list(&el);
 	if (o->path_exclude_check) {
 		path_exclude_check_clear(o->path_exclude_check);
 		free(o->path_exclude_check);
-- 
1.7.11.2.249.g31c7954
