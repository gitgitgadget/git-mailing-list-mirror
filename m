From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 11:34:13 +0100
Message-ID: <vpqio1nsk0q.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
	<vpqd1s04zzs.fsf@anie.imag.fr>
	<CAGZ79kbUG73eo5YvedbVB0bmZduMeCWNpbCRK4Adr9XDebsbQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:34:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVzRJ-0002ZA-80
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 11:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbcBQKe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 05:34:28 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58757 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934038AbcBQKe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 05:34:27 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1HAYC6v028973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 17 Feb 2016 11:34:12 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1HAYDOf023835;
	Wed, 17 Feb 2016 11:34:13 +0100
In-Reply-To: <CAGZ79kbUG73eo5YvedbVB0bmZduMeCWNpbCRK4Adr9XDebsbQQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 16 Feb 2016 10:10:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Feb 2016 11:34:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1HAYC6v028973
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456310055.65575@EhMmsquA6KHxRXwF3Suryg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286492>

Stefan Beller <sbeller@google.com> writes:

> I'd be interested to co-mentor a sh->C conversion.
>
> I think the git-rebase*.sh is a good start.
>
> $ wc -l git-rebase*.sh
>   101 git-rebase--am.sh
>  1296 git-rebase--interactive.sh
>   167 git-rebase--merge.sh
>   636 git-rebase.sh
>  2200 total
>
> So start with rebase--am and rebase--merge to have the same amount
> of lines as git-pull.sh. I did not look at the code, just judging by
> the lines of
> code.

There's a funny exercice there: the git-rebase--$type.sh scripts are not
called as external helpers, but like this:

run_specific_rebase () {
	if [ "$interactive_rebase" = implied ]; then
		GIT_EDITOR=:
		export GIT_EDITOR
		autosquash=
	fi
	. git-rebase--$type
	# ...

So, turning these scripts into builtins would first require turning this
". git-rebase--$type" into an actual command call. But nothing
unfeasible.

Anyway, I'm not happy with the current shape of the code since
.-including files within a function already caused us several issues (I
fixed a FreeBSD related bug which triggered another one, so the current
code is a fix for a workaround for a FreeBSD issue ...).

I guess git-rebase--interactive.sh would be a lot for a single GSoC
project, but it can remain a shell-script helper called by a builtin.

Can you add more details to the "Convert scripts to builtins" part of
http://git.github.io/SoC-2016-Ideas/ to reflect this? And make it look
attractive for candidates ;-).

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
