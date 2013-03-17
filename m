From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix unparsed object access in upload-pack
Date: Sat, 16 Mar 2013 22:16:40 -0700
Message-ID: <7v7gl6txl3.fsf@alter.siamese.dyndns.org>
References: <20130316102428.GA29358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH5y2-000549-FN
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab3CQFQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 01:16:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3CQFQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 01:16:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82DFA8C3B;
	Sun, 17 Mar 2013 01:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xAOqznAIxYD8LKvI9DXDGpuLfq0=; b=Wf1MnW
	y2AlxWVgnfLNLBqxayN32vVZj53lwZcdEYFxWQ8yfvPSCoZ4y/cBq6xI3u29AVkc
	nt95AYCxSdUy1437slAWDYz3E0bm1pfQSrlisoHzU8+On4dwuGucImcYUoDyGLJD
	lo0Baz5onEmYxtV9JYDNDLVhrRGRyPo9jJ9bA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUxMcmSeT4q9/K/azd5m3hoYsRVM92Jj
	j8b19gLGCO2z9zvZ090z9x8L9i1pnNPK+ZFDeUSxoHIABzAv+OJOIZl6+rX6toqs
	u1iGS0y0x13g7PRLa+5NislJI/KBWms2IH1dM7fikWkVYJAzFOC6FGFEkdRT3cGy
	DfgfKj59Y6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77D668C3A;
	Sun, 17 Mar 2013 01:16:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3CDA8C39; Sun, 17 Mar 2013
 01:16:41 -0400 (EDT)
In-Reply-To: <20130316102428.GA29358@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 16 Mar 2013 06:24:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA6A322C-8EC1-11E2-BAE2-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218329>

Jeff King <peff@peff.net> writes:

> This series fixes the issue I mentioned recently with upload-pack, where
> we might feed unparsed objects to the revision parser. The bug is in
> 435c833 (the tip of the jk/peel-ref topic), which is in v1.8.1 and up.

Good to see follow-up from a responsible contributor ;-)

> ... (I had several bug reports
> within a few hours of deploying v1.8.1.5 on github.com)

Nice to have a pro at the widely used site ;-)  I often wish it had
a mechanism to deploy the tip of 'master' or 'maint', or even 'next'
for 0.2% of its users' repositories to give us an early feedback.

>   [3/3]: upload-pack: load non-tip "want" objects from disk
>
>     While investigating the bug, I found some weirdness around the
>     stateless-rpc check_non_tip code. As far as I can tell, that code
>     never actually gets triggered. It's not too surprising that we
>     wouldn't have noticed, because it is about falling back due to a
>     race condition. But please sanity check my explanation and patch.

Thanks. That fall-back is Shawn's doing and I suspect that nobody is
exercising the codepath (he isn't).
