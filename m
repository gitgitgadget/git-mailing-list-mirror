From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] bash completion: refactor diff options
Date: Mon, 19 Jan 2009 22:18:00 +0100
Message-ID: <1232399880-22036-2-git-send-email-trast@student.ethz.ch>
References: <20090119173153.GB14053@spearce.org>
 <1232399880-22036-1-git-send-email-trast@student.ethz.ch>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 22:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP1aL-0008BU-Ai
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 22:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbZASVVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 16:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbZASVR7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 16:17:59 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52795 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080AbZASVR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 16:17:57 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Jan 2009 22:17:55 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Jan 2009 22:17:55 +0100
X-Mailer: git-send-email 1.6.1.389.g45b4ee
In-Reply-To: <1232399880-22036-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Jan 2009 21:17:55.0224 (UTC) FILETIME=[65157180:01C97A7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106392>

diff, log and show all take the same diff options.  Refactor them from
__git_diff and __git_log into a variable, and complete them in
__git_show too.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 contrib/completion/git-completion.bash |   36 ++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 096603b..bfae953 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -773,14 +773,7 @@ _git_describe ()
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
@@ -789,9 +782,21 @@ _git_diff ()
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
@@ -977,17 +982,16 @@ _git_log ()
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
 			--pickaxe-all --pickaxe-regex
 			"
 		return
@@ -1492,7 +1496,9 @@ _git_show ()
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
tg: (3f8c856..) t/bash-complete-show (depends on: origin/next t/bash-complete-pickaxe t/bash-complete-pickaxe)
