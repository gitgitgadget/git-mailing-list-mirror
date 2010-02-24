From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 11:26:10 -0800
Message-ID: <7vljeio2p9.fsf@alter.siamese.dyndns.org>
References: <20100224.082728.16634.0@webmail17.dca.untd.com>
 <20100224170853.GA4756@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "ddrowley3\@juno.com" <ddrowley3@juno.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:26:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMsO-0008CB-3w
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699Ab0BXT0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:26:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757683Ab0BXT0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:26:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD7609C1F8;
	Wed, 24 Feb 2010 14:26:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HFqqrgwPS67q5x1lgTXrMzFs00=; b=G6Cl8B
	7jY7akhrVDFlVsNrOWqUrvL21DdekVmcIMdGcrE4AD2AvBF0TP6xrmHds8bE8aXX
	7Jjt5Jzidxy6+9FiEABjxFpQZECRktZgz39ETgeDwLrxVfTI84yBKDZKHTd5Y3Al
	6+SQarl4U8yLqhwNm8qrtSolrWDyPcUMXuEv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JJkttyJ6dCZIg1rgocJa94eVVcR3/3Sc
	dru+yxo/sN5+qjh7GdIeD95AE1TiJnNUys4l5qch3OQDHiwVU2b0KnPQqZ7HpoVY
	yQoEaVtAGFHUiSHkS+r94FJzg/FR2eaemfXhO77/GQ57Q4pJmOHfYbfGefwOzvPX
	BVwXlREUJ7I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79A7E9C1F5;
	Wed, 24 Feb 2010 14:26:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A357F9C1F2; Wed, 24 Feb
 2010 14:26:11 -0500 (EST)
In-Reply-To: <20100224170853.GA4756@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 24 Feb 2010 12\:08\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A37C2F0-217A-11DF-8047-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140976>

Jeff King <peff@peff.net> writes:

> ... On
> the other hand, branch->merge_name _does_ have one element, so perhaps
> it is an error in the caller to assume that branch->merge_nr and
> branch->merge necessarily correspond.

I think this is a sensible thing to do.   branch_has_merge_config() could
be used here but I do not see a point, as the code already knows branch is
non NULL and there are many other places that checks !!branch->merge
themselves.

It may be worth adding a helper function that a caller can lazily sanity
check the set of configuration around a given branch, but that sanity
check will probably go way beyond what branch_has_merge_config() currently
does, so I would think that would be a separate patch after somebody
audits what current non-users of branch_has_merge_config() want.  For
example, builtin-branch.c not only makes sure branch->merge is non NULL
but also wants branch->merge[0] and branch->merge[0]->dst exists, and
encapsulating only the first two out of four checks it does by using
branch_has_merge_config() does not add much value to it..

Thanks.
