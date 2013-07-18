From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 18 Jul 2013 11:00:10 -0700
Message-ID: <7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan> <871u6v93a8.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 20:00:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsV6-0004JR-7b
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 20:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330Ab3GRSAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 14:00:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759072Ab3GRSAN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 14:00:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C86003168F;
	Thu, 18 Jul 2013 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MjX07BoaQykdvvmjTk+6iKHoyPs=; b=VO1DI8
	FpGKmkkoL27Ct5McWjYrihUrsCGtAIdtIVc3nmU1tGx/aewew5KT8NSwlwWi63Wp
	A4+kdQb0K8kQ1f+1CQu+4AIhS+NJWT2wZP652aKPYf7f/ffMXTyzKVPn44k1bn6d
	L37W+YMzzFQDOtH5Fou51uvQ1lP492quf0O7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hOjbFFZ2RrBQJvCtUZzDNznj+N7/cPJT
	sCJwYJ8DX+CEX/uL8QM5M0U5/lqGSMShE2XjlW3f4Zy+SUWMgVmzR6r8HrFAU3G1
	2jbTZKEkxGL33YJPgGu8gcIBo9L9f5KkiuLoRP0Dg4yAMPyn+l9T6FMYEA95kxzu
	Aj6co4RwjIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE783168E;
	Thu, 18 Jul 2013 18:00:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C1EB3168D;
	Thu, 18 Jul 2013 18:00:12 +0000 (UTC)
In-Reply-To: <871u6v93a8.fsf@igel.home> (Andreas Schwab's message of "Thu, 18
	Jul 2013 19:38:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4427106-EFD3-11E2-8117-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230718>

Andreas Schwab <schwab@linux-m68k.org> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
>>> diff --git a/git-pull.sh b/git-pull.sh
>>> index 638aabb..4a6a863 100755
>>> --- a/git-pull.sh
>>> +++ b/git-pull.sh
>>> @@ -264,6 +274,30 @@ case "$merge_head" in
>>>  		die "$(gettext "Cannot rebase onto multiple branches")"
>>>  	fi
>>>  	;;
>>> +*)
>>> +	# integrating with a single other history
>>> +	merge_head=${merge_head% }
>>> +	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
>>> +		test -n "$orig_head" &&
>>> +		! $(git merge-base --is-ancestor "$orig_head" "$merge_head")
>>
>> I think this needs to be:
>>
>> 	! $(git merge-base --is-ancestor "$orig_head" "$merge_head" ||
>> 	    git merge-base --is-ancestor "$merge_head" "$orig_head")
>
> Neither makes sense.  You want to check the exit status of git
> merge-base --is-ancestor, not execute its (empty) output as a command.

Gaah.  You are right.

Thanks for spotting.
