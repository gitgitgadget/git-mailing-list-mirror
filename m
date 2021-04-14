Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E8C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C6661155
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhDNVNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:13:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54964 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDNVNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 17:13:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 982A112D05D;
        Wed, 14 Apr 2021 17:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eJabNivL+bm3
        Wn0JFtk0v4YXtYc=; b=PprE1amnvPmTVwQ64Ha9wJM11tuS2J5dk2AvvDD7MmKk
        rhLVaonX4n4b0hZ/Q3oQLF+PkqKI6XHaxd+y/WcXNWqVmHvPhJOGyL/UoeKNYYHR
        11PI1txLW+C0Bv5N5Z2ceCbvITvNBCE3UCWoxepoC41HvgQo9EAaHcjeg4Iz+0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SQI63v
        yQU9KPe9jPeQn+hH5Y60lVNQfxZmVwxdhU8EIptPCXZIVfOJyZi1DdLBIRotWsXT
        +pFSBoIqrBmcaMlzLx90flTxZmLncCTipCzcED1N+RH10HEkHvCHjXj6mDh4FY7W
        n5DhLMhs6Cj0vrFkyOxSD/wioiLZdr7foGDFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90A7612D05B;
        Wed, 14 Apr 2021 17:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7D2012D058;
        Wed, 14 Apr 2021 17:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Sam Bostock <sam.bostock@shopify.com>,
        Git List <git@vger.kernel.org>
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
        <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
        <87sg3t16ec.fsf@evledraar.gmail.com> <87pmyxjcnz.fsf@igel.home>
Date:   Wed, 14 Apr 2021 14:12:57 -0700
In-Reply-To: <87pmyxjcnz.fsf@igel.home> (Andreas Schwab's message of "Wed, 14
        Apr 2021 14:03:44 +0200")
Message-ID: <xmqqim4oy3hi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 305A34D2-9D66-11EB-ADCE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Apr 14 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Nothing in git itself actually needs this remote HEAD past clone time,
>> and with 4f37d457065 (clone: respect remote unborn HEAD, 2021-02-05)
>> there'll be even less reason to pay attention to it.
>
> Isn't that what git rev-parse origin resolves to?

Correct.

And that is why refs/remotes/origin/HEAD is defined to point at the
branch that the owner of LOCAL repository considers is of interest,
which may not be the same as what the owner of the REMOTE repository
thinks is the primary branch in their worldview.


