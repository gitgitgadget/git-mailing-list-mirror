From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] dir: simplify fill_directory()
Date: Fri, 11 May 2012 16:59:25 +0200
Message-ID: <4FAD294D.4010101@lsrfire.ath.cx>
References: <4FAD27D3.7070208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 16:59:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSrJs-0007tu-4J
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 16:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759952Ab2EKO7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 10:59:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:60080 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233Ab2EKO7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 10:59:39 -0400
Received: from [192.168.2.105] (p579BEA13.dip.t-dialin.net [87.155.234.19])
	by india601.server4you.de (Postfix) with ESMTPSA id 1E57C2F803C;
	Fri, 11 May 2012 16:59:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FAD27D3.7070208@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197677>

Now that read_directory_recursive() (reached through read_directory())
respects the string length limit we provide, we don't need to create a
NUL-limited copy of the common prefix anymore.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 dir.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index d5444fb..ed1510f 100644
--- a/dir.c
+++ b/dir.c
@@ -74,7 +74,6 @@ char *common_prefix(const char **pathspec)
 
 int fill_directory(struct dir_struct *dir, const char **pathspec)
 {
-	const char *path;
 	size_t len;
 
 	/*
@@ -82,15 +81,9 @@ int fill_directory(struct dir_struct *dir, const char **pathspec)
 	 * use that to optimize the directory walk
 	 */
 	len = common_prefix_len(pathspec);
-	path = "";
-
-	if (len)
-		path = xmemdupz(*pathspec, len);
 
 	/* Read the directory and prune it */
-	read_directory(dir, path, len, pathspec);
-	if (*path)
-		free((char *)path);
+	read_directory(dir, pathspec ? *pathspec : "", len, pathspec);
 	return len;
 }
 
-- 
1.7.10.1
