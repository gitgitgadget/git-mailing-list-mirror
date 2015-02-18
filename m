From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Wed, 18 Feb 2015 11:08:34 -0800
Message-ID: <xmqqh9uj2g25.fsf@gitster.dls.corp.google.com>
References: <20150216054550.GA24611@peff.net>
	<20150216054754.GB25088@peff.net> <20150217104628.GA25978@peff.net>
	<xmqqsie4300s.fsf@gitster.dls.corp.google.com>
	<20150217182324.GA12816@peff.net>
	<xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
	<20150218185007.GA7257@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9zG-0006cE-9L
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbbBRTIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:08:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbbBRTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:08:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEA9F38473;
	Wed, 18 Feb 2015 14:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pRo2e6sy05EPgJrSdEWWNEneb/8=; b=CRX1VZ
	+e7UmzgdukbKsNVhGVql2utzHk978N/M9/WsI3n/UXAz2emavJgUgwzdTmoOvJBu
	odq/YvcNk1tRVSuz0cNuxLLRSGVN+MVRa+BCAGBaP1LfcTiAx4wJRmwqwzHCP/XI
	3IrcJ85IsBjivpyc22nuB+43nNmTGN3oFsuRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gMaBsF+53pxMGyO8dpTpzYdzsEIbRkbu
	U8saSsmIe/bt5rKRy1+zDehRBqOigfl8bZs5xhJ0T0wGf0tcgFpbt9VHKGfRqNAk
	qGS+3sX/AK1+alUKHPzb7b+dyFg3dxjnps3uFs0m3gAgx1RLj2Cj2BEun30eNWxN
	NeLMnxLNpeo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5F8A38471;
	Wed, 18 Feb 2015 14:08:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49A873846E;
	Wed, 18 Feb 2015 14:08:35 -0500 (EST)
In-Reply-To: <20150218185007.GA7257@peff.net> (Jeff King's message of "Wed, 18
	Feb 2015 13:50:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 898ABB78-B7A1-11E4-A079-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264049>

Jeff King <peff@peff.net> writes:

>> +	if (!strcmp(k, "push.followtags")) {
>> +		if (git_config_bool(k, v))
>> +			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
>> +		else
>> +			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
>> +		return 0;
>> +	}
>
> Did you have an opinion on sticking this behind a helper function?

Not very strongly either way.  Seeing the above does not bother me
too much, but I do not know how I would feel when I start seeing

	val = git_config_book(k, v);
	flip_bool(val, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);

often.  Not having to make sure that the bit constant whose name
tends to get long is not misspelled is certainly a plus.
