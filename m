From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH v2] git-gui: Add shortcut keys for Show More/Less Context
Date: Tue,  1 Apr 2008 11:54:03 +0100
Message-ID: <1207047243-27738-1-git-send-email-maillist@steelskies.com>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 01 12:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jge8n-0004E5-Tp
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 12:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbYDAKyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 06:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757426AbYDAKyN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 06:54:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:9488 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758400AbYDAKyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 06:54:12 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2790341fkr.5
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:sender;
        bh=Cv6EQr0mgVG9PGNeGYdPT7ICgL4WAZwgJukxDJnL5gY=;
        b=PDM/877ymgz1uyG88dfs3WZgtgDB1DWimZ87tJPi+PNHB4YCuJSXP8Zh1SmUlL7tKEexdzTojt+Q3kXbL5OlYueTAeAJHgBBJLmBgswQQhgIkqyVhOmG5UrH7qu6+h0fShvYg75EcNYrOqdC5YVX4LoYf3OaS64PXX1kXjYGi6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=qMv200dErG6yzT/l/vQQZG6zwshx0GkeSVzUoPQmH+60yfzGPyFSIehaKst1qUPXy+F6Bk2YMZaNX8WkQcd/uIH/RDajcZLZpyqeSI/8cFS5zw2n6oxjU7nv00blQEBU9Qq0WO4KXoicZeezjJmigKfITvJitm/v92DRZvicUgw=
Received: by 10.82.149.8 with SMTP id w8mr18799063bud.24.1207047246954;
        Tue, 01 Apr 2008 03:54:06 -0700 (PDT)
Received: from localhost ( [89.105.122.147])
        by mx.google.com with ESMTPS id q9sm5672719gve.7.2008.04.01.03.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Apr 2008 03:54:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.rc2.1.g107f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78642>

Bound to Ctrl/Cmd + left & right square brackets, depending on your platform.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---

Second attempt to add Show Context shortcuts to git gui.  This new version also adds the items to the Commit menu, complete with accelerator keys to make the shortcut more visible.

 git-gui/git-gui.sh |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 5e97fbf..9ee2d32 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1845,7 +1845,21 @@ proc add_range_to_selection {w x y} {
 	}
 	$w tag add in_sel $begin.0 [expr {$end + 1}].0
 }
+proc show_more_context {} {
+	global repo_config
+	if {$repo_config(gui.diffcontext) < 99} {
+		incr repo_config(gui.diffcontext)
+		reshow_diff
+	}
+}
 
+proc show_less_context {} {
+	global repo_config
+	if {$repo_config(gui.diffcontext) >= 1} {
+		incr repo_config(gui.diffcontext) -1
+		reshow_diff
+	}
+}
 ######################################################################
 ##
 ## ui construction
@@ -2046,6 +2060,16 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 
 	.mbar.commit add separator
 
+	.mbar.commit add command -label [mc "Show Less Context"] \
+		-command show_less_context \
+		-accelerator $M1T-\[
+
+	.mbar.commit add command -label [mc "Show More Context"] \
+		-command show_more_context \
+		-accelerator $M1T-\]
+
+	.mbar.commit add separator
+
 	.mbar.commit add command -label [mc "Sign Off"] \
 		-command do_signoff \
 		-accelerator $M1T-S
@@ -2593,17 +2617,11 @@ lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add separator
 $ctxm add command \
 	-label [mc "Show Less Context"] \
-	-command {if {$repo_config(gui.diffcontext) >= 1} {
-		incr repo_config(gui.diffcontext) -1
-		reshow_diff
-	}}
+	-command show_less_context
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
 	-label [mc "Show More Context"] \
-	-command {if {$repo_config(gui.diffcontext) < 99} {
-		incr repo_config(gui.diffcontext)
-		reshow_diff
-	}}
+	-command show_more_context
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
@@ -2695,6 +2713,8 @@ bind $ui_comm <$M1B-Key-v> {tk_textPaste %W; %W see insert; break}
 bind $ui_comm <$M1B-Key-V> {tk_textPaste %W; %W see insert; break}
 bind $ui_comm <$M1B-Key-a> {%W tag add sel 0.0 end;break}
 bind $ui_comm <$M1B-Key-A> {%W tag add sel 0.0 end;break}
+bind $ui_comm <$M1B-Key-\[> {show_less_context;break}
+bind $ui_comm <$M1B-Key-\]> {show_more_context;break}
 
 bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
 bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
-- 
1.5.5.rc2.1.g107f.dirty
