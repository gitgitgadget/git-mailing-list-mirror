From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: hint to use push.default=upstream when
 appropriate
Date: Mon, 19 Dec 2011 12:16:43 -0800
Message-ID: <7vfwggmi50.fsf@alter.siamese.dyndns.org>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
 <7vmxatofvr.fsf@alter.siamese.dyndns.org>
 <7vliq9nn0l.fsf@alter.siamese.dyndns.org>
 <7vbor5nmsq.fsf_-_@alter.siamese.dyndns.org>
 <20111219103746.GB1736@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 21:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcjdj-0002U2-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 21:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1LSUQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 15:16:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab1LSUQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 15:16:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2067FFB;
	Mon, 19 Dec 2011 15:16:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAyRS6dbHumg3eGN42t9Zh+9ZyA=; b=GJRMHD
	AJY5eK13az34/F4dyTbkb3WF6O22TzCwXQyJWkXq6W7fON0M5yP8UeFaoMW2tDc7
	mwiplTz9J3pk8z2B0zp3pFVh2QnoffIJGZlBKf+KfpR2iGxaMuIlIiZpJXa1Oj91
	eI93NU0CwxroK69FmYeNLDVDQ7L+YGfugfDMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OWpENiMWIIpFt0yXOPINfLUBmHtZFUOS
	GLHAuCvGqmBeEkARPSnyi8OyPUdzn36qPbStdXKXR9y2SpBZfJrvKwAFz4Wj2B+X
	mMl6UZrlUR842CypYcsr5Y9QxAXOyxCcILANK4OPcNPBbaFyqovnRTfejoBiqf7e
	2Sz/1WtGRB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D43627FFA;
	Mon, 19 Dec 2011 15:16:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D46E7FF8; Mon, 19 Dec 2011
 15:16:45 -0500 (EST)
In-Reply-To: <20111219103746.GB1736@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Dec 2011 05:37:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F705E50-2A7E-11E1-A493-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187468>

Jeff King <peff@peff.net> writes:

> It seems like the real problem is that they are on branch "foo", but the
> matching behavior tried to push "bar", which didn't work. And we are
> worried that they may be surprised that we even attempted to push "bar"
> at all.

Of we may be seeing a non-fast-forward on 'foo' itself, which is your
1. below.

> And that probably happened because of the situation you describe, but we
> (and the user) don't have to think about that. We can just think about
> the more immediate mistake of "oops, I didn't want to push 'bar'".
>
> Which leads me to two ideas:
>
>   1. This is not good advice to give when pushing the _current_ branch
>      failed due to non-ff. Setting push.default to "upstream" would
>      probably yield the same error. We should probably tighten the
>      condition for showing this message to when a non-HEAD branch failed
>      to fast-forward.
>
>   2. The text should focus on the (possible) local misconfiguration, not
>      the repo setup.

OK, I think we are in agreement.

> So maybe something like:
>
>   By default, git pushes all branches that have a matching counterpart
>   on the remote. In this case, some of your local branches were stale
>   with respect to their remote counterparts. If you did not intend to
>   push these branches, you may want to set the 'push.default'
>   configuration variable to 'upstream' to push only the current branch.
>
> I'm not 100% happy with that text, but I think you can see the direction
> I am talking about.

As long as we can tighten the condition further to ensure that the advice
above is triggered only when appropriate, I actually am 100% happy with
that text. Seeing others do the real work for me always makes me happy ;-)

In addition to "did we use default-matching?", we should use "did we get
non-fast-forward error on a branch that is _not_ the current one?" instead
of the "did we get any non-fast-forward error?" in my patch, and the text
should match the situation more-or-less exactly.

> ... If we follow my suggestion above and
> only print this message for non-HEAD refs, then these two messages
> become an either/or situation, I think. If the HEAD failed to
> fast-forward, then the right advice is probably "git pull && git push".
> If a non-HEAD failed, then the right advice is either "git checkout $X
> && git pull && git push" or "here's how to avoid accidentally pushing
> $X".
>
> So the logic would be something like:
>
>   if (nonfastforward == NONFASTFORWARD_HEAD)
>           advise_pull_before_push();
>   else if (nonfastforward == NONFASTFORWAD_OTHER) {
>           if (default_matching_used)
>                   advise_use_upstream();
>           else
>                   advise_checkout_pull_push();
>   }

Sounds good. Spelling things out at this detail would let others who may
be interested in getting their hands dirty try to come up with an updated
patch ;-).

Thanks.
