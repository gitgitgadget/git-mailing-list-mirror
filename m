From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 1/6] gitk: Add Return and Escape bindings to dialogs.
Date: Sun,  2 Nov 2008 21:59:44 +0300
Message-ID: <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiED-0005yD-4v
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbYKBTBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbYKBTBt
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:01:49 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:15346 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYKBTBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:01:47 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2459943fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KDW7ilbMfIiL8Oi+CU34HhFQVTaRr+xLWwPRByhsbew=;
        b=wWr/t1bv9HfzeJdVLnZVeLx5QZJX1wMGCPaOCF23Nx+O/A5YQJtwjMS30YTo8aFIm3
         CLdVa7GAtqqmtA70oSelz3VlG8Wi9KKr20VmEJikZFdUCaAOuE4ivWasQNSZ4KY/iLDJ
         76wlzD0LGcchkVsN16b3zspL6Iw/6PhH0UaUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EBC+1fH4XEncMEO7DizyB+BTdAueJXEG/bZMZTx8lhVCoMrBTcuRHUqt7IIhyL047m
         hiXy5tZLzHXA7AIQEPf+5HJDsDRp6igCxuJnCZLFHkTpgvIm4ZB7bQZGIbCpkoexdlmC
         gaByOuu3515lARDhaLZVep0eba3k3tCYA4iQ0=
Received: by 10.181.148.3 with SMTP id a3mr3930508bko.74.1225652505911;
        Sun, 02 Nov 2008 11:01:45 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:44 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is often more convenient to dismiss or accept a
dialog using the keyboard, than by clicking buttons
on the screen. This commit adds key binding to make
it possible with gitk's dialogs.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 3fe1b47..edef9e2 100755
--- a/gitk
+++ b/gitk
@@ -1746,6 +1746,8 @@ proc show_error {w top msg} {
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
+    bind $top <Key-space>  "destroy $top"
+    bind $top <Key-Escape> "destroy $top"
     tkwait window $top
 }
 
@@ -1769,6 +1771,9 @@ proc confirm_popup msg {
     button $w.cancel -text [mc Cancel] -command "destroy $w"
     pack $w.cancel -side right -fill x
     bind $w <Visibility> "grab $w; focus $w"
+    bind $w <Key-Return> "set confirm_ok 1; destroy $w"
+    bind $w <Key-space>  "set confirm_ok 1; destroy $w"
+    bind $w <Key-Escape> "destroy $w"
     tkwait window $w
     return $confirm_ok
 }
@@ -2611,6 +2616,7 @@ proc keys {} {
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     button $w.ok -text [mc "Close"] -command "destroy $w" -default active
+    bind $w <Key-Escape> [list destroy $w]
     pack $w.ok -side bottom
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
@@ -3533,6 +3539,7 @@ proc vieweditor {top n title} {
     frame $top.buts
     button $top.buts.ok -text [mc "OK"] -command [list newviewok $top $n]
     button $top.buts.can -text [mc "Cancel"] -command [list destroy $top]
+    bind $top <Escape> [list destroy $top]
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7793,6 +7800,8 @@ proc mkpatch {} {
     frame $top.buts
     button $top.buts.gen -text [mc "Generate"] -command mkpatchgo
     button $top.buts.can -text [mc "Cancel"] -command mkpatchcan
+    bind $top <Key-Return> mkpatchgo
+    bind $top <Key-Escape> mkpatchcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7864,6 +7873,8 @@ proc mktag {} {
     frame $top.buts
     button $top.buts.gen -text [mc "Create"] -command mktaggo
     button $top.buts.can -text [mc "Cancel"] -command mktagcan
+    bind $top <Key-Return> mktaggo
+    bind $top <Key-Escape> mktagcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7967,6 +7978,8 @@ proc writecommit {} {
     frame $top.buts
     button $top.buts.gen -text [mc "Write"] -command wrcomgo
     button $top.buts.can -text [mc "Cancel"] -command wrcomcan
+    bind $top <Key-Return> wrcomgo
+    bind $top <Key-Escape> wrcomcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -8014,6 +8027,8 @@ proc mkbranch {} {
     frame $top.buts
     button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top]
     button $top.buts.can -text [mc "Cancel"] -command "catch {destroy $top}"
+    bind $top <Key-Return> [list mkbrgo $top]
+    bind $top <Key-Escape> "catch {destroy $top}"
     grid $top.buts.go $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -8138,6 +8153,7 @@ proc resethead {} {
     button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     pack $w.ok -side left -fill x -padx 20 -pady 20
     button $w.cancel -text [mc Cancel] -command "destroy $w"
+    bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
     tkwait window $w
@@ -8315,6 +8331,7 @@ proc showrefs {} {
     pack $top.f.l -side left
     grid $top.f - -sticky ew -pady 2
     button $top.close -command [list destroy $top] -text [mc "Close"]
+    bind $top <Key-Escape> [list destroy $top]
     grid $top.close -
     grid columnconfigure $top 0 -weight 1
     grid rowconfigure $top 0 -weight 1
@@ -9666,6 +9683,8 @@ proc choosefont {font which} {
 	frame $top.buts
 	button $top.buts.ok -text [mc "OK"] -command fontok -default active
 	button $top.buts.can -text [mc "Cancel"] -command fontcan -default normal
+	bind $top <Key-Return> fontok
+	bind $top <Key-Escape> fontcan
 	grid $top.buts.ok $top.buts.can
 	grid columnconfigure $top.buts 0 -weight 1 -uniform a
 	grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -9845,6 +9864,8 @@ proc doprefs {} {
     frame $top.buts
     button $top.buts.ok -text [mc "OK"] -command prefsok -default active
     button $top.buts.can -text [mc "Cancel"] -command prefscan -default normal
+    bind $top <Key-Return> prefsok
+    bind $top <Key-Escape> prefscan
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
-- 
1.6.0.3.15.gb8d36
