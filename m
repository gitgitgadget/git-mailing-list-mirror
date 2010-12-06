From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] Fix use of hunk tag for non-hunk content.
Date: Mon, 06 Dec 2010 21:25:43 +0000
Message-ID: <87ei9uy4o8.fsf@fox.patthoyts.tk>
References: <02730a5b5e904409da58c7f5ebe40e16e7adc1f1.1291019649.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:26:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiZl-0000qt-7X
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab0LFV0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:26:21 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:51109 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193Ab0LFV0T (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 16:26:19 -0500
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PPiZe-0002Cd-Ci; Mon, 06 Dec 2010 21:26:18 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PPiZ6-0001ig-2w; Mon, 06 Dec 2010 21:25:44 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id B6EE7218F6; Mon,  6 Dec 2010 21:25:43 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <02730a5b5e904409da58c7f5ebe40e16e7adc1f1.1291019649.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Mon, 29 Nov 2010 12:41:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163025>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>The hunk tag d_@ lost its blue forground color in "apply color information
>from git diff output" (2010-10-22, 8f85599). But this tag was also used
>for non-hunk content like untracked file mime types or git submodules.
>
>Introduce a new tag for this type of content which has the blue forground
>again.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> git-gui.sh   |    2 ++
> lib/diff.tcl |   14 +++++++-------
> 2 files changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/git-gui.sh b/git-gui.sh
>index 38362fa..c85a53c 100755
>--- a/git-gui.sh
>+++ b/git-gui.sh
>@@ -3331,6 +3331,8 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
> }
> $ui_diff tag configure clr1 -font font_diffbold
> 
>+$ui_diff tag conf d_info -foreground blue -font font_diffbold
>+
> $ui_diff tag conf d_cr -elide true
> $ui_diff tag conf d_@ -font font_diffbold
> $ui_diff tag conf d_+ -foreground {#00a000}
>diff --git a/lib/diff.tcl b/lib/diff.tcl
>index 8fea947..8435635 100644
>--- a/lib/diff.tcl
>+++ b/lib/diff.tcl
>@@ -208,32 +208,32 @@ proc show_other_diff {path w m cont_info} {
> 			$ui_diff insert end [append \
> 				"* " \
> 				[mc "Git Repository (subproject)"] \
>-				"\n"] d_@
>+				"\n"] d_info
> 		} elseif {![catch {set type [exec file $path]}]} {
> 			set n [string length $path]
> 			if {[string equal -length $n $path $type]} {
> 				set type [string range $type $n end]
> 				regsub {^:?\s*} $type {} type
> 			}
>-			$ui_diff insert end "* $type\n" d_@
>+			$ui_diff insert end "* $type\n" d_info
> 		}
> 		if {[string first "\0" $content] != -1} {
> 			$ui_diff insert end \
> 				[mc "* Binary file (not showing content)."] \
>-				d_@
>+				d_info
> 		} else {
> 			if {$sz > $max_sz} {
> 				$ui_diff insert end [mc \
> "* Untracked file is %d bytes.
> * Showing only first %d bytes.
>-" $sz $max_sz] d_@
>+" $sz $max_sz] d_info
> 			}
> 			$ui_diff insert end $content
> 			if {$sz > $max_sz} {
> 				$ui_diff insert end [mc "
> * Untracked file clipped here by %s.
> * To see the entire file, use an external editor.
>-" [appname]] d_@
>+" [appname]] d_info
> 			}
> 		}
> 		$ui_diff conf -state disabled
>@@ -442,10 +442,10 @@ proc read_diff {fd conflict_size cont_info} {
> 		} elseif {$is_submodule_diff} {
> 			if {$line == ""} continue
> 			if {[regexp {^Submodule } $line]} {
>-				set tags d_@
>+				set tags d_info
> 			} elseif {[regexp {^\* } $line]} {
> 				set line [string replace $line 0 1 {Submodule }]
>-				set tags d_@
>+				set tags d_info
> 			} else {
> 				set op [string range $line 0 2]
> 				switch -- $op {

Looks great. Thank you.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
