From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: Remove mc parameter from proc show_error
Date: Fri,  1 May 2015 21:13:20 -0600
Message-ID: <1430536400-22008-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, bernt@norang.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 05:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNrv-0002d6-B6
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 05:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbbEBDN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 23:13:27 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33910 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbEBDN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 23:13:26 -0400
Received: by iget9 with SMTP id t9so37204929ige.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 20:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tpjDIhIzi/EnVmf1zF4JPnbuEfo/N9IuZyrgEqNCuV4=;
        b=cFnwu+N0sIecMMm9MUI4A0EI+Vo1ACmMVpVYXF/VgDkJI4jKVqnmuiOTsqSzh5o8zC
         TMmgkApsWUJDu4vHte1TxAvp4rlKSyKaN+TZlrO71BOYz5jFBbm9VHrijisJvbvqHREC
         1Mu4QZBn7xblJjiPwprJfR94/5//6y/a321KTa7Vh7wseKtA3Uy4DJdIw8VLerymPk6q
         RFUb3djlkwG0RFoZ8/mtxg8Zj2ydcb6qgTKLtFVTpYxgOKmGHdKJi/llp4YTUxeRVELD
         jzizCRPeecXeCsFCcPdrNhGGQUgaqRzHHngIRRm2FWMZoXLKShyRLhE29oLU1cEwCKow
         bD7w==
X-Received: by 10.107.129.229 with SMTP id l98mr15602551ioi.32.1430536405750;
        Fri, 01 May 2015 20:13:25 -0700 (PDT)
Received: from localhost.localdomain (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id 10sm4788945ioh.44.2015.05.01.20.13.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 May 2015 20:13:24 -0700 (PDT)
X-Mailer: git-send-email 2.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268216>

This is a better fix for 8d849957d81fc0480a52570d66cc3c2a688ecb1b.

All that was required to fix the original issue was to remove the extra
mc call, i.e. change [mc "Sorry, gitk cannot run..."] to simply
"Sorry, gitk cannot run..." Changing the signature of proc show_error
was unnecessary and introduced two new bugs: It made "OK" untranslatable
and "mc" translatable when the opposite should be true.

This new fix makes the string "OK" translatable and the string "mc" not
translatable, while leaving the string "Sorry, gitk cannot run..." not
translatable. It will take effect the next time `make update-po` is run.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 30fcd30..096389f 100755
--- a/gitk
+++ b/gitk
@@ -1894,13 +1894,13 @@ proc make_transient {window origin} {
     }
 }
 
-proc show_error {w top msg {mc mc}} {
+proc show_error {w top msg} {
     global NS
     if {![info exists NS]} {set NS ""}
     if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    ${NS}::button $w.ok -default active -text [$mc OK] -command "destroy $top"
+    ${NS}::button $w.ok -default active -text [mc OK] -command "destroy $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
@@ -12011,7 +12011,7 @@ proc get_path_encoding {path} {
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
     show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
-		     Gitk requires at least Tcl/Tk 8.4." list
+		     Gitk requires at least Tcl/Tk 8.4."
     exit 1
 }
 
-- 
2.3.7
