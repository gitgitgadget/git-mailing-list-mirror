From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: refactor diff options
Date: Sun, 11 Jan 2009 14:14:23 +0100
Message-ID: <1231679663-31907-1-git-send-email-trast@student.ethz.ch>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 14:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0AT-0001MM-W8
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZAKNO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 08:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbZAKNO2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:14:28 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47216 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbZAKNO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:14:27 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 14:14:25 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 14:14:24 +0100
X-Mailer: git-send-email 1.6.1.279.g41f0
X-OriginalArrivalTime: 11 Jan 2009 13:14:25.0006 (UTC) FILETIME=[865778E0:01C973EE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105175>

diff, log and show all take the same diff options.  Refactor them from
__git_diff and __git_log into a variable, and complete them in
__git_show too.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

This conflicts with the --patience series; I can send a version based
on that if it goes in first.


 contrib/completion/git-completion.bash |   38 ++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7b074d7..5017369 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -759,24 +759,29 @@ _git_describe ()
 	__gitcomp "$(__git_refs)"
 }
 
-_git_diff ()
-{
-	__git_has_doubledash && return
-
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	case "$cur" in
-	--*)
-		__gitcomp "--cached --stat --numstat --shortstat --summary
+__git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies-harder --pickaxe-all --pickaxe-regex
+			--find-copies-harder
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --exit-code --quiet --ext-diff
 			--no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
-			--base --ours --theirs
 			--inter-hunk-context=
+			--raw
+"
+
+_git_diff ()
+{
+	__git_has_doubledash && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--cached --pickaxe-all --pickaxe-regex
+			--base --ours --theirs
+			$__git_diff_common_options
 			"
 		return
 		;;
@@ -959,16 +964,15 @@ _git_log ()
 			--relative-date --date=
 			--author= --committer= --grep=
 			--all-match
-			--pretty= --name-status --name-only --raw
+			--pretty=
 			--not --all
 			--left-right --cherry-pick
 			--graph
-			--stat --numstat --shortstat
-			--decorate --diff-filter=
-			--color-words --walk-reflogs
+			--decorate
+			--walk-reflogs
 			--parents --children --full-history
 			--merge
-			--inter-hunk-context=
+			$__git_diff_common_options
 			"
 		return
 		;;
@@ -1473,7 +1477,9 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty="
+		__gitcomp "--pretty=
+			$__git_diff_common_options
+			"
 		return
 		;;
 	esac
-- 
tg: (7eb5bbd..) t/bash-complete-show (depends on: origin/master)
