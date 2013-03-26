From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] clone: die on errors from unpack_trees
Date: Tue, 26 Mar 2013 14:40:57 -0700
Message-ID: <7vtxnxsuty.fsf@alter.siamese.dyndns.org>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202359.GH16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbcX-0003kX-D6
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab3CZVlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:41:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab3CZVlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F12AA40D;
	Tue, 26 Mar 2013 17:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AsDrDHwPjH2hHEfQMQVzNeVb2Mo=; b=BoJmnE
	rntos3v/rBiEY3+FrzXY+gTouxwOtAhfU0boiJNsEBsqyymPSP2MJZsdgzFgpvmh
	uCJb6hpjkfJyOmrBQsSirl33a0Q/5JeOEFURMq2HletbDedjvn81oyk8zZ9ba00K
	3XzrvqomcrLi8f2nnl8Wg0SzXKxymPlKNjTjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RB0h/8/QQwZXaYlDefJrTTkmHMtgcGhT
	D7472f6W1u3BHfFebqzVEkc3IVZLI9r6NYUiiwzE21EFCVxCTHHim/P/bNkLHGjM
	KWUHsrj+87miU6ah6kZ/oATV3mFuiYg7Kqx/XuWvQtUw7Oyt3CB939pEBz/KySnR
	3k0fvA4WWZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82F87A40B;
	Tue, 26 Mar 2013 17:40:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5E05A407; Tue, 26 Mar 2013
 17:40:58 -0400 (EDT)
In-Reply-To: <20130325202359.GH16019@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Mar 2013 16:23:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8E4272A-965D-11E2-BC64-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219215>

Jeff King <peff@peff.net> writes:

> When clone is populating the working tree, it ignores the
> return status from unpack_trees; this means we may report a
> successful clone, even when the checkout fails.
>
> When checkout fails, we may want to leave the $GIT_DIR in
> place, as it might be possible to recover the data through
> further use of "git checkout" (e.g., if the checkout failed
> due to a transient error, disk full, etc). However, we
> already die on a number of other checkout-related errors, so
> this patch follows that pattern.
>
> In addition to marking a now-passing test, we need to adjust
> t5710, which blindly assumed it could make bogus clones of
> very deep alternates hierarchies. By using "--bare", we can
> avoid it actually touching any objects.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.

> I think the "leave the data behind" fix may be to just set "junk_pid =
> 0" a little sooner in cmd_clone (i.e., before checkout()). Then we
> would still die, but at least leave the fetched objects intact.

Yeah, perhaps, but I agree that is a much lower priority change.
