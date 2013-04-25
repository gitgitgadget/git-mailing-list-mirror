From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 13:06:06 -0700
Message-ID: <7vsj2e2x5d.fsf@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net>
	<7vehdy7j5f.fsf@alter.siamese.dyndns.org>
	<CAMP44s0FHnm0xeSuzVNxVhn_rMQ=oKqoDxCU+OWGKPNOxmnGyA@mail.gmail.com>
	<7vwqrq31tv.fsf@alter.siamese.dyndns.org>
	<CAMP44s3LhYt+eNaKWyoDWAPtepaOKXLhYsPXg5dPjYN8MoGA-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSQr-0001SL-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548Ab3DYUGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:06:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756207Ab3DYUGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:06:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4E6019445;
	Thu, 25 Apr 2013 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3vYkV2nkXlUUUi9YZo9nWRtxIFY=; b=B/6LcU
	O18OY++AtLb7V29tXoJLTbRNzdWmFP0Qs9Ba1hV3rXE3Cw1pEv250zga2tDFA84R
	fRPp+9Wxj186HiJeOJH6c9TVeybLGT7QLtRyJN7ta+/r/Dn4qHYCXcBmMfVU6skz
	wVeEtgPHTm25J/2ggPNX2npKAmy1abV/uhaLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rjn4/4kB12PBEWXOk5n7cSdUW7NhFaqU
	ili6vfFaUdyc7AgK1mgd8LDybzeICX49HFowl0vM+FZT2YWTxGT3xxCgpGsFCFjK
	1w4HwsQQ0Du8qLQn5Xrk2wny/vc56KuEAerMkCFrgb3VRjPrLLnukyEqzUZvtcEO
	rZA0Z+Gjl6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8BCA19444;
	Thu, 25 Apr 2013 20:06:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D2C519442;
	Thu, 25 Apr 2013 20:06:08 +0000 (UTC)
In-Reply-To: <CAMP44s3LhYt+eNaKWyoDWAPtepaOKXLhYsPXg5dPjYN8MoGA-w@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 14:24:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9154A090-ADE3-11E2-B557-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222440>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 25, 2013 at 1:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>>> ...
>>>>> +             git for-each-ref --format='%(refname) %(objectname)' |
>>>>> +             while read ref a
>>>>>               do
>>>>> -                     test $a == $b && continue
>>>>> +                     case "$before" in
>>>>> +                     *"$ref $a"*)
>>>>> +                             continue
>>>>
>>> I wonder if we should bother with this at all. The purpose of the code
>>> was mainly to show to users that they should report the success only
>>> if the refs have been updated, but the code is becoming more
>>> obfuscated, a comment should do the trick. And then, we can just
>>> report success for all the refs (and explain in the comment why).
>>
>> Are you proposing to say "ok $ref" to everything we see in the
>> resulting repository, even the ones the caller of remote-testgit did
>> not ask us to do anything with?
>>
>> Wouldn't the caller be surprised if we did so?
>
> Why would it?  The only effective difference is what you'll see
> reported in the UI, but there's no user here.

You are correct that it affects only the UI, but isn't that because
the current implementation of push_update_refs_status() blindly
accepts whatever 'ok' response says without checking the ref
mentioned against what it tried to push out?  I was wondering if
that codepath should stay that way forever, or if we may want add
sanity checks later.  If the latter, I suspect this would manifest
as an ancient bug to say 'ok' for everything we have instead of what
we actually pushed out (of course, the explanation in the comment
would help).

So I am OK with that simpler approach.  Care to roll the conclusion
of your idea into a patch?

By the way, I noticed that Documentation/gitremote-helpers.txt does
not even mention these 'ok' responses for 'export' command, but they
should be the same as responses to 'push'. Perhaps we can share some
text between the two?
