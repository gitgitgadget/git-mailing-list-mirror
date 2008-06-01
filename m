From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sun, 01 Jun 2008 10:22:01 +0200
Message-ID: <vpqabi5o992.fsf@bauges.imag.fr>
References: <1212258886-87484-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Jun 01 10:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ird-0007Ji-RS
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 10:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYFAIXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 04:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYFAIXi
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 04:23:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:37591 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbYFAIXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 04:23:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m518M5QO006860
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 1 Jun 2008 10:22:05 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K2ipF-0000Zj-Vn; Sun, 01 Jun 2008 10:22:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K2ipF-0007bV-Sp; Sun, 01 Jun 2008 10:22:01 +0200
In-Reply-To: <1212258886-87484-1-git-send-email-mfwitten@mit.edu> (Michael Witten's message of "Sat\, 31 May 2008 14\:34\:46 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 01 Jun 2008 10:22:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83436>

Michael Witten <mfwitten@MIT.EDU> writes:

> [problem with different versions of perl]

There's also the case where perl simply isn't available in /usr/bin,
but is somewhere else.

> It would seem to me that something like '/usr/bin/env perl' is slightly
> more vanilla in the sense that it can handle more cases.
>
> Perhaps the Makefile can be smarter about guessing the right path?

Perhaps something like this?

diff --git a/Makefile b/Makefile
index 865e2bf..5828745 100644
--- a/Makefile
+++ b/Makefile
@@ -323,7 +323,7 @@ ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
 ifndef PERL_PATH
-	PERL_PATH = /usr/bin/perl
+	PERL_PATH = $(shell which perl)
 endif
 
 export PERL_PATH

(untested)

This would generate the same files in the common case, but detect
another installation at compile time.

Note that this is indeed different from the original proposal in the
case of a multi-user system: here, the perl installation is chosen
once and for all by the guy who installs git, but can't be overridden
later (e.g by a user having his own custom perl installation in his
$HOME). I don't know which is better.


-- 
Matthieu
