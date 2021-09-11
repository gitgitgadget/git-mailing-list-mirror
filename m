Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903AAC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A11860FDA
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhIKGOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 02:14:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62077 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKGOE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 02:14:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C9BEAB91;
        Sat, 11 Sep 2021 02:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=RR65eQvh/8+7sRffiJlYS1x/y
        e9egfuKYmYuQp3bd5E=; b=Ywg/MCLFDy7IqekNSuuA3vqP2yTpmcl1O2VKn2PHg
        tLWO8fJIsd8Qs/CzjcY6LrT0Ip7YlcK6RIFAnN2Zc97UI7H6cPtWQKxmE7aOfmc5
        2W5hCKikN75npM3QZeeb0aIH1/YPOtFpuV/Hoo+K9dD7DYab8Vb7QuyewDIREyNe
        mI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91529EAB8F;
        Sat, 11 Sep 2021 02:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1085DEAB8E;
        Sat, 11 Sep 2021 02:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/6] git.c: add a NEED_UNIX_SOCKETS option for built-ins
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
        <xmqqr1dwotmn.fsf@gitster.g> <87mtojaklj.fsf@evledraar.gmail.com>
        <YTwm57pp/cvfR5rg@carlos-mbp.lan>
Date:   Fri, 10 Sep 2021 23:12:50 -0700
Message-ID: <xmqqee9vmyhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B2FA716-12C7-11EC-ACEB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> Sorry, if this is silly, but why is this not better (at least as a star=
ting
> point, since it obviously will need more work?
>
> Undefined symbols for architecture x86_64:
>   "_cmd_credential_cache", referenced from:
>       _commands in git.o
>   "_cmd_credential_cache_daemon", referenced from:
>       _commands in git.o
>
> Carlo
> ---- >8 ----
> diff --git a/Makefile b/Makefile
> index 44734f916a..2a60685c37 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1098,8 +1098,10 @@ BUILTIN_OBJS +=3D builtin/commit-tree.o
>  BUILTIN_OBJS +=3D builtin/commit.o
>  BUILTIN_OBJS +=3D builtin/config.o
>  BUILTIN_OBJS +=3D builtin/count-objects.o
> +ifndef NO_UNIX_SOCKETS
>  BUILTIN_OBJS +=3D builtin/credential-cache--daemon.o
>  BUILTIN_OBJS +=3D builtin/credential-cache.o
> +endif
>  BUILTIN_OBJS +=3D builtin/credential-store.o
>  BUILTIN_OBJS +=3D builtin/credential.o
>  BUILTIN_OBJS +=3D builtin/describe.o

That smells to show a much better direction to me ;-)
