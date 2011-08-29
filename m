From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 13:56:35 -0700
Message-ID: <7vhb50543g.fsf@alter.siamese.dyndns.org>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu> <7vty92adv0.fsf@alter.siamese.dyndns.org>
 <20110829185011.GC756@sigill.intra.peff.net>
 <20110829190118.GE756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8st-0008UA-3L
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1H2U4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:56:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab1H2U4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:56:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662FD40D2;
	Mon, 29 Aug 2011 16:56:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rWC4tM7dIytVI5MkwpdkyFsr5AE=; b=AC/1Iy
	apPBorO8h8il6jyEHJKH2fx5Id92VZoEKuHMGBLvDxhq1Ss7+a8m6b7hPL/JmLSO
	rFRCDWssS+H2c3SwpWAt2RxTgfe3E/mzjHY0XrHLvQDmiUtRTQjbNaa7DRXkY7KA
	iHUyKAuXqRJLUIbKJuRnK19sKg1XPYzI/M9UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rv0KSFaduBTT4+3CCdQiCidZXxIAz/sF
	d5k9CPeKx4AHxYv84S4Mpon1VLeVlgFg3V7WKrDYHBGlc+b6GUlb+0EfUtCwtoY3
	HqP1pElMrAM5UWTkhAfPOQCHjVBOzqjemKzYYKhHCXDdU22tpoWEPNeTEBR6PmLp
	dRqXhd5eFIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CF5340D1;
	Mon, 29 Aug 2011 16:56:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21B540D0; Mon, 29 Aug 2011
 16:56:36 -0400 (EDT)
In-Reply-To: <20110829190118.GE756@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 29 Aug 2011 15:01:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62AF0D82-D281-11E0-BE71-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180350>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 29, 2011 at 02:50:12PM -0400, Jeff King wrote:
>
>>   3. Having better tool support for comparing two sets of commits. The
>>      ideal interface (to me) for this workflow would be something like:
>
> BTW, this discussion is obviously about comparing what was applied
> upstream with what was submitted, but I think such a tool could have
> other purposes, too. It should be able to provide a much nicer interdiff
> between two versions of the same series (e.g., for reviewers looking at
> a re-roll).

I agree with it in principle, but I am not going to write one any time
soon. I think the most difficult case is when the submitter based a fix on
'next' or 'pu' and I fixed it up so that it applies to 'maint'. It is not
trivial to express conflict resolution in such a case, as what your tool
has to do its work are (1) the original patch that may apply to
"somewhere" (the tool could ask "am -3" to help it out), and (2) the patch
that is queued somewhere in 'pu'.
