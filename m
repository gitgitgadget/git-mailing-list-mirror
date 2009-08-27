From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Wed, 26 Aug 2009 22:46:35 -0700
Message-ID: <7vprahyfk4.fsf@alter.siamese.dyndns.org>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
 <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <7veiqzjmy7.fsf@alter.siamese.dyndns.org> <20090826050224.GK3526@vidovic> <h72td7$cu6$1@ger.gmane.org> <alpine.DEB.1.00.0908261059530.4713@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 07:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgXoy-0005xp-Q4
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 07:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbZH0Fqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 01:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbZH0Fqn
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 01:46:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZH0Fqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 01:46:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A01C1A6C4;
	Thu, 27 Aug 2009 01:46:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k7swT8E51l7P/DPh5apt1Ujxr48=; b=HsDwpC
	c4Xubm2hQSQ7kKAJeX23qGoCwF6M/AAPySogSA2SDTmDJxNfapsk+dI5+qIGWmcB
	/XN6Br7l8+1NJOtFvdN9Qmr+qW0EdgKkW4Dx4kIVkSzz2m/Y5fOwUVFnBn4NJBoE
	ouIaaHWBRFgwv4hLYuKvHhrNB4cqtXKFUsxf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XFCR5a8iDhRE5ycjtb7e27m3tUpRRCDw
	SPk6WemJueD7p3QWEuIY9A1yUiZl1wRUV+pSzjdLLlfccxt5MNtFwWt/rYf70wrL
	4SVnwoV9dgJuZ3AYjS4TKzl6A5/96hLB3F0b6H1fBNt8eJb0QUGynLl6g/UldhYY
	5aHxmiG0Xxo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 191081A6C2;
	Thu, 27 Aug 2009 01:46:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F9B81A6C1; Thu, 27 Aug
 2009 01:46:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908261059530.4713@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed\, 26 Aug 2009 11\:00\:52 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEA24796-92CC-11DE-A2FD-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127142>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> mailsplit.scissors
>
> Sorry, did not have time to read this thread properly, but has anybody put 
> thought into the interaction between this patch and "git rebase" (which 
> uses "git am", and therefore mailsplit, internally)?

I was looking around this area tonight (I promised I won't touch the
definition of scissors, but I never said I won't work on making it
usable), as I originally shared the same worry with you.

It turns out that "rebase" invokes "am" with the "--rebasing" option.
Under this option, "am" uses an equivalent of "commit -C $commit"
internally to port the message forward.  So our worries are unfounded.
