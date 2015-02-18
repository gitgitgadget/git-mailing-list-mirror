From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git gc removes all packs
Date: Tue, 17 Feb 2015 23:13:05 -0800
Message-ID: <xmqqoaor4rr2.fsf@gitster.dls.corp.google.com>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
	<20150205200332.GD15326@peff.net> <54E36EBF.2070600@alum.mit.edu>
	<20150217165514.GA12176@peff.net> <54E3A695.1050708@alum.mit.edu>
	<xmqq7fvg19se.fsf@gitster.dls.corp.google.com>
	<54E3BE8B.2040403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Dmitry Neverov <dmitry.neverov@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 18 08:13:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNyos-0001Jq-TV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 08:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbBRHNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 02:13:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750962AbbBRHNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 02:13:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C53431DDD;
	Wed, 18 Feb 2015 02:13:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s3XKoTxqrR5S2yUDq4pBUB2PGTA=; b=kUiguH
	Cn4a6B+QVbu8qF4xcPaivg5QK8O3k7MI83z2MGkbFRFex0MOnWuM/rZaIV4azmZB
	uzNIpJnkE/sN5UBXZ5eqHNIWC/F9eYNVXYY5ybT8Tn8tnxkKnT7BTs213fmSB/rK
	lWslTtlAOHA2KJzssmIK6t5KqEu44IinnKJ1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DfkC8kFIUWwigUAdn+Gj3UXKe5XDv8Is
	drf8GKz4VlcJYuujca3nymuQ1XFzEml00i72uXsU8otlAHZA8hcxaeyLiNR/I7q/
	O9bo4ti7NScyI0us707pCwxfuqJSBtHAatpKdfhjNPib6LtQuqNXOtcgEsyjkoq4
	8kEhJfNR3tg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30BCD31DDC;
	Wed, 18 Feb 2015 02:13:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAD3E31DDB;
	Wed, 18 Feb 2015 02:13:06 -0500 (EST)
In-Reply-To: <54E3BE8B.2040403@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 17 Feb 2015 23:19:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 961A07B8-B73D-11E4-92AF-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264005>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/17/2015 10:57 PM, Junio C Hamano wrote:
> ...
>> Do you mean that we would end up reading refs/heads/hold if the user
>> did this:
>> 
>>     git rev-parse --verify HEAD -- >precious
>>     ln -s ../../../precious .git/refs/heads/hold
>> 
>> because that symbolic link does not begin with "refs/",
>
> Correct, you can do exactly that. The "hold" reference is resolvable and
> listable using "for-each-ref". But if I try to update it, the contents
> of the "precious" file are overwritten. On the other hand, if I run
> "pack-refs", then the current value of the "hold" reference is moved to
> "packed-refs" and the symlink is removed. This behavior is not sane.
>
>> and is an
>> accident waiting to happen so we should forbid it in the longer
>> term and warning when we see it would be the first step?
>
> Yes, I am proposing that approach, though if somebody can suggest a use
> case I'm willing to be convinced otherwise.

Thanks.  I agree the proposed tightening is probably harmless, but I
too would want to see if somebody comes up with a valid use case.  I
do not think of anything offhand.
