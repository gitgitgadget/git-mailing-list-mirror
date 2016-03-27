From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 2/2] gitk: add an option to enable sorting the "Tags and heads" view by ref type
Date: Sun, 27 Mar 2016 11:06:08 -0400
Message-ID: <1459091168-46908-3-git-send-email-rappazzo@gmail.com>
References: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Mar 27 17:06:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akCGt-0005sV-Lz
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 17:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbcC0PGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 11:06:25 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:34066 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcC0PGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 11:06:23 -0400
Received: by mail-qg0-f66.google.com with SMTP id j35so7057317qge.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bw0nYO1KRkhwGi87ai2rhJsTT8bkOFCWtv+iHGrk9RE=;
        b=QODGK+tMageOumqi3M6xn+VpYSkc25uqUJsPyALiZUpElTxZbiSwWHyCDhNJCg2uGG
         kP7lQks8SczmHwf5okwNue6RDynBTinFwPRNVIpqet+sl97cJ6yLvIOsrjUS7eLTIly3
         0aZZVqhQSvPHganNVuB3LxLNgK5OAZQhdGm1OsAMFo9VG+295HzbOaW3hIQovHQeQPZk
         lMzxhAl8sKv2fr19sKmd9cDdz9xllT38D57qBIYtHs/t5heJxbdL8o2jRZnHM+XUEa7p
         Gtvqwje7mSkQs8nHVJdTfCh2hlujctc5QtLW7Es1VPJnV7LFub8ncDvi4cmZGT8C0a5I
         Ej/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bw0nYO1KRkhwGi87ai2rhJsTT8bkOFCWtv+iHGrk9RE=;
        b=KGW+tecmp6kKJohxBI/3dJakHNMNH0wcpyevliIaMDG8cVXi+fORV35n3Q1n2eR1TY
         MAx16rfgrUAf4AvSk8INBeM+YhFgFigoGzhDXzGmos746wdUltpWIeaXi52VHSz66a8v
         rBid13LI4Hm9okORLsNpG5fzCy+fnTj9OgIj1iWg+tdVoLv+n2YZ0Gj2+uV34iLLRDtt
         lqQo/491cZVPwisT6LfhgHwYchW1NNt5FaF/6DJ3LP4Id3AU6kNCFZewU2Bm+LM3sPAu
         BgRXOn370l1eTzo6R0eDAJQkkTAPzoxNVNSAZUbsMPgXTAm6lbsuTGf9TWRSXxD8XCbP
         vkMA==
X-Gm-Message-State: AD7BkJKOil6yfUYCcQWrKJgRo3EybdtE2N0g0gi54XwKwsY+MaJhJbP4B4WctJApkooWLg==
X-Received: by 10.140.38.104 with SMTP id s95mr29347274qgs.7.1459091182378;
        Sun, 27 Mar 2016 08:06:22 -0700 (PDT)
Received: from MRappazzo-8.nycap.info (cpe-74-70-59-36.nycap.res.rr.com. [74.70.59.36])
        by smtp.gmail.com with ESMTPSA id 78sm2312230qhr.4.2016.03.27.08.06.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Mar 2016 08:06:21 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290013>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 3686370..29ef36c 100755
--- a/gitk
+++ b/gitk
@@ -9944,7 +9944,7 @@ proc reflistfilter_change {n1 n2 op} {
 }
 
 proc refill_reflist {} {
-    global reflist reflistfilter showrefstop headids tagids otherrefids localrefs_tracking_remotes
+    global reflist reflistfilter showrefstop headids tagids otherrefids localrefs_tracking_remotes sortrefsbytype
     global curview
 
     if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
@@ -10004,6 +10004,10 @@ proc refill_reflist {} {
     }
     set otherrefs [lsort -index 0 $otherrefs]
     lappend refs {*}$localrefs {*}$locally_tracked_remote_refs {*}$remoterefs {*}$tagrefs {*}$otherrefs
+    if {$sortrefsbytype ne 1} {
+       set refs [lsort -index 0 $refs]
+    }
+
     if {$refs eq $reflist} return
 
     # Update the contents of $showrefstop.list according to the
@@ -11416,7 +11420,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs
+    global hideremotes want_ttk have_ttk maxrefs sortrefsbytype
 
     set page [create_prefs_page $notebook.general]
 
@@ -11440,6 +11444,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
 	-variable hideremotes
     grid x $page.hideremotes -sticky w
+    ${NS}::checkbutton $page.sortrefsbytype -text [mc "Sort refs by type"] \
+	-variable sortrefsbytype
+    grid x $page.sortrefsbytype -sticky w
 
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11544,7 +11551,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk sortrefsbytype
 
     set top .gitkprefs
     set prefstop $top
@@ -11553,7 +11560,8 @@ proc doprefs {} {
 	return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+		   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+		   sortrefsbytype} {
 	set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11679,7 +11687,8 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+		   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+		   sortrefsbytype} {
 	global $v
 	set $v $oldprefs($v)
     }
@@ -12215,6 +12224,7 @@ set showneartags 1
 set hideremotes 0
 set maxrefs 20
 set visiblerefs {"master"}
+set sortrefsbytype 0
 set maxlinelen 200
 set showlocalchanges 1
 set limitdiffs 1
@@ -12318,6 +12328,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
+    sortrefsbytype
 }
 foreach var $config_variables {
     config_init_trace $var
-- 
2.7.4
