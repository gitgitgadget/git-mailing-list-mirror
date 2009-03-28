From: Sebastian Pipping <webmaster@hartwork.org>
Subject: [PATCH] Add diffuse as merge and diff tool
Date: Sat, 28 Mar 2009 23:25:38 +0100
Message-ID: <49CEA3E2.9020805@hartwork.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010203080400080000020904"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 23:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lngzk-0000Ce-Co
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 23:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZC1WZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbZC1WZn
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 18:25:43 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:33054 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbZC1WZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 18:25:42 -0400
Received: from [85.179.0.255] (helo=[192.168.0.3])
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1LngyB-0004Jy-4I
	for git@vger.kernel.org; Sat, 28 Mar 2009 23:25:39 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114985>

This is a multi-part message in MIME format.
--------------010203080400080000020904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------010203080400080000020904
Content-Type: text/x-patch;
 name="git-diffuse-mergetool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-diffuse-mergetool.patch"

>From e54c153a67cef9b162eb51f4b7cefb65e59c3a13 Mon Sep 17 00:00:00 2001
From: Sebastian Pipping <sebastian@pipping.org>
Date: Thu, 26 Mar 2009 20:42:31 +0100
Subject: [PATCH] Add diffuse as merge and diff tool

---
 Documentation/git-mergetool.txt        |    3 ++-
 Documentation/merge-config.txt         |    7 ++++---
 contrib/completion/git-completion.bash |    3 ++-
 contrib/difftool/git-difftool-helper   |   12 ++++++++----
 contrib/difftool/git-difftool.txt      |    4 ++--
 git-gui/lib/mergetool.tcl              |    7 +++++++
 git-mergetool.sh                       |   15 ++++++++++++---
 7 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 5d3c632..c3a8092 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,7 +26,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
+	diffuse and opendiff
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 1ff08ff..ef07cf2 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -22,9 +22,10 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
-	"opendiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
+	"diffuse" and "opendiff".  Any other value is treated is custom
+	merge tool and there must be a corresponding mergetool.<tool>.cmd
+	option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1c6b0e2..2e7a9d7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1173,7 +1173,8 @@ _git_mergetool ()
 	--tool=*)
 		__gitcomp "
 			kdiff3 tkdiff meld xxdiff emerge
-			vimdiff gvimdiff ecmerge opendiff
+			vimdiff gvimdiff ecmerge diffuse
+			opendiff
 			" "" "${cur##--tool=}"
 		return
 		;;
diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index 9c0a134..ea44e4e 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -1,6 +1,6 @@
 #!/bin/sh
 # git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
-# It supports kdiff3, kompare, tkdiff, xxdiff, meld, opendiff,
+# It supports kdiff3, kompare, tkdiff, xxdiff, meld, diffuse, opendiff,
 # emerge, ecmerge, vimdiff, gvimdiff, and custom user-configurable tools.
 # This script is typically launched by using the 'git difftool'
 # convenience command.
@@ -103,6 +103,10 @@ launch_merge_tool () {
 			"$LOCAL" "$REMOTE"
 		;;
 
+	diffuse)
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		;;
+
 	opendiff)
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			-merge "$MERGED" | cat
@@ -140,7 +144,7 @@ valid_custom_tool() {
 # Built-in merge tools are always valid.
 valid_tool() {
 	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+	kdiff3 | kompare | tkdiff | xxdiff | meld | diffuse | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
 		;; # happy
 	*)
 		if ! valid_custom_tool "$1"
@@ -194,9 +198,9 @@ if test -z "$merge_tool"; then
 	if test -n "$DISPLAY"; then
 		# If gnome then prefer meld, otherwise, prefer kdiff3 or kompare
 		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-			merge_tool_candidates="meld kdiff3 kompare tkdiff xxdiff gvimdiff"
+			merge_tool_candidates="meld kdiff3 kompare tkdiff xxdiff gvimdiff diffuse"
 		else
-			merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff"
+			merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff diffuse"
 		fi
 	fi
 	if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 2b7bc03..6419d37 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -28,8 +28,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
-	vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
+	ecmerge, diffuse and opendiff
 +
 If a merge resolution program is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index eb2b4b5..658c021 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -219,6 +219,13 @@ proc merge_resolve_tool2 {} {
 			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED"]
 		}
 	}
+	diffuse {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" "$BASE" ]
+		} else {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" ]
+		}
+	}
 	ecmerge {
 		if {$base_stage ne {}} {
 			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..2c96da1 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -239,6 +239,15 @@ merge_file () {
 	    fi
 	    check_unchanged
 	    ;;
+	diffuse)
+	    touch "$BACKUP"
+	    if base_present; then
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" "$BASE" | cat
+	    else
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" | cat
+	    fi
+	    check_unchanged
+	    ;;
 	opendiff)
 	    touch "$BACKUP"
 	    if base_present; then
@@ -345,7 +354,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		kdiff3 | tkdiff | xxdiff | meld | diffuse | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
 			;; # happy
 		*)
 			if ! valid_custom_tool "$1"; then
@@ -398,9 +407,9 @@ fi
 if test -z "$merge_tool" ; then
     if test -n "$DISPLAY"; then
         if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
+            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff diffuse"
         else
-            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff diffuse"
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-- 
1.6.2.1-2808-gb0085a7


--------------010203080400080000020904--
