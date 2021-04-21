Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C8EC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2626113B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbhDUS5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:57:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54564 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243190AbhDUS5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:57:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F074D134664;
        Wed, 21 Apr 2021 14:56:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=inqiX2zVWIDT
        1gWbvboQ/GdJwPQ=; b=REjmabIGMmtM1BKIwoJ0h2B1AscIZxft8MFyr71ObWXR
        /Oc6OI2+yaookEpiNpUmfxf6X7u/vy8W4QqkpOxjwZdlObViRsrkCf/FHfN2Juv8
        +IV+PxiCEEUe0pDrTAwGKJ4d8rlLzXkbLLjWMPx3p8kHTM8wMReYjXcyAJy9hHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Eo0PBo
        +DrzQvKxlP7+54tj3NcModOHt0y6Idf6dPtPsuzY5Vj0gjuSocWKwTWE6oaMzG2H
        LFgBsTuhFPEasYj4J4GFdBgLhV5R9qHD4qU4sNKJYOQ3XLk43AnxXkRBiQtbUS8M
        wcb5zcFrlXZnFIfx6goaol5nbQomxE/T//f1o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E85C4134663;
        Wed, 21 Apr 2021 14:56:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 38D56134661;
        Wed, 21 Apr 2021 14:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/12] check-non-portable-shell: check for "test
 <cond> -a/-o <cond>"
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
        <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
        <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
        <xmqqwnsw3872.fsf@gitster.g> <87r1j42ffz.fsf@evledraar.gmail.com>
Date:   Wed, 21 Apr 2021 11:56:22 -0700
In-Reply-To: <87r1j42ffz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 21 Apr 2021 10:46:08 +0200")
Message-ID: <xmqqtunzxy95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44E392A0-A2D3-11EB-A080-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Applying your suggestion results in these false positives:
> =09
> 	t4038-diff-combined.sh:135: error: "test A && test B" preferred to "te=
st A -a B": git commit -m "test space change" -a &&

This is utterly amusing.  Consider the suggestion withdrawn.
