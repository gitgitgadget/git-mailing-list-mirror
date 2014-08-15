From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Fri, 15 Aug 2014 14:45:14 -0700
Message-ID: <xmqqmwb5zatx.fsf@gitster.dls.corp.google.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
	<xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFJiUt1p_OfefswS8O8_BA6mQy=PStmYyNw=ABZCOQprQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 23:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIPJV-0008JL-9x
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 23:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbaHOVp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 17:45:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61213 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbaHOVpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 17:45:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CDC330BFD;
	Fri, 15 Aug 2014 17:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P/ysclgISDxAUI5gSO5GnXEhIG0=; b=yAK2YQ
	Q/5BITz1IiDCDedWOPvCwxsYXV7b5dDKUH0O0ktdpBP52aiLifUsH/nUK1E3IznX
	Lle24yByY8kqNwBCvTfEu8MOvoeb0oMy/s4OzbV5G6yuFE2NkAInXtcWU/KclkuY
	c4VctMjMyq6KCtskkdHpA44WI14TDBdmS2vw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=taX+eo6R408tJblhAKD4e8eVJSmPpVvW
	fW7P1ngqkju/+6dx07iDKjG9XHQM5+/q+qnGZIiQyvMqjGN4gzfZxtMCj5WT1ClK
	RZpaAyyk5zY4L9xN6J1Hp3Qb9p5i3G6IyuCRR2D3Ro04mZlAukpGulV0L9BtHADt
	UJ5lo0JUJEQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EAFC30BFC;
	Fri, 15 Aug 2014 17:45:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0211730BF3;
	Fri, 15 Aug 2014 17:45:15 -0400 (EDT)
In-Reply-To: <CAPuZ2NFJiUt1p_OfefswS8O8_BA6mQy=PStmYyNw=ABZCOQprQ@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Fri, 15 Aug 2014 21:50:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 718D0F40-24C5-11E4-B375-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255306>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> On Thu, Aug 14, 2014 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Being a conservative, I'd rather avoid doing any magic during
>> read_cache() time. "ls-files -s" for example should show the four
>> stages so that the "broken" state can be inspected.
>>
> Well, only read_cache_unmerged() is modified in the sent patch, so no
> magic is done in read_cache(), I'd also avoid changes there.

Ahh, I must have overlooked that; changes being only in _unmerged()
variant makes me feel much better, and it probably would make much
of ...

>> Yes, it would be more work,...

... moot, hopefully ;-)

> git reset will clean the index anyway if the loop finishes, would it
> be ok?

Surely.

> git merge is also affected by the loop in read_cache_unmerged(), but
> any of the solutions would be enough for it as only by finishing the
> loop with unmerged entries it will die without commiting the cache to
> the index file.

Again, true.  The mergy operations want to start from a clean slate
and they call _unmerged() variant primarily to learn that there were
unmerged entries in the index, only to abort the operation in that
case, so a change to _unmerged() variant should be safe for them.

I'll take another look at your patch later, but not before the 2.1
final, and by that time you may already have sent a reroll ;-)

Thanks.
