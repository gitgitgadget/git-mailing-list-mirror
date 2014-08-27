From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Wed, 27 Aug 2014 07:47:13 -0700
Message-ID: <xmqqtx4yf0r2.fsf@gitster.dls.corp.google.com>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
	<1409066605-4851-3-git-send-email-prohaska@zib.de>
	<20140826182125.GC17546@peff.net>
	<xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
	<20140826203158.GA30651@peff.net>
	<xmqq38cihq7w.fsf@gitster.dls.corp.google.com>
	<20140827044621.GA32141@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMeVU-00030R-RY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935019AbaH0OrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 10:47:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50430 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933802AbaH0OrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 10:47:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08C5A3163F;
	Wed, 27 Aug 2014 10:47:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgu/hDCweE2GyXMBCuDyG7zLRXQ=; b=dn95lP
	jqis+oxafCgHdj212M/qCyQyma2j5vrHZIxX9w2iHE+cLpVJNsk8KK/S1msor5ki
	RDGi4ZbE5LI77GK3ejcaIFE//7Pn7i7egSNvEzpc1XQzShRQenFTs5N4VX967DKn
	FkODoy6IK4WKQJ6q3QqLCHh5Yy4XwuzZmFNf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YfWSIqniNy2mKAR+hMSoITQJXIbkOHWd
	rBTcEYQXSTWs7r/G5HAzLV3zdw1HnMUjfTH5etRwXNiIZqCxz1gXoIixIJqKoQ1a
	SA5IEuovcUerb12K50QryvSzLgaRnOcYddWzO8NhL2+qoRzOutl8CPjl/O/kHdmB
	YJMhUc9EW9Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF9813163E;
	Wed, 27 Aug 2014 10:47:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 16CED31637;
	Wed, 27 Aug 2014 10:47:15 -0400 (EDT)
In-Reply-To: <20140827044621.GA32141@peff.net> (Jeff King's message of "Wed,
	27 Aug 2014 00:46:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 092877E0-2DF9-11E4-84FE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256001>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 26, 2014 at 02:54:11PM -0700, Junio C Hamano wrote:
>
>> A worse position is to have git_env_bool() that says "empty is
>> false" and add a new git_env_ulong() that says "empty is unset".
>> 
>> We should pick one or the other and use it for both.
>
> Yeah, I agree they should probably behave the same.
>
>> > The middle ground would be to die(). That does not seem super-friendly, but
>> > then we would also die with GIT_SMART_HTTP=foobar, so perhaps it is not
>> > unreasonable to just consider it a syntax error.
>> 
>> Hmm, I am not sure if dying is better.  Unless we decide to make
>> empty string no longer false everywhere and warn now and then later
>> die as part of a 3.0 transition plan or something, that is.
>
> I think it is better in the sense that while it may be unexpected, it
> does not unexpectedly do something that the user cannot easily undo.
>
> I really do not think this topic is worth the effort of a long-term
> deprecation scheme (which I agree _is_ required for a change to the
> config behavior). Let's just leave it as-is. We've seen zero real-world
> complaints, only my own surprise after reading the code (and Steffen's
> patch should be tweaked to match).

OK, then let's do that at least for now and move on.
