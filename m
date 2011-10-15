From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/4] git-gui: search and linenumber input are mutual exclusive in the blame view
Date: Sat, 15 Oct 2011 23:22:14 +0100
Message-ID: <877h45ki95.fsf@fox.patthoyts.tk>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Fries <David@Fries.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCcX-0002Lb-J3
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439Ab1JOWWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:22:17 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:21441 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751442Ab1JOWWR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 18:22:17 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015222215.SPFR21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 23:22:15 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFCcR-0005WA-Jz; Sat, 15 Oct 2011 23:22:15 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E141521B0E; Sat, 15 Oct 2011 23:22:14 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 13 Oct 2011 15:48:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=K67mSuyFn_8A:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=e_0MVxkbqTakMCutyxwA:9 a=uJP5SznLK5ciPWPqaSoA:7 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183681>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>It was possible to open the search input (Ctrl+S) and the goto-line input
>(Ctrl+G) at the same time. Prevent this.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/blame.tcl |   22 ++++++++++++++++------
> 1 files changed, 16 insertions(+), 6 deletions(-)
>
>diff --git a/lib/blame.tcl b/lib/blame.tcl
>index 2099776..691941e 100644
>--- a/lib/blame.tcl
>+++ b/lib/blame.tcl
>@@ -280,11 +280,11 @@ constructor new {i_commit i_path i_jump} {
> 	$w.ctxm add command \
> 		-label [mc "Find Text..."] \
> 		-accelerator F7 \
>-		-command [list searchbar::show $finder]
>+		-command [cb _show_finder]
> 	$w.ctxm add command \
> 		-label [mc "Goto Line..."] \
> 		-accelerator "Ctrl-G" \
>-		-command [list linebar::show $gotoline]
>+		-command [cb _show_linebar]
> 	menu $w.ctxm.enc
> 	build_encoding_menu $w.ctxm.enc [cb _setencoding]
> 	$w.ctxm add cascade \
>@@ -351,13 +351,13 @@ constructor new {i_commit i_path i_jump} {
> 	bind $w_cviewer <Tab>       "[list focus $w_file];break"
> 	bind $w_cviewer <Button-1>   [list focus $w_cviewer]
> 	bind $w_file    <Visibility> [cb _focus_search $w_file]
>-	bind $top       <F7>         [list searchbar::show $finder]
>-	bind $top       <Key-slash>  [list searchbar::show $finder]
>-	bind $top    <Control-Key-s> [list searchbar::show $finder]
>+	bind $top       <F7>         [cb _show_finder]
>+	bind $top       <Key-slash>  [cb _show_finder]
>+	bind $top    <Control-Key-s> [cb _show_finder]
> 	bind $top       <Escape>     [list searchbar::hide $finder]
> 	bind $top       <F3>         [list searchbar::find_next $finder]
> 	bind $top       <Shift-F3>   [list searchbar::find_prev $finder]
>-	bind $top    <Control-Key-g> [list linebar::show $gotoline]
>+	bind $top    <Control-Key-g> [cb _show_linebar]
> 	catch { bind $top <Shift-Key-XF86_Switch_VT_3> [list searchbar::find_prev $finder] }
> 
> 	grid configure $w.header -sticky ew
>@@ -1349,4 +1349,14 @@ method _resize {new_height} {
> 	set old_height $new_height
> }
> 
>+method _show_finder {} {
>+	linebar::hide $gotoline
>+	searchbar::show $finder
>+}
>+
>+method _show_linebar {} {
>+	searchbar::hide $finder
>+	linebar::show $gotoline
>+}
>+
> }

Looks good. Will apply.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
