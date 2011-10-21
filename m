From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: delegate selection from gutter columns to text output
Date: Fri, 21 Oct 2011 23:24:18 +0100
Message-ID: <87ehy63rvx.fsf@fox.patthoyts.tk>
References: <5fc6f5d088e37508f1911f89b4d82932071045e0.1319139888.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 00:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHNVp-0005t6-RI
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 00:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1JUWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 18:24:20 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:46565 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab1JUWYU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 18:24:20 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111021222419.EVMJ21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 21 Oct 2011 23:24:19 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RHNVi-000063-Vj; Fri, 21 Oct 2011 23:24:19 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 6F95F20368; Fri, 21 Oct 2011 23:24:18 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <5fc6f5d088e37508f1911f89b4d82932071045e0.1319139888.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 20 Oct 2011 21:45:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=sgn3AYuFd48A:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=jpW39f6Ji4A5xmqXilAA:9 a=0vbdCUBCLUEpctwbseMA:7 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184090>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Selecting in the gutter columns of the blame view should make no sense,
>so delegate any selection action in these columns to the text output
>by selecting whole lines there.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> git-gui.sh    |   20 ++++++++++++++++++++
> lib/blame.tcl |    4 +++-
> 2 files changed, 23 insertions(+), 1 deletions(-)
>
>diff --git a/git-gui.sh b/git-gui.sh
>index 21033cb..cf5ed79 100755
>--- a/git-gui.sh
>+++ b/git-gui.sh
>@@ -2077,6 +2077,26 @@ proc many2scrollbar {list mode sb top bottom} {
> 	foreach w $list {$w $mode moveto $top}
> }
> 
>+proc delegate_sel_to {w from} {
>+	set bind_list [list \
>+		<Button-1> \
>+		<B1-Motion> \
>+		<Double-Button-1> \
>+		<Triple-Button-1> \
>+		<Shift-Button-1> \
>+		<Double-Shift-Button-1> \
>+		<Triple-Shift-Button-1> \
>+	]
>+
>+	foreach seq $bind_list {
>+		set script [bind Text $seq]
>+		set new_script [string map [list %W $w %x 0 word line] $script]
>+		foreach f $from {
>+			bind $f $seq "$new_script; break"
>+		}
>+	}
>+}
>+
> proc incr_font_size {font {amt 1}} {
> 	set sz [font configure $font -size]
> 	incr sz $amt
>diff --git a/lib/blame.tcl b/lib/blame.tcl
>index 49eae19..9ab0da5 100644
>--- a/lib/blame.tcl
>+++ b/lib/blame.tcl
>@@ -210,6 +210,8 @@ constructor new {i_commit i_path i_jump} {
> 
> 	set w_columns [list $w_amov $w_asim $w_line $w_file]
> 
>+	delegate_sel_to $w_file [list $w_amov $w_asim $w_line]
>+
> 	${NS}::scrollbar $w.file_pane.out.sbx \
> 		-orient h \
> 		-command [list $w_file xview]
>@@ -315,7 +317,7 @@ constructor new {i_commit i_path i_jump} {
> 		$i conf -yscrollcommand \
> 			"[list ::searchbar::scrolled $finder]
> 			 [list many2scrollbar $w_columns yview $w.file_pane.out.sby]"
>-		bind $i <Button-1> "
>+		bind $i <Button-1> "+
> 			[cb _hide_tooltip]
> 			[cb _click $i @%x,%y]
> 			focus $i

The patch seems to be fine but I don't think I agree with the intention
here. Currently clicking anywhere that is not marked as a link (blue
underlined text) selects a commit and shows information in the lower
pane. With this change, the left hand columns become inactive in regards
to selecting a commit. I don't see why that is desirable.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
