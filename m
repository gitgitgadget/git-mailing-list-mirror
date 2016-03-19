From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH 2/2] gitk: Allow checking out a remote branch
Date: Sat, 19 Mar 2016 19:33:03 +0100
Message-ID: <4410053.4PRisWLqAX@wiske>
References: <51900395.pKIx87RN0F@wiske> <10662590.KWXHt2RUKZ@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 09:14:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahYVl-0000iQ-KC
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 09:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbcCTIOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 04:14:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32815 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbcCTIOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 04:14:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id x188so14947622wmg.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lz7LH/WnPTlRJYR3kMKhMAjQn3Gr/cnJEra66eU479w=;
        b=nT6x+Iir8Nn2vXR35c6z7/8im+wXlhXcsudo+zLd7qPryVeHFBmc4WvBYVaS2dd9gb
         V0/YUoWM5evlEXNZrxcZp+dKTTERfI1Xa/1xTfhWwP2hdZy5+M8+if4RQ/ZeXjfXpr7O
         Jv6Utq4qZHrP45QsXpEMibhInLYtbLWR5pewjoYSRgV7fSd2EMtzS/C1Z+r3ndIXQI1L
         qioDir7CWtaFw3HVAM7c8pF26Em5nE6wlCT0nyPWOfqWgBNuORZUIob/QhuEuTWJoHVF
         yIln8bNkEw4CvELmw8z6StBSjfpwzrdHVUdKKUff0seKEteGrvI42GiOdYzySmSNvNNY
         0c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lz7LH/WnPTlRJYR3kMKhMAjQn3Gr/cnJEra66eU479w=;
        b=SzeTm+fdhlamLV7rMtZyPvXwrUwbEM/Ge1Xg5uP/j6zFjxlgwBroOHczbsw9qdMLd8
         SWU8IK862yojsuULOuIDUqN2CsH/9salHQASgsVNb0lVbPfVyMu3w2moacG3bYnwKK6C
         8VA89YOfU20v2jQ1sgI/BWoHEaTpGMwEK+wt6dPPOVtpSmyVNciY++BH4yJowVS2oTgv
         5kAhIV7ydd1KvzxK3ihOpLQ9oD/9ceLviVEfmUOmxn178BMjC4P6LTPHVGFiRuGPKkza
         951qzpMionpyUWsCnt7ezu0TFrF3G5GalPhtiZbsp6YNQ9p0iDblwnDeN1lP6Nw0rjtv
         Vjrg==
X-Gm-Message-State: AD7BkJJa82YQji/sQ0kLagkyYytKf5t58S0TP0jqgxkTz7xhkZOuISciTEsG0dgodfEX0Q==
X-Received: by 10.28.34.69 with SMTP id i66mr7799444wmi.91.1458461685240;
        Sun, 20 Mar 2016 01:14:45 -0700 (PDT)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id lh1sm19647042wjb.20.2016.03.20.01.14.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 01:14:44 -0700 (PDT)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <10662590.KWXHt2RUKZ@wiske>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289340>


Git allows checking out remote branches, creating a local tracking
branch in the process. Allow gitk to do this as well, provided a
local branch of the same name does not yet exist.

Signed-off-by: Rogier Goossens <goossens.rogier@gmail.com>
---
 gitk | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 84b49bc..dc75c97 100755
--- a/gitk
+++ b/gitk
@@ -9824,14 +9824,18 @@ proc readresetstat {fd} {
 
 # context menu for a head
 proc headmenu {x y id head} {
-    global headmenuid headmenuhead headctxmenu mainhead
+    global headmenuid headmenuhead headctxmenu mainhead headids
 
     stopfinding
     set headmenuid $id
     set headmenuhead $head
     array set state {0 normal 1 normal 2 normal}
     if {[string match "remotes/*" $head]} {
-	array set state {0 disabled 1 disabled 2 disabled}
+	set localhead [string range $head [expr [string last / $head] + 1] end]
+	if {[info exists headids($localhead)]} {
+	    set state(0) disabled
+	}
+	array set state {1 disabled 2 disabled}
     }
     if {$head eq $mainhead} {
 	array set state {0 disabled 2 disabled}
@@ -9847,11 +9851,27 @@ proc cobranch {} {
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
@@ -9859,12 +9879,12 @@ proc cobranch {} {
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
@@ -9879,8 +9899,14 @@ proc readcheckoutstat {fd newhead newheadid} {
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
