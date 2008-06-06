From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Fri, 06 Jun 2008 14:33:28 +0400
Message-ID: <87iqwmzwcn.fsf@osv.gnss.ru>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
	<4847CCD9.6000305@viscovery.net>
	<alpine.DEB.1.00.0806051403370.21190@racer>
	<4847EBC3.8060509@viscovery.net>
	<alpine.DEB.1.00.0806051441560.21190@racer>
	<4847F49F.8090004@viscovery.net>
	<alpine.DEB.1.00.0806051548140.21190@racer>
	<48480123.7030903@viscovery.net>
	<alpine.DEB.1.00.0806051719170.21190@racer>
	<alpine.DEB.1.00.0806051720070.21190@racer>
	<7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0806052304300.21190@racer>
	<7v4p87zcv6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 12:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ZVD-0007Sr-Et
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 12:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487AbYFFKrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 06:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbYFFKrp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 06:47:45 -0400
Received: from javad.com ([216.122.176.236]:2104 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756790AbYFFKrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 06:47:43 -0400
X-Greylist: delayed 818 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jun 2008 06:47:43 EDT
Received: from osv ([89.175.180.242])
	by javad.com (8.11.6/8.11.0) with ESMTP id m56AXYW89358;
	Fri, 6 Jun 2008 10:33:35 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1K4ZGC-0008Pn-SO; Fri, 06 Jun 2008 14:33:28 +0400
In-Reply-To: <7v4p87zcv6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 05 Jun 2008 16\:22\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84046>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> And the robustness issue I worry about the second point also applies to 
>>> a line that is "^-- $", especially if we were to make this available to 
>>> git-am.  Perhaps when the line begins with a '-', the logic could be 
>>> extra careful to detect the case where the line looks like the e-mail 
>>> signature separator and check one line beyond it to see if it does not 
>>> look anything like part of a diff (in which case you stop, without 
>>> considering the line you are currently looking at, "^-- $", a deletion 
>>> of "^- $", as part of the preimage context).
>>
>> Is this really an issue?  fixup_counts() is only called after a hunk 
>> header was read, and that should be well after any "^-- $".
>
> Are you talking about "^-- $" or "^---$"?  Yes we are way past the
> three-dash separator at this point, but e-mail signature separator happens
> at the very end after the patch.
>
> You read a hunk header line "@@ -l,m +n,o @@", and start counting the diff
> text because you do not trust m and o.  When you read the last hunk in a
> patch e-mail, you may hit a e-mail signature separator, like what is given
> by format-patch output at the end.  Mistaking that as an extra preimage
> context to remove "^- $" is what I was worried about.

Don't you think it's time to fix git-format-patch to put some reliable
"end-of-patch" marker line before the signature? This change (along with
refusal to generate brain-damaged empty lines inside hunks) will make
git diffs easily parseable without information from hunk headers.

-- Sergei.
