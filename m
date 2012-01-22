From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] fix git-gui crash due to uninitialized variable
Date: Sun, 22 Jan 2012 23:18:58 +0000
Message-ID: <87bopvz5p9.fsf@fox.patthoyts.tk>
References: <20120121175724.GA7319@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jan 23 00:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp6hB-0005ZI-44
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 00:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab2AVXTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 18:19:04 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:65123 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752255Ab2AVXTD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2012 18:19:03 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120122231859.YEQY27245.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sun, 22 Jan 2012 23:18:59 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Rp6gd-00014E-RS; Sun, 22 Jan 2012 23:18:59 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id EDDDF20A81; Sun, 22 Jan 2012 23:18:58 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20120121175724.GA7319@ecki> (Clemens Buchacher's message of
	"Sat, 21 Jan 2012 18:57:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=hkuyh5REm3kA:10 a=kj9zAlcOel0A:10 a=Rf460ibiAAAA:8 a=UODnhlcGlycEuP4qaoIA:9 a=Uv4C6vmcxyU-YqrxpSMA:7 a=CjuIK1q_8ugA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188972>

Clemens Buchacher <drizzd@aon.at> writes:

>Recently, a clone initiated via git gui on Windows crashed on me due to
>an "unknown variable cdone". It turns out that there is a code path
>where this variable is used uninitialized.
>
>Signed-off-by: Clemens Buchacher <drizzd@aon.at>
>---
>
>Looking at the output of display(), it's not clear to me now the
>function below could ever be called with total=0. But I can't delve into
>it more deeply right now, and this seems like an obvious fix.
>
> git-gui/lib/status_bar.tcl |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
>index 95cb449..02111a1 100644
>--- a/git-gui/lib/status_bar.tcl
>+++ b/git-gui/lib/status_bar.tcl
>@@ -77,6 +77,7 @@ method start {msg uds} {
> 
> method update {have total} {
> 	set pdone 0
>+	set cdone 0
> 	if {$total > 0} {
> 		set pdone [expr {100 * $have / $total}]
> 		set cdone [expr {[winfo width $w_c] * $have / $total}]

It might be nice to know what kind of conditions triggered this for you,
but the patch is fine. Thanks, applied.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
