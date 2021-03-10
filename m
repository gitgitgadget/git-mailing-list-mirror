Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41603C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BED064FC9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCJWZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:25:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59357 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhCJWYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 17:24:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9755A123D99;
        Wed, 10 Mar 2021 17:24:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MP9qOFulIq9r
        +JbW1SEj8P+XeRc=; b=uhIS0UfmpuUJx+vzZWmsuarf1s6PAj6Rw6tg3R5bZt3t
        qP8bQj4hXs59AmWVFtPELlMYnpJ5hxmTgx8E37wWVjity9i26rSUDF6WbJOInb0R
        cumJziVZt0BY/NRWaJvafDycJ6Y7F4A2CqIBJIXL/YjH1LrJUl+m4df1MjPo1Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NiDO3R
        7xs1v9Kzjv1DRvy7Kghs9oUvAgV8vtY5Sqe090ztB4p9+ZqgpBua6iS95ooOnp75
        ptmirUC9EZfoWz7DnP5V7dADxPGHnKFmDqfjod0I8Gufrqv0uWcpJtRl7Aifv9io
        rvtbYjJMsJ4gA7W0P095miiysNiNrHKLTdQnU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D2A2123D98;
        Wed, 10 Mar 2021 17:24:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA533123D97;
        Wed, 10 Mar 2021 17:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] sha256 fixes for filter-branch
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
        <20200729231428.3658647-1-sandals@crustytoothpaste.net>
        <8735x3i59m.fsf@evledraar.gmail.com>
        <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
        <CABPp-BH9epFANH15Om4095PHZTkNSAgV9o2cr5OD0vc0yWGMVg@mail.gmail.com>
Date:   Wed, 10 Mar 2021 14:24:38 -0800
In-Reply-To: <CABPp-BH9epFANH15Om4095PHZTkNSAgV9o2cr5OD0vc0yWGMVg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 10 Mar 2021 09:54:37 -0800")
Message-ID: <xmqqlfauir4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6774872A-81EF-11EB-8D0F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> =C3=86var successfully nerd sniped you.
>
> ...and sucked me in too, since I went through and read your patches.
> :-)  They look good to me.

Yup, thanks, both.
