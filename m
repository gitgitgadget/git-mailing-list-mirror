Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB03BC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhKWUUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:20:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60577 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhKWUUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 15:20:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E528C15E083;
        Tue, 23 Nov 2021 15:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c/nvVlvkw7QL6kEs8b6cwZS/mAWWxPqfX2/KjC
        CpNnM=; b=Uuo/Rz6wj5BydwzdKx2W/UmmcWKbrLV2lt6HhLjLxSD/EuP94yq4dO
        Bb1NWPvRRmV5PayDZm1+jNwxmbQNpMQJUsME5652U7zl6ckmmTw/y2k5ihh9AJ76
        tLyhYRIeEOXCy/FnmnYtktjFJYr4HHEilCNJPgFIW1jwRR1EP3Luk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD32415E082;
        Tue, 23 Nov 2021 15:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B96015E080;
        Tue, 23 Nov 2021 15:17:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 supporty
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
        <20211114211622.1465981-2-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
        <xmqqk0h7423v.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
        <xmqq1r38hzi9.fsf@gitster.g>
        <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
        <xmqq8rxgf254.fsf@gitster.g> <xmqqv90jewwa.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet>
        <xmqqwnkzdepm.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111231331530.63@tvgsbejvaqbjf.bet>
Date:   Tue, 23 Nov 2021 12:17:42 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111231331530.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 23 Nov 2021 13:32:44 +0100 (CET)")
Message-ID: <xmqq8rxe8w49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A45AC38-4C9A-11EC-B436-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 22 Nov 2021, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> But if we were to do so, perhaps we'd want something like what I
>> >> gave at https://lore.kernel.org/git/xmqqy25lwa86.fsf@gitster.g/ in
>> >> its place to avoid confusing people.
>> >
>> > That sounds like a good course of action to me.
>> >
>> > Please note that the MSVC-related adjustment of the `FLEX_ARRAY` block is
>> > still needed, I think.
>>
>> The "something like what I gave ... to avoid confusing people" patch
>> is following up on the direction to drop the patch with -std=gnu99
>> change.  IIRC, your MSVC adjustment was to tweak that patch we were
>> discussing of dropping, so even if it is still needed, it won't be
>> part of what I was doing.
>
> I thought we were only dropping the `--std=gnu99` part, not the change to
> the `git-compat-util.h` header file, nor the patch to the CMake
> configuration for MS Visual C.

Ah, yes, I think these parts need to be kept.  I am just dropping
the latest iteration with -std=gnu99 from consideration to merge
down to 'next' and below.

