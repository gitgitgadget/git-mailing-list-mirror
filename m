Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12773C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D8960E54
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhKSQwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:52:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57244 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhKSQwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:52:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49AB3109CB8;
        Fri, 19 Nov 2021 11:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ROk3Lg58PrfjXmZBRZMmxw6uSpAo9rE7qnQ2UX
        RDrV4=; b=lezOSfScXson5LMhEV/zclRaibw+i2pFfCakqJq89YLw4+1zRM7zmy
        dpbqP8wYKVNAkCutNaHSWznOydvdSiePZuISCHOJOKIZIIH3jdmUdi60Tm4La+IK
        s36FaobOxYNuo8tmaSL7Pd1SlhLvoZ6G5ZBxwUoxfVxf8Jg6p9u3Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D206109CB7;
        Fri, 19 Nov 2021 11:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80A1A109CB5;
        Fri, 19 Nov 2021 11:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 2/3] am: support --empty option to handle empty patches
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
        <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com>
        <211119.861r3c4a4g.gmgdl@evledraar.gmail.com>
        <CAPig+cQq3Ek7RL9NKuvR5V9OVULRf7=N3QEYvy9=xqdZB3EEWg@mail.gmail.com>
Date:   Fri, 19 Nov 2021 08:49:07 -0800
In-Reply-To: <CAPig+cQq3Ek7RL9NKuvR5V9OVULRf7=N3QEYvy9=xqdZB3EEWg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 19 Nov 2021 07:20:24 -0500")
Message-ID: <xmqqy25kqef0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D3AFCBE-4958-11EC-91DA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I recently expressed an opposing opinion in [1], stating effectively
> that omitting the quotes like this is "an accident waiting to happen":
>
>     ... the lack of quotes ... in the `echo ... >expect` statement
>     gives me a moment's pause since it relies upon the fact that
>     `echo` will insert exactly one space between the ... arguments
>     (which happens to match the single space in the [command's output]
>     ). For clarity and that extra bit of robustness, I'd probably have
>     used a single double-quoted string argument with `echo`.
>
> But, it's a fairly minor objection.

It indeed is minor enough that a patch to turn an existing

	echo A B C >expect &&
	test_cmp expect actual

into

	echo "A B C" >expect &&
	test_cmp expect actual

is not welcome.  But it still is worth pointing out and correcting
in a patch to add new code, I would think.  It all depends on what
we care about, and the use of test_cmp means we do care about exact
shape of the string, including the inter-word spacing.

Thanks.
