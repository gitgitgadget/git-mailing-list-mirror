Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B581FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbcLEUFO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:05:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63089 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751581AbcLEUE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:04:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F78A54C62;
        Mon,  5 Dec 2016 15:04:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=82DDqS/3zanBkT4nMCX7cPGrj98=; b=TvOkRC
        xhuCH1KjMIi2K5H7YSdLKA/czP3olJG+gQqMP5KNS7F02i7gFu+BRjpceWe1qfgv
        u+0/0lux695N3NjdSAbcp8GRzu70nGmlCfpR8bBsTIKtvAq3m7lzPrW5yDgUq/1O
        IL9fJoBx/zWpB9bE3CTofwneajw7t95Njq+z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f9tbdwvHgjkA37/h3zR/tHucEY3w3vl5
        SXLTZk7Sz0VcAGhBj1N3m4qtiXNa+WTGGcI8UUNnXwJf4BzNMQm0LyALGKa3lv6C
        kgmu/8biMsmODPWhUsXrvxHPF+WQ8c8hjqpqESwmEWL6SF+KnIYrsj6pScWVMsAj
        88Z504gzVoU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 257E454C61;
        Mon,  5 Dec 2016 15:04:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78FD054C60;
        Mon,  5 Dec 2016 15:04:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to is_transport_allowed
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
        <1480623959-126129-1-git-send-email-bmwill@google.com>
        <1480623959-126129-5-git-send-email-bmwill@google.com>
        <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
        <20161201230738.GJ54082@google.com>
        <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
        <20161201235856.GL54082@google.com>
Date:   Mon, 05 Dec 2016 12:04:52 -0800
In-Reply-To: <20161201235856.GL54082@google.com> (Brandon Williams's message
        of "Thu, 1 Dec 2016 15:58:56 -0800")
Message-ID: <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16204B46-BB26-11E6-9117-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 12/01, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> > I started taking a look at your http redirect series (I really should
>> > have taking a look at it sooner) and I see exactly what you're talking
>> > about.  We can easily move this logic into a function to make it easier
>> > to generate the two whitelists.
>> 
>> OK.  With both of them queued, t5812 seems to barf, just FYI; I'll
>> expect that a future reroll would make things better.
>
> Yeah I expected we would see an issue since both these series collide in
> http.c
>
> I'm sending out another reroll of this series so that in Jeff's he can
> just call 'get_curl_allowed_protocols(-1)' for the non-redirection curl
> option, which should make this test stop barfing.

I was hoping to eventually merge Peff's series to older maintenance
tracks.  How bad would it be if we rebased the v8 of this series
together with Peff's series to say v2.9 (or even older if it does
not look too bad)?

