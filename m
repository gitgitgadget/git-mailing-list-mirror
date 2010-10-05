From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] On Windows, avoid git-gui to call Cygwin's nice utility
Date: Tue, 05 Oct 2010 11:03:02 +0100
Message-ID: <8762xhq7mx.fsf@fox.patthoyts.tk>
References: <AANLkTik4WdEcfQCGETJ6VQs=fj0DLr1DA+5JQCXqYpUP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 12:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P34Mk-0004l3-6d
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 12:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758019Ab0JEKDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 06:03:13 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:37150 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755445Ab0JEKDM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 06:03:12 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P34MW-00057a-R9; Tue, 05 Oct 2010 11:03:09 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P34MR-0003TF-3K; Tue, 05 Oct 2010 11:03:03 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 7FF2F25205; Tue,  5 Oct 2010 11:03:02 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTik4WdEcfQCGETJ6VQs=fj0DLr1DA+5JQCXqYpUP@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 5 Oct 2010 11:12:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158182>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>It's a common case for Windows developers to have both Cygwin and msysGit
>installed. Unfortunately, some scenarios also require to have Cygwin in PATH.
>By default, Cygwin comes with nice.exe, while msysGit does not. Since git-gui
>calls nice if it is in PATH, this results in Cygwin's nice.exe being called
>from msysGit's git-gui. Mixing Cygwin and msysGit generally is not a good idea,
>and in this particular case it causes differences not being correctly detected.
>So we only call nice.exe on Windows if it is in the same directory as git.exe.
>This way, this work-around does neither affect a pure Cygwin environment, or
>the case when nice.exe will be shipped with msysGit at some point in time.
>
>This fixes msysGit issue 394.
>
>Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>---
> git-gui/git-gui.sh |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index 3c9a8aa..288ec87 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -444,6 +444,8 @@ proc _lappend_nice {cmd_var} {
> 		set _nice [_which nice]
> 		if {[catch {exec $_nice git version}]} {
> 			set _nice {}
>+		} elseif {[is_Windows] && [file dirname $_nice] != [file dirname $::_git]} {
>+			set _nice {}
> 		}
> 	}
> 	if {$_nice ne {}} {

I just tested this out and its fine. It's marginally better to use 'ne'
rather than '!=' as the comparison operator here as this is a string
comparison and we don't support tcl older than 8.4 when 'eq/ne' was
introduced. I've applied it to git-gui's repository with 'ne'.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
