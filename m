Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE4C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 23:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiANX5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:57:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52939 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiANX5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 18:57:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1B4816AD7D;
        Fri, 14 Jan 2022 18:57:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G2isSehP2ci4
        kPRNmJAfJ9KorrNxu7JgsPV5FGBdC2Q=; b=OzECrw69qo8z78+ES70jfXvmv5JU
        8qsaeva2PgNAk4vUSk7gEBMDBDjo3v32RyhRm+/atd57zrQ85TIOkVLKleuXQyn1
        t6jCYPEwBo2lT/I/u/SdD0CQQwaxwbM1ucaFiwnnC6ACHKQARA+tTf3QVz3nsFxN
        bgoXtrvy1Qybmh4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE0B316AD7C;
        Fri, 14 Jan 2022 18:57:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38D9C16AD7A;
        Fri, 14 Jan 2022 18:57:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g>
        <220114.8635lqrqci.gmgdl@evledraar.gmail.com>
        <xmqqk0f29e6w.fsf@gitster.g>
Date:   Fri, 14 Jan 2022 15:57:48 -0800
In-Reply-To: <xmqqk0f29e6w.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Jan 2022 13:53:43 -0800")
Message-ID: <xmqqh7a598g3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7188984-7595-11EC-B6D0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Wow, that sounds horribly broken.
>>
>> Yes, but it's also working as designed :) We're erroring because the C
>> library headers on the OS aren't C99-compliant. That it would apply to
>> only git.git's sources was only ever wishful thinking.
>
> No, C library supporting only C11 is perfectly fine.  On such a
> system, the compiler shouldn't even support -std=3Dgnu99.  That is
> what I consider broken.

Or, the system headers should be arranged in such a way that
depending on __STDC_VERSION__, it should refrain from using features
of the language that is not supported.  So supporting -std=3Dgnu99 in
their compilers may not be a bug---but in that case, their system
headers are buggy.

Anyway.  I think <xmqqzgny7xo7.fsf@gitster.g> shows a viable way
forward.
