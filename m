From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 09 Jul 2013 11:55:36 -0700
Message-ID: <7vy59fv9zr.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 20:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwd4j-0003KQ-22
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab3GISzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 14:55:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab3GISzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 14:55:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEFDA2F39E;
	Tue,  9 Jul 2013 18:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z8mwKy+4ZT1kZLTBYbNhQigXhtk=; b=nRUhPR
	5yfx+THxABmsQQMWjs6tukheYRkYP4CgPdyjc+xuDMFY5Mhr/jige6TNXNvvz075
	/kUzoCPwEc2nP9gEY5rn/bIhV7LWcbbxTSCBhFkQxsWF8sWgL72yuI6PQKh702yU
	bPFkbcPW3gYXAN7tXvXWSdMeOLuamRMhJsuHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XN/pGJ15QhQbohkUn/fMGB5HVMjL3ZAO
	yio3tz7X+gjF7TIWuKPLGNZp8k0uLjATxqlyXZj1vVjowJWyFkCqvy45iTVUukwu
	pWVOzlDl2W51ySGnItQrJ20USzpxdx4Dibzo7mAd+a7lijiIJ3cK0H4mLuSaLcAf
	pMUU0ImQyp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3D892F39C;
	Tue,  9 Jul 2013 18:55:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36D022F39B;
	Tue,  9 Jul 2013 18:55:38 +0000 (UTC)
In-Reply-To: <CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 9 Jul 2013 14:23:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 250EBC60-E8C9-11E2-806C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229978>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 9, 2013 at 1:42 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>>>      beginning of the second range is found by choosing C that comes
>>>      _after_ the end of the previous range (/B/ may choose either
>>>      the second or the 4th line, and the only C that comes after
>>>      either of them is the 5th line and that is where the second
>>>      range should begin, not at the beginning of the file).  The
>>>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>>>      to be the beginning of the second range).
>>
>> So passing several -L arguments does not blame the union of what each
>> argument would blame individually?  Doesn't that make it rather harder
>> to explain?
>
> I don't think Junio meant to imply that. Collecting the blame ranges
> can/should be a distinct step from coalescing them. Junio is saying
> that an -L /re/ range search should start after the maximum line
> number already specified by any preceding range.

I am not sure if I want "maximum specified so far". I meant "start
searching at the last location", e.g.

	-L 100,200 -L 4,6 -L /A/,+20

would want to find the first A after line 6, not after line 200.

> Once all input ranges
> are collected, they can be coalesced. (If a -L /re/ range happens to
> be coalesced with or into some other range, that's fine: you're still
> seeing blame output for the requested lines.)

Yes.
