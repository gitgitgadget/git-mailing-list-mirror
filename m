From: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Subject: PATCH to add a button to perform a meld on the current file
Date: Fri, 07 Sep 2007 14:16:22 +0930
Message-ID: <46E0D79E.3080606@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080700050803080500010209"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 07:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITW8j-00062E-Qh
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 07:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbXIGFMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 01:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXIGFMQ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 01:12:16 -0400
Received: from tanto.mecheng.adelaide.edu.au ([129.127.14.1]:28247 "EHLO
	tanto.mecheng.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555AbXIGFMP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 01:12:15 -0400
X-Greylist: delayed 1550 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2007 01:12:15 EDT
Received: from [129.127.15.154] (unknown [129.127.15.154])
	by tanto.mecheng.adelaide.edu.au (Postfix) with ESMTP id 83985402426C
	for <git@vger.kernel.org>; Fri,  7 Sep 2007 14:08:30 +0930 (CST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57979>

This is a multi-part message in MIME format.
--------------080700050803080500010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a dodgy [not that good] patch to perform a GUI comparison on a file.
It is dodgy because it assumes cogito is installed, and you want to use 
meld, and it doesn't remove the temporary files.

Not expecting this to go into main branch, but I find it handy for my 
own purposes nether-the-less.

Pierre

--------------080700050803080500010209
Content-Type: text/x-patch;
 name="gitk_addGUIdiff01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitk_addGUIdiff01.patch"

--- /usr/bin/gitk	2007-08-06 07:55:41.000000000 +0930
+++ /home/pmdumuid/bin/gitkpmd	2007-09-07 14:09:28.000000000 +0930
@@ -609,7 +609,9 @@
 	-command changediffdisp -variable diffelide -value {0 1}
     radiobutton .bleft.mid.new -text "New version" \
 	-command changediffdisp -variable diffelide -value {1 0}
-    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
+    button .bleft.top.meld -text "GUI diff" -command doguidiff \
+	-font $uifont
+    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new .bleft.top.meld -side left
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font $textfont \
@@ -4564,6 +4566,19 @@
     }
 }
 
+proc doguidiff {} {
+    global cflist sha1string
+
+    set taglist [$cflist tag ranges highlight]
+    set from [lindex $taglist 0]
+    set to [lindex $taglist 1]
+
+    set fname [$cflist get $from $to]
+    exec cg-admin-cat -r $sha1string^ $fname > .gitk_diffolder
+    exec cg-admin-cat -r $sha1string $fname > .gitk_diffnewer
+    exec meld .gitk_diffolder .gitk_diffnewer &
+}
+
 proc dosearch {} {
     global sstring ctext searchstring searchdirn
 

--------------080700050803080500010209--
