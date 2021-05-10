Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A7C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92D7613E1
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJG0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 02:26:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58889 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJG0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 02:26:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAE36141253;
        Mon, 10 May 2021 02:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=24ENRoUBMNXi
        lsygNzHKC37tYfy8k1Ao64PwFuqEua0=; b=VJ5505flJHi3N53SLZCJQl8HSlk5
        fOfJjwhYYCbiOj/E2zVOjMA2dwdtxWsss++WQqZZODcX00qbu0bjQAliM0bcJW/r
        +nzdwz7G0ugi8VtzDUTU6tz7mKv6JKEqlgUHkZ9w45XD8l+RIsoq8ubh/OfbZ5G4
        qzI+MjtXiR9EebI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3673141252;
        Mon, 10 May 2021 02:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5DE0141251;
        Mon, 10 May 2021 02:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
        <20210509213217.449489-1-lenaic@lhuard.fr>
        <20210509213217.449489-2-lenaic@lhuard.fr> <YJiKXRywBhhGXC5Q@danh.dev>
        <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
Date:   Mon, 10 May 2021 15:25:07 +0900
In-Reply-To: <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 9 May 2021 22:48:17 -0400")
Message-ID: <xmqqtunbqf5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77BB153E-B158-11EB-AE72-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I think others have strong opinion on not using "%1$s",
>> and prefer simple "%s" and using "exec_path" twice instead.
>
> I brought it up only because I hadn't seen it in Git sources, and
> wasn't sure if we'd want to start using it. Aside from =C3=86var, who
> seemed reasonably in favor of it, nobody else chimed in, so it could
> go either way, I suppose.

If this were a piece of code that _everybody_ would use on _all_ the
supported platforms, I would suggest declaring that this is a
weather-balloon to see if some platforms have trouble using it.  But
unfortunately this is not such a piece of code.  Dependence on
systemd should strictly be opt-in.

So my preference is

 - here, just do it in the dumb and simple way

 - somewhere else, find code that is compiled and run for everybody
   on all platforms that feeds two same arguments to printf format,
   and update it to use "%1$x" twice, mark it clearly as a weather
   balloon, and document it (see how what 512f41cf did is documented
   in Documentation/CodingGuidelines and mimick, but tone it down as
   we haven't declared it safe to use (yet).

It is likely that we need rearrangement of argument order for po/
files anyway, but a misimplementation might not handle using the
same placeholder twice, and that is why I'd like to be a bit extra
careful.
