From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 11:23:33 -0700
Message-ID: <xmqqd2ec3byy.fsf@gitster.dls.corp.google.com>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
	<99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net>
	<20140613114615.GE14066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 20:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvW8e-0000Qi-0L
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 20:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbaFMSXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 14:23:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62800 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbaFMSXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 14:23:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBFEA1F5D7;
	Fri, 13 Jun 2014 14:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eK1Cm1Jgxjy9kPuzN/bVfiwwddA=; b=TFiwQl
	dCpKK1S+i2Y/3wYv/fu1QRFe7tIlQFJkvEm8egZnzIAUpQfJ6x9wC8M7G0NDn5ob
	OCji5+C9RFhiItwM1pSvX9y7BCAmtQznxX4PHR6vnQtOlYDfBZ0vMUOpeFBjsSJw
	ryBkabLBaKVc0C2dA3kPxskZ5GQpjf9frdx7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eAUgwXKa+TCgsTw7cey+LG+76kNXm4Du
	X5D5ahbGyi1mutu0Yf7wTAJ6EaX/D9hC4NjHI1niRW/mJkCJ7SKcU/C8EC396hL+
	fqNzk70l07FazmYIb9uJpR9tK09ge/xd9I08lZS2PxRHMUBnDExoHDcvEy28asYr
	W5bqqpSs/0s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D293B1F5D6;
	Fri, 13 Jun 2014 14:23:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7FBDE1F5C9;
	Fri, 13 Jun 2014 14:23:34 -0400 (EDT)
In-Reply-To: <20140613114615.GE14066@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jun 2014 07:46:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D47B2440-F327-11E3-849E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251627>

Jeff King <peff@peff.net> writes:

>>  	(
>>  		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
>>  		do
>> -			git show --pretty=short --show-signature $commit >actual &&
>> +			git show --pretty=short --show-signature $commit >actual || exit 1
>>  			grep "Good signature from" actual || exit 1
>
> Hrm. The original is:
>
>   X &&
>   Y || exit 1
>
> Won't that still exit (i.e., it is already correct)? Doing:
>
>   for X in true false; do
>     for Y in true false; do
>       ($X && $Y || exit 1)
>       echo "$X/$Y: $?"
>     done
>   done
>
> yields:
>
>   true/true: 0
>   true/false: 1
>   false/true: 1
>   false/false: 1
>
> (and should still short-circuit Y, because we go from left-to-right).
>
> I do not mind changing it to keep the style of each line consistent,
> though. I would have written it as a series of "&&"-chains, with a
> single exit at the end, but I think that is just a matter of preference.

Yeah, series of && chain with a single exit at the end is good, and
the subshell is there only to allow us to do that "exit at the end".
