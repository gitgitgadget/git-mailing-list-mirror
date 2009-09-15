From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/2] Work around leftover temporary save file.
Date: Tue, 15 Sep 2009 10:26:30 +0100
Message-ID: <87ab0wcsyp.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexy Borzenkov <snaury@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 14:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnWoU-0001u9-0y
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 14:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbZIOMG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 08:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZIOMG6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 08:06:58 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:58093 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094AbZIOMG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 08:06:58 -0400
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MnWoC-00055Y-Da; Tue, 15 Sep 2009 13:06:56 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MnWoB-0008Sz-RL; Tue, 15 Sep 2009 13:06:55 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 3552851843; Tue, 15 Sep 2009 13:06:54 +0100 (BST)
Cc: Paul Mackerras <paulus@samba.org>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128532>


If a file exists and is hidden on Windows the Tcl open command will
fail as the attributes provided in the CREAT call fail to match those
of the existing file. Forcing removal of the temporary file before we
begin solves any problems caused by previous failures to save the
application settings. An alternative would be to remove the hidden
attribute before calling 'open'.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1306178..a0214b7 100755
--- a/gitk
+++ b/gitk
@@ -2526,6 +2526,7 @@ proc savestuff {w} {
     if {$stuffsaved} return
     if {![winfo viewable .]} return
     catch {
+	if {[file exists ~/.gitk-new]} {file delete -force ~/.gitk-new}
 	set f [open "~/.gitk-new" w]
 	if {$::tcl_platform(platform) eq {windows}} {
 	    file attributes "~/.gitk-new" -hidden true
-- 
1.6.4.msysgit.0
