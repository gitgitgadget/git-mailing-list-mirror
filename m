From: Marius Storm-Olsen <git@storm-olsen.com>
Subject: [PATCH v3] Add bare repository indicator for __git_ps1
Date: Sat, 21 Feb 2009 20:20:57 +0100
Message-ID: <1235244057-16912-1-git-send-email-git@storm-olsen.com>
Cc: git@vger.kernel.org, Marius Storm-Olsen <git@storm-olsen.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Feb 21 20:24:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaxSy-0004ZK-8m
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 20:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZBUTXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 14:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbZBUTXT
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 14:23:19 -0500
Received: from hoat.troll.no ([62.70.27.150]:42432 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbZBUTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 14:23:19 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 7DCD221110;
	Sat, 21 Feb 2009 20:23:11 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 6DAD921108;
	Sat, 21 Feb 2009 20:23:11 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc0.5.gf970
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110974>

Prefixes the branch name with "BARE:" if you're in a
bare repository.

Signed-off-by: Marius Storm-Olsen <git@storm-olsen.com>
---
 Well there you go. That's what you get for not testing your
 patch after a rebase.. another version. ;-)

 Next had progressed into handling the --inside-git-dir case,
 and would replace branch name with "GIT_DIR!". Now, that's
 not so useful when that GIT_DIR! is a bare repository, so
 this version will prefix the branch name with "BARE:"
 instead.

 contrib/completion/git-completion.bash |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec587d2..90ba428 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -117,9 +117,14 @@ __git_ps1 ()
 
 		local w
 		local i
+		local c
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
-			b="GIT_DIR!"
+			if [ "true" = "$(git config --bool core.bare 2>/dev/null)" ]; then
+				c="BARE:"
+			else
+				b="GIT_DIR!"
+			fi
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
@@ -137,9 +142,9 @@ __git_ps1 ()
 
 		if [ -n "$b" ]; then
 			if [ -n "${1-}" ]; then
-				printf "$1" "${b##refs/heads/}$w$i$r"
+				printf "$1" "$c${b##refs/heads/}$w$i$r"
 			else
-				printf " (%s)" "${b##refs/heads/}$w$i$r"
+				printf " (%s)" "$c${b##refs/heads/}$w$i$r"
 			fi
 		fi
 	fi
-- 
1.6.2.rc0.5.gf970
