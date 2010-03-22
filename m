From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: Fix display of copyright symbol in non-utf-8 locales
Date: Mon, 22 Mar 2010 22:58:03 +0000
Message-ID: <87pr2wc6bo.fsf@fox.patthoyts.tk>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
	<1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
	<1268418709-4998-3-git-send-email-patthoyts@users.sourceforge.net>
	<20100320061452.GA26224@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 23:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtqZb-0002d4-2q
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 23:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab0CVW6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 18:58:10 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58279 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756657Ab0CVW6I convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 18:58:08 -0400
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NtqZR-0002r4-5U; Mon, 22 Mar 2010 22:58:05 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NtqZQ-00062f-CS; Mon, 22 Mar 2010 22:58:04 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id DD422201F7; Mon, 22 Mar 2010 22:58:03 +0000 (GMT)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <20100320061452.GA26224@progeny.tock> (Jonathan Nieder's message of "Sat\, 20 Mar 2010 01\:14\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142974>

Jonathan Nieder <jrnieder@gmail.com> writes:

>Unless the =91-encoding=92 option is supplied, wish interprets source
>files using the default system encoding, which depends on locale.
>This can cause the copyright symbol to display incorrectly in gitk=92s
>about dialog.
>
>The -encoding option was added to tcl in version 8.1.
>
>Reported-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>---
>Hi,
>
>Pat Thoyts wrote:
>
>> The script file uses utf-8 encoding but when sourced it will be read
>> using the default system encoding which is never utf8 on windows. Th=
is
>> causes the copyright symbol to display incorrectly in the about dial=
og.
>
>I can reproduce this in Linux with LANG=3Dde_DE@euro ./gitk.
>
>> Using the unicode escape sequence avoids incorrect decoding but does
>> require a double escape in the .po files.
>
>When I tried applying your patch, running =93make update-po=94 seemed =
to
>undo its effect on translations.  I am also worried about what would
>happen in locales where ASCII is not a subset of the native character
>set, or other uses of non-ASCII characters in the translated messages.
>
>Maybe the following would be safer?  I haven=92t looked at the effect =
on
>translations yet.
>
> gitk |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/gitk b/gitk
>index 1f36a3e..a7c9a9a 100755
>--- a/gitk
>+++ b/gitk
>@@ -1,6 +1,6 @@
> #!/bin/sh
> # Tcl ignores the next line -*- tcl -*- \
>-exec wish "$0" -- "$@"
>+exec wish -encoding utf-8 "$0" -- "$@"
>=20
> # Copyright =A9 2005-2009 Paul Mackerras.  All rights reserved.
> # This program is free software; it may be used, copied, modified
>--=20
>1.7.0.2

I would much rather see any fault in the makefile fixed than use
source -encoding in all the various places this script might get
loaded from. THere are two characters in this file that are not ASCII
and one of them is in a comment. We could even just use (c) to
simplify this. However, \u00a9 is the correct unicode escape sequence
for tcl to get a copyright character into the script in a way that is
independent of the encoding. The escape sequence should be passed
through unchanged in any translations - tcl wants to see exactly
\u00a9 and everyone is using a copyright glyph here.=20
--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
