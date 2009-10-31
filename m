From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] gitk: Initialize msgcat before first use
Date: 31 Oct 2009 21:34:53 +0000
Message-ID: <87d443xn5u.fsf@users.sourceforge.net>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
	<1256415640-10328-2-git-send-email-bernt@norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Sat Oct 31 23:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4MSd-0001fz-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 23:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbZJaW3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 18:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757872AbZJaW3q
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 18:29:46 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:33677 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757868AbZJaW3p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2009 18:29:45 -0400
X-Greylist: delayed 3292 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2009 18:29:45 EDT
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N4Lb5-0000LZ-JD; Sat, 31 Oct 2009 21:34:55 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1N4Lb4-0001D3-VM; Sat, 31 Oct 2009 21:34:55 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 541D813D310; Sat, 31 Oct 2009 21:34:54 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <1256415640-10328-2-git-send-email-bernt@norang.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131862>

Bernt Hansen <bernt@norang.ca> writes:

>The error text generated when your version of Tcl is too old is
>translated with msgcat (mc) before msgcat is initialized.  This
>causes Tcl to abort with:
>
>    Error in startup script: invalid command name "mc"
>
>We now initialize msgcat first before we check the Tcl version.  Msgcat
>is available since Tcl 8.1.
>

This doesn't quite work. [file normalize] was introduced with Tcl 8.4
and when I test this by starting it using Tcl 8.3 I get an error:
 "bad option "normalize": must be atime, attributes, channels..."
from line 11014. It is probably sufficient to just drop the [file
normalize] here. On Windows $argv0 is fully qualified and 
[file dirname] works ok on it. By removing the [file normalize] I get
the expected error dialog when testing with 8.3.

However, on Windows we actually get a better looking result by not
catching the [package require Tcl 8.4] and just letting Tk bring up a
standard message box with the version conflict error message.

Well, actually if show_error just used tk_messageBox it would look
better on Windows.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
