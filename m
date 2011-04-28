From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 7/7] Improve error handling when parsing dirstat
 parameters
Date: Fri, 29 Apr 2011 01:16:28 +0200
Message-ID: <201104290116.28647.johan@herland.net>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <7vhb9i43sl.fsf@alter.siamese.dyndns.org>
 <7vd3k641zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 01:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFaRs-0008TA-Th
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 01:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162Ab1D1XQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 19:16:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49383 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605Ab1D1XQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 19:16:34 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKD00I2XXZLTG00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 01:16:33 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 644241EA561D_DB9F551B	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 23:16:33 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4AF351EA391C_DB9F551F	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 23:16:33 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKD00M37XZG7W10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 01:16:33 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vd3k641zn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172418>

On Thursday 28 April 2011, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I am not sure if three combinations (vanilla, -M and -C -C) need to be
> > tested to produce an empty result.  If so, it would make it easier to
> > read if they are split into three tests, or at least have a blank line
> > between them, but I suspect that you would agree that it is not worth
> > to have three separate test_expect_success for these.
> 
> I think it makes sense to cull these three cases into one for the case we
> expect the command to stop without doing anything, but we would still
> want to validate the output for three variants in the "config" case.

Agreed.

> Also I forgot to say that the new "grep" invocations added to check the
> error output might have to be test_i18ngrep.  Please check with
> 
>     make GETTEXT_POISON=YesPlease test
> 
> The configuration variable names and typo in user input should appear
> somewhere in the output for any real locale, but I think gettext-poison
> would throw these away.

Hmm. Not exactly sure how this is supposed to work. I ran the above command 
(after a test merge with 'pu' to get GETTEXT_POISON in my working tree), and 
it succeeded. But then, I have not marked my added strings for translation 
with "_()". Should I? AFAICS no other strings in diff.c are marked for 
translation either...

> By the way, should the following two entries make any difference, and if
> so how?
> 
> 	[diff]
>           dirstat = unknown,0,lines
>           dirstat = 0,lines,unknown

No difference. The "rules" that apply in this case are:
- Tokens are separated by commas
- Unrecognized tokens are ignored

This is fundamentally what 7/7 tries to accomplish.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
