From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git 'new' alias
Date: Mon, 05 Sep 2011 18:36:48 +0200
Message-ID: <vpqipp77xpb.fsf@bauges.imag.fr>
References: <CACnwZYfo2E0SFfFrYzUktAZYwqgyX_J4KgFQD5kqXToGmip3Lg@mail.gmail.com>
	<vpqei00m4pf.fsf@bauges.imag.fr>
	<20110901211747.GA16308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 18:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0cAm-0001TY-8d
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 18:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab1IEQhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 12:37:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47018 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab1IEQhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 12:37:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p85GZtkG002567
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2011 18:35:57 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R0cAD-0005SS-5B; Mon, 05 Sep 2011 18:36:49 +0200
In-Reply-To: <20110901211747.GA16308@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 1 Sep 2011 17:17:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 05 Sep 2011 18:35:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p85GZtkG002567
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315845358.2097@9Qc5M0cM4Ydab9cIQB9NUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180748>

Jeff King <peff@peff.net> writes:

>   $ git config alias.one
>   !f() { r=$1; shift; echo $r@{1}..$r@{0} "$@"; }; f

(which, I've just discovered, should be written as

[alias]
        one = "!f() { r=$1; shift; echo $r@{1}..$r@{0} "$@"; }; f"

otherwise "git config" messes up with the ; in the line)

> which I think was the original intent (modulo me replacing "git log"
> with "echo" for debugging, of course).

The original intent was mis-specified ;-).

I think I originally made the alias to do

git new               # give me new stuff on current branch
git new origin/master # same, for origin/master

and tried to enrich it to allow

git new master --oneline

without thinking about what

git new --oneline

should do (and obviously, without really testing it, I guess I had one
version of the alias allowing each senario, and none allowing all of
them).

I now have this, which is really ugly in a config file, but does the
DWIMery I want:

	new = "!f () { if echo \"$1\" | grep -q -e '^-' -e '^$'; then r=; else r=$1; shift; fi; git log $r@{1}..$r@{0} \"$@\"; } && f"

(this one has even been vaguely tested ;-) )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
