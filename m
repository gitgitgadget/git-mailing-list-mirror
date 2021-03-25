Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC24C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0EC61A37
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCYSIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:08:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51406 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCYSIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 14:08:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6D72C64CF;
        Thu, 25 Mar 2021 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7isUX74eap6njjBLB/WuGlJ2NCo=; b=GkYFvn
        5hv3x3yUYWOPsM4m2goLmGRKRGXWVubpZ0ddvNEvJS4TAZKqluNL9XzDvZNCC93J
        WJG79m9+ayRd1Jm5k4FCQD4wA5yu05RuebnZy+47GQ35Ja1q+jA3TNyZAabVDiSW
        vhcchcxtdmEybnmSiwd27vyotqcU1vyzV9REA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jCJ0OdUfM/r5pGoH17VK8R5j68MBi9bt
        ictImJevcBjEeSjpdhsh5pcQgVq5cyGSeTV7Guk0GImA9d0yedbcJIEJUUR8fifo
        HiIeHqzESsquABgi1rNKU02CgJhwFqbYVdz5i1J/5MLojzd0+23hG7GgQLspInK2
        XeU11peAKwM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF1DEC64CE;
        Thu, 25 Mar 2021 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45D70C64CD;
        Thu, 25 Mar 2021 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
        <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
        <YCwJ8tORQg2Air4r@nand.local>
        <xmqqmtw3pzu3.fsf@gitster.c.googlers.com>
        <YCwhPG6RaAhU9ljg@nand.local>
        <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
        <xmqqsg4l3h32.fsf@gitster.g>
        <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
Date:   Thu, 25 Mar 2021 11:08:40 -0700
In-Reply-To: <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
        (Christian Couder's message of "Thu, 25 Mar 2021 08:53:04 +0100")
Message-ID: <xmqqr1k3w1g7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21491C28-8D95-11EB-AEF3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> > Any patch to relax how blank lines and other aspects of trailers
>> > parsing in my opinion should come with some documentation change to
>> > explain what we now accept and what we don't accept, and also tests to
>> > enforce that.
>>
>> OK.  But do we document clearly what we accept and we don't before
>> any change?
>
> Maybe it's not enough, but the doc already has the following:

OK.

The next step is to find out if there is anything unclear in the
description of the current behaviour in that paragraph that may have
resulted in the report of the "bug" that turned out to be a non-bug.

> ------
> Existing trailers are extracted from the input message by looking for
> a group of one or more lines that (i) is all trailers, or (ii) contains at
> least one Git-generated or user-configured trailer and consists of at
> least 25% trailers.
> The group must be preceded by one or more empty (or whitespace-only) lines.
> The group must either be at the end of the message or be the last
> non-whitespace lines before a line that starts with '---' (followed by a
> space or the end of the line). Such three minus signs start the patch
> part of the message. See also `--no-divider` below.
>
> When reading trailers, there can be whitespaces after the
> token, the separator and the value. There can also be whitespaces
> inside the token and the value. The value may be split over multiple lines with
> each subsequent line starting with whitespace, like the "folding" in RFC 822.
> ------

Thanks.
