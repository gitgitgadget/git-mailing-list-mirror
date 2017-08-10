Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05FFA208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdHJSm2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:42:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752504AbdHJSm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:42:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C742988F3;
        Thu, 10 Aug 2017 14:42:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oVow1G9LzS0VDW1y0u7ziijsWfA=; b=cXBEBX
        OFB/XWsnuP6ZXOaCAxwPEgfJ/PqD35GJO/ZuIN34Wbybc3qrg3JZbEyLxu+ZTpsv
        utHXf7axeeGHZtUFqRfNt+HqV2/yX+wqEO3n3EI4XdtQzQHbSp0UkKK8mBXiT4+7
        9/HceJLzK5Z5e2OGkZOfFbITJ5sNDStcuM9vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=beWxkhrj73nso4G7D7SFGjaZ1Pdc294D
        2jvyb2XdeYwv1hZQ6mZWX0EV9PScXZXci/gTSHIJHc2q7S7M6IyRwg4Qw1JIBqc+
        KuZEwAL7EEknXuGzyqa+S6823ySdO5ysp1svbeDi75JyO9k1bIukbvX0lw5xEfWc
        RuWA4dvzVrI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 556DF988EF;
        Thu, 10 Aug 2017 14:42:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C26B9988EE;
        Thu, 10 Aug 2017 14:42:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
        <xmqq60dw7j5u.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xoifkJyH34Q0NJdE_=UzWK1SA+2gwyXrHpF7Sv2PBHATQ@mail.gmail.com>
        <20170810072822.rj6y6zcqhyfz4yi7@sigill.intra.peff.net>
Date:   Thu, 10 Aug 2017 11:42:18 -0700
In-Reply-To: <20170810072822.rj6y6zcqhyfz4yi7@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 03:28:22 -0400")
Message-ID: <xmqqd1834645.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3E5ED1C-7DFB-11E7-8308-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > The above example made me wonder if we also want a format specifier
>> > to do the above without piping, but it turns out that we already
>> > have "log --format=%(trailers)", so we are good ;-)
>> 
>> I was going to say, I thought we had a way to get trailers for a
>> commit via the pretty format, since that is what i used in the past.
>
> I do like that you could get the trailers for many commits in a single
> invocation. That doesn't matter for my current use-case, but obviously
> piping through O(n) interpret-trailers invocations is a bad idea.
> But there are a few difficulties with using %(trailers) for this,...

I think it is clear to you, but it may not be clear to others, that
I did not mean to say "because 'log --format' already knows about
it, this change to interpret-trailers is unnecessary".

> For (1) I think many callers would prefer to see the original
> formatting. Maybe we'd need a %(trailers:normalize) or something.

Thanks; that is exactly the line of thought I had in the back of my
head without even realizing when I brought up %(trailers) format
element.
