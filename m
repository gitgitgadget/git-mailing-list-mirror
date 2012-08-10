From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git am and the wrong chunk of ---
Date: Fri, 10 Aug 2012 07:46:02 -0700
Message-ID: <7vsjbuls9h.fsf@alter.siamese.dyndns.org>
References: <5024523F.3050208@zytor.com>
 <20120810103612.GA21562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 16:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzqTf-0006TI-0V
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 16:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650Ab2HJOqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 10:46:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758573Ab2HJOqI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 10:46:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8D5977A;
	Fri, 10 Aug 2012 10:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7tctq7xeKcwPWtovLz8K+dNeo8c=; b=XEGphl
	PCmOrHZNVT88NbIgmo0eIUJbNaTcrXPkIf7kHbdQ+g8AZx7dw+dYjq8jDNRdX4hQ
	Y2M6Lg5kAWYVFCBJsEh4zdpoc098kFqASfmlmYPXHSTSRAYzZ9USiw6fcBf5n/yg
	QiqQ0kUsm4PUG4PiKquiTAPON9C7WYnv8LQ4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M77oeBmWtXhW3TrNeD/7o1vAfrB/cT9t
	ipGCLWVwxp9CEK+SDapyO1Tosru7bvdB1s7/wtAGFd3wnPU9Y902CM7v8efruShV
	ijwQUugQCWbwM0bMZY8T/kb3ZwqFeqv8X38Ufk0ODdbz/6mGRNo4HC8jcdksvUtl
	+kiDeoE03HU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5BCA9779;
	Fri, 10 Aug 2012 10:46:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11FC79778; Fri, 10 Aug 2012
 10:46:03 -0400 (EDT)
In-Reply-To: <20120810103612.GA21562@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 06:36:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C35EE18-E2FA-11E1-A8A5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203219>

Jeff King <peff@peff.net> writes:

> If I understand your issue, somebody is writing:
>
>
>     From: them
>     To: you
>     Date: ...
>     Subject: [PATCH] subject line
>
>     commit message body
>     ....
>
>     some cover letter material that should go below the "---"
>     ---
>       [diffstat + diff]
>
> How do you know when the commit message body ends, and the cover letter
> begins? We already have two machine-readable formats for separating the
> two ("---" after the commit message, and "-- >8 --" scissors before). Is
> there some machine-readable hint? Is it always the paragraph before the
> "---"? Chopping that off unconditionally seems like a dangerous
> heuristic.

Or it could be like this:

    ...
    Subject: [PATCH] patch title

    Heya,

    I was walking my dog when I found a solution to this
    problem the other day.  Here it is.

    commit message body

    S-o-b: ...
    ---

And I agree that clever heuristics are dangerous.  We need to draw a
line somewhere anyway, and the line should be at the place that is
easily understandable to people.  That means mechanically parseable
and easy to follow convention to use markers e.g. "---".
