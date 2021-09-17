Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D29C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657F761244
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhIQRUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:20:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65373 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhIQRUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 13:20:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63CB91571F1;
        Fri, 17 Sep 2021 13:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bMt4iulEypjx
        5mOdGDYy75DAiK6Pq2zvda94m0heKxc=; b=iyqby8RyQojlr8yS3ptnJGGA4TM8
        fKIMrgoLMNMmBE4/NORgVdu2os/9+DsJp6whoUMI2DgLf3BwUq+uDvx2MhbWlPBJ
        l1kaDGZUD0DmyMSCCIG7UJWCn9OZ5MgbGN11AvgEAmhlrwG1yBxTjHNZw6FVMxfA
        BiO//39bVLvUvOQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B81E1571F0;
        Fri, 17 Sep 2021 13:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BF5BA1571EC;
        Fri, 17 Sep 2021 13:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/5] environment.c: remove test-specific
 "ignore_untracked..." variable
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
        <patch-v2-2.5-57290842f0f-20210916T182918Z-avarab@gmail.com>
Date:   Fri, 17 Sep 2021 10:19:10 -0700
In-Reply-To: <patch-v2-2.5-57290842f0f-20210916T182918Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 16 Sep
 2021 20:30:33
        +0200")
Message-ID: <xmqqy27vglwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6006DA42-17DB-11EC-A900-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-=
untracked-cache.c
> index cf0f2c7228e..99010614f6d 100644
> --- a/t/helper/test-dump-untracked-cache.c
> +++ b/t/helper/test-dump-untracked-cache.c
> @@ -45,8 +45,10 @@ int cmd__dump_untracked_cache(int ac, const char **a=
v)
>  	struct untracked_cache *uc;
>  	struct strbuf base =3D STRBUF_INIT;
> =20
> -	/* Hack to avoid modifying the untracked cache when we read it */
> -	ignore_untracked_cache_config =3D 1;
> +	/* Set core.untrackedCache=3Dkeep before setup_git_directory() */
> +	xsetenv("GIT_CONFIG_COUNT", "1", 1);
> +	xsetenv("GIT_CONFIG_KEY_0", "core.untrackedCache", 1);
> +	xsetenv("GIT_CONFIG_VALUE_0", "keep", 1);
> =20
>  	setup_git_directory();
>  	if (read_cache() < 0)

If any parent process were using the GIT_CONFIG_* and the
GIT_CONFIG_PARAMETERS mechanism to pass one-shot config setting down
to a git subprocess, this obviously will break, but I would assume
that:

 (1) this test helper itself is not interested in being told to
     pretend any configuration other than what is found in the files
     are in effect, and

 (2) this test helper will not spawn git subprocesses that should
     honor the one-shot config setting whoever started the test
     helper wanted them to use.

So this should be an OK price to pay for being able to remove the
test-only code from the core part.

Looking good.
