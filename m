From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Gitk local language issue
Date: Sat, 18 Feb 2012 13:09:01 +0000
Message-ID: <8762f4xp8y.fsf@fox.patthoyts.tk>
References: <1329467459691-7293532.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: shyamal <shyamal2005@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 14:09:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryk2O-0004Wy-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 14:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab2BRNJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 08:09:09 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:59443 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752242Ab2BRNJH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2012 08:09:07 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120218130904.RDXL15568.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 18 Feb 2012 13:09:04 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Ryk2B-0006OH-Ua; Sat, 18 Feb 2012 13:09:03 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C1AB2217EE; Sat, 18 Feb 2012 13:09:02 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1329467459691-7293532.post@n2.nabble.com> (shyamal's message of
	"Fri, 17 Feb 2012 00:30:59 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=8eIMXMbzO203UfjatMAA:9 a=meFZqHEATPx4Zu0bZGUA:7 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191006>

shyamal <shyamal2005@gmail.com> writes:

>Hi,
>
>I am working in Japan now on a windows environment.
>I installed GIT on my machine.When I run the application,The menus are in
>Japanese.To get the English menu I added 
>@set LANG=en 
>at the beginning of git.cmd file.This worked like a magic :-)
>But when I click the Visualize master' history from the repository menu of
>Git Gui, a new interface (Gitk:Websites) opens where all the menus are still
>in Japanese.Any idea how to change the menu to  English in Gitk too?
>
>Thanks in advance
>
>Regards,
>Shyamal.

If I modify the git.cmd file here on my English system to include
@set LANG=fr just after the @set PLINK_PROTOCOL=ssh command, then git
gui runs with French menus and selecting the view history menu item
launches gitk with French menus.

This is because git-gui executes a new tcl interpreter subprocess passing
in the known gitk script location. So the gitk process inherits the
git-gui environment (including this LANG setting). It doesn't call the
gitk.cmd script on Windows.

Possibly your interpreter is picking up some other locale setting. The
msgcat script will use LC_ALL, LC_MESSAGES or LANG (in that order) and
only makes use of the first one it sees. So perhaps you have an LC_ALL
set someplace - however, I would assume that would force the git-gui
script to use that locale too.

One quick hack would be to modify bin/gitk and after the msgcat
initialization force the locale using:
   msgcat::mclocale en


-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
