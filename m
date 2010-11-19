From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: support for underline styles
Date: Fri, 19 Nov 2010 10:00:49 +0000
Message-ID: <87oc9lhbjx.fsf@fox.patthoyts.tk>
References: <1289815498-12287-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 11:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJNs7-0007Pt-Fr
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 11:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0KSKHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 05:07:05 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:49288 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553Ab0KSKHD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 05:07:03 -0500
Received: from [172.23.144.247] (helo=asmtp-out3.blueyonder.co.uk)
	by smtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PJNru-0001Bp-Oa; Fri, 19 Nov 2010 10:06:59 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PJNru-0005qF-GL; Fri, 19 Nov 2010 10:06:58 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 1C865200C5; Fri, 19 Nov 2010 10:06:58 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1289815498-12287-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Mon, 15 Nov 2010 11:04:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161732>


Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

I left underline out because I reckon it would just make text harder to
read on a gui display. It seems like the option would only be useful on
monochrome terminals.

If we do want to support underlines in the diff view window then we can
have a different tag rather than replicating each color to get a
underlined version of the same color.
Something like the following should do it:


 git-gui.sh   |    1 +
 lib/diff.tcl |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d3acf0d..137cd72 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3330,6 +3330,7 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
 	$ui_diff tag configure clri3$n -background $c
 }
 $ui_diff tag configure clr1 -font font_diffbold
+$ui_diff tag configure clr4 -underline 1
 
 $ui_diff tag conf d_cr -elide true
 $ui_diff tag conf d_@ -font font_diffbold
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 0579fa6..203ab07 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -473,7 +473,7 @@ proc read_diff {fd cont_info} {
 			set prefix clr
 			foreach style [split $colbegin ";"] {
 				if {$style eq "7"} {append prefix i; continue}
-				if {$style < 30 || $style > 47} {continue}
+				if {$style != 4 && ($style < 30 || $style > 47)} {continue}
 				set a "$mark linestart + $posbegin chars"
 				set b "$mark linestart + $posend chars"
 				catch {$ui_diff tag add $prefix$style $a $b}
-- 
1.7.3.1.msysgit.0
