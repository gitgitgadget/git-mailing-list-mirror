From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Avoid using non-POSIX cp options
Date: Tue,  1 Jan 2013 20:13:17 +0000
Message-ID: <1357071197-7927-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 01 22:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq97t-0003KJ-3V
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab3AAVLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:11:32 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:49910 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3AAVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:11:30 -0500
X-Greylist: delayed 3494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2013 16:11:29 EST
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:40374 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1Tq8D4-0005vm-CC ; Tue, 01 Jan 2013 15:13:14 -0500
Received: from 86-44-4-31-dynamic.b-ras1.bbh.dublin.eircom.net ([86.44.4.31]:38410 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1Tq8D1-0003Op-MU ; Tue, 01 Jan 2013 15:13:11 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1Tq8Dk-00024N-4s; Tue, 01 Jan 2013 20:13:56 +0000
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212442>

t/3600-rm was using the -a option to cp.  This option is a GNU extention
and is not portable.  Instead, use just -R (no -p necessary).

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t3600-rm.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 06f6384..37bf5f1 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -474,7 +474,7 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	git submodule update &&
 	(cd submod &&
 		rm .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git merge conflict2 &&
@@ -508,7 +508,7 @@ test_expect_success 'rm of a populated submodule with a .git directory fails eve
 	git submodule update &&
 	(cd submod &&
 		rm .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git rm submod &&
@@ -606,7 +606,7 @@ test_expect_success 'rm of a populated nested submodule with a nested .git direc
 	git submodule update --recursive &&
 	(cd submod/subsubmod &&
 		rm .git &&
-		cp -a ../../.git/modules/sub/modules/sub .git &&
+		cp -R ../../.git/modules/sub/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git rm submod &&
-- 
1.7.10.4
