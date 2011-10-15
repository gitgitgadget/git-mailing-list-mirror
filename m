From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [RFC/PATCH 4/4] git-gui: incremental goto line in blame view
Date: Sat, 15 Oct 2011 23:26:46 +0100
Message-ID: <8739etki1l.fsf@fox.patthoyts.tk>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
	<fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
	<1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<7a9760b8cf85274b17c7233f61f59bb59cd18578.1318513492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Fries <David@Fries.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:26:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCgu-0003hN-N7
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab1JOW0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:26:48 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:51244 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab1JOW0s (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 18:26:48 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015222646.ULEF13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 23:26:46 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFCgo-00010u-Rs; Sat, 15 Oct 2011 23:26:46 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2B595207A7; Sat, 15 Oct 2011 23:26:46 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7a9760b8cf85274b17c7233f61f59bb59cd18578.1318513492.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 13 Oct 2011 15:48:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=iy88rGj-4cQA:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=xA6SEuRzsxCn1pgWn0QA:9 a=jRsVjsjgo92BA_X3wwMA:7 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183682>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>The view jumps now to the given line number after each key press.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
>
>I didn't know this before, but gedits goto-line-dialog works this way.
>
> lib/line.tcl |   15 +++++++++++----
> 1 files changed, 11 insertions(+), 4 deletions(-)
>
>diff --git a/lib/line.tcl b/lib/line.tcl
>index 70785e1..0113e06 100644
>--- a/lib/line.tcl
>+++ b/lib/line.tcl
>@@ -20,7 +20,7 @@ constructor new {i_w i_text args} {
> 		-background lightgreen \
> 		-validate key \
> 		-validatecommand [cb _validate %P]
>-	${NS}::button $w.bn      -text [mc Go] -command [cb _incrgoto]
>+	${NS}::button $w.bn      -text [mc Go] -command [cb _goto]
> 
> 	pack   $w.l   -side left
> 	pack   $w.bn  -side right
>@@ -29,7 +29,8 @@ constructor new {i_w i_text args} {
> 	eval grid conf $w -sticky we $args
> 	grid remove $w
> 
>-	bind $w.ent <Return> [cb _incrgoto]
>+	trace add variable linenum write [cb _goto_cb]
>+	bind $w.ent <Return> [cb _goto]
> 	bind $w.ent <Escape> [cb hide]
> 
> 	bind $w <Destroy> [list delete_this $this]
>@@ -67,10 +68,16 @@ method _validate {P} {
> 	return 0
> }
> 
>-method _incrgoto {} {
>+method _goto_cb {name ix op} {
>+	after idle [cb _goto 1]
>+}
>+
>+method _goto {{nohide {0}}} {
> 	if {$linenum ne {}} {
> 		$ctext see $linenum.0
>-		hide $this
>+		if {!$nohide} {
>+			hide $this
>+		}
> 	}
> }

Works fine. Will apply.

OK These 4 patches are applied and pushed to master branch - with
modifications made to 'only accept numbers in the goto-line input' made
as mentioned.

Thanks,

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
