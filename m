Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67CC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B92610E8
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 22:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhI0WOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:14:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60334 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhI0WOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 18:14:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3866FEB374;
        Mon, 27 Sep 2021 18:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gQzzQE8cPAFb
        eB7YjZFagiDXWh8Vy1WMxumKOVpfRh4=; b=okDC4qGHCd5GmFYwcH79n3vFXaf3
        nvLFfRIIh5m9SzvMqfNvCgYHrvXnKId8ATMIDacW55AOJam58/UZAJxWFnpLcI5r
        acEKEhgUtQ4tmfOuD7wOdOwKFPJmOkfxpcIlo9n4sfq342IHIuwe2utcC/hZi1tm
        VPYvR1j2YjOdGeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F9D7EB373;
        Mon, 27 Sep 2021 18:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96ED8EB372;
        Mon, 27 Sep 2021 18:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/5] urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
        <patch-v2-3.5-3783788b553-20210927T125715Z-avarab@gmail.com>
Date:   Mon, 27 Sep 2021 15:12:38 -0700
In-Reply-To: <patch-v2-3.5-3783788b553-20210927T125715Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 27 Sep
 2021 14:58:43
        +0200")
Message-ID: <xmqq8rzhoeg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 073F70D8-1FE0-11EC-9A36-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -575,11 +575,10 @@ static int get_urlmatch(const char *var, const ch=
ar *url)
>  	int ret;
>  	char *section_tail;
>  	struct string_list_item *item;
> -	struct urlmatch_config config =3D { STRING_LIST_INIT_DUP };
> +	struct urlmatch_config config =3D URLMATCH_CONFIG_INIT;

While I think this is much easier to follow than the original, I am
not quite sure about the removal of these explicit _assignments_ in
code, like this ...

>  	config.collect_fn =3D urlmatch_collect_fn;
> -	config.cascade_fn =3D NULL;
>  	config.cb =3D &values;

and this ...

>  	config.section =3D "credential";
> -	config.key =3D NULL;
>  	config.collect_fn =3D credential_config_callback;
> -	config.cascade_fn =3D NULL;
>  	config.select_fn =3D select_all;

and this ...

>  	config.section =3D "http";
> -	config.key =3D NULL;
>  	config.collect_fn =3D http_options;
>  	config.cascade_fn =3D git_default_config;
> -	config.cb =3D NULL;

as they have documentation value (e.g. "for this invocation I do
want to use no cascade_fn" is a statement worth making, by having
it next to the assignment to .collect_fn member).

