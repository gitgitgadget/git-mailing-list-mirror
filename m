From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 03 Dec 2014 15:43:43 -0800
Message-ID: <xmqqiohsuwnk.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051911.GP6527@google.com>
	<xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
	<xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
	<20141203232951.GJ6527@google.com>
	<xmqqmw74uwx0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:43:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJaI-0001sX-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbaLCXnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:43:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbaLCXnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:43:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58E6123976;
	Wed,  3 Dec 2014 18:43:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bwnt2rjT0ROUNgSZPeVtzDic+iw=; b=YbX14q
	tpigvr5vco6FBKhRrQ5YAhzh4aEkgyqB/x4YdVKxYg9wdEmts4cwz6OBja8Hygiq
	+ZriNfVaPnwufLloXVhuZwsoQfxCFpe6Lj2V4oNht8c3NCx/nSM8lkw/DUw0Hpj2
	WkYnJyJoONfqzPDY1ljTers5mK9yTNHryqp6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cl/dxhpFOLpxdBVG+oVPTRDixzqzUTrI
	c4L2koHofvlV4vFkxhxeetQGN5XO/7n0BJkCKHTvl9cncrTbYScg8RMlLqCtIDZz
	seDvkQrtp6OBsrteKZtmYSp8DXhnU5iMDWv/zH+MAOIa9XgnPMKzpfajrAxdtnqY
	+rsGBWDuuxM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D72123975;
	Wed,  3 Dec 2014 18:43:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7C7D23973;
	Wed,  3 Dec 2014 18:43:44 -0500 (EST)
In-Reply-To: <xmqqmw74uwx0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Dec 2014 15:38:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3818445A-7B46-11E4-B8FC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260714>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> The 14-patch series may have been internally consistent and its
>>> individual patches, when each of them was taken alone by itself, may
>>> have made sense, but it appears that the aggregated whole these
>>> separate topics took their root from is inconsistent with itself
>>> in minor ways like this here and there X-<.
>>
>> I don't follow.  It's normal for an API change to affect code that
>> uses the API --- what inconsistency are you talking about here?
>
> I was under the impression that the purpose of the series was to
> propose an API update to be used together with the remainder of the
> system, not just "update code in master, breaking unstated set of
> topics and leaving them behind without updating them for now".
> ...

About the "inconsistent with itself" bit.

The other topic is a piece from the long-ish series by Ronnie, and
somehow I had assumed this 14-patch series also originated from
another part of that series, especially given that it is largely
about refs.  That's where "itself" came from.

Looking at it again, this errno thing is more or less separate and
independent, so your "I don't follow" is perfectly understandable to
me now.  Sorry about being grumpy.
