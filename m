From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 20:02:06 +0200
Message-ID: <vpqr4tl4ti9.fsf@bauges.imag.fr>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	<20120610115619.GA6453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se8wY-0007Rf-8W
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab2FKSCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 14:02:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52471 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab2FKSCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:02:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BHr29x021212
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 19:53:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Se8wJ-0002cE-Ii; Mon, 11 Jun 2012 20:02:07 +0200
In-Reply-To: <20120610115619.GA6453@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 10 Jun 2012 07:56:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 19:53:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BHr29x021212
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340041985.89798@dz7Vra1O74y3SJyJjyyJEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199686>

Jeff King <peff@peff.net> writes:

> It's nice to have an example like this, but there's much detail missing
> in how the format is specified. However, this format is already
> documented in the "helpers" section of api-credentials.txt, so it
> probably makes sense to refer to that document.

I'd do it the other way around. api-credentials.txt is in technical/,
while the document we're writing will end-up in a man page, which cannot
link to technical/.

So, it makes more sense to move the format specification to
git-credential.txt, and link to it from api-credentials.txt (now that we
have a nice way to link to manpages from technical/ ;-) ).

> I assume this got copied by looking at test-credential. I'd be OK with
> including this feature in git-credential (and converting our test
> scripts to use it, so we can drop test-credential entirely). But
> probably it should not soak up all of the command-line arguments, and
> instead should be a hidden option like:
>
>   git credential --helper=cache fill
>
> That will give us more flexibility later down the road.

Actually, this should already be possible with

  git -c credential.helper=cache credential fill

I suspect that this feature will never be used outside tests, and if so,
I don't think it deserves a command-line option.

> I am tempted to suggest that this actually output the _whole_
> credential, not just the username and password. Coupled with the above
> behavior, you would get:
>
>   $ git credential fill https://example.com/foo.git
>   protocol=https
>   host=example.com
>   path=foo.git
>   username=bob
>   password=secr3t
>
> which happens to be exactly what you want to feed back to the "approve"
> and "reject" actions (and it is not really any harder to parse).

I like that, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
