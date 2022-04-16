Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1562CC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 05:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiDPF7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 01:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPF7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 01:59:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FDE29C82
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 22:56:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B7E218F667;
        Sat, 16 Apr 2022 01:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sct+H1MGCkhF
        o9aFQBGazGRqqHSyaGwY2YK47JE9/CU=; b=r5CHCA7msQUE9+95zpLdmCLhpkuJ
        oErQssSMQ144gB8E4NScK00hmvuze6wQ9uwjnx3rpISUy4zeCjW0LHPQKgj6ZCk3
        NqHGRL/W70Sem+4orkr3eFe3k/wGsAIw9E8hDvgYngK8GFNqDE4WsUqeA3SpVLra
        tvwDyqWFJa3h2DU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F55E18F666;
        Sat, 16 Apr 2022 01:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FD8418F624;
        Sat, 16 Apr 2022 01:56:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood@talktalk.net
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-2-carenas@gmail.com>
        <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
        <CAPUEspgYU_797VSsdLWVqLXjSYsKfJhUb7M=jdouF01kHcKQyA@mail.gmail.com>
        <220416.86tuatalmf.gmgdl@evledraar.gmail.com>
Date:   Fri, 15 Apr 2022 22:56:33 -0700
In-Reply-To: <220416.86tuatalmf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 16 Apr 2022 02:55:18 +0200")
Message-ID: <xmqqo8117er2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8D6311E-BD49-11EC-90CF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Apr 15 2022, Carlo Arenas wrote:
>
>>> > +# https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
>>> > +ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
>>> > +DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
>>> > +endif
>>>
>>> What I meant with "just set -Wno-error=3Dstringop-overread on gcc12 f=
or
>>> dir.(o|s|sp)?" was that you can set this per-file:
>>
>> of course, but that change goes in the Makefile and therefore affects
>> ...
> I mean it can go in config.mak.dev, it doesn't need to be in the
> Makefile itself.
> ...
>>>         dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop=
-overread
>>
>> I know at least one developer that will then rightfully complain that
>> the git build doesn't work in AIX with xl after this.
>
> Yes, it would break if it were in the Makfile, but not if it's in
> config.mak.dev.

I do not think you can blame Carlo for poor reading/comprehension in
this case---I too (mis)read what you wrote, and didn't realize that
you were suggesting to add the "for these target, EXTRA_CPPFLAGS
additionally gets this value" inside the ifneq/endif Carlo added to
hold the DEVELOPER_CFLAGS thing.

For now, let's stick to the simpler form, though.

Thanks.
