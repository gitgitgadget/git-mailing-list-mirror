From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 09 May 2013 18:13:15 -0700
Message-ID: <7vk3n763is.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
	<CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
	<7v38tv7n5y.fsf@alter.siamese.dyndns.org>
	<CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com>
	<7vobcj65wp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 03:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uabtk-0004Dg-3U
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 03:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab3EJBNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 21:13:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab3EJBNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 21:13:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D32F41457F;
	Fri, 10 May 2013 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Qynw+dUDI+oexQOymWrJzihn+k=; b=A/l/PW
	ib8mcG47kvdTBU+t5n2A7GagNWHiGkotv+WY3AypDWy7u7jESiYw9vLua7N4BX0g
	WmFfVi0qy3rL6A3Tz2mvR+wfRUVr2S66u5C6L/ZaEm6Gio+R/DdxL5wXuPJc8YD0
	ladqaqxWsVJv+llkHvM1KMTP/PhfLMfc6ucIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mb7rILjg+1hbu3dhrlCQHkDmioRgZD88
	WB4tUcAF9+U4Ki1t3ONeTVITK6fy1UsMmO6NGkFaBZH01AY143TVJ9dlgn9OXX2Z
	j92wwQH0FwhhYsnUzbqR9ikP6KGqM6NX8qOuO3iRj1A5zxSn5/EiPnEuAhRGt0dn
	HxhDat5fkHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8ED01457D;
	Fri, 10 May 2013 01:13:17 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28D2D1457A;
	Fri, 10 May 2013 01:13:17 +0000 (UTC)
In-Reply-To: <7vobcj65wp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 09 May 2013 17:21:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBA4956C-B90E-11E2-97E2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223809>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 9, 2013 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Simple.  You treat everything as refspecs and form revision ranges
>>> out of them.  Note that that is exactly the reason why "git push"
>>> can take "master" as a short-hand for "master:master" [*1*].
>> ...
>>> So I would imagine you would be spelling that as:
>>>
>>>     git fast-export master:new-master --not next refs/tags/*
>>>
>>> or something, no?
>>
>> rev-list doesn't accept 'refs/tags/*'.
>
> I think you misunderstood.  That is meant to illustrate what your
> end users feed "fast-export". "fast-export" in turn expands that
> into a revision range, which needs to happen anyway when it strips
> :new-master from the positive end of the range to make the range
> into
>
> 	master ^next ^refs/tags/v1.0 ^refs/tags/v1.1 ...

A few corrections and a related random thought.

 * The original --not "refs/tags/*:refs/tags/backup/*" fooled me. As
   my primary point was that an earlier change to fast-export made
   the uninteresting bottom not appear as reset in the output
   stream, I omitted everything after colon without much thought.

   If the current fast-export does not let you say "refs/tags/*" to
   export all the tags, we do not have to extend it to allow it to
   do so.

 * On the other hand, "git log 'fc/*'" might be a handy thing for
   any command that wants to have multiple starting points for
   revision traversal, so in principle I would not mind such an
   enhancement to rev-list machinery.

   But that does not have to be part of this series.

 * I alluded to the similarity between fast-export and bundle,
   meaning to hint that "git bundle" might also benefit from being
   able to say "record these refs under different name", but after
   thinking about it a bit more, I think it is unnecessary.

   The user of the bundle's output, either fetch or clone, can use
   the usual refspec mapping to use the data in any way it wants.
   If the bundle says refs/heads/master is at one commit, the _user_
   of that bundle can decide to map it to refs/remotes/origin/master
   (or refs/heads/origin, for that matter).

   It is a very powerful concept that we can generate data once,
   cast it in stone, and delay the decision on _how_ it is used
   until the last minute, much better than mapping at export time.
   So bundle does not need a similar refspec mechanism to map what
   it exports.  I haven't thought things through to see if the same
   logic applies to fast-export output (if so, it would mean it is
   better to allow the consumer of the stream take the refspec
   parameter and map the tips it finds in its input), though.
