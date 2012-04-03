From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -p loses amended changes
Date: Tue, 03 Apr 2012 15:02:04 -0700
Message-ID: <7vwr5wbhk3.fsf@alter.siamese.dyndns.org>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch>
 <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
 <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
 <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBnp-0000rX-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab2DCWCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:02:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab2DCWCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:02:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89DB17521;
	Tue,  3 Apr 2012 18:02:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J7oUzJGlUuGC3x9r+Ad8byRSpLc=; b=IepOkB
	xB9/AcCKI/vqfgEsoIjSZPVs5PA9PxY2SxiULV93DCCDiS9Sfr8VGn4WWq8WQebx
	1eSWQohQqKDDptEnyF1Ilj4sKylHRW6vG5T9niTwvHM200+TAovmFTWlI+CE1nt8
	D7LNJtCPRaJrq2tyU1t/Jfshkh6gZw+b2CM8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qIcKZ1P5e+oqE4qdDSF/vyN7LL2vgILN
	hZT4US/0aOOfBlqYClP1g1fvW90mzEO4BhgtdJ6SJGFBvjUARsqqaCiu1Y/v/4BN
	r8sK3SC0hVpfq04N+g5Dhh+7hFGb7Vysn+GJk+LyHLpcez/XM0B3hSEqEcDRVYu6
	5RyySHP8Ln0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8128A7520;
	Tue,  3 Apr 2012 18:02:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1122A751F; Tue,  3 Apr 2012
 18:02:05 -0400 (EDT)
In-Reply-To: <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com> (Jon
 Seymour's message of "Wed, 4 Apr 2012 07:43:29 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6B08576-7DD8-11E1-A602-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194654>

Jon Seymour <jon.seymour@gmail.com> writes:

> It'd be quite expensive to attempt to detect cases where this might be
> a problem, but let's articulate, as a thought experiment, what such a
> solution might look like - I am not suggesting that it is a good idea,
> but the thought experiment might be illustrative.
>
> Suppose you have a merge of a A and B that produces M, which is then
> amended as M'.
>
> During rebase, you redo the merge A and B. If there are no conflicts,
> then compare M with M' to produce D. You now have enough information
> to reproduce the amended commit M' during a rebase (merge Ar and,Br
> then apply D).

Not necessarily.  You realized yourself a half of it.

> What isn't clear to me, in this thought experiment, is how you might
> attempt to solve the case where there were syntactic (as opposed to
> semantic) conflicts between the merge of A and B originally. You have
> no idea, at that point, how the user originally resolved the conflicts
> to produce M, thus no idea how to calculate D or even if there was a
> non-trivial D.

True.  The other half of the issue is that the merge heuristics may have
improved between the version of Git used to originally create M and the
version of Git used when you are attempting the rebase.  The original one
may have given a clean but incorrect merge, and your trial merge during a
rebase may have given a clean and correct merge.  The patch D may be the
right fix-up to apply to M, but it may not be if applied to M'.

In short, it is not "quite expensive", but is fundamentally impossible.
