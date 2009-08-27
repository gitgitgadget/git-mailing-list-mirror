From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] abspath.c: move declaration of 'len' into inner block and use appropriate type
Date: Thu, 27 Aug 2009 11:16:33 -0500
Message-ID: <vODpKBYr5sNtCfB7C_mUMmQyYO9vzbX98QMYSBId5GcwHT7q6zvrKlJpRNwoJvTTF7qKScin5PA@cipher.nrlssc.navy.mil>
References: <vODpKBYr5sNtCfB7C_mUMqGkpPTwc8quzfdAUjySMC_tekZRVbEOpzkstotoeMXAS6wJ4OaF2NA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 18:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MghfE-0005cB-L8
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZH0QRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbZH0QRR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:17:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34296 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZH0QRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:17:17 -0400
Received: by mail.nrlssc.navy.mil id n7RGGr9G031868; Thu, 27 Aug 2009 11:16:53 -0500
In-Reply-To: <vODpKBYr5sNtCfB7C_mUMqGkpPTwc8quzfdAUjySMC_tekZRVbEOpzkstotoeMXAS6wJ4OaF2NA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 27 Aug 2009 16:16:52.0698 (UTC) FILETIME=[C9DBB3A0:01CA2731]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127170>

From: Brandon Casey <drafnel@gmail.com>

The 'len' variable was declared at the beginning of the make_absolute_path
function and also in an inner 'if' block which masked the outer declaration.
It is only used in two 'if' blocks, so remove the outer declaration and
make a new declaration inside the other 'if' block that uses 'len'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 abspath.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/abspath.c b/abspath.c
index 4bee0ba..b88122c 100644
--- a/abspath.c
+++ b/abspath.c
@@ -18,7 +18,7 @@ const char *make_absolute_path(const char *path)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
 	char cwd[1024] = "";
-	int buf_index = 1, len;
+	int buf_index = 1;
 
 	int depth = MAXDEPTH;
 	char *last_elem = NULL;
@@ -50,7 +50,7 @@ const char *make_absolute_path(const char *path)
 			die_errno ("Could not get current working directory");
 
 		if (last_elem) {
-			int len = strlen(buf);
+			size_t len = strlen(buf);
 			if (len + strlen(last_elem) + 2 > PATH_MAX)
 				die ("Too long path name: '%s/%s'",
 						buf, last_elem);
@@ -61,7 +61,7 @@ const char *make_absolute_path(const char *path)
 		}
 
 		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
-			len = readlink(buf, next_buf, PATH_MAX);
+			ssize_t len = readlink(buf, next_buf, PATH_MAX);
 			if (len < 0)
 				die_errno ("Invalid symlink '%s'", buf);
 			if (PATH_MAX <= len)
-- 
1.6.4
