From: Andreas Amann <a.amann@ucc.ie>
Subject: [PATCH v2] gitk: Add a "Save file as" menu item
Date: Sun, 21 Jul 2013 20:55:40 +0100
Message-ID: <87wqojhemb.fsf@msstf091.ucc.ie>
References: <87ppuculyi.fsf@msstf091.ucc.ie> <alpine.DEB.2.00.1307211910250.9615@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Peter Krefting <peter@softwolves.pp.se>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 21 21:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0zjT-0008Vb-0g
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 21:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab3GUTzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 15:55:47 -0400
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:13218
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755934Ab3GUTzq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 15:55:46 -0400
Received: from mail66-ch1-R.bigfish.com (10.43.68.243) by
 CH1EHSOBE015.bigfish.com (10.43.70.65) with Microsoft SMTP Server id
 14.1.225.22; Sun, 21 Jul 2013 19:55:46 +0000
Received: from mail66-ch1 (localhost [127.0.0.1])	by mail66-ch1-R.bigfish.com
 (Postfix) with ESMTP id EED071201FA;	Sun, 21 Jul 2013 19:55:45 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:143.239.1.23;KIP:(null);UIP:(null);IPV:NLI;H:mail3.ucc.ie;RD:mail3.ucc.ie;EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zzzz1f42h208ch1ee6h1de0h1d18h1fdah2073h1202h1e76h1d1ah1d2ah1fc6hzz1de098h1de097hz2fh2a8h668h839hd24he5bhf0ahfa3h107ah11b5h121eh1288h12a5h12a9h12bdh12e5h137ah13b6h1441h14afh1504h1537h153bh162dh1631h1758h18e1h1946h19b5h1b0ah1d0ch1d2eh1d3fh1dfeh1dffh1e1dh1155h)
Received-SPF: pass (mail66-ch1: domain of ucc.ie designates 143.239.1.23 as permitted sender) client-ip=143.239.1.23; envelope-from=a.amann@ucc.ie; helo=mail3.ucc.ie ;mail3.ucc.ie ;
Received: from mail66-ch1 (localhost.localdomain [127.0.0.1]) by mail66-ch1
 (MessageSwitch) id 1374436542347290_31542; Sun, 21 Jul 2013 19:55:42 +0000
 (UTC)
Received: from CH1EHSMHS024.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])	by mail66-ch1.bigfish.com (Postfix) with ESMTP id 46A8F60049;
	Sun, 21 Jul 2013 19:55:42 +0000 (UTC)
Received: from mail3.ucc.ie (143.239.1.23) by CH1EHSMHS024.bigfish.com
 (10.43.70.24) with Microsoft SMTP Server (TLS) id 14.16.227.3; Sun, 21 Jul
 2013 19:55:41 +0000
Received: from msstf091.ucc.ie (msstf091.ucc.ie [143.239.76.91])	by
 mail3.ucc.ie (8.14.4/8.14.4) with ESMTP id r6LJtepq032065;	Sun, 21 Jul 2013
 20:55:40 +0100
Received: by msstf091.ucc.ie (Postfix, from userid 1000)	id 89571A0939; Sun,
 21 Jul 2013 20:55:40 +0100 (IST)
In-Reply-To: <alpine.DEB.2.00.1307211910250.9615@ds9.cixit.se>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
X-OriginatorOrg: ucc.ie
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230942>

Previously, there was no easy way to save a particular file from the
currently selected revision.

This patch adds a menu item "Save file as" to the file list popup
menu, which opens a file selection dialog to determine the name under
which a file should be saved.  The default filename is of the form
"[shortid] basename".  If the current revision is the index, the
default pattern is of the form "[index] basename".  This works for
both, the "Patch" and "Tree" view.  The menu item is disabled for the
"local uncommitted changes" fake revision.

Signed-off-by: Andreas Amann <andreas.amann@web.de>
---
 gitk | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/gitk b/gitk
index 5cd00d8..b5a70b5 100755
--- a/gitk
+++ b/gitk
@@ -2595,6 +2595,7 @@ proc makewindow {} {
 	{mc "Highlight this too" command {flist_hl 0}}
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
+	{mc "Save file as" command {save_file_as}}
 	{mc "Blame parent commit" command {external_blame 1}}
     }
     $flist_menu configure -tearoff 0
@@ -3378,6 +3379,7 @@ proc sel_flist {w x y} {
 proc pop_flist_menu {w X Y x y} {
     global ctext cflist cmitmode flist_menu flist_menu_file
     global treediffs diffids
+    global nullid
 
     stopfinding
     set l [lindex [split [$w index "@$x,$y"] "."] 0]
@@ -3395,6 +3397,12 @@ proc pop_flist_menu {w X Y x y} {
     }
     # Disable "External diff" item in tree mode
     $flist_menu entryconf 2 -state $xdiffstate
+    set savefilestate "normal"
+    if {[lindex $diffids 0] eq $nullid} {
+	set savefilestate "disabled"
+    }
+    # Disable "Save file as" item "local uncommited changes" revision
+    $flist_menu entryconf 3 -state $savefilestate
     tk_popup $flist_menu $X $Y
 }
 
@@ -3496,6 +3504,30 @@ proc external_diff_get_one_file {diffid filename diffdir} {
 	       "revision $diffid"]
 }
 
+proc save_file_as {} {
+    global nullid nullid2
+    global flist_menu_file
+    global diffids
+
+    set diffid [lindex $diffids 0]
+    if {$diffid == $nullid} {
+	return
+    } elseif {$diffid == $nullid2} {
+	set diffidtext [mc "index"]
+	set diffid ""
+	set whattext $diffidtext
+    } else {
+	set diffidtext [shortids $diffid]
+	set whattext "[mc "revision"] $diffidtext"
+    }
+    set difffile "\[$diffidtext\] [file tail $flist_menu_file]"
+    set difffile [tk_getSaveFile -initialfile $difffile -title [mc "Save file as"] -parent .]
+    if {$difffile eq {}} {
+	return
+    }
+    save_file_from_commit $diffid:$flist_menu_file $difffile $whattext
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
-- 
1.8.3.3
