From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 15:08:46 -0700
Message-ID: <7vvcjp6vbl.fsf@alter.siamese.dyndns.org>
References: <4FB9F92D.8000305@alum.mit.edu>
 <201205211215.14455.mfick@codeaurora.org>
 <20120521194114.GA28358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 00:09:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWami-0003G7-5z
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759379Ab2EUWIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:08:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab2EUWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:08:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFC28C89;
	Mon, 21 May 2012 18:08:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JQIL1+ffGyOy0AEM2V8s7VMsu6Q=; b=fKOkeR
	eCvS3OqNyzEVltwz+A7RgBaB+czW02dJmQcu5aOco8Rwl1JoWgKl3yjmTOtlMud2
	ejwiPQg90gAmpZthBoz710bXTfLJwCbf8tXxCfp6/j2pMUYoTiXyOqCfutaiFnxF
	Zh9ZN4gyBMNoCv/MaTKGtx+9MCJ/6isAXs0Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOcNE47eF9gUZn0S4jzWMUGunkcbg2Pw
	htRaSvep8DUJNXU4ninUEXfF5BA8DBeDBo40LJ46fCYvecPXPhlNShlk+klSykPn
	C4d0gqr4PueYOh3lgJL+CyitwC94vgA2JNbYOgIZcz6arzhgThunxt7RNPKMoGXf
	MmTw+zw0SBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 252E58C87;
	Mon, 21 May 2012 18:08:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B14A18C7A; Mon, 21 May 2012
 18:08:52 -0400 (EDT)
In-Reply-To: <20120521194114.GA28358@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 May 2012 15:41:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CE77922-A391-11E1-850C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198131>

Jeff King <peff@peff.net> writes:

> Anyway, my point is that we don't even have to talk about "reasonable"
> or "absurd".  Git should be fast even on absurd cases,...

I agree with you 98%.

If we can make Git fast even on "absurd" cases without penalizing less
extreme and boring cases and/or maintainability of the code, we should
strive to do so.  And I think the codepaths mentioned in this thread falls
into that category.

The remaining 2% is only to allow me to say that we reserve the right to
label cases "absurd" when it is extremely painful to support without
penalizing the code and performance of less extreme and boring cases ;-)
