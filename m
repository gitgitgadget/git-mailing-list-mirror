Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EEB2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcGARXK (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:23:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752498AbcGARXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:23:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A001D294C4;
	Fri,  1 Jul 2016 13:23:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q0Ym3kgX5Nl39zbJ9ZDT+vzy1UA=; b=uQYJ32
	2Xg2/TsUq92aVaozwIyWXgWITqM7FE44uOJoeLzQNPEpS1q/hPgXJm9kLEECfAms
	dkYdfw2wjZH43PwTA478IOc2/T72vqSP4QFgWcJwhfzdKAY5rkhjW6wMBDmuhDgn
	8puQ82bInqojZCnjWZEFy4Wbme1QkZBk2R8NE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PXgG5A3hAoP06agmK7IUShoe2x7osKGj
	5MGSHqnHZXsAijA4M9oxMjuWPzoGXcSM76oeVzLsJ6UJKUk1y/lOp+8KyE7sS5Qr
	zF4wqzg4Y6DBIDyrAmcqE5I1G5YkNe2TteEuAdAz7tc4W7J+zMspQ5Edzi9r2TuI
	zPT0iwZ1eaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98E98294C3;
	Fri,  1 Jul 2016 13:23:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25C55294C0;
	Fri,  1 Jul 2016 13:23:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 1/5] t9300: factor out portable "head -c" replacement
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090753.GA17463@sigill.intra.peff.net>
Date:	Fri, 01 Jul 2016 10:23:05 -0700
In-Reply-To: <20160630090753.GA17463@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 30 Jun 2016 05:07:54 -0400")
Message-ID: <xmqqd1mxz30m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79CD1954-3FB0-11E6-908A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In shell scripts it is sometimes useful to be able to read
> exactly N bytes from a pipe. Doing this portably turns out
> to be surprisingly difficult.

I'd rotate the above by three words ;-).

    It is sometimes useful to be able to read
    exactly N bytes from a pipe. Doing this portably turns out
    to be surprisingly difficult
    in shell scripts.

>   - "dd bs=1 count=$n" fixes the partial read problem (all
>     reads are 1-byte, so there can be no partial response).
>     It does make a lot of write() calls, but for our tests
>     that's unlikely to matter.

It makes me wonder if it helps to use different ibs and obs if many
writes bother you, but because this patch moves us away from dd,
that is a moot point.

> That makes the perl solution the least bad (because we
> conveniently omitted "length of code" as a criterion).
> It's also what t9300 is currently using, so we can just pull
> the implementation from there.

;-).

The patch itself is good.
