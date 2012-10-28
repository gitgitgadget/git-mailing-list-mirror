From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 5/8] longest_ancestor_length(): take a string_list argument for prefixes
Date: Sun, 28 Oct 2012 17:16:24 +0100
Message-ID: <1351440987-26636-6-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVY9-0003SU-Hb
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab2J1QRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:17:08 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:55226 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab2J1QRG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:17:06 -0400
X-AuditID: 12074411-b7fa36d0000008cc-ef-508d5a81c014
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DD.44.02252.18A5D805; Sun, 28 Oct 2012 12:17:05 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJf002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:17:03 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqNsY1Rtg8GmFrEXXlW4mi4beK8wW
	T+beZbY4esrC4vaK+cwWP1p6mC3Wv7vK7MDu8ff9ByaPnbPusns8fNXF7vGsdw+jx8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGd8/LKfueCxRsXfmTfZGxinKXYxcnJICJhI7Jv4jR3CFpO4
	cG89WxcjF4eQwGVGiSPXPzNBOGeYJDYvfsAEUsUmoCuxqKcZzBYRkJX4fngjI0gRs8BdRolJ
	R6cCtXNwCAtES5xZlglSwyKgKtH9dDMrSJhXwEXic2clxDI5iQ97HrGDhDkFXCWO9juDhIWA
	Kv6sesc4gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQYBPcwTjj
	pNwhRgEORiUe3ksFPQFCrIllxZW5hxglOZiURHmZg3oDhPiS8lMqMxKLM+KLSnNSiw8xSnAw
	K4nwLuUGyvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHinRgI1Chal
	pqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gveYg7bzFBYm5QFGI1lOM
	uhxH38x9yCjEkpeflyolznssAqhIAKQoozQPbgUstbxiFAf6WJg3DWQUDzAtwU16BbSECWiJ
	Dh/YkpJEhJRUA+OMf488bhyZZzXTuGT9lvTlrmVNR6dNvfhE+OWddT8T1/7/8qB5YdrDRSsY
	HwjOl9zW4BN/Xa518v/fz9mKBeL+zGq/UXTIQ+zGjo6fTGL8p/r3R5390LWsPnfi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208555>

Change longest_ancestor_length() to take the prefixes argument as a
string_list rather than as a colon-separated string.  This will make
it easier for the caller to alter the entries before calling
longest_ancestor_length().

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
1.8.0
