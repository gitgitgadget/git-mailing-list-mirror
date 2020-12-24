Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2814BC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 14:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F152D22287
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgLXOPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 09:15:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60218 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXOPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 09:15:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A986A110F56;
        Thu, 24 Dec 2020 09:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=eFXklQsGAzrbhgPUWCgHaheTe8M=; b=mX5UTnb+/qiHYKASOXCf
        JhUGGx5+sJpbm1EZ1cMj6W3Ox64YeaQ6tjc9Pej+2xiZSXMGbg8sXJR6+MZhAjIW
        p2Z2gyQR9oIFoFlH27YDvryeELpWKZshGUqqJ979HL+fUhaTrhtv7E0RxI8pOP3y
        gby5aKm7x1mUjv80BOUz4EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=l/ekBsPjBrWyChpeuZs+cdBEL8+Y3atL85lcDoYpXE5wkO
        XzwBGzPa9ZyH6rFqCxfrIL18TAwZQnUBhNHUi4qklidnOPC5aNF/tKlhXpeCnAnJ
        wTdsM1cHmKyx1vWGd+aTgC3NTIWk6E115eJu0WwhTgmRyKa9l1RG2ydPDGwc8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FE75110F55;
        Thu, 24 Dec 2020 09:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7A76110F53;
        Thu, 24 Dec 2020 09:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
        <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
        <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
        <20201208201256.GK36751@google.com>
        <xmqqsg8g559i.fsf@gitster.c.googlers.com>
        <xmqqh7ow54eb.fsf@gitster.c.googlers.com>
        <CAP8UFD2mrgympQ0tbhty+cgZ7ow_+bsxE8gm1Wsn_mo+a6sq2Q@mail.gmail.com>
Date:   Thu, 24 Dec 2020 06:14:23 -0800
Message-ID: <xmqqczyz2sw0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54102902-45F2-11EB-90AF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I wonder if it is a good direction to go to run the tests with the
>> "set -e" option on, and accept its peculiarities.
>
> Another solution could be to define a command_not_found_handle
> function as bourne shells should call that.

I am reasonably sure it is bash-ism and a rather stale stackexchange
question seems to say that command_not_found_handler function (note
the 'r' at the end) is its equivalent in zsh.

Having said that, we already have other bash-specific debugging
support in our test harness, and it may not be a bad idea to use the
facility to catch these bugs, even if the support is available only
when running the tests under bash and no other shell.

> By the way it's not the first time we get such an issue, see:
>
> https://lore.kernel.org/git/CAP8UFD15+p+xKwJ=B9WVsrc+2TvLHKmu78SBCLUFZVSYoTtbbg@mail.gmail.com/

Excellent memory.  Thanks.
