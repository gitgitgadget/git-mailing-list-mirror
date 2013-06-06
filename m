From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Thu, 06 Jun 2013 12:40:38 -0700
Message-ID: <7vobbjxc21.fsf@alter.siamese.dyndns.org>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
	<CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukg3I-00068Q-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab3FFTks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 15:40:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab3FFTkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:40:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A592A2586D;
	Thu,  6 Jun 2013 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wPDOdy8FAzg01HEHBa39mpvq7ls=; b=RRZdJS
	iC5+jNuFrqaYQ3wJlIlaB7uiq1X96aMm0HDKR0h/FnrjSie+CuqZzr4vAr8fHnnV
	Rb23QU8VrFEUsppbXBWRIhJSOnwFJAG9HslicboYNADjSUUi6HYTH7ZqsGJ/Eqge
	QOosF5qDpP2ggxVvwtYrta4ElvIVxUNiH0KzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IqyAw+e3m6qw0X2CsruL3KMoGtMa2C9A
	VaM6wk5PjqLN/bRC9D5+HkIl84P/fyW/F9upSrNGqEvfzeVWTuSl76kavNMdGLsr
	FNRLSoqDZvdJRkzrByzFf2A7wHp0XHsIgdir85piF6maelPnpS5Mgs4o6Aws65sA
	Qwk2WFNO36U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB842586C;
	Thu,  6 Jun 2013 19:40:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DE4025866;
	Thu,  6 Jun 2013 19:40:46 +0000 (UTC)
In-Reply-To: <CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
	(Elliott Cable's message of "Thu, 6 Jun 2013 15:03:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB75B3F6-CEE0-11E2-B0EA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226552>

Elliott Cable <me@ell.io> writes:

>> And update revs->lifo to use that same enum, without adding
>> use_author_date bit to rev_info.
>
> I'll look into replacing lifo with an enum as soon as I can sit back
> down to update this patch. For the moment, nothing more than
> committer_date_sort and author_date_sort, I suppose?

> I'll try and make this a separate patch. First commit, to replace lifo
> with an enum; second commit, to *actually implement* the code obeying
> that enum when it is set to author_date_order.

If you want to do this in a multi-step series (which may not be a
bad idea), I would imagine that the enum starts as a choice between
the two: traversal-order vs committer-date-order.  The first patch
would change nothing else.

And then you would add the third choice, author-date-order, and
implement the logic to sort them using author instead of committer
date in the same patch.

>> Elliott: you can see the relevant changes to the topo-sort in commit
>> 96c4f4a (commit: allow associating auxiliary info on-demand,
>> 2013-04-09).
>>
>> -Peff
>
> Again, might be a little over my head. If you really think it's best
> that I look into that branch, I will try. :)
>
> Meantime, is there any other, more-immediate approach you can think
> of? I thought, for a moment, of only storing *either* the committer
> *or* the author date in the commit-struct at a given time, and
> flagging with a single bit ... but I'm not sure how widely-spread the
> nead for committer-date currently is. Maybe I can go back and
> parse-out the author date *when I need it*, instead, though that
> sounds slow …

You would parse all of them at the beginning of topo-sort function
once and store these dates in the commit-info-slab (alongside with
indegree).  Once you are done sorting, you can discard the slab.

This could be done as a follow-up patch, but the tons of helper
functions you added to compare by author date to revision.c will
have to be removed in such a transition, because the whole point of
using commit-info-slab is not to have commit->author_date field,
which these new helpers work on.
