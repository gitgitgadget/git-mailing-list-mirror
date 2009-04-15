From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: handle external diff tool with spaces in the path
Date: 15 Apr 2009 16:54:19 +0100
Message-ID: <87tz4pnc9g.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 17:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7Sv-0000Og-Ik
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 17:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbZDOPyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 11:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZDOPyX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 11:54:23 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:49614 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014AbZDOPyW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 11:54:22 -0400
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Lu7RN-0000NS-4X; Wed, 15 Apr 2009 16:54:21 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Lu7RM-0006gp-KW; Wed, 15 Apr 2009 16:54:20 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 114EE51836; Wed, 15 Apr 2009 16:54:20 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116618>


  This fixes the launching of external diff to handle a diff tool
  that has spaces in the path. This patch ensures a correctly formed
  tcl list is passed to the open command with a single pipe character
  prefixing the list (as per the tcl manual page for open).

  The specific fault observed was that selecting WinMerge as the diff
  tool from the default installed location in Program Files failed to
  be launched from the context menu.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index edb3ba2..656c2c1 100755
--- a/gitk
+++ b/gitk
@@ -3237,9 +3237,8 @@ proc external_diff {} {
     set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
 
     if {$difffromfile ne {} && $difftofile ne {}} {
-        set cmd [concat | [shellsplit $extdifftool] \
-		     [list $difffromfile $difftofile]]
-        if {[catch {set fl [open $cmd r]} err]} {
+        set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
+        if {[catch {set fl [open |$cmd r]} err]} {
             file delete -force $diffdir
             error_popup "$extdifftool: [mc "command failed:"] $err"
         } else {
-- 
1.6.2.2.1669.g7eaf8
