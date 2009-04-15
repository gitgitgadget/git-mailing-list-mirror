From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: avoid crash if closed while reading references
Date: 15 Apr 2009 17:14:03 +0100
Message-ID: <87prfdnbck.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 18:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7m6-0000HS-3y
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZDOQON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbZDOQOM
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:14:12 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:56339 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704AbZDOQOM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 12:14:12 -0400
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Lu7kY-0004m1-F1; Wed, 15 Apr 2009 17:14:10 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Lu7kS-0007gH-Vb; Wed, 15 Apr 2009 17:14:05 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 7DC0D51836; Wed, 15 Apr 2009 17:14:04 +0100 (BST)
CC: johannes.schindelin@gmx.de
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116620>


  As recorded in msysGit issue 125 if the user closes gitk while it
  reports itself as still reading references then Tk will crash in the
  geometry management code. This has been fixed for Tk 8.5.7 and above.
  This patch avoids the problem by flushing outstanding geometry events
  before calling the readrefs procedure.

  See also http://code.google.com/p/msysgit/issues/detail?id=125

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 656c2c1..a346bd5 100755
--- a/gitk
+++ b/gitk
@@ -10952,6 +10952,7 @@ catch {
 # wait for the window to become visible
 tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
+update
 readrefs
 
 if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
-- 
1.6.2.2.1669.g7eaf8
