From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] introduce credentials API
Date: Fri, 22 Jul 2011 14:42:09 -0700
Message-ID: <7vtyaevupu.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075034.GF12341@sigill.intra.peff.net>
 <7vy5zs4mxt.fsf@alter.siamese.dyndns.org>
 <20110722203901.GA11922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:03:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNp3-00043V-R7
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625Ab1GVWDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:03:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab1GVWDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:03:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A22F533F;
	Fri, 22 Jul 2011 18:03:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=PUntVGnYYOm++A3bD6g8b8Tha5Y=; b=emvw8O8jp94kAnXensBv
	5rMnFBd/2BBdDYSBKgCBYUIyJG+FIVQ1wIfJYoom0E71S06dtuCaVPH20kR98lpM
	FxxkrDvalZJhX2PXOdbojh5ryggBZM5tdjdJLQ/ZV1YHjI5rVLqr1EzwTrW7PZzG
	qyQVNW+sKfNbP/YDaxjErFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZLC1XTxplDcRFv1lRVsXmmSIR/6UIUWSGxT6YtbBXL9bXD
	Up//159fWwZ5gdubkHAaVXm120ThzFc8WOpDl1Tc9RQEbmuR1dG9EV81rhieUdgw
	zjoNEc/uvqbTgvLgNnkn3hmwNA2ZkZT/y+I9xncHimpJF7rpKdTkt+qZ/IR3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 824D5533E;
	Fri, 22 Jul 2011 18:03:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 009BC533D; Fri, 22 Jul 2011
 18:03:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76B6F560-B4AE-11E0-A6A5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177674>

Jeff King <peff@peff.net> writes:

>> > +`credential_reject`::
>> > +
>> > +	Inform the credential subsystem that the provided credentials
>> > +	have been rejected. This will clear the username and password
>> > +	fields in `struct credential`, as well as notify any helpers of
>> > +	the rejection (which may, for example, purge the invalid
>> > +	credentials from storage).
>> 
>> What hints do helpers get when this is called? Do they get username,
>> unique and description to allow them to selectively purge the bad ones
>> while keeping good ones, or the username is already cleared by the time
>> the helpers are notified and they have no clue?
>
> They get username, unique, and description, to let them purge the
> minimal amount (they are always free to ignore the username and purge
> more, of course, if they are backed by less-capable storage).
>
> We could also...

Ahh, that wasn't what I was getting at. I was only reacting to the order
of events described in "clear them, as well as notify" (as if these
cleared information is no longer available to be used to nitify) and
asking for clarification. As long as enough information is sent to the
helper to selectively purge stale/mistyped information so that it can ask
again, I am perfectly happy.
>> The document did not say anything about escaping/quoting of values, but it
>> may not be a bad idea to make it more explicit over there.
>
> There is no quoting or escaping. As the document says, "the value may
> contain any bytes except a newline". It doesn't mention that keys cannot
> contain an "=" or a newline, though that is also true.

This also was a documentation comment; "may contain any bytes" can be
followed with "and used as-is" and I wouldn't have been confused.

Thanks.
