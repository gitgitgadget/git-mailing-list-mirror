From: Maurice Bos <m-ou.se@m-ou.se>
Subject: [PATCH] git-prompt.sh: make '+' work for unborn branches
Date: Thu, 6 Mar 2014 00:05:24 +0100
Message-ID: <20140305233219.A6FF54284F@server>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Mar 06 00:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLLLu-0007JX-Dm
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 00:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbaCEXfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 18:35:50 -0500
Received: from m-ou.se ([95.211.166.210]:50125 "EHLO server"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756848AbaCEXft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 18:35:49 -0500
Received: by server (Postfix, from userid 1000)
	id A6FF54284F; Thu,  6 Mar 2014 00:32:19 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243494>

For unborn branches, it now compares the index against the empty tree.
(Just like git status does.)

Signed-off-by: Maurice Bos <m-ou.se@m-ou.se>
---
 contrib/completion/git-prompt.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 7b732d2..f656838 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -407,12 +407,14 @@ __git_ps1 ()
 		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
 		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
 		then
-			git diff --no-ext-diff --quiet --exit-code || w="*"
-			if [ -n "$short_sha" ]; then
-				git diff-index --cached --quiet HEAD -- || i="+"
-			else
+			local treeish=HEAD
+			if [ -z "$short_sha" ]; then
 				i="#"
+				# the empty tree
+				treeish=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 			fi
+			git diff --no-ext-diff --quiet --exit-code || w="*"
+			git diff-index --cached --quiet $treeish -- || i="$i+"
 		fi
 		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
 		   [ -r "$g/refs/stash" ]; then
-- 
1.8.5.rc0.23.gaa27064
