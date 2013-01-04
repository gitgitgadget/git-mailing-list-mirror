From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lockless Refs?
Date: Fri, 04 Jan 2013 13:28:32 -0800
Message-ID: <7vip7ctz7j.fsf@alter.siamese.dyndns.org>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <201212271611.52203.mfick@codeaurora.org>
 <201212310330.53835.mfick@codeaurora.org>
 <201301031652.44982.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:28:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrEox-0000tb-CI
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab3ADV2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:28:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab3ADV2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:28:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F45AB5CB;
	Fri,  4 Jan 2013 16:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fzrM4QqBYMkQ1hkaozqEWNt4b4=; b=DQarHr
	KXOqLx0HN9HNb0xIiYCt1TPcLvPTKFC6K93LMMuMn4xNFs99yfjhgbcrwILmt+TB
	HzVekBJVjRPy8GNoDN7HcFu4DBWKakduucZhvYiYy2XPw13ZsSZ19dxEeZ25Xb+m
	Yx/AuKbM/Tk1Gu+dt9Y84L7yatuLpTNiGVaEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vy99LeVSnaGXt7lwerdqnUxNZZF1hYL8
	sPj7uEor/w9Zz+JIDDl9In0+0PAVEpnrWMmltaQsr7ALXAhPourhAqSwmFr4VjHp
	ykcpeytl7otp/KGU6NV9fMqR1R7YKlSWE5UVu0Vo5CWhKUyc4SIz+LuIebkjF1Ro
	KR5T5MfVLsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F6F1B5CA;
	Fri,  4 Jan 2013 16:28:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EC3CB5C9; Fri,  4 Jan 2013
 16:28:33 -0500 (EST)
In-Reply-To: <201301031652.44982.mfick@codeaurora.org> (Martin Fick's message
 of "Thu, 3 Jan 2013 16:52:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1201B96-56B5-11E2-B28F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212644>

Martin Fick <mfick@codeaurora.org> writes:

> Any thoughts on this idea?  Is it flawed?  I am trying to 
> write it up in a more formal generalized manner and was 
> hoping to get at least one "it seems sane" before I do.

The general impression I have been getting was that this isn't even
worth the effort and the resulting complexity of the code, given
Peff's observations earlier in the thread that ref update conflicts
and leftover locks are reasonably rare in practice.  But perhaps I
has been mis-reading the discussion.

I also have this suspicion that if you really want to shoot for
multi-repository transactions in an massively scaled repository
hosting environment, you would rather want to not rely on hacks
based on filesystem semantics, but instead want to RPC with a
dedicated "ref management service" that knows the transaction
semantics you want, but that could become a much larger change.

I dunno.
