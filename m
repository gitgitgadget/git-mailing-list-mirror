From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 04 Apr 2013 13:31:43 -0700
Message-ID: <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqpU-0005Pi-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764823Ab3DDUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764798Ab3DDUbq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:31:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0A9A13B8B;
	Thu,  4 Apr 2013 20:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DzERPvWorkw41OZOBA0xezUiDCY=; b=slBp5J
	w71JUjmLRk7mi3C5QfIMFeiHHMO5B2ABK6hy+ljJ4Ksdp/Hmm05sa+cjVMHIV8M+
	5CKvE3qCZjM8gxTuQ/9Q28sqUGR3wjEfG9oPI1D72PpZh7pnbcxoD7FfB/SD+rnB
	f2vFn0GHTSE+eaKE1xiiEliU3w7rP7rCwct4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kr9XTnSSpcPytBoL6llJAko1qBWL2Q+3
	UK8rZw+BkDg80FgJS4UgAlWUodq+QSwYpzcMk3/4MkOwP+lCJS0MVRK5YD8LgzUq
	sOBlh9zqGF8skvEnjiHPccApu+6EytxNe4p9CXabB81dGbgPgwmkMx/cFocG3Ido
	X/yw8Y+brsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B508813B8A;
	Thu,  4 Apr 2013 20:31:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2482D13B88; Thu,  4 Apr
 2013 20:31:45 +0000 (UTC)
In-Reply-To: <20130404195554.GA20823@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 15:55:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAC1F25E-9D66-11E2-AB4C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220092>

Jeff King <peff@peff.net> writes:

>> If you do this:
>> 
>> 	rm -fr d e
>>         mkdir e
>>         >e/f
>>         ln -s e d
>>         git add d/f
>> 
>> we do complain that d/f is beyond a symlink (meaning that all you
>> can add is the symlink d that may happen to point at something).
>
> Right, but that is because you are adding a bogus entry to the index; we
> cannot have both 'd' as a symlink and 'd/f' as a path in our git tree.
> But in the removal case, the index manipulation is perfectly reasonable.

I think you misread me.  I am not adding 'd' as a symlink at all.
IIRC, ancient versions of Git got this case wrong and added d/f to
the index, which we later fixed.

I have been hinting that we should do the same safety not to touch
(even compare the contents of) e/f, because the only reason we even
look at it is because it appears beyond a symbolic link 'd'.
