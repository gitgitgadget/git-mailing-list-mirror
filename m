From: Scott Kyle <scott@appden.com>
Subject: [PATCH] completion: Add PS1 configuration for submodules
Date: Mon,  6 Dec 2010 15:22:43 -0800
Message-ID: <1291677763-55385-1-git-send-email-scott@appden.com>
Cc: Scott Kyle <scott@appden.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:23:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkOj-0004qq-72
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab0LFXW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:22:59 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57580 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab0LFXW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:22:58 -0500
Received: by iwn9 with SMTP id 9so782434iwn.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:22:56 -0800 (PST)
Received: by 10.231.33.137 with SMTP id h9mr6582202ibd.117.1291677775994;
        Mon, 06 Dec 2010 15:22:55 -0800 (PST)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm7975260wfd.22.2010.12.06.15.22.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:22:54 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.574.g98527
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163061>

For those who often work on repositories with submodules, the dirty
indicator for unstaged changes will almost always show because development
is simultaneously happening on those submodules. The config option
diff.ignoreSubmodules is not appropriate for this use because it has larger
implications.

Signed-off-by: Scott Kyle <scott@appden.com>
---
 contrib/completion/git-completion.bash |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 604fa79..539bcb1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -37,7 +37,9 @@
 #       value, unstaged (*) and staged (+) changes will be shown next
 #       to the branch name.  You can configure this per-repository
 #       with the bash.showDirtyState variable, which defaults to true
-#       once GIT_PS1_SHOWDIRTYSTATE is enabled.
+#       once GIT_PS1_SHOWDIRTYSTATE is enabled.  You can also set
+#       GIT_PS1_IGNORESUBMODULES to a value that git diff understands
+#       to adjust the behavior of the dirty state indicator.
 #
 #       You can also see if currently something is stashed, by setting
 #       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
@@ -286,7 +288,8 @@ __git_ps1 ()
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
-					git diff --no-ext-diff --quiet --exit-code || w="*"
+					local ignore_submodules=${GIT_PS1_IGNORESUBMODULES+"--ignore-submodules=$GIT_PS1_IGNORESUBMODULES"}
+					git diff $ignore_submodules --no-ext-diff --quiet --exit-code || w="*"
 					if git rev-parse --quiet --verify HEAD >/dev/null; then
 						git diff-index --cached --quiet HEAD -- || i="+"
 					else
-- 
1.7.3.3.574.g98527
