From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Thu, 16 Feb 2012 09:59:29 +0100
Message-ID: <vpqy5s3i26m.fsf@bauges.imag.fr>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
	<94614DF7-9EE3-47CB-BC6E-97069597557E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxxBn-0006sM-B4
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab2BPI7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:59:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:38896 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854Ab2BPI7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:59:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1G8uOZx009811
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Feb 2012 09:56:24 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RxxBa-00020a-79; Thu, 16 Feb 2012 09:59:30 +0100
In-Reply-To: <94614DF7-9EE3-47CB-BC6E-97069597557E@gmail.com> (Steven
	Michalske's message of "Thu, 16 Feb 2012 00:47:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Feb 2012 09:56:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1G8uOZx009811
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329987388.76936@AMS+7QwhAj9QTbFamLZabg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190887>

Steven Michalske <smichalske@gmail.com> writes:

> On Mac OS X use the open command and the OS will use the correct viewer chosen by the user
>
> open "$pdffile"

Unfortunately, open also exists on my system, but does not do that at
all. I'm squashing this into the next version:

--- a/contrib/latex/git-latexdiff
+++ b/contrib/latex/git-latexdiff
@@ -120,7 +120,13 @@ if [ "$old" = "" ]; then
 fi
 
 verbose "Auto-detecting PDF viewer"
-for command in xdg-open evince okular xpdf acroread; do
+candidates="xdg-open evince okular xpdf acroread"
+if [ "$(uname)" = Darwin ]; then
+    # open exists on GNU/Linux, but does not open PDFs
+    candidates="open $candidates"
+fi
+
+for command in $candidates; do
     if [ "$PDFVIEWER" = "" ]; then
        if command -v "$command" >/dev/null 2>&1; then
            PDFVIEWER="$command"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
