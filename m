Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0DC43462
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802176124B
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhDPStQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:49:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58271 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhDPStG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:49:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59486CF071;
        Fri, 16 Apr 2021 14:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LVKrLQG4aocy
        wlbvvZKP0mfxRwE=; b=oG1ORQgy9Wop0fqoj84SML2zBOiwKHOZBQk0C8fWuPkN
        7ZCpjEmAyLZFpiTD6SKNiM5qbLR0sHqA4uoXeZlZjN0pV7BHRe+eQbAmaoyQ1LSJ
        gZA1a62KozITtRxDPIhH9Sqnrme+Bf12AdfB67MeI0m6pLq220dEV+7Vuyr9JWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bMD+5k
        9pchMnuDJIMCkFJG91vitk3KAnh+xmXRH6pMCmozmVibSv5nMJXN2uh4XO0R5o0I
        a6qqZ5c5yLRgrDohpFThJWGd2fB9wnEAGVmxek+6aKWQ65U8fGHpGc7+0f6ApcGr
        AbQisZv3aXweUt0q1dqHx9NRDR3/5buz2Ft9w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F551CF070;
        Fri, 16 Apr 2021 14:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D28A8CF06F;
        Fri, 16 Apr 2021 14:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] transport: respect verbosity when setting upstream
References: <20210415123353.14686-1-oystwa@gmail.com>
        <CAPig+cSGDULOmqqpxe4b+r0ML-dMqjzgOjqgk++9E2oW-pz+9A@mail.gmail.com>
        <CAFaJEqvL4xaXZOxS_4vXf_0gqTXBMbEO_k7ozsioTmqEMs09kA@mail.gmail.com>
Date:   Fri, 16 Apr 2021 11:48:40 -0700
In-Reply-To: <CAFaJEqvL4xaXZOxS_4vXf_0gqTXBMbEO_k7ozsioTmqEMs09kA@mail.gmail.com>
        (=?utf-8?Q?=22=C3=98ystein?= Walle"'s message of "Fri, 16 Apr 2021 15:38:03
 +0200")
Message-ID: <xmqqk0p2m5fb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5CA1BAA4-9EE4-11EB-890A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> On Thu, 15 Apr 2021 at 17:29, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>
>> I wondered why you used `tee` here since it adds no value (as far as I
>> can tell), but I see that you copied it from the test preceding this
>> one. So... [intentionally left blank]
>
> Indeed, I wondered about that too; it seems a plain redirection will do
> the trick. But a mix of laziness and not second-guessing others' work m=
ade
> me leave it as it is.

Let's agree to mark it as #leftoverbits then?

Thanks for a fix, additional tests, and a good review.

