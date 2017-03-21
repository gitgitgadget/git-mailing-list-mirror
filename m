Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5E42096C
	for <e@80x24.org>; Tue, 21 Mar 2017 20:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933142AbdCUUQx (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 16:16:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53452 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933119AbdCUUQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 16:16:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEB2B68E3E;
        Tue, 21 Mar 2017 16:16:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MMwgLP8fyY/ptBVNPStvaYJsJqg=; b=jbna59
        L8Ux3MBUPZL0m06YcNYO4MBFJtCvKD4JFgeUxiLerkmCNOw/moBCDTFN3jjkDe+s
        M3yrktNqXFJSzeYHzd2semtAUUCQ50xqXblBYO7LGn2BIZolHQJBTwSvsCYUuneQ
        bymPrsrJw6BNCWjIO6sweq5fxDNhPGGFWmm4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VXAnwY6JC5rvHQLbNXms6lIdhZk/nkGn
        FW/ZFGhUQ3Pxp4Jh82h2ZH0WpO8ws+G9DU2D+fq/yOMSld1wcqVDM1vQUkRri6l7
        SdfA1rcA0FGD9U4pEjzA1Ikohmx+9d7Ws+oV2WtWLVxI0YUS27i5n+2eoptoEUq6
        S+9AKQ4UQQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5E7268E3D;
        Tue, 21 Mar 2017 16:16:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AB7668E3B;
        Tue, 21 Mar 2017 16:16:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: USE_SHA1DC is broken in pu
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
        <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
        <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
        <alpine.DEB.2.20.1703212105030.3767@virtualbox>
Date:   Tue, 21 Mar 2017 13:16:29 -0700
In-Reply-To: <alpine.DEB.2.20.1703212105030.3767@virtualbox> (Johannes
        Schindelin's message of "Tue, 21 Mar 2017 21:09:42 +0100 (CET)")
Message-ID: <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4520571A-0E73-11E7-A3C5-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 17 Mar 2017, Lars Schneider wrote:
>
>> > On 17 Mar 2017, at 11:18, Lars Schneider <larsxschneider@gmail.com>
>> > wrote:
>> > 
>> > Would it make sense/have value to add a job to our TravisCI build [1]
>> > that compiles Git in a few variations with some high profile switches
>> > such as USE_SHA1DC? Running all the tests for these variations would
>> > probably take to long but just compiling would be less than 2min per
>> > variation.
>> 
>> ... or just run individual tests instead of the entire test suite for
>> these variations (e.g. only t0013 for the USE_SHA1DC variation).
>
> The best solution may be to open a PR with .travis.yml patched to enable
> this flag. And then report back to he mailing list because the gentle
> people here are not that used to paying attention to Continuous Testing
> :-D

Actually, the best solution may be to do nothing ;-)  With the
current incarnation parked in 'pu' (or I may have already merged it
to 'next'), without any explicit VARIANT_SHA1 request to $(MAKE), we
default to use the DC_SHA1 variant.

Those who are paying attention to Travis would have noticed this by
now, I thought ;-).
