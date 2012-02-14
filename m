From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --stat
Date: Tue, 14 Feb 2012 12:07:31 -0800
Message-ID: <7vfwed6uws.fsf@alter.siamese.dyndns.org>
References: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
 <20120214195036.GD12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOf5-0001S0-9d
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151Ab2BNUHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:07:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757060Ab2BNUHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:07:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DF58748C;
	Tue, 14 Feb 2012 15:07:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YpKqXWcAtfpyL6XKXhfWt3IWgkU=; b=cADSqG
	RhUdfmrau8vm//nDwTxAGuHow3kHnGvVrOuwLj8b/S85UT2EzPpkZRMAcqDqNBV0
	dTDp3FdCi94dQ3vk+PW8SbAW0K0LOsIWg7fkkkT10zeV1vnlJgvbbMcUKf0mv03g
	4t+Ecz7BrT278MgqwEk5tgqNGgMeQi6+kY0jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ph/4yKEZIQPkNSlW8r2i65TM4Txfj9AI
	eYKiPYF5iUsi53S7+QLkMtpM5kHHAQbn1bNgz8gVx3ROOCtB76CL3plebZC5XBor
	sJnhU78Zo6QmowAdgL/b39M/5ZbEJiY1PovO/mprqFrZ9cT75u4w4WMq/G3hnOAG
	4qAmllA5Lpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75647748B;
	Tue, 14 Feb 2012 15:07:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BAA67487; Tue, 14 Feb 2012
 15:07:32 -0500 (EST)
In-Reply-To: <20120214195036.GD12072@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Feb 2012 14:50:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87CEAC62-5747-11E1-9A24-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190744>

Jeff King <peff@peff.net> writes:

> Hmm. Looking at scale_linear, the formula is:
>
>    return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
>
> I don't see how that can be accurate, since the magnitude of the "-1"
> tweak will vary based on the value of "it". This code is due to
> 3ed74e6, but I don't quite follow the logic in the commit message.

Doesn't it need +1 at the end, I wonder?  We want to map:

 - zero to zero
 - any number to at least 1

so scaling a non-zero "it" so that maximum maps to (width-1) and then
adding 1 would be the right way for the latter case.

Of course, an easy way out without worrying about the correct math is to
scale the total and the smaller one and then declare that the scaled
larger one is the difference between the two. That way, both of these two
files have 109 in total so the length of the entire graph would be the
same ;-).
