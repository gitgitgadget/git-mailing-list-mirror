From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: use a tristate to control the case mode in the searchbar
Date: Fri, 21 Oct 2011 22:41:02 +0100
Message-ID: <87r5263tw1.fsf@fox.patthoyts.tk>
References: <CAKPyHN0KCwDu2-JXAEk4wAvfOqE3jHY63aG6R9YSOoLoKwWGgQ@mail.gmail.com>
	<9193677f1fef348d5b081653840e8a829ddd3e50.1319138692.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 23:41:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHMq2-0000Ek-CY
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 23:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1JUVlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 17:41:07 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:19560 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770Ab1JUVlG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 17:41:06 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111021214103.CRTM21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 21 Oct 2011 22:41:03 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RHMpr-0001ZH-Jo; Fri, 21 Oct 2011 22:41:03 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id A4C5320368; Fri, 21 Oct 2011 22:41:02 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <9193677f1fef348d5b081653840e8a829ddd3e50.1319138692.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 20 Oct 2011 21:27:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=ztCqu3vZs30A:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=IDWggvlrpXBk3sbilmAA:9 a=I7sxn88Uez1G8kin6DMA:7 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184087>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>The config is now called gui.search.case and can have the three values:
>no/yes/smart. yes is the default.
>
>It also resets the case detection in smart mode, when the entry field was
>cleared by the use.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/search.tcl |   24 +++++++++++++++++-------
> 1 files changed, 17 insertions(+), 7 deletions(-)
>
>diff --git a/lib/search.tcl b/lib/search.tcl
>index 04a316b..ef1e555 100644
>--- a/lib/search.tcl
>+++ b/lib/search.tcl
>@@ -26,11 +26,20 @@ constructor new {i_w i_text args} {
> 	set ctext  $i_text
> 
> 	set default_regexpsearch [is_config_true gui.search.regexp]
>-	set smartcase [is_config_true gui.search.smartcase]
>-	if {$smartcase} {
>+	switch -- [get_config gui.search.case] {
>+	no {
> 		set default_casesensitive 0
>-	} else {
>+		set smartcase 0
>+	}
>+	smart {
>+		set default_casesensitive 0
>+		set smartcase 1
>+	}
>+	yes -
>+	default {
> 		set default_casesensitive 1
>+		set smartcase 0
>+	}
> 	}
> 
> 	set history [list]
>@@ -157,12 +166,10 @@ method _incrsearch {} {
> 	if {[catch {$ctext index anchor}]} {
> 		$ctext mark set anchor [_get_new_anchor $this]
> 	}
>-	if {$smartcase} {
>-		if {[regexp {[[:upper:]]} $searchstring]} {
>+	if {$searchstring ne {}} {
>+		if {$smartcase && [regexp {[[:upper:]]} $searchstring]} {
> 			set casesensitive 1
> 		}
>-	}
>-	if {$searchstring ne {}} {
> 		set here [_do_search $this anchor mlen]
> 		if {$here ne {}} {
> 			$ctext see $here
>@@ -175,6 +182,9 @@ method _incrsearch {} {
> 			#$w.ent configure -background lightpink
> 			$w.ent state pressed
> 		}
>+	} elseif {$smartcase} {
>+		# clearing the field resets the smart case detection
>+		set casesensitive 0
> 	}
> }

Look good to me. Applied.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
