From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/17] safe_create_leading_directories(): introduce enum for return values
Date: Sat, 18 Jan 2014 23:48:51 +0100
Message-ID: <1390085341-2553-8-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ei1-00054S-R9
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbaARWtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:39 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47715 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbaARWth (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:37 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-7e-52db050153c9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CD.7E.18966.1050BD25; Sat, 18 Jan 2014 17:49:37 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN90030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:36 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqMvIejvIoKOBx6LrSjeTRUPvFWaL
	2yvmMzswe/x9/4HJ4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNObdvHXNArX3FpcgNbA+N9
	iS5GTg4JAROJZ6sbGCFsMYkL99azdTFycQgJXGaU6Dy4kgXCOcEk8bxrIhNIFZuArsSinmYw
	W0RATWJi2yEWEJtZwEFi8+dGsEnCArESz55dYwWxWQRUJX4fPgxm8wo4SzTOfA+0gQNom4LE
	6utCIGFOAReJI/MvgI0UAiq5+foJ+wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30
	cjNL9FJTSjcxQkKFdwfj/3UyhxgFOBiVeHgPMN0OEmJNLCuuzD3EKMnBpCTKqwwS4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMIbvOFWkBBvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFq
	EUxWhoNDSYLXmwVoqGBRanpqRVpmTglCmomDE0RwgWzgAdkAUshbXJCYW5yZDlF0ilFRSpw3
	HCQhAJLIKM2DGwCL6leM4kD/CPNKgVTxABMCXPcroMFMQINFYm+CDC5JREhJNTAq7NnG9E4v
	cnVxo0DPbA3n95ZdfRqnL7WUPjjhvbovuKTYRmB2H/viqC8V59S2bDnk7WNWIql5d9r+wAW/
	FeZG21ansS98fdy0yeZu9ea3q6fdry77bKh97n0hd2C4x/yc9YaJc7O0tsxiefnkb8H/xDVM
	GR9eTf0cGDpHXrkr7bP8DMHT1tlKLMUZiYZazEXFiQAa8sZRxQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240652>

Instead of returning magic integer values (which a couple of callers
go to the trouble of distinguishing), return values from an enum.  Add
a docstring.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c |  4 ++--
 cache.h           | 17 +++++++++++++++--
 merge-recursive.c |  2 +-
 sha1_file.c       | 16 ++++++++--------
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b3f03cf..6f69593 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -515,10 +515,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				saved = shared_repository;
 				shared_repository = 0;
 				switch (safe_create_leading_directories_const(argv[0])) {
-				case -3:
+				case SCLD_EXISTS:
 					errno = EEXIST;
 					/* fallthru */
-				case -1:
+				case SCLD_FAILED:
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				default:
diff --git a/cache.h b/cache.h
index c9efe88..8030e36 100644
--- a/cache.h
+++ b/cache.h
@@ -737,8 +737,21 @@ enum sharedrepo {
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
-int safe_create_leading_directories(char *path);
-int safe_create_leading_directories_const(const char *path);
+
+/*
+ * Create the directory containing the named path, using care to be
+ * somewhat safe against races.  Return one of the scld_error values
+ * to indicate success/failure.
+ */
+enum scld_error {
+	SCLD_OK = 0,
+	SCLD_FAILED = -1,
+	SCLD_PERMS = -2,
+	SCLD_EXISTS = -3
+};
+enum scld_error safe_create_leading_directories(char *path);
+enum scld_error safe_create_leading_directories_const(const char *path);
+
 int mkdir_in_gitdir(const char *path);
 extern void home_config_paths(char **global, char **xdg, char *file);
 extern char *expand_user_path(const char *path);
diff --git a/merge-recursive.c b/merge-recursive.c
index a18bd15..8400a8e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -693,7 +693,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	/* Make sure leading directories are created */
 	status = safe_create_leading_directories_const(path);
 	if (status) {
-		if (status == -3) {
+		if (status == SCLD_EXISTS) {
 			/* something else exists */
 			error(msg, path, _(": perhaps a D/F conflict?"));
 			return -1;
diff --git a/sha1_file.c b/sha1_file.c
index 80122b2..a065308 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -105,12 +105,12 @@ int mkdir_in_gitdir(const char *path)
 	return adjust_shared_perm(path);
 }
 
-int safe_create_leading_directories(char *path)
+enum scld_error safe_create_leading_directories(char *path)
 {
 	char *next_component = path + offset_1st_component(path);
-	int ret = 0;
+	enum scld_error ret = SCLD_OK;
 
-	while (!ret && next_component) {
+	while (ret == SCLD_OK && next_component) {
 		struct stat st;
 		char *slash = strchr(next_component, '/');
 
@@ -127,26 +127,26 @@ int safe_create_leading_directories(char *path)
 		if (!stat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode))
-				ret = -3;
+				ret = SCLD_EXISTS;
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
 			else
-				ret = -1;
+				ret = SCLD_FAILED;
 		} else if (adjust_shared_perm(path)) {
-			ret = -2;
+			ret = SCLD_PERMS;
 		}
 		*slash = '/';
 	}
 	return ret;
 }
 
-int safe_create_leading_directories_const(const char *path)
+enum scld_error safe_create_leading_directories_const(const char *path)
 {
 	/* path points to cache entries, so xstrdup before messing with it */
 	char *buf = xstrdup(path);
-	int result = safe_create_leading_directories(buf);
+	enum scld_error result = safe_create_leading_directories(buf);
 	free(buf);
 	return result;
 }
-- 
1.8.5.2
