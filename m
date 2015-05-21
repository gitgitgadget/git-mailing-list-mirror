From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Thu, 21 May 2015 10:09:45 +0200
Message-ID: <vpqd21ujqra.fsf@anie.imag.fr>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<alpine.DEB.2.11.1505202256330.9343@orwell.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Faheem Mitha <faheem@faheem.info>
X-From: git-owner@vger.kernel.org Thu May 21 10:10:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvLYX-0007oN-9E
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbbEUIKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:10:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50678 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755490AbbEUIJv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:09:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4L89iOt023046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 May 2015 10:09:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4L89jte030562;
	Thu, 21 May 2015 10:09:45 +0200
In-Reply-To: <alpine.DEB.2.11.1505202256330.9343@orwell.homelinux.org> (Faheem
	Mitha's message of "Wed, 20 May 2015 23:28:15 +0530 (IST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 21 May 2015 10:09:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4L89iOt023046
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432800585.23926@pqLyEKMo+FWn78rs11LceQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269567>

Faheem Mitha <faheem@faheem.info> writes:

> I was going by the answer (by CodeWizard) in
> http://stackoverflow.com/q/30348615/350713

OK, so the hash you got comes from a superproject which references it.
My guess is that the superproject did a private commit in a submodule,
added this submodule to the superproject, and forgot to push the
submodule.

If so, it's a user error (that could arguably have been avoided with a
better command-line interface, so Git is partly guilty), but not a
repository corruption.

> If I just give a random hash to `git show` in that repos, I get
>
>     fatal: ambiguous argument '...': unknown revision or path not in the working tree.

Not "a random hash", but a random abreviated hash. Look:

Changing the last digit:

$ git show 280c12ab49223c64c6f914944287a7d049cf4d23
fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4d23
$ git show 280c12ab49223c64c6f914944287a7d049cf4d24
fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4d24
$ git show 280c12ab49223c64c6f914944287a7d049cf4d25
fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4d25
$ git show 280c12ab49223c64c6f914944287a7d049cf4d26
fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4d26

Removing the last digit:

$ git show 280c12ab49223c64c6f914944287a7d049cf4d2 
fatal: ambiguous argument '280c12ab49223c64c6f914944287a7d049cf4d2': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
