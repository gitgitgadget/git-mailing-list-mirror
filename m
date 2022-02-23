Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F97C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 20:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbiBWUQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiBWUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 15:16:56 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C44CD58
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:16:28 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBF8F10283B;
        Wed, 23 Feb 2022 15:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4W29GQGii62F
        EzLSfykGmImET/JEiyv5SdzzUZM9eL4=; b=bBLl7b2T8nWOD5ty4KRx8OwkUJoj
        wBYE3Ch2Dc1ajbQ5W8EqvWO3QHpNKPFDUjJbypOXlhc8cfmFE433FPelevsuNrxw
        SIqRP4VFJAH4W3pOGTQ2GQXTbanpcsonW0tjm+CHOiCr2ylGQLaYplT8kx07p/Kw
        MXTb/erV5za7P68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4114102839;
        Wed, 23 Feb 2022 15:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 595FC102834;
        Wed, 23 Feb 2022 15:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
        <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
        <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
        <YhPL+wSxtI0KIz07@nand.local>
        <220221.868ru4avw6.gmgdl@evledraar.gmail.com>
        <xmqqee3vwepd.fsf@gitster.g>
        <220222.86o82z8als.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Feb 2022 12:16:26 -0800
In-Reply-To: <220222.86o82z8als.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 22 Feb 2022 11:14:17 +0100")
Message-ID: <xmqq4k4puyn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B0256D2-94E5-11EC-A4A5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Feb 21 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> Sorry to notice this so late, but this hunk caught my eye. What happ=
ens
>>>> if `TEST_DIRECTORY` is provided by the user (and doesn't end in "/t"=
)?
>>>
>>> I think that the preceding 2/4 should cover your concern here, i.e. I
>>> think that's not possible.
>>>
>>>> Before this change, we would have set GIT_BUILD_DIR to the parent of
>>>> whatever TEST_DIRECTORY is, whether or not it ended in "/t". We'll s=
till
>>>> do the same thing with this patch if TEST_DIRECTORY ends in "/t". Bu=
t if
>>>> it doesn't, then we'll set GIT_BUILD_DIR to be the same as
>>>> TEST_DIRECTORY, which is a behavior change.
>>>
>>> Indeed, but I believe (again see 2/4) that can't happen.
>>
>> It is not like "can't happen", but "whoever wrote the TEST_DIRECTORY
>> override logic did not mean to support such a use case".
>
> To clarify with "can't happen" I mean (and should have said) that "can'=
t
> work", i.e. it would error out anyway.
>
> E.g. try in a git.git checkout:
>    =20
>     (
>         mv t t2 &&
>         cd t &&
>         ./t0001-init.sh
>     )
>
> It will die with:
>    =20
>     You need to build test-tool:
>     Run "make t/helper/test-tool" in the source (toplevel) directory
>     FATAL: Unexpected exit with code 1
>
> And if you were to manually patch test-lib.sh to get past that error it
> would start erroring on e.g.:
>
>     sed: couldn't open file /home/avar/g/git/t2/../t/chainlint.sed: No =
such file or directory
>
> And if you "fix" that it'll error out on something else.
>
> I.e. we'll have discovered that $(pwd)/.. must be our build directory,
> and we then construct paths by adding the string "/t/[...]" to that.
>
>> I am perfectly fine if we declared that we do not to support the use
>> of that override mechanism by anybody but the "subtest" thing we do
>> ourselves.  If we can catch a workflow that misuses the mechansim
>> cheaply enough (e.g. perhaps erroring out if TEST_DIRECTORY is set
>> and it does not end in "/t"), we should do so, I would think, instead
>> of doing the "go up and do pwd", which will make things worse.
>
> What I was going for in 2/4 in
> http://lore.kernel.org/git/patch-v3-2.4-33a628e9c3a-20220221T155656Z-av=
arab@gmail.com
> is that we've already declared that. I.e. test-lib.sh has various
> assumptions about appending "/t/..." to the build directory being a
> valid way to get paths to various test-lib.sh-adjacent code.
>
> So trimming off "/t" here with a string operation v.s. $(cd .. && pwd)
> is being consistent with that code.
>
> It would be odd to make the bit at the top very generic, only to have
> the reader keep reading and wonder how that generic mechanism and the
> subsequent hardcoding of "/t/[...]" are supposed to work together.

Correct.  That is why I said $(... pwd) to pretend that we can take
anything would make it worse in a separate message.

If we have to strip off /t anyway, piggy-backing on that part to
detect and abort when somebody misused the mechanism would be a good
idea---which is what I said in the message you are responding to and
not responding to.

