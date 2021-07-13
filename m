Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDCC07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DA961358
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGMRt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:49:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50879 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGMRt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 13:49:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0867C56C4;
        Tue, 13 Jul 2021 13:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vW94R8ZsW7J/
        5BBbreI6PQpc0/hiD6ezZuNu4BZLz0A=; b=ksufH4RZKfWXjtMbKeALTYxq0bAr
        RWPIzBNWhGeh39Z9V/vSgI4ze/M8C4HcCu/ZLC/sD4zd6k4LQqczw2r8EFBWwdvb
        QlzTgpRBvljiHw3mw29nwlUZSvIprQKF/iFm9owyJza+SwDd/5QBLb7n7rcPFHeL
        bhEhxQvqn4DmBCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A78F3C56C3;
        Tue, 13 Jul 2021 13:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CAB3C56C2;
        Tue, 13 Jul 2021 13:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
        <87h7hdbpgb.fsf@evledraar.gmail.com>
        <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
        <CABPp-BF+GiAZVxeC+MAr6pSssRpSi2pNwHLrxUp9HvrOhUBieg@mail.gmail.com>
Date:   Tue, 13 Jul 2021 10:47:07 -0700
In-Reply-To: <CABPp-BF+GiAZVxeC+MAr6pSssRpSi2pNwHLrxUp9HvrOhUBieg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 13 Jul 2021 10:36:23 -0700")
Message-ID: <xmqq1r822jj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57EFD2D0-E402-11EB-AA08-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jul 13, 2021 at 10:10 AM Jeff Hostetler <git@jeffhostetler.com>=
 wrote:
>>
>> a quick test on my Windows machine shows that
>>
>>         test_seq 1 10000 | xargs touch
>>
>> takes 3.1 seconds.
>>
>> just a simple
>>
>>         test_seq 1 10000 >/dev/null
>>
>> take 0.2 seconds.
>>
>> using my test-tool helper cuts that time in half.
>
> Yeah, test_seq is pretty bad; it's just a loop in shell.  Is there a
> 'seq' on windows, and does using it instead of test_seq make things
> faster with =C3=86var's suggested command?

Unless I am misreading Jeff's message, I do not think that makes
sense.  Counting to 10000 in shell loop is trivial (0.2 seconds),
but letting touch invoked 10000 times to create (or smudge mtime of,
but I suspect that is not what is going on here) 10000 files takes
3.1 seconds, and of course a native binary that creates 10000 files
with a single invocation would be faster.

> I'd really like to modify test_seq to use seq when it's available and
> fall back to the looping-in-shell when we need to for various
> platforms.

So, if I am reading Jeff correctly, that optimizes something that is
not a bottleneck.

> Maybe it'd even make sense to write a 'test-tool seq' and make
> test_seq use that just so we can rip out that super lame shell
> looping.
