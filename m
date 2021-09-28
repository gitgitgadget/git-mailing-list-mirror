Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94462C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D3360D42
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhI1AZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:25:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52995 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhI1AZw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:25:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEC26D976F;
        Mon, 27 Sep 2021 20:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCCbhTrLIw544Yi0mDQJ5jPvAoOCPYWr4ZPo83
        kToME=; b=w04B1XBf/vEsXeo9PTatw2+MHFT/4/jSUA8RmdHD+gY0vjf4tfzcQb
        eMuYEa3mnPEPtmqskiW6jQiyZlJpEHaZ7ZPDt0xzxYiDVsPLcuKThikuUAx6eral
        IrEY6xC99pWdVifSxGpDuzZkNEdJOiu7edx8VndDfODrVftym9+H0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6B2BD976E;
        Mon, 27 Sep 2021 20:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C7BCD976D;
        Mon, 27 Sep 2021 20:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
        <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
        <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
        <xmqqa6k1slxe.fsf@gitster.g>
        <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
        <xmqqo88eq8um.fsf@gitster.g>
        <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
Date:   Mon, 27 Sep 2021 17:24:11 -0700
In-Reply-To: <YVImeFHxY7hmb3wY@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 27 Sep 2021 16:15:52 -0400")
Message-ID: <xmqqee99mtsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 682D9A20-1FF2-11EC-A805-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Sure, but at that point, we'd probably want some quoting mechanism
>> for the literal to be compared, e.g.
>> 
>> 	[includeIf "env:PATH ~= \"(:|^)/usr/bin(:|$)\""]
>
> Ick. The extra quoting of the internal double-quotes is pretty horrid to
> look at. Also, how does one match a double-quote in the value? \\\"?

Ick indeed.  I didn't mean to say you must always dq quote.  It
started more like 

	includeIf "env:VAR == ' value with leading whitespace'"

(or use \" inside ""-pair to mean a double-quote) as a demonstration
of an escape hatch needed if we took your "let's by default strip
the whitespace around the value" example in the message I was
responding to.

Just like we in most cases do not have to quote the value in the
configuration files, unless you have strange needs like wanting to
express a value with leading whitespace that should not be stripped,
if we were to go this route, 

> If it were optional, that would make the common cases easy (no dq, no
> whitespace), and the hard ones possible.

Yup.
