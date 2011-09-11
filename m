From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/3] Fix some "variable might be used uninitialized" warnings
Date: Sun, 11 Sep 2011 20:39:32 +0100
Message-ID: <4E6D0E74.1020801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pxe-0005Fj-AA
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1IKTo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:44:56 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:36422 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab1IKToy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:44:54 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pxU-00049R-fg; Sun, 11 Sep 2011 19:44:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181188>


In particular, gcc complains as follows:

        CC tree-walk.o
    tree-walk.c: In function `traverse_trees':
    tree-walk.c:347: warning: 'e' might be used uninitialized in this \
        function

        CC builtin/revert.o
    builtin/revert.c: In function `verify_opt_mutually_compatible':
    builtin/revert.c:113: warning: 'opt2' might be used uninitialized in \
        this function

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/revert.c |    2 +-
 tree-walk.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5f1cee8..30538a1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -110,7 +110,7 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 
 static void verify_opt_mutually_compatible(const char *me, ...)
 {
-	const char *opt1, *opt2;
+	const char *opt1, *opt2 = NULL;
 	va_list ap;
 
 	va_start(ap, me);
diff --git a/tree-walk.c b/tree-walk.c
index 808bb55..a8d8a66 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -344,7 +344,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		unsigned long mask, dirmask;
 		const char *first = NULL;
 		int first_len = 0;
-		struct name_entry *e;
+		struct name_entry *e = NULL;
 		int len;
 
 		for (i = 0; i < n; i++) {
-- 
1.7.6
