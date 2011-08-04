From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 23/23] Rename git_checkattr() to git_check_attr()
Date: Thu,  4 Aug 2011 06:36:33 +0200
Message-ID: <1312432593-9841-24-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgt-0005WA-VA
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab1HDEhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39690 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1HDEhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:09 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agI3029203;
	Thu, 4 Aug 2011 06:37:05 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178689>

Suggested by: Junio Hamano <gitster@pobox.com>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-gitattributes.txt |    8 ++++----
 archive.c                                     |    2 +-
 attr.c                                        |    2 +-
 attr.h                                        |    4 ++--
 builtin/check-attr.c                          |    4 ++--
 builtin/pack-objects.c                        |    2 +-
 convert.c                                     |    2 +-
 ll-merge.c                                    |    4 ++--
 userdiff.c                                    |    2 +-
 ws.c                                          |    2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 3bd2f57..5a1403f 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -19,7 +19,7 @@ Data Structure
 `struct git_attr_check`::
 
 	This structure represents a set of attributes to check in a call
-	to `git_checkattr()` function, and receives the results.
+	to `git_check_attr()` function, and receives the results.
 
 
 Attribute Values
@@ -52,7 +52,7 @@ Querying Specific Attributes
   attributes you would want to check.  To populate this array, you would
   need to define necessary attributes by calling `git_attr()` function.
 
-* Call `git_checkattr()` to check the attributes for the path.
+* Call `git_check_attr()` to check the attributes for the path.
 
 * Inspect `git_attr_check` structure to see how each of the attribute in
   the array is defined for the path.
@@ -78,13 +78,13 @@ static void setup_check(void)
 }
 ------------
 
-. Call `git_checkattr()` with the prepared array of `struct git_attr_check`:
+. Call `git_check_attr()` with the prepared array of `struct git_attr_check`:
 
 ------------
 	const char *path;
 
 	setup_check();
-	git_checkattr(path, ARRAY_SIZE(check), check);
+	git_check_attr(path, ARRAY_SIZE(check), check);
 ------------
 
 . Act on `.value` member of the result, left in `check[]`:
diff --git a/archive.c b/archive.c
index 2a7a28e..3fd7f47 100644
--- a/archive.c
+++ b/archive.c
@@ -123,7 +123,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_checkattr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		convert = ATTR_TRUE(check[1].value);
diff --git a/attr.c b/attr.c
index 658112e..da29c8e 100644
--- a/attr.c
+++ b/attr.c
@@ -731,7 +731,7 @@ static void collect_all_attrs(const char *path)
 		rem = fill(path, pathlen, stk, rem);
 }
 
-int git_checkattr(const char *path, int num, struct git_attr_check *check)
+int git_check_attr(const char *path, int num, struct git_attr_check *check)
 {
 	int i;
 
diff --git a/attr.h b/attr.h
index 9e22893..eb8ca0d 100644
--- a/attr.h
+++ b/attr.h
@@ -20,7 +20,7 @@ extern const char git_attr__false[];
 #define ATTR_UNSET(v) ((v) == NULL)
 
 /*
- * Send one or more git_attr_check to git_checkattr(), and
+ * Send one or more git_attr_check to git_check_attr(), and
  * each 'value' member tells what its value is.
  * Unset one is returned as NULL.
  */
@@ -36,7 +36,7 @@ struct git_attr_check {
  */
 char *git_attr_name(struct git_attr *);
 
-int git_checkattr(const char *path, int, struct git_attr_check *);
+int git_check_attr(const char *path, int, struct git_attr_check *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index f20772a..6b16368 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -45,8 +45,8 @@ static void check_attr(int cnt, struct git_attr_check *check,
 	const char *file)
 {
 	if (check != NULL) {
-		if (git_checkattr(file, cnt, check))
-			die("git_checkattr died");
+		if (git_check_attr(file, cnt, check))
+			die("git_check_attr died");
 		output_attr(cnt, check, file);
 	} else {
 		if (git_all_attrs(file, &cnt, &check))
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 84e6daf..ac8bed8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -634,7 +634,7 @@ static int no_try_delta(const char *path)
 	struct git_attr_check check[1];
 
 	setup_delta_attr_check(check);
-	if (git_checkattr(path, ARRAY_SIZE(check), check))
+	if (git_check_attr(path, ARRAY_SIZE(check), check))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index 85939c2..416bf83 100644
--- a/convert.c
+++ b/convert.c
@@ -727,7 +727,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_checkattr(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
 		ca->crlf_action = git_path_check_crlf(path, ccheck + 4);
 		if (ca->crlf_action == CRLF_GUESS)
 			ca->crlf_action = git_path_check_crlf(path, ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index 6ce512e..da59738 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -330,7 +330,7 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_checkattr(path, 2, check);
+	return git_check_attr(path, 2, check);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -387,7 +387,7 @@ int ll_merge_marker_size(const char *path)
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_checkattr(path, 1, &check) && check.value) {
+	if (!git_check_attr(path, 1, &check) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index 01d3a8b..bf553ad 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -270,7 +270,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_checkattr(path, 1, &check))
+	if (git_check_attr(path, 1, &check))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/ws.c b/ws.c
index 9fb9b14..b498d75 100644
--- a/ws.c
+++ b/ws.c
@@ -88,7 +88,7 @@ unsigned whitespace_rule(const char *pathname)
 	struct git_attr_check attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_checkattr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attr(pathname, 1, &attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 
1.7.6.8.gd2879
