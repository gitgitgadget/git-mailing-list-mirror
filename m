Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A85E1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763722AbcINTaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:30:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56455 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760199AbcINTaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:30:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC7D03E7AD;
        Wed, 14 Sep 2016 15:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AGjB4QMcfQUgucRZ8UEClTMVROY=; b=GQDYQC
        GNFoq1OZIo7B1GXbsOfXpHfzxivlH8iO5RMAc8ckohpBbpsBFoitGPNVkW4cxsc5
        CAvFqOUVXjcQ/e/sqDSLd+XX9upMVTWHPxkGcIioG+6E8gk1u/6AA9N0UjaxfJIh
        IAgJlF1jHQpGneQRRwkjLQ6sA7TnvAnfhyRuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uO0z+I9yP5NuWH2RHB6r0teebUHpuKcx
        sR/9WnmAyOcfqzwIaSugdkQo7BN/f+nc43WhiqGzd9zJ+rW2SRP1F7vv6WDfHD3y
        rCtDWhLynKpuHnzA3yYN4T8wXkFPi0icKJI6udbzbZtkD7wcl1tJ5GyOSUI6Uf9B
        TulRWODYtgE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4E6E3E7AC;
        Wed, 14 Sep 2016 15:30:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53F803E7AB;
        Wed, 14 Sep 2016 15:30:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
        <20160913234612.22806-1-me@ikke.info>
        <20160913234612.22806-2-me@ikke.info>
        <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
        <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
        <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
        <20160914160308.GB26893@ikke.info>
        <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
        <20160914191759.5unwaq2eequ4pifr@sigill.intra.peff.net>
Date:   Wed, 14 Sep 2016 12:30:06 -0700
In-Reply-To: <20160914191759.5unwaq2eequ4pifr@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Sep 2016 12:17:59 -0700")
Message-ID: <xmqqfup2qny9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A55E70EA-7AB1-11E6-8C59-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 14, 2016 at 10:43:18AM -0700, Junio C Hamano wrote:
>
>> I think we can go either way and it does not matter all that much if
>> "mailinfo" changes its output or the reader of "mailinfo" output
>> changes its input--we will either be munging data read from "From:"
>> when producing the "Author:" line, or taking the "Author:" output by
>> mailinfo and removing the quotes.
>
> Yeah, that was the part I was wondering about in my original response.
> What is the output of mailinfo _supposed_ to be, and do we consider that
> at all public (i.e., are there are other tools besides "git am" that
> build on mailinfo)?
>
> At least "am" already does some quote-stripping, so any de-quoting added
> in mailinfo is potentially a regression (if we indeed care about keeping
> the output stable).

Another small thing I am not sure about is if the \ quoting can hide
an embedded newline in the author name.  Would we end up turning

	From: "Jeff \
            King" <peff@peff.net>

or somesuch into

	Author: Jeff
        King
        Email: peff@peff.net

;-)

> But if we are OK with that, it seems to me that mailinfo is the best
> place to do the de-quoting, because then its output is well-defined:
> everything after "Author:" up to the newline is the name.

There are other things mailinfo does, like turning this

	From: peff@peff.net (Jeff King)

into

	Author: Jeff King
        Email: peff@peff.net

and

	From: Uh "foo" Bar peff@peff.net (Jeff King)

into

	Author: Uh "foo" Bar (Jeff King)
        Email: peff@peff.net

So let's roll the \" -> " into mailinfo.

I am not sure if we also should remove the surrounding "", i.e. we
currently do not turn this

	From: "Jeff King" <peff@peff.net>

into this:

	Author: Jeff King
        Email: peff@peff.net

I think we probably should, and remove the one that does so from the
reader.

