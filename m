From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] t6111: new TREESAME test set
Date: Tue, 07 May 2013 09:28:14 -0700
Message-ID: <7vwqrakb4x.fsf@alter.siamese.dyndns.org>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
	<1367767977-14513-4-git-send-email-kevin@bracey.fi>
	<7v1u9jrgl4.fsf@alter.siamese.dyndns.org> <51891B9C.5040608@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue May 07 18:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZkkb-0006DJ-E5
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 18:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759101Ab3EGQ2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 12:28:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759089Ab3EGQ2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 12:28:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD0B1A00F;
	Tue,  7 May 2013 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JCG6MiZkCcb9WRbrmUAib83K1vc=; b=RXsY3B
	P8/dMNYJhP3tOTe2udsqDgm+/GR1TydKgxl1tM/Z0hdxI2eAarulRciHSZz9ByJq
	9KMkvV25Zhx7UDPY5C4rSg7frgDTMfwSv148Lr/FkoCrgrXXDflQ0Y87XfIcUiAW
	DecV+NFWlWlUWttq+4tUFFfVWrEc02wmjENCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OtrIgtftwcw/pHpoGcHx3AJKmTRCEFlL
	XBfGOgy2vhRIenFue1GasVplJMGfQYffNi94IX7kFf/FUy5G45YkY7ZTfjPJ7c/t
	maJIZPXggGSEE8mob76NXaXKF6yKkKBjmghzFM6xWPmehNnS6XVitdNBH5SLbOA6
	UA0YSmYL/qA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23EF01A00E;
	Tue,  7 May 2013 16:28:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A3781A00C;
	Tue,  7 May 2013 16:28:16 +0000 (UTC)
In-Reply-To: <51891B9C.5040608@bracey.fi> (Kevin Bracey's message of "Tue, 07
	May 2013 18:19:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EEA9F6A-B733-11E2-ABE8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223586>

Kevin Bracey <kevin@bracey.fi> writes:

> On 06/05/2013 23:36, Junio C Hamano wrote:
>> Kevin Bracey <kevin@bracey.fi> writes:
>>
>>> +#        ,---E--.   *H----------.             * marks !TREESAME parent paths
>>> +#       /        \ /             \*
>>> +# *A--*B---D--*F-*G---------K-*L-*M
>>> +#   \     /*       \       /
>>> +#    `-C-'          `-*I-*J
>>> +#
>>> +# A creates "file", B and F change it.
>>> +# Odd merge G takes the old version from B.
>>> +# I changes it, but J reverts it.
>>> +# H and L both change it, and M merges those changes.
>>> + ...
> ...
>>> +check_outcome failure 'M L H' G..M -- file # includes J I
>>> +check_outcome failure 'M L H' G..M --parents -- file # includes J I
>> I am not sure if it should be a failure or your expectation is wrong.
>> G is outside the graph, so as far as the remainder of the graph is concerned,
>> J is the sole remaining parent of K and I and J did change the path in question.
>>
>> What makes you think I and J should be excluded in these cases?
>
> Because it's the simplest answer to the question "what happened in
> M since G", which is what "G..M" is supposed to mean. ...
> 
> This all comes about because the formal graph definition doesn't
> match the user interface. The question "B..C" currently generates
> a graph of all commits in C since B, and the connections between
> those commits. It turns out to be problematic that the graph
> doesn't include the connection to B itself. It would be fine if
> only worrying about nodes in the graph. But it's not fine when you
> start doing graph operations that care about edge connections to
> parents.

OK, that makes sense.

> ...
> What I'm effectively doing is extending the graph to actually
> include the unshown bottom. I think it just makes more sense.

Yup, and this is a good summary.


> ... I assume you mean:
>
>> That is, "-a-p F..M" makes F the sole remaining parent of G and G does change the
>> path from F so it should be shown, while "-a-p E..M" makes E the sole parent of G,
>> and G does not change the path from E, so it should not be shown.

Yes.

> Which is the way the logic works - we treat F and E as
> interesting/priority parents when they're specified as a bottom in
> each case. Without doing that, G would have 2 differing and
> equally (un)important parents in each case, and thus would be
> shown in both cases.
>
> In this case, the same logic says that G is treated as an
> interesting parent of K because it is the specified bottom. Which
> then enables the default following to follow that path direct to
> G, rather than having to go down the IJ path (which leads to G
> anyway).

OK.
