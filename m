From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Add Code Compare v2.80.4 as a merge / diff tool for Windows
Date: Wed, 08 Aug 2012 22:31:12 +0200
Message-ID: <5022CC90.3060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 22:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzCv1-0008Kj-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236Ab2HHUbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:31:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:38717 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab2HHUbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:31:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SzCud-0007ku-9U
	for git@vger.kernel.org; Wed, 08 Aug 2012 22:31:27 +0200
Received: from p5ddb050a.dip0.t-ipconnect.de ([93.219.5.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 22:31:27 +0200
Received: from sschuberth by p5ddb050a.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 22:31:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb050a.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203123>

Code Compare is a commercial file comparison tool for Windows, see

    http://www.devart.com/codecompare/

Version 2.80.4 added support for command line arguments preceded by a
dash instead of a slash. This is required for Git for Windows because
slashes in command line arguments get mangled with according to these
rules:

    http://www.mingw.org/wiki/Posix_path_conversion

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/merge-config.txt         |  8 ++++----
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  |  2 +-
 mergetools/codecompare                 | 25 +++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 mergetools/codecompare

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 861bd6f..e9e0d55 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -54,10 +54,10 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
-	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
-	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
-	and "xxdiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
+	"bc3", "codecompare", "diffuse", "ecmerge", "emerge", "gvimdiff",
+	"kdiff3", "meld", "opendiff", "p4merge", "tkdiff", "tortoisemerge",
+	"vimdiff" and "xxdiff".  Any other value is treated is custom merge
+	tool and there must be a corresponding mergetool.<tool>.cmd option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffedce7..222b804 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1071,7 +1071,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f730253..54cb708 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -126,7 +126,7 @@ list_merge_tool_candidates () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/codecompare b/mergetools/codecompare
new file mode 100644
index 0000000..3f0486b
--- /dev/null
+++ b/mergetools/codecompare
@@ -0,0 +1,25 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" -BF="$BASE" \
+			-RF="$MERGED"
+	else
+		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" \
+			-RF="$MERGED"
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	if merge_mode
+	then
+		echo CodeMerge
+	else
+		echo CodeCompare
+	fi
+}
-- 
1.7.11.msysgit.3
