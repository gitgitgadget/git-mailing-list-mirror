From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 17 Jun 2013 16:27:03 -0700
Message-ID: <7v38sgb9o8.fsf@alter.siamese.dyndns.org>
References: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
	<1371301305-30160-1-git-send-email-apelisse@gmail.com>
	<7vzjuog175.fsf@alter.siamese.dyndns.org>
	<CALWbr2zM=rD3GE9a=Xyrvz0E5mAMsDesJu8-Zs7JH7W4U4AbeA@mail.gmail.com>
	<7vd2rkcy6r.fsf@alter.siamese.dyndns.org>
	<CALWbr2x0gxQ8boXEa3WJUbaA8e9imt9Ri_NFmANEhJuK6Moi+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 01:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoipR-0007dU-8t
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 01:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab3FQX1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 19:27:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659Ab3FQX1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 19:27:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE7428A0D;
	Mon, 17 Jun 2013 23:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BmThmJ4n1EH7eUbUgXgLvy5C/vI=; b=g/hAdI
	GnV8IptIt6pIoVRB5BvnB0k6OS5C6f/gcs/+zU3mD7NOx2Nt7awKYj/2XJJz5/u6
	+Tzrp5w8wqliC14Yy0g2CmGv7AN2JkOWkw5+ESqX9dl+faPs1d4RpDxhEuRiQEcG
	piuWL2gBrp688QS+bmS/CRepNF0Puzb8XGDqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V+r5bTehFS6niDGrLVPiQXm4wefF32co
	WQo49LjrhO+BLNLjc+72UruSRjpcCa0iy8IcNQB6BtrRoh3fFu6I+H+uvrlvSqS0
	cEwXnmToj953F2Y7fptGhQWzowe5gCR6BH25W4duVMpAiBK60AME/IY+MWHy5ojR
	HoCM4R0xeZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FB2D28A0C;
	Mon, 17 Jun 2013 23:27:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAF3628A08;
	Mon, 17 Jun 2013 23:27:04 +0000 (UTC)
In-Reply-To: <CALWbr2x0gxQ8boXEa3WJUbaA8e9imt9Ri_NFmANEhJuK6Moi+A@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 17 Jun 2013 23:33:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B814B98-D7A5-11E2-9E0D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228124>

Antoine Pelisse <apelisse@gmail.com> writes:

> Re-reading note: OK, This last sentence ("If not we will eventually be
> too far and break") is actually a bug. We might break before we find
> something interesting while we should keep going. For example in such
> a case, we should display like this, but won't:

Glad to see that my question has helped ;-)

>> This is on the else side of if (!xch->ignore), so we are looking at
>> ignored hunk, which means there is only blank line change.  Can chg2
>> be 0 while chg1 is not zero, i.e. xch being a blank line removal?
>
> Exactly. It can be a blank line removal. But I don't want to consider
> it in the calculation.
> Here's why:
> ...
> What should be the output of diff --ignore-blank-lines ?
>
> I chose this alternative:
> @@ -1,3 +1,4 @@
> +change
>  1
>  2
>  3
> @@ -7,3 +5,4 @@
>  4
>  5
>  6
> +change
>
> While one could have chosen:
> @@ -1,10 +1,8 @@
> +change
>  1
>  2
>  3
> -
> -
> -
> -
>  4
>  5
>  6
> +change
> ...
> Nothing is interesting here, we just leave the interesting zone (if
> not already left) because everything else failed.

Yes, that asymmetry is what I was wondering if we want to have.  If
we show additional blanks as a significant event, I am not so sure
we can say "Nothing is interesting here".

I do not feel strongly either way, but it just felt somewhat
inconsistent.

Thanks.
