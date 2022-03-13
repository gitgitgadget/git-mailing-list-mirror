Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2CC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 07:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiCMHfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCMHfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 03:35:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC282D21
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 23:34:38 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 994E5120B21;
        Sun, 13 Mar 2022 03:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LtZqxjxPlJGD
        UiyYFa4ES0BR9N2wmjM0/4NIQtQlb5U=; b=O+9wEsScZxRGDc57AwaOXZs7kbcU
        DJJu5QHDYgcV/DjGmHNeQeo2AfnO4b6JaSt5Vn5Rcc+QcTchRhNDKByNLXIW7I4h
        egyztyiyLd6g9IMvEXDBGLsj2XVH/4Nt3m7F+NarC5+OplHbIIrSHA4bKAkRt7GT
        UgbmuRxZyKMO3YI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ED34120B20;
        Sun, 13 Mar 2022 03:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA242120B1F;
        Sun, 13 Mar 2022 03:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
        <20220308113305.39395-1-carenas@gmail.com>
        <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
        <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
        <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
        <xmqqv8wnm30q.fsf@gitster.g>
        <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
        <CAPig+cQNeTAvWHm2GUGc2i=FKF2V6Gqkmmsw4kDOTzrSYEbgxA@mail.gmail.com>
        <220312.86o82bfo7x.gmgdl@evledraar.gmail.com>
        <xmqqtuc2lhis.fsf@gitster.g>
        <CAPUEspgdmaztSShPd6vJpT7801_czRuBt_QaPu_W2JGOw+UqrQ@mail.gmail.com>
Date:   Sun, 13 Mar 2022 07:34:35 +0000
In-Reply-To: <CAPUEspgdmaztSShPd6vJpT7801_czRuBt_QaPu_W2JGOw+UqrQ@mail.gmail.com>
        (Carlo Arenas's message of "Sat, 12 Mar 2022 18:37:27 -0800")
Message-ID: <xmqqilsiwbjo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08CD7C22-A2A0-11EC-BE17-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Sat, Mar 12, 2022 at 6:21 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > But probably better is to just amend that to call it as "test-tool l=
ibc
>> > is-glibc-2.34-or-newer" or whatever. Then just do:
>> >
>> >       if (__GLIBC__ > 2 || (__GLIBC__ =3D=3D 2 && 34 >=3D __GLIBC_MI=
NOR__))
>> >               return 0;
>> >       return 1;
>>
>> Yuck.  Then we'd have yet another libc-is-glibc-2.36-or-newer
>> option, too, in the future?
>
> Luckily that won't be needed, as this the original version (with expr)
> is practically good enough even if it might be a little odd looking
> and incorrect for 2.4 <=3D glibc <=3D 2.9 (which are over 10 years old)=
.
>
>   $ expr 2.34 \<=3D "2.34.9000"
>   1
>   $ expr 2.34 \<=3D ""
>   0

Yeah, that is good.

What I was trying to get at was to extend =C3=86var's one trivially to

  $ test-tool libc-is-at-or-later-than 2.34

so that we can deal with

  $ test-tool libc-is-at-or-later-than 2.36

for free, but if we do not have to do anything, that is even better
;-)

