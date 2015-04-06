From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] gitk: Remove mc parameter from proc show_error
Date: Sun,  5 Apr 2015 23:06:04 -0600
Message-ID: <1428296764-29970-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, bernt@norang.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 07:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YezEy-000464-L6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 07:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbbDFFGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 01:06:16 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34548 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbbDFFGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 01:06:15 -0400
Received: by pdbni2 with SMTP id ni2so33585727pdb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yFHwrYcN3SV/E7q0LPT2HNDGE0p6EOFl1sAzillXZpc=;
        b=cYhr4vCiJs8tla+s7oIraXYkTOff0L7vO7YoBceS2pSGQ+cLvVGJjX1YRFfU+m0Go2
         rExt1mFvf5tAmTyCE4RV4Z7Aay13BHTcaoH998xSz37h1pMU8cWh5LioYA/ALQjGCFdU
         54kKx1gyiTVxnA7H/SadGjY4NP8I7eLXVu1UMHBtBXR/5oetK/DPRCCt6eXqANyUM7Sr
         muVjb2LnY5ZBc9hrqn7Ex4x9mx6UZsSwDLHnQn/dhM+TJ6UTZkfMgmy2zcuBs0iMl+id
         qsVPJVRQLYUjJSm1cyfx1TpDV03YTV5E7d6BnwlFqTwEvqoIbC3RiakeZFHbxF3Gskik
         wqcQ==
X-Received: by 10.70.89.174 with SMTP id bp14mr24454579pdb.14.1428296774998;
        Sun, 05 Apr 2015 22:06:14 -0700 (PDT)
Received: from localhost.localdomain (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id jd5sm3094788pbd.35.2015.04.05.22.06.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Apr 2015 22:06:14 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266837>

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
2.3.5
