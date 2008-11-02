From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 3/6] gitk: Add accelerators to frequently used menu commands.
Date: Sun,  2 Nov 2008 21:59:46 +0300
Message-ID: <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiEE-0005yD-Gc
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYKBTB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYKBTBz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:01:55 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:7785 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbYKBTBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:01:53 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2268971muf.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S/DLFPtsncs+LdTnVW8d3do9L2ErJmWz/oemFte1pdI=;
        b=MkotorxlcftPIOf1XLPPGLwa6+ovM+jNCqFnuB1qllRYDzF9ZaudhzFmPrFIhjGDj0
         FVaPin2d+qDi7SK+8OMLX3rDhshSAoYrz1pggid86GMS4G5W83BaWaQaos9ToFJtiQYj
         D6prXojFRxnBqqm31+eHAt/aLvr0tJ3CYNGlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=prg1b9iAWOzRDkdQu6avObP/eqR5mlsx5PEm7G+gQvwXa6dKUHyV6XUvsCIQ6E7KlM
         bEL5x3FMcn9fMH3xYjewlhvYvTv1EPAuVPZBvP7+Co+126gvfa/yOkqmFKFpeNlWexKc
         9WbjbDaxtPQGHV70lecpl2k8Y4octJo9RB/Cg=
Received: by 10.180.215.9 with SMTP id n9mr3925922bkg.164.1225652510954;
        Sun, 02 Nov 2008 11:01:50 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:49 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99864>

This commit documents keyboard accelerators used for menu
commands in the menu, as it is usually done, and adds some
more, e.g. F4 to invoke Edit View.

The changes include a workaround for handling Shift-F4 on
systems where XKB binds special XF86_Switch_VT_* symbols
to Ctrl-Alt-F* combinations. Tk often receives these codes
when Shift-F* is pressed, so it is necessary to bind the
relevant actions to them as well.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   36 +++++++++++++++++++++++++++++-------
 1 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 41d3d2d..f747c70 100755
--- a/gitk
+++ b/gitk
@@ -1801,6 +1801,11 @@ proc setoptions {} {
 # command to invoke for command, or {variable value} for radiobutton
 proc makemenu {m items} {
     menu $m
+    if {[tk windowingsystem] eq {aqua}} {
+	set M1T Cmd
+    } else {
+	set M1T Ctrl
+    }
     foreach i $items {
 	set name [mc [lindex $i 1]]
 	set type [lindex $i 2]
@@ -1826,7 +1831,9 @@ proc makemenu {m items} {
 		    -value [lindex $thing 1]
 	    }
 	}
-	eval $m add $params [lrange $i 4 end]
+	set tail [lrange $i 4 end]
+	regsub -all {\$M1T\y} $tail $M1T tail
+	eval $m add $params $tail
 	if {$type eq "cascade"} {
 	    makemenu $m.$submenu $thing
 	}
@@ -1860,17 +1867,17 @@ proc makewindow {} {
     makemenu .bar {
 	{mc "File" cascade {
 	    {mc "Update" command updatecommits -accelerator F5}
-	    {mc "Reload" command reloadcommits}
+	    {mc "Reload" command reloadcommits -accelerator $M1T-F5}
 	    {mc "Reread references" command rereadrefs}
-	    {mc "List references" command showrefs}
-	    {mc "Quit" command doquit}
+	    {mc "List references" command showrefs -accelerator F2}
+	    {mc "Quit" command doquit -accelerator $M1T-Q}
 	}}
 	{mc "Edit" cascade {
 	    {mc "Preferences" command doprefs}
 	}}
 	{mc "View" cascade {
-	    {mc "New view..." command {newview 0}}
-	    {mc "Edit view..." command editview -state disabled}
+	    {mc "New view..." command {newview 0} -accelerator Shift-F4}
+	    {mc "Edit view..." command editview -state disabled -accelerator F4}
 	    {mc "Delete view" command delview -state disabled}
 	    {xx "" separator}
 	    {mc "All files" radiobutton {selectedview 0} -command {showview 0}}
@@ -2232,7 +2239,12 @@ proc makewindow {} {
     bindkey <Key-Return> {dofind 1 1}
     bindkey ? {dofind -1 1}
     bindkey f nextfile
-    bindkey <F5> updatecommits
+    bind . <F5> updatecommits
+    bind . <$M1B-F5> reloadcommits
+    bind . <F2> showrefs
+    bind . <Shift-F4> {newview 0}
+    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
+    bind . <F4> edit_or_newview
     bind . <$M1B-q> doquit
     bind . <$M1B-f> {dofind 1 1}
     bind . <$M1B-g> {dofind 1 0}
@@ -3483,6 +3495,16 @@ proc newview {ishighlight} {
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
 
+proc edit_or_newview {} {
+    global curview
+
+    if {$curview > 0} {
+	editview
+    } else {
+	newview 0
+    }
+}
+
 proc editview {} {
     global curview
     global viewname viewperm newviewname newviewperm
-- 
1.6.0.3.15.gb8d36
