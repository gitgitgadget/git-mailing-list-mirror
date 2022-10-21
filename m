Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B807C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJUXvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJUXvv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:51:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9F2B0913
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:51:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84D9C1C0B6B;
        Fri, 21 Oct 2022 19:51:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aShnPVYCHJ3U
        5r2yg2PrGO1ao1hssDqH47eRRnmutBI=; b=xysmcunGnk2911cNVgslavkPhmAR
        Z+O69kl5Y2jlkZYs6fHqMvNzf6rYS0NKLTdydBD2g3p0uFgOIfp0EbMB6zrJCtqz
        ud7DChSspXpxV6hmj7KYs1w2Lf4SbCK6+J6X7BItbgbXdP9772F6E09158DOXpo7
        jTVczEoYcsMXF0s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 723811C0B6A;
        Fri, 21 Oct 2022 19:51:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FF5F1C0B69;
        Fri, 21 Oct 2022 19:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jan =?utf-8?Q?Po?= =?utf-8?Q?korn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 1/4] repack: convert "names" util bitfield to array
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
        <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
        <Y1Mm9zTX3XwN3IWu@nand.local>
        <Y1MrXoobkVKngYL1@coredump.intra.peff.net>
        <xmqqfsfgiwcq.fsf@gitster.g>
        <Y1MumtN5fcCGD5+G@coredump.intra.peff.net>
Date:   Fri, 21 Oct 2022 16:51:44 -0700
In-Reply-To: <Y1MumtN5fcCGD5+G@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 21 Oct 2022 19:43:22 -0400")
Message-ID: <xmqq8rl8ivlb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51E447EC-519B-11ED-A91A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 21, 2022 at 04:35:17PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > Yeah, I actually considered writing it that way, but it felt a bit s=
illy
>> > to use _ARRAY for something which is clearly meant to be a single it=
em.
>>=20
>> You are not alone.  I updated R=C3=A9ne's coccinelle rules to refrain
>> from converting xcalloc() to CALLOC_ARRAY() for a single element
>> case exactly because it feels silly to use array function for a
>> singleton with 1c57cc70 (cocci: allow xcalloc(1, size), 2021-03-15).
>
> OK. Then I'll leave it as-is, then. :)
>
> -Peff

I do not think any "huh? array for a singleton" folks mind your

  #define CALLOC(x) CALLOC_ARRAY((x), 1)

though ;-)

