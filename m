Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B16BC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbiATSiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 13:38:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59694 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiATSiX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 13:38:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 082A9FE925;
        Thu, 20 Jan 2022 13:38:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KV6v4aqdBfPR
        xpduGrizRTvSkpLcUPKsNWkYV2xVH0g=; b=EvMAHp99DLf7hHh2TVKKsRpugeBP
        YGXyWQJhOrRsw7BUoqj0LkT3Ff49yxlklv2W2oBXECfx0zL+7Y8ugH0PAL8IKMFq
        EKjzVcQhyk1d066doys3Ld161hl4WuUUSr1Dahb/d94AvmtiOENB0uKcWjWlFxEC
        KKSP8+9tROq8leQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F36C5FE924;
        Thu, 20 Jan 2022 13:38:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55E8FFE923;
        Thu, 20 Jan 2022 13:38:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        <220120.86zgnqli9v.gmgdl@evledraar.gmail.com>
Date:   Thu, 20 Jan 2022 10:38:21 -0800
In-Reply-To: <220120.86zgnqli9v.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jan 2022 13:05:52 +0100")
Message-ID: <xmqqbl06jlr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2539726A-7A20-11EC-AD31-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> With that we'll now emit:
>    =20
>     $ ./git add -h 2>&1|grep chmod
>         --chmod[=3D](+|-)x      override the executable bit of the list=
ed files
> ...
> But the usage output stated that the "=3D" was mandatory before.

I am not sure if it is healthy to be _that_ strict when interpreting
the boilerplate elements in the output.  Between "git add -h" that
gives

    (1) git add --chmod( |=3D)(+|-)x
    (2) git add --chmod=3D(+|-)x

I would prefer the latter 10x as much as the former.  The choice
"You can give either plus or minus" is very much what the reader
must understand and it is worth reminding in the help.  Compared to
that, "You can use the stuck form that is recommended by gitcli
documentation when giving the argument to the --chmod option, or you
can give the argument to the option as a separate command line
argument", while technically correct, is not a choice that is worth
cluttering the output and making it harder to read.

To put it differently, the choice (+|-) is something the user needs
to pick correctly to make what they want to happen happen.  On the
other hand, the choice ( |=3D) is not.  As this is a boilerplate
choice that is shared by any and all options that take an argument,
once you are aware that stuck form is recommended but that separate
form is also accepted, you'd see "git add --chmod=3Dblah" in the help
and would not hesitate to type "git add --chmod blah".  And if you
are not aware of the existence of the alternative, nothing is lost.
You can type '=3D' and see what you want to see happen happen.

Not cluttering the help text with an extra choice that the user does
not have to make has a value.


