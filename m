From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: unwrap tag refs
Date: Wed, 13 Jan 2016 09:40:01 -0800
Message-ID: <xmqq8u3tpedq.fsf@gitster.mtv.corp.google.com>
References: <1447388144-23806-1-git-send-email-git@rob.dqd.com>
	<87h9kqwm67.fsf@waller.obbligato.org>
	<87d1t6p5ov.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rob Mayoff <mayoff@dqd.com>, git@vger.kernel.org
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Wed Jan 13 18:40:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPP2-00086S-68
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbcAMRkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:40:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755192AbcAMRkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:40:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC6BE3AD52;
	Wed, 13 Jan 2016 12:40:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FcgJl8AExXqABXs9buRTQShfWC0=; b=SjnF4I
	niSYR3rgav/dPTeG64kJ3I+Hi3cyZr9m8sqjKYQa2OwYBolQx8LMPeOh81mP4jc7
	u9gu2EqsPGbuYPGLoZEPJndxrXqeSqOZ7JINCfTQUh1VVAXKD3PxRC4HhbWuR5Kk
	I4897I0BFrdxPV4wLqd8wpR+4w4OQXjIFfIkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LTWoDvBbUP5qXnsWkuRRybbkQ8Euf76H
	y3c2lBlUtDhtfxuMm0hVl7V3ujyOIsM9lV8ine+NJTQfyvamt4ijjtr7zh2Ne3XQ
	GgS0OHsEPNh4GBUnVvsRnt8AFwGPJI/10xTT1dXQS/Ryu6pLkqoOMMfpppDU3wi2
	zPAbBmWDjWI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1E543AD50;
	Wed, 13 Jan 2016 12:40:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E9D03AD46;
	Wed, 13 Jan 2016 12:40:03 -0500 (EST)
In-Reply-To: <87d1t6p5ov.fsf@waller.obbligato.org> (David A. Greene's message
	of "Tue, 12 Jan 2016 20:35:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD38ED82-BA1C-11E5-9900-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283953>

greened@obbligato.org (David A. Greene) writes:

> I am sorry I neglected to follow-up on this.
>
> greened@obbligato.org (David A. Greene) writes:
>
>> Rob Mayoff <mayoff@dqd.com> writes:
>>
>>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>>> index 9f06571..b051600 100755
>>> --- a/contrib/subtree/git-subtree.sh
>>> +++ b/contrib/subtree/git-subtree.sh
>>> @@ -245,7 +245,10 @@ find_latest_squash()
>>>  		case "$a" in
>>>  			START) sq="$b" ;;
>>>  			git-subtree-mainline:) main="$b" ;;
>>> -			git-subtree-split:) sub="$b" ;;
>>> +			git-subtree-split:)
>>> +				sub="$b"
>>
>> Why include the above line?
>
> My bad.  Missed the diff markers.  This is fine.
>
>>> +				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"
>>
>> This seems like odd quoting.  Would not this do the same?
>>
>> 				sub="$(git rev-parse $b^0)" || die "could not rev-parse split hash $b from commit $sq"
>>
>> Perhaps I am missing something.
>
> Jeff explained it, so this is ok.
>
> This all looks good to me.  Junio, please apply.
>
>                             -David

Thanks, all.  Let's mark rm/subtree-unwrap-tags topic to be merged
to 'next', then.
