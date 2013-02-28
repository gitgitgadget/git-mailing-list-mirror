From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix
 overlap
Date: Thu, 28 Feb 2013 14:29:38 -0800
Message-ID: <7vip5cgjhp.fsf@alter.siamese.dyndns.org>
References: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
 <1362088540-14564-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:30:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBzc-00050W-JC
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 23:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab3B1W3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 17:29:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab3B1W3l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 17:29:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9C70B385;
	Thu, 28 Feb 2013 17:29:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gVCFcpPNmXFq/G6nAQF18fE6EDo=; b=w8t8F8
	1sQbYzb8Sm9572FUjtOMAr7EYrVlL2XKjLVO12iFlcGdGGZlL3w0KF+ml6DDY8sD
	hNrUROW50+EJNXFqSBk69A7l8dx6qpleWY8lWCAd3uSlTpDxn282C0fEY5fbUMVK
	XXGW1prUz7y3suESjMEUPN10jgVWfrXhc7v0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvmsZT895Rh+XXDBl8fcfcpsvKL1v6JB
	pO0BLpodmtRfeIi30I0PG6IP9S2BLXKrk3mL4VCLtuHFHza4/o4/CBr9Wsq5RANy
	DXhdOMq/yyOsOqLDVOb3p0m6jP2ChyTKJqIq9wDYRzU+cdhUYdD3SFW0ldRfVvwX
	XCXbpkWsz3Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD06B384;
	Thu, 28 Feb 2013 17:29:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F11EB383; Thu, 28 Feb 2013
 17:29:40 -0500 (EST)
In-Reply-To: <1362088540-14564-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Thu, 28 Feb 2013 22:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 575A36F2-81F6-11E2-B79B-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217263>

Antoine Pelisse <apelisse@gmail.com> writes:

> When considering a rename for two files that have a suffix and a prefix
> that can overlap, a confusing line is shown. As an example, renaming
> "a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c", instead of "a/b/{b => }/c"
>
> Currently, what we do is calculate the common prefix ("a/b/"), and the
> common suffix ("/b/c"), but the same "/b/" is actually counted both in
> prefix and suffix. Then when calculating the size of the non-common part,
> we end-up with a negative value which is reset to 0, thus the "{ => }".
>
> Do not allow the common suffix to overlap the common prefix and stop
> when reaching a "/" that would be in both.
>
> Also add some test file to place corner-cases we could met (and this one)
> with rename pretty print.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

Hmm, haven't we already applied this with a fix from Thomas Rast and
queued the result to 'next'?
