Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65213C4708B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 15:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA63613E4
	for <git@archiver.kernel.org>; Mon, 24 May 2021 15:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhEXPzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 11:55:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54036 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhEXPxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 11:53:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FCC013C4FB;
        Mon, 24 May 2021 11:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=hFG9wjDEfabrvYek/c5cxuT3F
        FiiF0EXRPQJiMuR9ak=; b=BCSeI9afwhCH5cho56dkzZJQ4nhkz/CpbSEzPuph6
        oCpXtQySlQ38nxpS+/RgSnc30czW732bWRFoetvLBGxC9l+OxB5dZZH2tlu3aenJ
        FKl24hutvBcXef1wGbJaC65l2j0tOCn71V8vl3o6CWS80UyDa82j8E3dVstvVQdF
        mE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 386DE13C4FA;
        Mon, 24 May 2021 11:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6008F13C4F6;
        Mon, 24 May 2021 11:51:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on Linux
References: <20210509213217.449489-1-lenaic@lhuard.fr>
        <20210520221359.75615-1-lenaic@lhuard.fr>
        <20210520221359.75615-5-lenaic@lhuard.fr>
        <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
        <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
        <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
        <60aaa09aebce4_454920811@natae.notmuch>
        <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
        <87wnrooa17.fsf@evledraar.gmail.com>
Date:   Tue, 25 May 2021 00:51:53 +0900
Message-ID: <xmqqim38jfja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6FAF2EC-BCA7-11EB-9E10-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Personally I don't care whether someone submits a patch where their
> commit message discusses an example of "he", "she", "they", "it" or
> whatever. It's just meant as an example, and not some statement about
> what the gender (or lack thereof) of such a user *should* be.
>
> It's immediately obvious what the author meant in this case, and that
> the particular wording is arbitrary. For the purposes of discussing the
> contribution it matters whether it's unclear or ambiguous, which it's
> not.

Nicely put.  Thanks.
