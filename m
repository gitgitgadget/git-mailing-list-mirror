From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Sat, 14 Jul 2007 12:14:04 +0200
Message-ID: <vpqy7hjl2c3.fsf@bauges.imag.fr>
References: <vpq8x9k9peu.fsf@bauges.imag.fr>
	<11843484982037-git-send-email-Matthieu.Moy@imag.fr>
	<7vfy3rlbnp.fsf@assigned-by-dhcp.cox.net>
	<7vy7hjjw01.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 12:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9edv-0002eF-G4
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbXGNKOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXGNKOY
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:14:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:61167 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbXGNKOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:14:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6EAE4sa017063
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 14 Jul 2007 12:14:04 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I9edY-0007a7-Bg; Sat, 14 Jul 2007 12:14:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I9edY-0006f1-95; Sat, 14 Jul 2007 12:14:04 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vy7hjjw01.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 14 Jul 2007 00\:16\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 14 Jul 2007 12:14:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52460>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Although I would not be using it often myself, I think this
>> would make "git rm" more pleasant to use.
>>
>> Thanks for the patch, and my thanks also go to people who
>> commented on the patch.
>
> Having said that, I think this comment is not quite right.
>
> +		else if (!index_only) {
> +			/* It's not dangerous to git-rm --cached a
> +			 * file if the index matches the file or the
> +			 * HEAD, since it means the deleted content is
> +			 * still available somewhere.
> +			 */
>
> Personally I do not think "rm --cached" needs any such "safety",
> even though I'll keep the check for now, primarily because
> loosening the restriction later is always easier than adding new
> restriction.  I really do not think this is about protecting the
> user from "deleted content is not available anywhere else".

I agree that this is something you can argue about.

But in this case, the behavior without -f should be changed too. If
the file matches HEAD, then "git-rm file" should work, regardless of
the index then (but this situation is less frequent).

In any case, the situation where you might lose content in the index
by doing git-rm are rare: it means you started working on a file, did
"git-add" at least once, and edited the file again later, and then
decided you wanted to remove the file. So, requiring the -f flag in
those situation is not a real problem, even if the situation is
slightly-dangerous-but-not-quite-so.

I'm willing to work on another patch on top of this one if there's an
agreement on a better semantics. This one was about fixing something
which was IMHO wrong, but doesn't necessarily achieve perfection ;-).

-- 
Matthieu
