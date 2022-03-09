Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A051C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 17:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiCIRsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCIRsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 12:48:36 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F9CFB96
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 09:47:37 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3641410B55E;
        Wed,  9 Mar 2022 12:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Om64g4Gy4MYL
        /Cxun/zt/jF1ChVat5htuRIvHZq2md8=; b=pxK4ZNVAHh3tUANjffvhLStUg2/e
        2tCbNwiC0cqk2trXj9ShlaTuOM10JreWRCneiyscvlIT9I6/1U/4Q6b7jzHYvuUf
        iVQEZSUBXGWicB63Kxl+J9iscQPjUyZy7LkBlLe5L0Qt1geqK7u9PaDO+fwjwcj1
        SpQTvEydtJgUFSo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E4E910B55D;
        Wed,  9 Mar 2022 12:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 901B710B55C;
        Wed,  9 Mar 2022 12:47:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
        <20220308113305.39395-1-carenas@gmail.com>
        <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
        <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
        <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
Date:   Wed, 09 Mar 2022 09:47:33 -0800
In-Reply-To: <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 8 Mar 2022 19:05:47 -0500")
Message-ID: <xmqqv8wnm30q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00723AF8-9FD1-11EC-B4B7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 8, 2022 at 6:58 PM Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>> On Tue, Mar 8, 2022 at 6:55 PM Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
>> > On Tue, Mar 8, 2022 at 6:44 PM Carlo Marcelo Arenas Bel=C3=B3n
>> > <carenas@gmail.com> wrote:
>> > > +               local _GLIBC_VERSION=3D$(getconf GNU_LIBC_VERSION =
2>/dev/null)
>> > > +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
>> > > +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'
>> >
>> > No need for `cut` since `awk` can accomplish the same by itself.
>> >
>> >     if echo "$_GLIBC_VERSION" | awk '/^glibc / { if ($2 - 2.34 < 0) =
exit 1 }'
>> >
>> > should work, I would think.
>>
>> Nevermind, I forgot you want to better support "2.34.9000" matches.
>> Though, awk should still be able to do so on its own, one would
>> expect, but not too important.
>
> This seems to work, though it's getting a bit verbose:
>
>     awk '/^glibc / { split($2,v,"."); if (sprintf("%s.%s", v[1], v[2])
> - 2.34 < 0) exit 1 }'

If we are losing "cut" (which I think is a good thing to do), we
probably can lose the pipe, too and refer to $_GLIBC_VERSION as an
element in ARGV[] and make the command used as "if" condition to a
single "awk" script?

In general it is a good discipline to question a pipeline that
preprocesses input fed to a script written in a language with full
programming power like awk and perl (and to lessor extent, sed) to
see if we can come up with a simpler solution without pipeline
helping to solve what these languages are invented to solve, and I
very much appreciate your exploration ;-)

Thanks.
