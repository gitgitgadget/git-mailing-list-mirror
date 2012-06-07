From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 22:49:23 +0200
Message-ID: <vpqboku3l0s.fsf@bauges.imag.fr>
References: <4FD0D375.9060902@web.de>
	<1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<4FD0EB76.90501@web.de>
	<20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
	<4FD0FCAC.3070408@web.de>
	<20120607215512.Horde.RVmScHwdC4BP0QcggMBjKUA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 22:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScjeH-0008I1-67
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503Ab2FGUta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 16:49:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34271 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086Ab2FGUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 16:49:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q57KefVS032636
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 22:40:41 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Scje0-0007gr-2i; Thu, 07 Jun 2012 22:49:24 +0200
In-Reply-To: <20120607215512.Horde.RVmScHwdC4BP0QcggMBjKUA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Thu, 07 Jun 2012 21:55:12
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jun 2012 22:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57KefVS032636
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339706442.71039@B8sdvc1ER/qMZxxAujYnJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199450>

konglu@minatec.inpg.fr writes:

> As you pointed out, the problem seems to come from this line
> 	tmp=$(sed "/^pick .*/i\exec $i" "$1")
> I think that the dquote here doesn't work on MacOS, though i've
> never tried it.

I don't see a reason why it wouldn't. Anyway, quotes are managed by the
shell, and in our case, sed is the one complaining.

I experimented a bit, and it seems Mac OS's sed insists in having a \
and a newline after i (it seems POSIX requires it too). In your code
above, the \ is included in double quotes, so you have to escape it.

This snippet works reliably on my Linux machine and on a Mac OS X one:

x=$(echo 'pick foo' | sed -e "/pick/i\\
exec $1")
echo "$x"

> Anyway, even if it's not the problem, this kind of quoting is quite
> odd so it will be removed in the next patch

Be careful, you do need quoting around $i.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
