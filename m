Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A63AC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 05:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD0260F91
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 05:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhHLFDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 01:03:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhHLFDT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 01:03:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88D6AE7BA5;
        Thu, 12 Aug 2021 01:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XbrAQrpENIcR
        CAMA6mMTfmzW4mNWIqcG/A5wqp9XD4Q=; b=x/ZwqSZsvdgdpIApVOHMfhYjLxEe
        HgQfySy3RwRiR6GvzY1U4ywIiYp9nkfw+hg599zZ4zOWTG7KIv29EghAr0G2gC7g
        jI6fOYP0dypAm50FnPn+PDxjvNZCPa+lI3T5YogIV9rs42fqIO5xKiFnkgYOO3dh
        yQ7tRWXWSOpfSo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EB8EE7BA4;
        Thu, 12 Aug 2021 01:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05D1DE7BA1;
        Thu, 12 Aug 2021 01:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/6] config-based hooks restarted
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <xmqqa6ln6zi0.fsf@gitster.g>
Date:   Wed, 11 Aug 2021 22:02:53 -0700
In-Reply-To: <xmqqa6ln6zi0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        11 Aug 2021 21:47:03 -0700")
Message-ID: <xmqq5ywb6yrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D29752A-FB2A-11EB-815F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> This is the config-based hooks topic rebased onto v4 of =C3=86var's
>> branch[1].
>
> I have [1] in my tree, but these patches do not seem to apply
> cleanly; I see a failure in "git hooks list" step.
>
> Should I perhaps try merging [1] to one of the v2.33-rc and then
> queue these on top?

Ah, I figured it out.  Your 3/6 seems to be stale wrt 4787177b
(hook: support passing stdin to hooks, 2021-08-03) that came from
https://lore.kernel.org/git/patch-v4-22.36-639e59e9ed0-20210803T191505Z-a=
varab@gmail.com/

That patch did this to the early part of builtin/hook.c:

        diff --git a/builtin/hook.c b/builtin/hook.c
        index f33db9953c..27dce6a2f0 100644
        --- a/builtin/hook.c
        +++ b/builtin/hook.c
        @@ -7,7 +7,7 @@
         #include "strvec.h"

         #define BUILTIN_HOOK_RUN_USAGE \
        -	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>=
]")
        +	N_("git hook run [--ignore-missing] [--to-stdin=3D<path>] <hook=
-name> [-- <hook-args>]")

         static const char * const builtin_hook_usage[] =3D {
                BUILTIN_HOOK_RUN_USAGE,


but your [v2 3/6] here expects something entirely different.

        diff --git a/builtin/hook.c b/builtin/hook.c
        index 12c9126032..c36b05376c 100644
        --- a/builtin/hook.c
        +++ b/builtin/hook.c
        @@ -8,8 +8,11 @@

         #define BUILTIN_HOOK_RUN_USAGE \
                N_("git hook run [--to-stdin=3D<path>] <hook-name> [-- <h=
ook-args>]")
        +#define BUILTIN_HOOK_LIST_USAGE \
        +	N_("git hook list <hook-name>")

I've wiggled the patch in, as there wasn't any other funny
inconsistency like this one, but please double check the result
after I push it out perhaps tomorrow morning.

Thanks.
