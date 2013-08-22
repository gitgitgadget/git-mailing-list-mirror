From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Revert "bash prompt: avoid command substitution when finalizing gitstring"
Date: Wed, 21 Aug 2013 17:22:49 -0700
Message-ID: <xmqq7gfesheu.fsf@gitster.dls.corp.google.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
	<1377118173-23405-3-git-send-email-bcasey@nvidia.com>
	<xmqq7gfeu35g.fsf@gitster.dls.corp.google.com>
	<CA+sFfMc0BPo8pSLngi=bAWxYNT8xKFEOo77z3a12q+-Sq4qiiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>, szeder@ira.uka.de
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 02:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCIfx-0007Oc-HD
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 02:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab3HVAWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 20:22:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab3HVAWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 20:22:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBA2A27439;
	Thu, 22 Aug 2013 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ILhiXGGx7IEcpmo2hN9mdBvOfa8=; b=fnlvaM
	sEhrhT5QD+3oLOExnNF4maJ15DSLpFtTNzXwM0n4nnjsgXofl3RXjg/Ik1wtFvB6
	JtAYbSvsKAB2ifHB2Jk58otwSzXNM21W+UhIcN5PjjT/wzFSZFVjDPVwX9wscuSp
	wp1V3SRsVp2SIIFnCkoJFFci1ilOZ5mFoLYGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sl9/I+9XNDgZ2fS3driz+G50HJnclCr3
	vqO7eLTQL3kT7qiRgG9pJQr7r2Cl5/4vHkniObbFjS764vYm2Qy0q3v7F6Jr+/KI
	UBVEyOFv81hXPR1PcZVoLwPgfTE5z/yIGj8OvBlh0/9xHmT2RtQBSvKUMhJA2ebp
	qLPVfa8DFTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C04CE27438;
	Thu, 22 Aug 2013 00:22:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E60A27433;
	Thu, 22 Aug 2013 00:22:52 +0000 (UTC)
In-Reply-To: <CA+sFfMc0BPo8pSLngi=bAWxYNT8xKFEOo77z3a12q+-Sq4qiiA@mail.gmail.com>
	(Brandon Casey's message of "Wed, 21 Aug 2013 15:08:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB93BDA8-0AC0-11E3-960C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232754>

Brandon Casey <drafnel@gmail.com> writes:

> On Wed, Aug 21, 2013 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Brandon Casey <bcasey@nvidia.com> writes:
>>
>>> From: Brandon Casey <drafnel@gmail.com>
>>>
>>> This reverts commit 69a8141a5d81925b7e08cb228535e9ea4a7a02e3.
>>>
>>> Old Bash (3.0) which is distributed with RHEL 4.X and other ancient
>>> platforms that are still in wide use, does not have a printf that
>>> supports -v.  Let's revert this patch and go back to using printf
>>> in the traditional way.
>>>
>>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>>> ---
>>
>> Is this something you can detect at load-time once, store the result
>> in a private variable and then switch on it at runtime, something
>> along the lines of...
>>
>>
>>         # on load...
>>         printf -v __git_printf_supports_v -- "%s" yes >/dev/null 2>&1
>>
>>         ...
>>
>>         if test "${__git_printf_supports_v}" = yes
>>         then
>>                 printf -v gitstring -- "$printf_format" "$gitstring"
>>         else
>>                 gitstring=$(printf -- "$printf_format" "$gitstring")
>>         fi
>
> Yes, that appears to work.

A real patch needs to be a bit more careful, though.  The variable
needs to be cleared before all of the above, and the testing would
want to consider that the variable may not be set (i.e. use
"${var-}" when checking).

Thanks.

> -Brandon
>
>
>>>  contrib/completion/git-prompt.sh | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>>> index a81ef5a..7698ec4 100644
>>> --- a/contrib/completion/git-prompt.sh
>>> +++ b/contrib/completion/git-prompt.sh
>>> @@ -433,11 +433,7 @@ __git_ps1 ()
>>>       local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
>>>
>>>       if [ $pcmode = yes ]; then
>>> -             if [[ -n ${ZSH_VERSION-} ]]; then
>>> -                     gitstring=$(printf -- "$printf_format" "$gitstring")
>>> -             else
>>> -                     printf -v gitstring -- "$printf_format" "$gitstring"
>>> -             fi
>>> +             gitstring=$(printf -- "$printf_format" "$gitstring")
>>>               PS1="$ps1pc_start$gitstring$ps1pc_end"
>>>       else
>>>               printf -- "$printf_format" "$gitstring"
