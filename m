From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] sha1_name: use strlcpy() to copy strings
Date: Sat, 21 Feb 2015 20:55:22 +0100
Message-ID: <54E8E2AA.1020300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:56:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPG9d-00047B-J5
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 20:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbbBUTzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 14:55:53 -0500
Received: from mout.web.de ([212.227.15.14]:52564 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbBUTzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 14:55:53 -0500
Received: from [192.168.178.27] ([79.253.189.194]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lc8aj-1XiTCl01m1-00jXQe; Sat, 21 Feb 2015 20:55:42
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:nfy3jPRXk0ahrGh5FN/xA41LJ+jzGgHBoMaFJDLOzK5C82XxvOf
 fE8Ut8e3PRowDa1G4FL0NDgz8uWHodp8I/RkcltGH5lneTlEzSlllo31M9gYXYGUOy2tYO9
 BmESOJ3tUYw0Bzm8goakboyANFNko7tPmeRuwrs2pwBNwRLtipTalp58lX+yxlAg1ben8kQ
 5Y7DWtv8bigqoYen3qcfg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264227>

Use strlcpy() instead of calling strncpy() and then setting the last
byte of the target buffer to NUL explicitly.  This shortens and
simplifies the code a bit.

Signed-of-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_name.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index cf2a83b..95f9f8f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1391,9 +1391,7 @@ static int get_sha1_with_context_1(const char *name,
 			namelen = strlen(cp);
 		}
 
-		strncpy(oc->path, cp,
-			sizeof(oc->path));
-		oc->path[sizeof(oc->path)-1] = '\0';
+		strlcpy(oc->path, cp, sizeof(oc->path));
 
 		if (!active_cache)
 			read_cache();
@@ -1443,9 +1441,7 @@ static int get_sha1_with_context_1(const char *name,
 							   name, len);
 			}
 			hashcpy(oc->tree, tree_sha1);
-			strncpy(oc->path, filename,
-				sizeof(oc->path));
-			oc->path[sizeof(oc->path)-1] = '\0';
+			strlcpy(oc->path, filename, sizeof(oc->path));
 
 			free(new_filename);
 			return ret;
-- 
2.3.0
