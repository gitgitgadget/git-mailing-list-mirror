From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Thu, 05 Jun 2008 16:22:05 -0700
Message-ID: <7v4p87zcv6.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806052304300.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:23:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Ond-0003Gg-Eq
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbYFEXWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYFEXWY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:22:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYFEXWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:22:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E15023471;
	Thu,  5 Jun 2008 19:22:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2C446346E; Thu,  5 Jun 2008 19:22:17 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806052304300.21190@racer> (Johannes
 Schindelin's message of "Thu, 5 Jun 2008 23:39:48 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 403FBA62-3356-11DD-923D-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83999>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> And the robustness issue I worry about the second point also applies to 
>> a line that is "^-- $", especially if we were to make this available to 
>> git-am.  Perhaps when the line begins with a '-', the logic could be 
>> extra careful to detect the case where the line looks like the e-mail 
>> signature separator and check one line beyond it to see if it does not 
>> look anything like part of a diff (in which case you stop, without 
>> considering the line you are currently looking at, "^-- $", a deletion 
>> of "^- $", as part of the preimage context).
>
> Is this really an issue?  fixup_counts() is only called after a hunk 
> header was read, and that should be well after any "^-- $".

Are you talking about "^-- $" or "^---$"?  Yes we are way past the
three-dash separator at this point, but e-mail signature separator happens
at the very end after the patch.

You read a hunk header line "@@ -l,m +n,o @@", and start counting the diff
text because you do not trust m and o.  When you read the last hunk in a
patch e-mail, you may hit a e-mail signature separator, like what is given
by format-patch output at the end.  Mistaking that as an extra preimage
context to remove "^- $" is what I was worried about.

-- 
I worry, therefore I am...
