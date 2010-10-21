From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix color.pager = false with "git diff"
Date: Thu, 21 Oct 2010 15:53:36 -0700
Message-ID: <7vzku7rwcv.fsf@alter.siamese.dyndns.org>
References: <20101021150244.GA18426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9417-0003zu-Fu
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659Ab0JUWxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 18:53:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab0JUWxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 18:53:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF73AE0F80;
	Thu, 21 Oct 2010 18:53:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ytIOoHAYcRthIxnc1ok2niQaooM=; b=v1O04I
	XcyNa2sULeHblN+Ap215/6XJ1nvK5hJkBfJTnESFebL376Fqz4fBBMKLgzUHfCCb
	SoLqEeA1Pjun3Z9Nof73upAjhgmjKfpcDSfdM+ySdsnTh9zkClno/wfwdLNIETHi
	eIFPfOUFRp+nF0NoHR5vUzlCHKrv0TYjxf6Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqUcLPEMshfB5f2rKymYdW4HEglywCLA
	E6l7SzJ6R3qU+nuZj+TAiFT07/m3FzC1QfcbQvFYS65kQE6D9T32y3F6VElqJxPe
	mg9gpaZgTTjtQr2045kE650gu7/Bvr8sd0SMeWtGMeyonkHcvk2gaIlZvcEDtYU9
	Q2xdFXcnZss=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D346E0F7F;
	Thu, 21 Oct 2010 18:53:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2711E0F7E; Thu, 21 Oct
 2010 18:53:37 -0400 (EDT)
In-Reply-To: <20101021150244.GA18426@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 21 Oct 2010 11\:02\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C3396A0-DD66-11DF-9EDC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159584>

Jeff King <peff@peff.net> writes:

> The color code makes a decision early on about whether to
> use colors based on the config and whether we are using a
> pager. For the most part, this works, because if we are
> using a pager, we will start it more or less immediately.
>
> In the case of diff, however, we delay starting the pager in
> case --exit-code is being used. If this happens, then the
> color code makes the wrong decision (because it doesn't
> yet realize we are using a pager), and we need to correct
> the decision after deciding whether to use a pager.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Original discussion here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/89599
>
> I have mixed feelings on this one. It's kind of a hack. A more elegant
> solution would be totally rewriting the color code to check for the
> pager at first output.
>
> In favor of this patch:
>
>   1. It fixes a real bug.
>
>   2. Perfect is the enemy of the good, and I don't care enough about
>      this case to refactor the color code.

Hmm, with "[color] pager = false", what should

    $ git diff --color

do?
