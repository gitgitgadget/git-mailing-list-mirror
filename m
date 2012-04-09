From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Mon,  9 Apr 2012 15:27:56 +0200
Message-ID: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 15:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHEfU-0008ER-I2
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 15:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab2DIN3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 09:29:35 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34204 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2DIN3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 09:29:34 -0400
Received: by wibhj6 with SMTP id hj6so2358785wib.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dgubeN7uCkj6xsXjSQp8ElWJK5Q6n0KBsDwTzQrsGw4=;
        b=ow3Qi6D7gD6FXTudISjOBZekiMU8418NqcfbQMWBrP4pPtYoIfufk1Ctcl30kEhJlw
         JpCxQ17wHrn2aV33u/b8aXscHPXDaTeX92AhnsSLbKXgj84Vm1EktfW3Rvl1DyVAypMR
         OpcijWrjkB1Y6dx/aNMZcN3iYvle+sR8QSbbUupaB+N7Qc2zQxJ8s7hz57oDo//M7Crt
         FNT6AWErYI712PQpiF5z4Kdjw3iWYejQlMBbCmQ1Ofr1DaD33NR893abvqBfuRvUNWHb
         Jwj4XZnf8eiAlWOUv/7vi43AnbfA6BnCMvi618Ion2zGM7GuDz5jsI80OWTGwJnUx1Xp
         RUVQ==
Received: by 10.180.104.231 with SMTP id gh7mr15848535wib.10.1333978173124;
        Mon, 09 Apr 2012 06:29:33 -0700 (PDT)
Received: from localhost.localdomain (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id 17sm31788189wis.0.2012.04.09.06.29.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Apr 2012 06:29:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195015>

Print out a trailing newline when --show-prefix is run with cwd
at the top level of the tree which results in an empty prefix.
Behavior is now like --show-cdup.

Fixes an expected failure in t1501.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
 builtin/rev-parse.c |    2 ++
 t/t1501-worktree.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 98d1cbe..733f626 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -634,6 +634,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
+				else
+					putchar('\n');
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index e661147..8f36aa9 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -68,7 +68,7 @@ test_expect_success 'inside work tree' '
 	)
 '
 
-test_expect_failure 'empty prefix is actually written out' '
+test_expect_success 'empty prefix is actually written out' '
 	echo >expected &&
 	(
 		cd work &&
-- 
1.7.10
