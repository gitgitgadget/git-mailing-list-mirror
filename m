From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Replace memcpy with hashcpy when dealing hash copy globally
Date: Thu, 06 Mar 2014 11:32:47 -0800
Message-ID: <xmqqpplzxgv4.fsf@gitster.dls.corp.google.com>
References: <1394097084-3129-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:33:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLe2K-0002EF-TT
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbaCFTcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:32:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaCFTcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:32:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDF071E93;
	Thu,  6 Mar 2014 14:32:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tLPd98ciHt4tb3Nv0Rutk5b4W5s=; b=tsQaGP
	BsNZJ4Slxi4bQ5JtU4n6P5cvZLlJYA+84BjrCo4fQdtyXH4zweMeaIvKnnjxeJN8
	b9B/UFlTELyADA0p2IP1T7/xwJbAHZTXxfrkOzCVIb+fSW/kD8U92PkdOdl+x/V2
	JTFTXR2erNj3COsL55XM0Z1VvG1V1YndF3MeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vCnTL80X1JM8bvbr1DRjZRs+1EF3mxAU
	AnocgAeOK3fAPHx23TGjHRbO6efuUJgHpOI/1GVs6HeLEClpxCeBNzHtcQITLwIu
	6IA59wwrvHUFgoW/WNk4d9gz3BfAEWsUR4xcxXJ//HmNBtl/R/CpVx67ZeqCsRRp
	R03LGxn1vX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D2671E92;
	Thu,  6 Mar 2014 14:32:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 577A971E91;
	Thu,  6 Mar 2014 14:32:50 -0500 (EST)
In-Reply-To: <1394097084-3129-1-git-send-email-sunheehnus@gmail.com> (Sun He's
	message of "Thu, 6 Mar 2014 17:11:24 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AA78478-A566-11E3-A647-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243538>

Sun He <sunheehnus@gmail.com> writes:

> hashcpy() can keep the abstraction of "object name" behind it.

Do we really want to change the phrasing you took the above from to
say "*can* keep"?

Providing the "object name" abstraction is the whole point of the
function, so of course it can keep it, but that goes without
saying---it was the sole reason why it was invented in the first
place.

> Use it instead of memcpy() with hard-coded 20-byte length when
> moving object names between pieces of memory.
> We can benefit from it, when we switch to another hash algorithm,
> eg. MD5, by just fixing the hashcpy().

"fix" can be used in two scenarios, I think.  Something is broken
and you fix it, or something keeps changing and you force it not to
change.  I do not think either applies to hashcpy().  Perhaps
"updating", if we really wanted to say it, but because this change
is not about preparing us to any planned switch of hash function,
I'd suggest dropping those two lines starting from "We can benefit
from...".

> Leave ppc/sha1.c as it is, because the function is about the
> SHA-1 hash algorithm whose output is and will always be 20-byte.

Correct.
