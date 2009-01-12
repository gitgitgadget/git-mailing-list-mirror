From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] bash completion: refactor diff options
Date: Mon, 12 Jan 2009 10:16:57 +0100
Message-ID: <1231751817-17688-1-git-send-email-trast@student.ethz.ch>
References: <1231679663-31907-1-git-send-email-trast@student.ethz.ch>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 10:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIw3-0001SR-AY
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZALJQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbZALJQx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:16:53 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:8184 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbZALJQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:16:52 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 10:16:51 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 10:16:50 +0100
X-Mailer: git-send-email 1.6.1.310.g1063e
In-Reply-To: <1231679663-31907-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 12 Jan 2009 09:16:50.0608 (UTC) FILETIME=[8078B300:01C97496]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105308>

diff, log and show all take the same diff options.  Refactor them from
__git_diff and __git_log into a variable, and complete them in
__git_show too.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

js/patience-diff is now in next, so here's a version on top of that.


 contrib/completion/git-completion.bash |   38 ++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dee75b5..39ae7a3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -759,25 +759,30 @@ _git_describe ()
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
 			--patience
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
@@ -960,17 +965,16 @@ _git_log ()
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
 			--inter-hunk-context=
-			--patience
+			$__git_diff_common_options
 			"
 		return
 		;;
@@ -1475,7 +1479,9 @@ _git_show ()
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
tg: (f5cbdbb..) t/bash-complete-show (depends on: origin/next)
