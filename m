From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/8] longest_ancestor_length(): take a string_list argument for prefixes
Date: Sun, 21 Oct 2012 07:57:34 +0200
Message-ID: <1350799057-13846-6-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYp-0006i8-4T
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab2JUF6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:32 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:42213 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739Ab2JUF6b (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:31 -0400
X-AuditID: 1207440c-b7f616d00000270b-32-50838f0695e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 45.7F.09995.60F83805; Sun, 21 Oct 2012 01:58:31 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Ws013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:29 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqMve3xxg0PuXyeLImyfMFl1Xupks
	GnqvMFs8mXuX2eLoKQuL2yvmM1usf3eV2YHd4+/7D0web9p7GT12zrrL7vHwVRe7x8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGfcebKFseC9RsXxuz8YGxgXKnYxcnJICJhIbO/fwAZhi0lc
	uLceyObiEBK4zChxbulFJgjnDJPEgpY5zCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBe4wSiy8
	8gasSFggWuLI/pdgNouAqsT0rw/BVvAKuEjcvTSJEWKdosSP72vAajgFXCWuLJsDViMEVLNz
	43vGCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEhBzPDsZv62QO
	MQpwMCrx8DJaNwcIsSaWFVfmHmKU5GBSEuV90QsU4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7
	WxAox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4E3tA2oULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VHfDEwPkBSPEB7XUHaeYsLEnOBohCtpxh1OY6+
	mfuQUYglLz8vVUqc1wikSACkKKM0D24FLMG8YhQH+liY1wukigeYnOAmvQJawgS0xJy7EWRJ
	SSJCSqqBUXtZcKjE3fdf3u74nn825KCYw66N/XOlDB0fnrBVin1lyJm4KMvtheCS4M0Saodk
	s7/Hn/JSeF/n/kmr/9FsphfdpavtP+87drj/xvS1EjI8XxX7mJ75ngzS/Oe27oC+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208111>

Change longest_ancestor_length() to take the prefixes argument as a
string_list rather than as a PATH_SEP-separated string.  This will
make it easier to change the caller to alter the entries before
calling longest_ancestor_length().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h           |  2 +-
 path.c            | 22 +++++++++-------------
 setup.c           | 11 +++++++++--
 test-path-utils.c |  8 +++++++-
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index b0d75bc..8103385 100644
--- a/cache.h
+++ b/cache.h
@@ -718,7 +718,7 @@ const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
 const char *relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
-int longest_ancestor_length(const char *path, const char *prefix_list);
+int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
diff --git a/path.c b/path.c
index f455e8e..b80d2e6 100644
--- a/path.c
+++ b/path.c
@@ -570,30 +570,27 @@ int normalize_path_copy(char *dst, const char *src)
 
 /*
  * path = Canonical absolute path
- * prefix_list = Colon-separated list of absolute paths
+ * prefixes = string_list containing absolute paths
  *
- * Determines, for each path in prefix_list, whether the "prefix" really
+ * Determines, for each path in prefixes, whether the "prefix" really
  * is an ancestor directory of path.  Returns the length of the longest
  * ancestor directory, excluding any trailing slashes, or -1 if no prefix
- * is an ancestor.  (Note that this means 0 is returned if prefix_list is
- * "/".) "/foo" is not considered an ancestor of "/foobar".  Directories
+ * is an ancestor.  (Note that this means 0 is returned if prefixes is
+ * ["/"].) "/foo" is not considered an ancestor of "/foobar".  Directories
  * are not considered to be their own ancestors.  path must be in a
  * canonical form: empty components, or "." or ".." components are not
- * allowed.  prefix_list may be null, which is like "".
+ * allowed.  Empty strings in prefixes are ignored.
  */
-int longest_ancestor_length(const char *path, const char *prefix_list)
+int longest_ancestor_length(const char *path, struct string_list *prefixes)
 {
-	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	char buf[PATH_MAX+1];
 	int i, max_len = -1;
 
-	if (prefix_list == NULL || !strcmp(path, "/"))
+	if (!strcmp(path, "/"))
 		return -1;
 
-	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
-
-	for (i = 0; i < prefixes.nr; i++) {
-		const char *ceil = prefixes.items[i].string;
+	for (i = 0; i < prefixes->nr; i++) {
+		const char *ceil = prefixes->items[i].string;
 		int len = strlen(ceil);
 
 		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
@@ -611,7 +608,6 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		}
 	}
 
-	string_list_clear(&prefixes, 0);
 	return max_len;
 }
 
diff --git a/setup.c b/setup.c
index 3a1b2fd..b4cd356 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "string-list.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -627,10 +628,11 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
+	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv, *ret;
 	char *gitfile;
-	int len, offset, offset_parent, ceil_offset;
+	int len, offset, offset_parent, ceil_offset = -1;
 	dev_t current_device = 0;
 	int one_filesystem = 1;
 
@@ -655,7 +657,12 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	if (gitdirenv)
 		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
 
-	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
+	if (env_ceiling_dirs) {
+		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
+		ceil_offset = longest_ancestor_length(cwd, &ceiling_dirs);
+		string_list_clear(&ceiling_dirs, 0);
+	}
+
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
 		ceil_offset = 1;
 
diff --git a/test-path-utils.c b/test-path-utils.c
index 3bc20e9..acb0560 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
 
 int main(int argc, char **argv)
 {
@@ -30,7 +31,12 @@ int main(int argc, char **argv)
 	}
 
 	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
-		int len = longest_ancestor_length(argv[2], argv[3]);
+		int len;
+		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
+
+		string_list_split(&ceiling_dirs, argv[3], PATH_SEP, -1);
+		len = longest_ancestor_length(argv[2], &ceiling_dirs);
+		string_list_clear(&ceiling_dirs, 0);
 		printf("%d\n", len);
 		return 0;
 	}
-- 
1.7.11.3
