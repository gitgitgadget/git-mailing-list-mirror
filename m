From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #02; Tue, 11)
Date: Wed, 12 Mar 2014 12:49:48 -0700
Message-ID: <xmqqa9cvkxib.fsf@gitster.dls.corp.google.com>
References: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
	<20140312193509.GA1816@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpA7-0002FT-5M
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbaCLTtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:49:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbaCLTtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:49:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24BED73255;
	Wed, 12 Mar 2014 15:49:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=32MSCpyse7/16PQMMGB/n8Jy028=; b=xMOiQl
	AwFT4gij3DmKBZPRNnRsvTT3YKI4zMl+ZliWZvn7UuUFFGK3g23KNP8thd3tM89z
	cuxCNyO8TAdczYleddFtYKL0qDfbk+nzMicDcwdKoSpwGjU6/4NhBwRpQIQmGv5U
	M8tbuPwQO43jJR08sQSIcNwI8BeIns+9wfPg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MtfEfxJq5XxXHoNbgKGuN4hEENKjoW0h
	4V2X5i03+D5LuPpJon+6xdRxZKHV5LzVPtyAdphAJFwUaBLD/o3G78fA21uSy1zM
	EjyXwllyjFQimdK+CuFha6IaO+XUD3Jsz3FWE60dxa3E7v0SxED01Zh5kKQfMfJy
	KBHUqerd4U4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1353973254;
	Wed, 12 Mar 2014 15:49:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 576D473250;
	Wed, 12 Mar 2014 15:49:50 -0400 (EDT)
In-Reply-To: <20140312193509.GA1816@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 15:35:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 79199E34-AA1F-11E3-BEBD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243974>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 11, 2014 at 03:12:11PM -0700, Junio C Hamano wrote:
>
>> * jk/warn-on-object-refname-ambiguity (2014-01-09) 6 commits
>>  - get_sha1: drop object/refname ambiguity flag
>>  - get_sha1: speed up ambiguous 40-hex test
>>  - FIXUP: teach DO_FOR_EACH_NO_RECURSE to prime_ref_dir()
>>  - refs: teach for_each_ref a flag to avoid recursion
>>  - cat-file: fix a minor memory leak in batch_objects
>>  - cat-file: refactor error handling of batch_objects
>> 
>>  Expecting a reroll.
>
> I finally got a chance to return to this one. Michael had some good
> comments on the refactoring that was going on in the middle patches. He
> ended with:
>
>   Yes.  Still, the code is really piling up for this one warning for the
>   contrived eventuality that somebody wants to pass SHA-1s and branch
>   names together in a single cat-file invocation *and* wants to pass
>   lots of inputs at once and so is worried about performance *and* has
>   reference names that look like SHA-1s.  Otherwise we could just leave
>   the warning disabled in this case, as now.  Or we could add a new
>   "--hashes-only" option that tells cat-file to treat all of its
>   arguments/inputs as SHA-1s; such an option would permit an even faster
>   code path for bulk callers.
>
> Having looked at it again, I really think it is not worth pursuing. The
> end goal is not that interesting, there is a lot of code introduced, and
> a reasonable chance of accidentally introducing regressions and/or
> making the code less maintainable.  Keeping the existing code (which
> just disables the check for cat-file) is probably the sanest course of
> action. We can do a similar thing for "rev-list --stdin" if we want, or
> we can wait until somebody complains.
>
> The bottom two patches are reasonable cleanups we should keep, though
> (and the rest can just be discarded).

Fine, let's do that.

Thanks.
