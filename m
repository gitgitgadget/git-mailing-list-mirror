From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Sat, 8 Mar 2008 14:27:23 +0200
Message-ID: <20080308122723.GA11867@localdomain>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: paulus@samba.org, newsletter@dirk.my1.cc
X-From: git-owner@vger.kernel.org Sat Mar 08 13:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXyAO-0003rx-L4
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 13:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYCHM2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 07:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYCHM2F
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 07:28:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:13647 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYCHM2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 07:28:03 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1027366fga.17
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 04:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        bh=xwOUkKQzA2h/gaVk0Hkv9yXmJyLeAV0nRjM0EAzZ5q4=;
        b=WXF3xJ7k2/nEVx3O6vNpuhQmE9OU/bltL6gDO0xOQuvskPO7ikQCxZc0u6g4WqzgCy1XAFYnDx24umJwuY5rZqfz/9ZlTy1zO+rSje1hJ7k0hf5UP0lmR3U88O7Pcmzn5T6gMu24NB6d8aZDx+WgeJe/Tnif1HeL2Fsm7dONhBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=bECK5Aje0OYq9WH13mHrJGOgptIZtaOxBeq/fdkOChWla7E0z5pWrNSp48k8I8s4DpgVPk7Bj6KeOqvMw9v70gdI5Rd4+nelcwdCYP/5/xjx40xf3I/EyrV9S1TzLxDhYY+gT5ALdOFSBycVJBg5L0G1dpQORtDUxYKT6hHlNwE=
Received: by 10.82.171.16 with SMTP id t16mr6296344bue.25.1204979282001;
        Sat, 08 Mar 2008 04:28:02 -0800 (PST)
Received: from shadow ( [85.157.38.155])
        by mx.google.com with ESMTPS id c25sm10133651ika.9.2008.03.08.04.27.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 04:27:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76560>

Adding horizontal scroll bar makes the scrolling feature more
discoverable to the users. The horizontal scrollbar is a bit narrower
than vertical ones so we don't make too big impact on available screen
real estate. The text and scrollbar widget layout is done using grid
geometry manager.

An interesting side effect of Tk scrollbars is that the "elevator"
size changes depending on the visible content. So the horizontal
scrollbar "elevator" changes as the user scrolls the view up and down.

Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
---
A modified version of the earlier patch that adds horizontal
scrollbar. This version uses grid layout for text and scrollbar
widgets. I have tested this patch with Tk 8.4 and 8.5 on Linux.

The width of the horizontal scrollbar (-width 10) seems to be OK with
Tk 8.5 on Linux (the default seems to be about 10 as well). I don't
know what it looks like on Windows and Mac, however.

 gitk |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..429b091 100755
--- a/gitk
+++ b/gitk
@@ -827,6 +827,7 @@ proc makewindow {} {
     }
     frame .bleft.top
     frame .bleft.mid
+    frame .bleft.bottom
 
     button .bleft.top.search -text [mc "Search"] -command dosearch
     pack .bleft.top.search -side left -padx 5
@@ -854,18 +855,25 @@ proc makewindow {} {
     checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
-    set ctext .bleft.ctext
+    set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
-	-yscrollcommand scrolltext -wrap none
+	-yscrollcommand scrolltext -wrap none \
+	-xscrollcommand ".bleft.bottom.sbhorizontal set"
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor
     }
-    scrollbar .bleft.sb -command "$ctext yview"
+    scrollbar .bleft.bottom.sb -command "$ctext yview"
+    scrollbar .bleft.bottom.sbhorizontal -command "$ctext xview" -orient h \
+	-width 10
     pack .bleft.top -side top -fill x
     pack .bleft.mid -side top -fill x
-    pack .bleft.sb -side right -fill y
-    pack $ctext -side left -fill both -expand 1
+    grid $ctext .bleft.bottom.sb -sticky nsew
+    grid .bleft.bottom.sbhorizontal -sticky ew
+    grid columnconfigure .bleft.bottom 0 -weight 1
+    grid rowconfigure .bleft.bottom 0 -weight 1
+    grid rowconfigure .bleft.bottom 1 -weight 0
+    pack .bleft.bottom -side top -fill both -expand 1
     lappend bglist $ctext
     lappend fglist $ctext
 
@@ -5604,7 +5612,7 @@ proc searchmarkvisible {doall} {
 proc scrolltext {f0 f1} {
     global searchstring
 
-    .bleft.sb set $f0 $f1
+    .bleft.bottom.sb set $f0 $f1
     if {$searchstring ne {}} {
 	searchmarkvisible 0
     }
-- 
1.5.4.3

