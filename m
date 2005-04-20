From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 2/3] init-db.c: normalize env var handling.
Date: Tue, 19 Apr 2005 21:28:39 -0700
Message-ID: <mailbox-1242-1113971319-971926@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:25:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6lh-0007Cs-43
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVDTE27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDTE24
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:28:56 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:21391 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261352AbVDTE2o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 00:28:44 -0400
Received: (qmail 1255 invoked by uid 5006); 19 Apr 2005 21:28:44 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-1242-1113971319-958842@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch applies on top of:
        [PATCH 1/3] init-db.c: cleanup comments

 init-db.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>

Normalize init-db environment variable handling, allowing the creation
of object directories with something other than DEFAULT_DB_ENVIRONMENT.

--- a/init-db.c
+++ b/init-db.c
@@ -22,15 +22,10 @@ int main(int argc, char **argv)
 	}
 
 	sha1_dir = getenv(DB_ENVIRONMENT);
-	if (sha1_dir) {
-		struct stat st;
-		if (!stat(sha1_dir, &st) && S_ISDIR(st.st_mode))
-			return 0;
-		fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
+	if (!sha1_dir) {
+		sha1_dir = DEFAULT_DB_ENVIRONMENT;
+		fprintf(stderr, "defaulting to local storage area\n");
 	}
-
-	sha1_dir = DEFAULT_DB_ENVIRONMENT;
-	fprintf(stderr, "defaulting to private storage area\n");
 	len = strlen(sha1_dir);
 	if (mkdir(sha1_dir, 0755) < 0) {
 		if (errno != EEXIST) {
