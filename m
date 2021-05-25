Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14109C47086
	for <git@archiver.kernel.org>; Tue, 25 May 2021 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E0B6135F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 08:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhEYIJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 04:09:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54853 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhEYIJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 04:09:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5495CD827;
        Tue, 25 May 2021 04:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wv9CSH4hOcYM
        ls2In+UKQb9sqoT0ZDwU2FZf/MOsV2M=; b=lXIT/DCqFfxrC3tZZcMg7mRnH1xV
        zoQzPcQs8tePhlf+bkrNK4vc8TRfLiwfkVQ3eBwvWxb88xcxBDNzcQv+DoyjquLX
        66HofxplkIzg+/lxGNcUXPwOQnPO2GxhKGngZas8B/HaxZNWfsHvoVpzdjUnlrkO
        TcAS8wb9xTAtif0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80D51CD825;
        Tue, 25 May 2021 04:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85368CD824;
        Tue, 25 May 2021 04:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqn?= =?utf-8?B?biBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/4] maintenance: introduce ENABLE/DISABLE for code
 clarity
References: <20210520221359.75615-1-lenaic@lhuard.fr>
        <8e013441-08dc-fbb5-f9b9-649b2ffd78db@gmail.com>
        <YKudvp0m3m+Yi1+m@danh.dev> <9164987.SKD4A0viWJ@coruscant.lhuard.fr>
Date:   Tue, 25 May 2021 17:02:06 +0900
In-Reply-To: <9164987.SKD4A0viWJ@coruscant.lhuard.fr> (=?utf-8?B?IkzDqW5h?=
 =?utf-8?B?w69j?= Huard"'s
        message of "Tue, 25 May 2021 09:18:09 +0200")
Message-ID: <xmqqa6ojfdhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 802C0178-BD2F-11EB-BF21-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> I think the reason why the code looks worse is because I used an enum a=
nd I=20
> didn=E2=80=99t want to make any assumption about how the enum members w=
ould be=20
> evaluated in a boolean context.
>
> Do you think it would make sense to drop the enum type, to revert all l=
ogic=20
> changes (Use `if (enabled)` back instead of `switch`, etc.), and to def=
ine the=20
> following constants=E2=80=AF:
>
> static const int DISABLE =3D 0;
> static const int ENABLE =3D 1;
>
> so that we can keep function invocation in the form of=20
> `launchctl_boot_plist(DISABLE, filename, cmd)` ?

I think the code is much better off without DISABLE/ENABLE at all.

As has already been pointed out, you cannot read and write _without_
being aware of the fact that DISABLE is 0 if you want to write
readable code, i.e. instead of "if (able =3D=3D ENABLE) do this;", you
would want to say "if (able) do this;".

