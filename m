From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <jn.avila@free.fr>
Subject: [PATCH] t9902: Instruct git-completion.bash about a test mode
Date: Thu, 24 Jan 2013 22:20:08 +0100
Message-ID: <201301242220.09067.jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 22:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUFJ-0003vU-6H
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946003Ab3AXVVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 16:21:32 -0500
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:39994 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945995Ab3AXVUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 16:20:48 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id AC077D1A71E
	for <git@vger.kernel.org>; Thu, 24 Jan 2013 22:20:44 +0100 (CET)
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id AD3554B0158
	for <git@vger.kernel.org>; Thu, 24 Jan 2013 22:20:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214459>

In test mode, git completion should propose commands only if they
belong to the list of authorized commands.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---

Better show some code than try to explain. Here is what I mean by
"filter the output git help -a". 

 contrib/completion/git-completion.bash | 16 +++++++++++++++-
 t/t9902-completion.sh                  |  4 ++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 14dd5e7..6490553 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -531,6 +531,20 @@ __git_complete_strategy ()
 	return 1
 }
 
+if test -z "$AUTHORIZED_CMD_LIST"; then
+	__git_cmdlist ()
+	{ 
+		echo $1;
+	}
+else
+	__git_cmdlist ()
+	{ 
+		if [[ " $AUTHORIZED_CMD_LIST " =~ " $1 " ]] ; then
+				echo $1
+		fi
+	}
+fi
+
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
@@ -538,7 +552,7 @@ __git_list_all_commands ()
 	do
 		case $i in
 		*--*)             : helper pattern;;
-		*) echo $i;;
+		*) __git_cmdlist $i;;
 		esac
 	done
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..5e7d81e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -12,8 +12,8 @@ complete ()
 	# do nothing
 	return 0
 }
-
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+AUTHORIZED_CMD_LIST=" checkout show add filter-branch ls-files send-email describe"
+. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" 
 
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
-- 
1.8.1.1.271.g02f55e6
