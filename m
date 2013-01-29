From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH/RFC] git-blame.el: truncate author to avoid jagged left edge of code
Date: Tue, 29 Jan 2013 21:17:54 +0100
Message-ID: <87wquvkakt.fsf@hylton.kagedal.org>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <20110204014315.GB28525@elie>
	<87tygkm8h7.fsf@krank.kagedal.org>
	<201102041103.10770.jnareb@gmail.com>
	<87r5bom7g3.fsf@krank.kagedal.org> <87oc6sm1ef.fsf@krank.kagedal.org>
	<20110211022928.GA24775@elie> <20120610082437.GA29674@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Kevin Ryde <user42@zip.com.au>, Sergei Organov <osv@javad.com>,
	=?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Hli-0006Rm-CD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 21:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab3A2U0h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 15:26:37 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:52554 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3A2U0g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2013 15:26:36 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2013 15:26:36 EST
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 7963C4001D
	for <git@vger.kernel.org>; Tue, 29 Jan 2013 21:17:59 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 6D51A40016; Tue, 29 Jan 2013 21:17:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=disabled version=3.3.1
X-Spam-Score: -1.0
Received: from hylton (h77-53-24-66.dynamic.se.alltele.net [77.53.24.66])
	by mail.lysator.liu.se (Postfix) with ESMTPA id EF6DC40004;
	Tue, 29 Jan 2013 21:17:55 +0100 (CET)
Received: by hylton (Postfix, from userid 1000)
	id 4C489183BF1; Tue, 29 Jan 2013 21:17:55 +0100 (CET)
In-Reply-To: <20120610082437.GA29674@burratino> (Jonathan Nieder's message of
	"Sun, 10 Jun 2012 03:24:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214971>

Sorry for being absent a long time. I hope you have managed to sort out
the git-blame fixes anyway.

Jonathan Nieder <jrnieder@gmail.com> writes:

>Without this patch, the author column in git-blame-mode spills
>over in some rows:
>
>	822a7d <ramsay@ramsay1.demon.co.uk>:const char git_usage_
>	f2dd8c <jon.seymour@gmail.com>: "git [--version] [--exec-
>	a1bea2 <josh@joshtriplett.org>: "           [-p|--paginat
>	a1bea2 <josh@joshtriplett.org>: "           [--git-dir=3D<p
>	293b07 <trast@student.ethz.ch>: "           [-c name=3Dvalu
>	62b469 <stepan.nemec@gmail.com>:        "           <comm
>	822a7d <ramsay@ramsay1.demon.co.uk>:
>
>As a result, code meant to line up does not line up correctly and the
>colored code area has a jagged left edge.
>
>Specify a maximum width for the autohr email address in the default
>blame prefix (i.e., use %20.20A instead of %20A) to fix it.
>
>	822a7d <ramsay@ramsay1.demon.c:const char git_usage_strin
>	f2dd8c <jon.seymour@gmail.com>: "git [--version] [--exec-
>
>The (format) function used to implement format-spec has supported
>precision specifiers like ".20" in emacs since 2002-12-09, so this
>should be safe.
>
>Helped-by: Kevin Ryde <user42@zip.com.au>
>Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>---
>In February of 2011, I wrote:
>
>>  - email addresses are often longer than 20 characters.  Does
>>    format-spec provide a way to truncate to a certain length,
>>    so the prefixes can line up?
>
>Better late than never, I guess.  Sensible?
>
> contrib/emacs/git-blame.el |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
>index d351cfb6..137d5ba9 100644
>--- a/contrib/emacs/git-blame.el
>+++ b/contrib/emacs/git-blame.el
>@@ -102,7 +102,7 @@
>   :group 'git-blame)
>=20
> (defcustom git-blame-prefix-format
>-  "%h %20A:"
>+  "%h %20.20A:"
>   "The format of the prefix added to each line in `git-blame'
> mode. The format is passed to `format-spec' with the following format=
 keys:

--=20
David K=C3=A5gedal
