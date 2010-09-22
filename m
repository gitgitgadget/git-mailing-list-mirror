From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] diff: add a special SYMLINK user-diff driver
Date: Wed, 22 Sep 2010 18:59:24 +0200
Message-ID: <vpq62xxg1eb.fsf@bauges.imag.fr>
References: <20100921205914.GA1166@sigill.intra.peff.net>
	<20100921211303.GB1188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 19:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyT4D-0001fb-QO
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 19:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab0IVRZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 13:25:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:64177 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab0IVRZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 13:25:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8MGxQF7014650
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Sep 2010 18:59:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OySfF-0003iJ-4i; Wed, 22 Sep 2010 18:59:25 +0200
In-Reply-To: <20100921211303.GB1188@sigill.intra.peff.net> (Jeff King's message of "Tue\, 21 Sep 2010 17\:13\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 22 Sep 2010 18:59:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156810>

Jeff King <peff@peff.net> writes:

> Also, this special SYMLINK driver assumes you want to treat all symlinks
> the same. Which is probably good enough in practice. But if
> gitattributes were aware of file modes, it would be nice to be able to
> be able to apply multiple criteria (i.e., something besides just a
> pathname match) to matching files. And then you could do something like
> this in your gitattributes file:
>
>   # all symlinks match this
>   * is_symlink diff=symlink-diff-driver
>   # only a symlink that matches this filename will get this
>   some-particular-symlink is_symlink diff=other-symlink-diff-driver
>   # and here we can explicitly say that only regular files get this
>   # treatment
>   *.pdf is_regular diff=pdf
>   # and since that's what you want 99% of the time, we can imply
>   # is_regular, which is backwards compatible and syntactically nicer.
>   # So this is equivalent to the above
>   *.pdf diff=pdf
>
> which is more flexible, and neatly solves the "attributes shouldn't
> affect symlinks at all" issue.
>
> It does feel like overengineering, though.

After thinking a bit more, I don't feel this is so much
overengineering. Your initial SYMLINK driver proposal was somehow a
solution looking for a problem, and now we've found just one problem.
So I'd say the SYMLINK driver is overengineering for the potential
problem it solves: instead, people would probably prefer a
diff.showFinalNewlineForSymlink config option or so --- btw, wasn't
there a patch for that recently?

OTOH, if the SYMLINK driver is ever used for something other than the
"no newline at end of file", I'm pretty sure it will not be general
enough. So, to me, the SYMLINK driver is a rather bad compromise
between complexity and flexibility.

(but the counter-argument "that's a lot of work for very little
benefit" still holds...)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
