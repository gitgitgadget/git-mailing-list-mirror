Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978CC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 02:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhLYCBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 21:01:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50714 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLYCBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 21:01:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97EAC165140;
        Fri, 24 Dec 2021 21:01:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sXRmfUCwmHEl
        JDSxiXkV4YbESwGwZhW750Z63a18U3k=; b=UvfDF+t+tTWQQ5i/RKiKYCSuQFcM
        aewB5VULv7FaH5bUMys1K/Ygpg4squKHHZvPy3ND9A62qjOKowAliKGtCbnpFsAr
        NB+dfTPrzkpzT1sMKemTjWKEiehzIXHZkTkAhf3y4M/oA/lhJhMxREt534fmzf74
        Rl8gRVFKXcPmmQI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 906A916513E;
        Fri, 24 Dec 2021 21:01:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1D0C16513D;
        Fri, 24 Dec 2021 21:01:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Daniel Vicarel <shundra8820@gmail.com>, git@vger.kernel.org
Subject: Re: Why does "merge --continue" expect no arguments?
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
        <xmqqlf0dq3t3.fsf@gitster.g>
        <211224.86mtkqgc8e.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Dec 2021 18:01:17 -0800
In-Reply-To: <211224.86mtkqgc8e.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Dec 2021 18:08:32 +0100")
Message-ID: <xmqqk0ft5toy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CFB58A0-6526-11EC-A6E3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Dec 21 2021, Junio C Hamano wrote:
>
>> Or we could throw in another
>>
>>  * document more clearly that "merge --continue" is a mere synonym
>>    for, and hint that there is no reason to favor it over, "git
>>    commit".
>
> But it's not:
>
>     $ git add foo
>     $ git commit -v
>     hint: Waiting for your editor to close the file.[...]
>     ^C
>     $ git merge --continue
>     fatal: There is no merge in progress (MERGE_HEAD missing).
>
> FWIW I prefer and use it for that reason, i.e. it's useful for scriptin=
g
> to use these "stateful" commands when we're in some sort of rebase/merg=
e
> "sequence" since it's an extra layer of sanity checking.

There is no additional safety afforded by that, though.  There is no
reason why one would even try to say "merge --continue" without
doing any merge to begin with.

The "merge --continue" not taking any pathspec is a bit of safety,
but even there, "commit" already has its own safety to reject
pathspec when it notices that it is concluding a conflicted "merge",
so "merge --continue" is not necessary for additional safety there,
either.



