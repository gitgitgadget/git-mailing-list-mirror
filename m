From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] mergetool-lib: add diffuse as merge and diff tool
Date: Thu,  2 Apr 2009 03:30:46 -0700
Message-ID: <1238668246-762-3-git-send-email-davvid@gmail.com>
References: <1238668246-762-1-git-send-email-davvid@gmail.com>
 <1238668246-762-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Sebastian Pipping <sebastian@pipping.org>,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 12:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpKEV-0000C6-8S
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 12:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbZDBKbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 06:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757166AbZDBKbW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 06:31:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:1874 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbZDBKbV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 06:31:21 -0400
Received: by rv-out-0506.google.com with SMTP id f9so556998rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ORGk7nTOtzFZYXVv+/33+aSVlHR5fBmQceGOdS+BAlU=;
        b=uF1Ns6F6yh96qoeV3aOX3bo5oiIiGm4G6y96mYwM+ojV3dRJZH/jlPv1TeyPIul6fH
         dvh+6nouBQ+38aLs83rmW89Ef9d8wIvw5+A4Ic167HHoZyNDWjTUYA9cSYXrt34ky8VE
         Nr8kd69laI6vK2MB8nDF00Z0+UiJ6LJGFz4FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JFE7ziHfKlHjVl+COeyywDD+F3RRQESo6f9bVNrpp3U99ltbBusmE2WT5C+/hhU9AM
         aCLYRTxYrs07N+yJTQnH5lhhi04JaMmWBZtUyEsEX5LKVauEaGSqxQsZZw5+ySbPyAJ9
         lImW4iGU/A9P4SFJWSihB8gR6DD/VnCZqK2rY=
Received: by 10.115.14.1 with SMTP id r1mr5819903wai.171.1238668279873;
        Thu, 02 Apr 2009 03:31:19 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n33sm1036876wag.18.2009.04.02.03.31.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 03:31:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
In-Reply-To: <1238668246-762-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115451>

From: Sebastian Pipping <sebastian@pipping.org>

This adds diffuse as a built-in merge tool.

Signed-off-by: Sebastian Pipping <sebastian@pipping.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is Sebastian's patch rebased onto Junio's pu branch.

I removed the git-gui part because I think git-gui
patches go through Shawn / git-gui.git?


This diff is still too big, so maybe we should
refactor the $mergetool_candidate code into
mergetool-lib as well.

 Documentation/git-difftool.txt         |    4 ++--
 Documentation/git-mergetool.txt        |    3 ++-
 Documentation/merge-config.txt         |    7 ++++---
 contrib/completion/git-completion.bash |    3 ++-
 git-difftool-helper.sh                 |    6 ++----
 git-mergetool-lib.sh                   |   17 ++++++++++++++++-
 git-mergetool.sh                       |    4 ++--
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 73d4782..15b247b 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -30,8 +30,8 @@ OPTIONS
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
-	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
-	vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
+	ecmerge, diffuse and opendiff
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
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
index 1ff08ff..c4fc3eb 100644
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
+	"diffuse" and "opendiff".  Any other value is treated as a custom
+	merge tool and there must be a corresponding mergetool.<tool>.cmd
+	option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e72ce24..4fcd77a 100755
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
diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index 2dfc870..d174b34 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 # git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
-# It supports kdiff3, kompare, tkdiff, xxdiff, meld, opendiff,
-# emerge, ecmerge, vimdiff, gvimdiff, and custom user-configurable tools.
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
@@ -70,9 +68,9 @@ if test -z "$merge_tool"; then
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
diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
index 3ba332b..197533e 100644
--- a/git-mergetool-lib.sh
+++ b/git-mergetool-lib.sh
@@ -29,7 +29,7 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | diffuse)
 		if test "$1" = "kompare" && ! diff_mode; then
 			return 1
 		fi
@@ -108,6 +108,21 @@ run_mergetool () {
 		fi
 		check_unchanged
 		;;
+	diffuse)
+		if merge_mode; then
+			touch "$BACKUP"
+		fi
+		if $base_present; then
+			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" "$BASE" | cat
+		else
+			if merge_mode; then
+				"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" | cat
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+			fi
+		fi
+		check_unchanged
+		;;
 	vimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
diff --git a/git-mergetool.sh b/git-mergetool.sh
index fd81ad7..16562bd 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -284,9 +284,9 @@ fi
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
1.6.2.1.303.g63699
