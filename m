From: linux@horizon.com
Subject: Re: Make ref resolution saner
Date: 12 Sep 2006 14:57:28 -0400
Message-ID: <20060912185728.29885.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Sep 12 20:58:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNDRx-0004wS-JH
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 20:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWILS5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWILS5a
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 14:57:30 -0400
Received: from science.horizon.com ([192.35.100.1]:40510 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030360AbWILS53
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 14:57:29 -0400
Received: (qmail 29886 invoked by uid 1000); 12 Sep 2006 14:57:28 -0400
To: git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26891>

I just noticed as part of that patch that building the path of
$GIT_DIR/HEAD is no longer necessary, which is the middle hunk,
and the other two jumped out at me while looking at the code.

(On top of Linus' patch.)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 23b7714..f4a6d1f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -203,7 +203,6 @@ static void create_default_files(const c
 	 * shared-repository settings, we would need to fix them up.
 	 */
 	if (shared_repository) {
-		path[len] = 0;
 		adjust_shared_perm(path);
 		strcpy(path + len, "refs");
 		adjust_shared_perm(path);
@@ -217,7 +216,6 @@ static void create_default_files(const c
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	strcpy(path + len, "HEAD");
 	if (read_ref("HEAD", sha1) < 0) {
 		if (create_symref("HEAD", "refs/heads/master") < 0)
 			exit(1);
@@ -227,7 +225,6 @@ static void create_default_files(const c
 	sprintf(repo_version_string, "%d", GIT_REPO_VERSION);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
-	path[len] = 0;
 	strcpy(path + len, "config");
 
 	/* Check filemode trustability */
