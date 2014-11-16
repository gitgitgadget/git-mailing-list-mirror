From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Sun, 16 Nov 2014 08:21:48 +0100
Message-ID: <1416122508-30654-3-git-send-email-mhagger@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 08:33:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpuLO-0000TR-O7
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 08:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbaKPH3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 02:29:10 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50262 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656AbaKPH3J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 02:29:09 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Nov 2014 02:29:08 EST
X-AuditID: 12074412-f79866d000000bd1-8d-546850981554
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 37.3E.03025.89058645; Sun, 16 Nov 2014 02:22:00 -0500 (EST)
Received: from michael.fritz.box (p4FC97A4A.dip0.t-ipconnect.de [79.201.122.74])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAG7Lrk8002608
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 16 Nov 2014 02:21:58 -0500
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqDsjICPEYP8zYYuuK91MFg29V5gt
	Fv47ym7xf8cCFovbK+YzW+xvSrJY072DyaKz4yujA4fH3/cfmDx2zrrL7nHsWCuzx8VLyh6f
	N8l53H62jcWjecp51gD2KG6bpMSSsuDM9Dx9uwTujAlXm5kKbslX7J9wnK2BsVmyi5GTQ0LA
	ROLS3V2MELaYxIV769m6GLk4hAQuM0rsmXGQEcI5wSRx5ulvJpAqNgFdiUU9zWC2iICaxMS2
	QywgRcwC25gkvs37xw6SEBYIlZj39x0biM0ioCqx6WQ/WJxXwEXi86ZJTBDr5CT2Tl7NAmJz
	CrhKnHy5GKxeCKhmVcdv1gmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWm
	lG5ihISh0A7G9SflDjEKcDAq8fBusMgIEWJNLCuuzD3EKMnBpCTKG+oEFOJLyk+pzEgszogv
	Ks1JLT7EKMHBrCTCu8YUKMebklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8Gh
	JMEb6w/UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjvhiYHyApHiA9k4Eaect
	LkjMBYpCtJ5iVJQS580HSQiAJDJK8+DGwpLLK0ZxoC+FeX+DVPEAExNc9yugwUxAgxmPpYIM
	LklESEk1MOYnlO+d5C5UcmR2zDXuCK4Wx/IIj8WdgjM+nRH/VXFkzfLHZ54qrosUagsx/XH9
	2GrmDMuMsM2c0aYKh84tT3pYwHsmIXDHZjODw93Hujm+W37kllrwxWFN8b59BQJ6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no reason for $GIT_DIR/config to be executable, plus there
used to be a bug (fixed by the previous commit) that caused "git init"
to set the u+x bit on that file. So whenever rewriting the config
file, take the opportunity to remove any executable bits that the file
might have.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/config.c       | 21 ++++++++++++++++++---
 config.c               | 12 ++++++++++--
 t/t1300-repo-config.sh | 13 +++++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 7bba516..1a7c17e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -551,6 +551,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 	}
 	else if (actions == ACTION_EDIT) {
+		char *config_file;
+		struct stat st;
+
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
 			die("not in a git directory");
@@ -559,9 +562,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
-		launch_editor(given_config_source.file ?
-			      given_config_source.file : git_path("config"),
-			      NULL, NULL);
+		config_file = xstrdup(given_config_source.file ?
+				      given_config_source.file : git_path("config"));
+		launch_editor(config_file, NULL, NULL);
+
+		/*
+		 * In git 2.1, there was a bug in "git init" that left
+		 * the u+x bit set on the config file. To clean up any
+		 * repositories affected by that bug, and just because
+		 * it doesn't make sense for a config file to be
+		 * executable anyway, clear any executable bits from
+		 * the file (on a "best effort" basis):
+		 */
+		if (!lstat(config_file, &st) && (st.st_mode & 0111))
+			chmod(config_file, st.st_mode & 07666);
+		free(config_file);
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
diff --git a/config.c b/config.c
index 9e42d38..47eaef4 100644
--- a/config.c
+++ b/config.c
@@ -1653,7 +1653,15 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
-		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+		/*
+		 * We mask off the executable bits because (a) it
+		 * doesn't make sense to have executable bits set on
+		 * the config file, and (b) there was a bug in git 2.1
+		 * which caused the config file to be created with u+x
+		 * set, so this will help repair repositories created
+		 * with that version.
+		 */
+		if (chmod(lock->filename, st.st_mode & 07666) < 0) {
 			error("chmod on %s failed: %s",
 				lock->filename, strerror(errno));
 			ret = CONFIG_NO_WRITE;
@@ -1832,7 +1840,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	fstat(fileno(config_file), &st);
 
-	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+	if (chmod(lock->filename, st.st_mode & 07666) < 0) {
 		ret = error("chmod on %s failed: %s",
 				lock->filename, strerror(errno));
 		goto out;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 46f6ae2..7637701 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -7,6 +7,12 @@ test_description='Test git config in different settings'
 
 . ./test-lib.sh
 
+test_expect_success POSIXPERM 'any executable bits cleared' '
+	chmod u+x .git/config &&
+	git config test.me foo &&
+	test ! -x .git/config
+'
+
 test_expect_success 'clear default config' '
 	rm -f .git/config
 '
@@ -1078,6 +1084,13 @@ test_expect_success 'git config --edit respects core.editor' '
 	test_cmp expect actual
 '
 
+test_expect_success POSIXPERM 'git config --edit clears executable bits' '
+	git config -f tmp test.value no &&
+	chmod u+x tmp &&
+	GIT_EDITOR="echo [test]value=yes >" git config -f tmp --edit &&
+	test ! -x tmp
+'
+
 # malformed configuration files
 test_expect_success 'barf on syntax error' '
 	cat >.git/config <<-\EOF &&
-- 
2.1.1
