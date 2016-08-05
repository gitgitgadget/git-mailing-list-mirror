Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475CB2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423832AbcHESl7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:41:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937426AbcHESly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:41:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5DBB3085E;
	Fri,  5 Aug 2016 14:41:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYnWUkSRZRw/70/k82c6A4oK+gs=; b=VX1XVp
	6R2WKn0ffoSS7zEoKhjT16SArn97dE7txHZiz52FKqcvtDrkUTjc8Nz+GJjMwAP4
	RLI1yuvTEHohR3Va1JsazSvDg0hN4DHt2WsA520kZZcrdRxcme2xxVMSzw/SzbuV
	fYPq3XUfB30ClRuKmjX0MtwvW0HHRPBYTtaKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aH+9k6LfWuDlMEmLPO4tpx+ui+9+hdTm
	xJ2Hj06II9Lh2Amngj9HmmU9HRguN2t3E+VPQhp2LVVkaSmnGXVVJqtfpjUKqOPX
	iobxf7WYoTkZgL0pJeSxRk6yQcKiCr10S0dxAIpoFc/qdI2yBjck3BoEOiwNnr0/
	tom4EOcyCgk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CBD353085D;
	Fri,  5 Aug 2016 14:41:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 555DF3085C;
	Fri,  5 Aug 2016 14:41:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	git <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] trace: use warning() for printing trace errors
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
	<20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net>
	<xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
	<20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net>
	<xmqqy44cz0k6.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3hvrrwmnyF0PLreAos62hN_1W4bwYV9toMQ-vQQ6rgog@mail.gmail.com>
Date:	Fri, 05 Aug 2016 11:41:50 -0700
In-Reply-To: <CAP8UFD3hvrrwmnyF0PLreAos62hN_1W4bwYV9toMQ-vQQ6rgog@mail.gmail.com>
	(Christian Couder's message of "Fri, 5 Aug 2016 09:59:22 +0200")
Message-ID: <xmqqwpjvvz0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46B25C9E-5B3C-11E6-9944-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Aug 4, 2016 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> I wondered if that would then let us drop set_warn_routine(), but it
>>> looks like there are other warning() calls it cares about. So that would
>>> invalidate the last paragraph here, though I still think converting the
>>> trace errors to warning() is a reasonable thing to do.
>>
>> Yes.  That is why tonight's pushout will have this series in 'jch'
>> (that is a point on a linear history between 'master' and 'pu') and
>> tentatively ejects cc/apply-am topic out of 'pu', expecting it to be
>> rerolled.
>
> Ok, I will reroll soon with Peff's suggested changes.

Thanks.
