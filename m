From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH 2/2] gitk: Allow checking out a remote branch
Date: Fri, 15 Jan 2016 22:43:47 +0100
Message-ID: <1964156.4P5fNkQCS3@wiske>
References: <51900395.pKIx87RN0F@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 22:49:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKCFN-0001gm-2j
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbcAOVtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:49:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33098 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbcAOVtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:49:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so4923254wmu.0
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 13:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=boB3Wovasoi0WG10w0M5Pgm/uMwxXl7dariGR53UZ+U=;
        b=q/Fyj0QbIizaekjridU52vpTILgkm0Bh9FGSpx4njLZyLKzFas7yYjDasZU+ucvnp8
         UgD6IieSBmIYWwCO9VdOiNkNen30tufYU/N6wTCyDnagpdjeuD5lKXokbK4+pqi+oRFe
         oXUGQhoXjixW75MTGpczXmyiY3RpPNjXkWnsBceXo2qLoaor8TXmhJ7ldYs8x8aThRer
         TKzLwFRZ/97dL3wIpawxXIwuJ8OLQh4RIfOKQFT5h3YtTSKXDAot7kZq5I+u5oJSp8jE
         0MpDbXNnBjEjJskWaN0SCBCgu5Lj6iekiCSSX9/KtWQEw8GLzT+X1j/z+MUxdCb/vbrK
         IroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=boB3Wovasoi0WG10w0M5Pgm/uMwxXl7dariGR53UZ+U=;
        b=EeTunWZwMEGWjdoRf1L2BLC3yprtuHktNkSgTD+3Vc6OB053BZLlsqq9RHXDDvq4oe
         zUHedjFyBW1cBMO0FvS+a4y+eweFXJQxAK1QLLOCO4tfDfl7rNu7C0Zc/SBUU6sont6a
         uQ6J6cfVhtpi3L79tqcGuDyrmrWhp/BKoPottLisRa3YoFJJvl53usr/12m6EhBMGLDa
         JGdsjrlCMySntVnbEqiJDurLJ3TbIqIwmhRjV23lp1+muHil0Uak3B6yeBLJKcCHgmzY
         7MzHX2O5ZLvuj93EughXkMuDv+DV02Kzps1QhlTj9mga80Tdwd605a4g8/K1qDVz6dxA
         i3IA==
X-Gm-Message-State: AG10YOQzb6Y5Hw3rpZ0B4/WRU6rkzdYJAmY+qwz+z35kMO2asTL6PjThNhok1XE+gs9/lQ==
X-Received: by 10.28.173.208 with SMTP id w199mr705619wme.45.1452894560636;
        Fri, 15 Jan 2016 13:49:20 -0800 (PST)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id q4sm12377694wja.6.2016.01.15.13.49.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jan 2016 13:49:19 -0800 (PST)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <51900395.pKIx87RN0F@wiske>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284221>


Git allows checking out remote branches, creating a local tracking
branch in the process. Allow gitk to do this as well, provided a
local branch of the same name does not yet exist.

Signed-off-by: Rogier Goossens <goossens.rogier@gmail.com>
---
 gitk | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index e9465fb..7d5fd33 100755
--- a/gitk
+++ b/gitk
@@ -9826,14 +9826,17 @@ proc readresetstat {fd} {
 
 # context menu for a head
 proc headmenu {x y id head} {
-    global headmenuid headmenuhead headctxmenu mainhead
+    global headmenuid headmenuhead headctxmenu mainhead headids
 
     stopfinding
     set headmenuid $id
     set headmenuhead $head
     array set state {0 normal 1 normal 2 normal 3 normal}
     if {[string match "remotes/*" $head]} {
-	set state(0) disabled
+	set localhead [string range $head [expr [string last / $head] + 1] end]
+	if {[info exists headids($localhead)]} {
+	    set state(0) disabled
+	}
 	set state(1) disabled
 	set state(2) disabled
     }
@@ -9852,11 +9855,27 @@ proc cobranch {} {
     global showlocalchanges
 
     # check the tree is clean first??
+    set newhead $headmenuhead
+    set command [list | git checkout]
+    if {[string match "remotes/*" $newhead]} {
+	set remote $newhead
+	set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
+	# The following check is redundant - the menu option should
+	# be disabled to begin with...
+	if {[info exists headids($newhead)]} {
+	    error_popup [mc "A local branch named %s exists already" $newhead]
+	    return
+	}
+	lappend command -b $newhead --track $remote
+    } else {
+	lappend command $newhead
+    }
+    lappend command 2>@1
     nowbusy checkout [mc "Checking out"]
     update
     dohidelocalchanges
     if {[catch {
-	set fd [open [list | git checkout $headmenuhead 2>@1] r]
+	set fd [open $command r]
     } err]} {
 	notbusy checkout
 	error_popup $err
@@ -9864,12 +9883,12 @@ proc cobranch {} {
 	    dodiffindex
 	}
     } else {
-	filerun $fd [list readcheckoutstat $fd $headmenuhead $headmenuid]
+	filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
     }
 }
 
 proc readcheckoutstat {fd newhead newheadid} {
-    global mainhead mainheadid headids showlocalchanges progresscoords
+    global mainhead mainheadid headids idheads showlocalchanges progresscoords
     global viewmainheadid curview
 
     if {[gets $fd line] >= 0} {
@@ -9884,8 +9903,14 @@ proc readcheckoutstat {fd newhead newheadid} {
     notbusy checkout
     if {[catch {close $fd} err]} {
 	error_popup $err
+	return
     }
     set oldmainid $mainheadid
+    if {! [info exists headids($newhead)]} {
+	set headids($newhead) $newheadid
+	lappend idheads($newheadid) $newhead
+	addedhead $newheadid $newhead
+    }
     set mainhead $newhead
     set mainheadid $newheadid
     set viewmainheadid($curview) $newheadid
-- 
2.1.4
