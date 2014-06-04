From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 09/11] lib-prompt-tests.sh: add variable for string that encodes percent in PS1
Date: Wed,  4 Jun 2014 17:01:25 -0400
Message-ID: <1401915687-8602-10-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:03:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsILQ-0006YF-7J
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaFDVD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:03:26 -0400
Received: from smtp.bbn.com ([128.33.0.80]:30083 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbaFDVB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:01:58 -0400
Received: from socket.bbn.com ([192.1.120.102]:34541)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJq-000IYU-BP; Wed, 04 Jun 2014 17:01:58 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 25D463FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250792>

To add a literal percent character to a Zsh prompt, the string "%%" is
used in PS1.  Bash and POSIX shells simply use "%".  To accommodate
this difference, use ${percent} where a percent character is expected
and define the percent variable in the set_ps1_format_vars function.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-bash.sh         |  1 +
 t/lib-prompt-tests.sh | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 9d428bd..8a030ac 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -19,6 +19,7 @@ shellname=Bash
 ps1_expansion_enable () { shopt -s promptvars; }
 ps1_expansion_disable () { shopt -u promptvars; }
 set_ps1_format_vars () {
+	percent='%%'
 	c_red='\\[\\e[31m\\]'
 	c_green='\\[\\e[32m\\]'
 	c_lblue='\\[\\e[1;34m\\]'
diff --git a/t/lib-prompt-tests.sh b/t/lib-prompt-tests.sh
index ba22acc..c6226b1 100644
--- a/t/lib-prompt-tests.sh
+++ b/t/lib-prompt-tests.sh
@@ -12,10 +12,11 @@
 #      (non-zero) and ps1_expansion_disable should simply return
 #      non-zero (0)
 #   3. define a function named set_ps1_format_vars that sets the
-#      variables c_red, c_green, c_lblue, and c_clear to the strings
-#      that __git_ps1 uses to add color to the prompt.  The values of
-#      these variables are used in the first argument to the printf
-#      command, so they must be escaped appropriately.
+#      variables percent, c_red, c_green, c_lblue, and c_clear to the
+#      strings that __git_ps1 uses to add percent characters and color
+#      to the prompt.  The values of these variables are used in the
+#      first argument to the printf command, so they must be escaped
+#      appropriately.
 #   4. source this library
 #   5. invoke the run_prompt_tests function
 
@@ -403,7 +404,7 @@ newline'
 	'
 
 	test_expect_success "$pfx - untracked files status indicator - untracked files" '
-		printf " (master %%)" >expected &&
+		printf " (master ${percent})" >expected &&
 		(
 			GIT_PS1_SHOWUNTRACKEDFILES=y &&
 			__git_ps1 >"$actual"
@@ -442,7 +443,7 @@ newline'
 	'
 
 	test_expect_success "$pfx - untracked files status indicator - shell variable set with config enabled" '
-		printf " (master %%)" >expected &&
+		printf " (master ${percent})" >expected &&
 		test_config bash.showUntrackedFiles true &&
 		(
 			GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -632,7 +633,7 @@ _run_pcmode_tests () {
 
 	test_expect_success "$pfx - untracked files status indicator" '
 		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}%%${c_clear}):AFTER\\n%s" master &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}${percent}${c_clear}):AFTER\\n%s" master &&
 		(
 			GIT_PS1_SHOWUNTRACKEDFILES=y &&
 			GIT_PS1_SHOWCOLORHINTS=y &&
-- 
2.0.0
