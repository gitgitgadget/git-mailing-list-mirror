From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] contrib/difftool: add support for Kompare
Date: Sat, 31 Jan 2009 00:19:29 +0100
Message-ID: <200901310019.30117.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 00:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2eZ-0000xT-0D
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 00:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbZA3XSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZA3XSg
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 18:18:36 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:44164 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbZA3XSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 18:18:36 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 88B8EF748ABA;
	Sat, 31 Jan 2009 00:18:34 +0100 (CET)
Received: from [89.59.122.30] (helo=pluto.local)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LT2d7-0002ZH-00; Sat, 31 Jan 2009 00:18:33 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18u9Exf0Ud4gYBnQlW1qh3QHW21QqOB6uoSHeiG
	//I2HXltEvyQrz2obZ4LPgitg0i9Fhp+vwrhu2q+TzkBCYTtL3
	LxGFzgGZbGMMwf5m83Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107883>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/difftool/git-difftool-helper |   16 ++++++++++------
 contrib/difftool/git-difftool.txt    |    3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index 0c48506..10632a3 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -1,7 +1,7 @@
 #!/bin/sh
 # git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
-# It supports kdiff3, tkdiff, xxdiff, meld, opendiff, emerge, ecmerge,
-# vimdiff, gvimdiff, and custom user-configurable tools.
+# It supports kdiff3, kompare, tkdiff, xxdiff, meld, opendiff,
+# emerge, ecmerge, vimdiff, gvimdiff, and custom user-configurable tools.
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
@@ -73,6 +73,10 @@ launch_merge_tool () {
 			> /dev/null 2>&1
 		;;
 
+	kompare)
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
+		;;
+
 	tkdiff)
 		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
 		;;
@@ -134,7 +138,7 @@ valid_custom_tool() {
 # Built-in merge tools are always valid.
 valid_tool() {
 	case "$1" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
 		;; # happy
 	*)
 		if ! valid_custom_tool "$1"
@@ -180,14 +184,14 @@ if test -z "$merge_tool"; then
 
 	# We have a $DISPLAY so try some common UNIX merge tools
 	if test -n "$DISPLAY"; then
-		merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+		merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff"
 		# If gnome then prefer meld
 		if test -n "$GNOME_DESKTOP_SESSION_ID"; then
 			merge_tool_candidates="meld $merge_tool_candidates"
 		fi
-		# If KDE then prefer kdiff3
+		# If KDE then prefer kdiff3 or kompare
 		if test "$KDE_FULL_SESSION" = "true"; then
-			merge_tool_candidates="kdiff3 $merge_tool_candidates"
+			merge_tool_candidates="kdiff3 kompare $merge_tool_candidates"
 		fi
 	fi
 
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index ca3dbd2..6e2610c 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -28,7 +28,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
+	vimdiff, gvimdiff, ecmerge, and opendiff
 +
 If a merge resolution program is not specified, 'git-difftool'
 will use the configuration variable `merge.tool`.  If the
-- 
1.6.1.2.256.g62566b
