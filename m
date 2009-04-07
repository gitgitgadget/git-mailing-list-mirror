From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [[PATCH  1/1] Ensure consistent usage of mergetool.keepBackup
Date: Tue,  7 Apr 2009 17:33:35 +0200
Message-ID: <cfb81044a29899f9dd0b46f10447243632c50c94.1239108064.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 17:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrDWJ-0002uy-PL
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 17:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614AbZDGPpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 11:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755396AbZDGPpF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 11:45:05 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:3643 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041AbZDGPpD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 11:45:03 -0400
X-Greylist: delayed 644 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2009 11:45:03 EDT
Received: from localhost.localdomain ([62.140.137.125])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id n37FXaAR071954;
	Tue, 7 Apr 2009 17:33:42 +0200 (CEST)
	(envelope-from ferry.huberts@pelagic.nl)
X-Mailer: git-send-email 1.6.0.6
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115964>

In several places merge.keepBackup is used i.s.o.
mergetool.keepBackup. This patch makes it all
consistent.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
This patch is rebased on v1.6.2.2

 contrib/difftool/git-difftool.txt |    2 +-
 git-gui/git-gui.sh                |    2 +-
 git-gui/lib/mergetool.tcl         |    2 +-
 git-mergetool.sh                  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 6e2610c..ca7482a 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -66,7 +66,7 @@ merge.tool::
 +
 See the `--tool=<tool>` option above for more details.
 
-merge.keepBackup::
+mergetool.keepBackup::
 	The original, unedited file content can be saved to a file with
 	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
 
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e018e07..e4e643a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -699,7 +699,7 @@ proc apply_config {} {
 
 set default_config(branch.autosetupmerge) true
 set default_config(merge.tool) {}
-set default_config(merge.keepbackup) true
+set default_config(mergetool.keepbackup) true
 set default_config(merge.diffstat) true
 set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index eb2b4b5..b7263b3 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -382,7 +382,7 @@ proc merge_tool_finish {fd} {
 		delete_temp_files $mtool_tmpfiles
 		ui_status [mc "Merge tool failed."]
 	} else {
-		if {[is_config_true merge.keepbackup]} {
+		if {[is_config_true mergetool.keepbackup]} {
 			file rename -force -- $backup "$mtool_target.orig"
 		}
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..1455bd9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -430,7 +430,7 @@ else
 
     init_merge_tool_path "$merge_tool"
 
-    merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+    merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
     merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
     if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
-- 
1.6.0.6
