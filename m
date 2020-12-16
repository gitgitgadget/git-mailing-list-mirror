Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A59C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C3022DD6
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgLPA5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:57:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64743 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLPA5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:57:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DBC79F017;
        Tue, 15 Dec 2020 19:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kZqBnN8L7a3UlBg80+h8EVXJ3Ew=; b=ZgSLhV
        7YoZYJNH++JZfZoUgarjf+wJpmNldwekuAApBTs+DTkPPMKulGYv5E2ZY9oL23bV
        vIeUmSjHshQun3ZxB9EyXXDNX6et29gZe1YCZLZ55WWtEA1s7NhA3v6w5ibpcBBF
        /Cgs0Enq0ARxmic7uwZGQDTF4Hft+BjDAvXW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bNNvWPVa3dSIWoOxFshUUWEM70frBM7l
        OabGhQkh97pv9e4hwJBEFVSTZbmjTdaDfkl5IPZklCh0xTXgRQ6rrocJiIbFuyfL
        nQ+wlrrT/+KK0JozOQPNSxOInnQ3NdLRynyeCPvt6NSdgdIPdfzQXcvHm/KjaDUv
        mkuT+Ub/7uI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03F7A9F016;
        Tue, 15 Dec 2020 19:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 826619F015;
        Tue, 15 Dec 2020 19:56:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 00/17] propose config-based hooks (part I)
References: <20201014232447.3050579-1-emilyshaffer@google.com>
        <20201205014607.1464119-1-emilyshaffer@google.com>
        <20201216003408.GR36751@google.com>
Date:   Tue, 15 Dec 2020 16:56:18 -0800
In-Reply-To: <20201216003408.GR36751@google.com> (Josh Steadmon's message of
        "Tue, 15 Dec 2020 16:34:08 -0800")
Message-ID: <xmqqlfdy6025.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 823AC8E2-3F39-11EB-BF74-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2020.12.04 17:45, Emily Shaffer wrote:
>> Hi folks, and thanks for the patience - I ran into many, many last-mile
>> challenges.
>> 
>> I haven't addressed many comments on the design doc yet - I was keen to get the
>> "functionally complete" implementation and conversion to the list.
>> 
>> Next on my plate:
>>  - Update the design doc to make sense with what's in the implementation.
>>  - A blog post! How to set up new hooks, why they're neat, etc.
>>  - We seem to have some Googlers interested in trying it out internally, so
>>    I'm hoping we'll gather and collate feedback from that soon too.
>>  - And of course addressing comments on this series.
>> 
>> Thanks!
>>  - Emily
>
> This approach looks good to me. I'll look forward to seeing the updated
> design and the feedback from the internal tests.

Thanks.

By the way, es/config-hooks does not seem to pass 5411 (at least)
even as a standalone topic, and has been kicked out of 'seen' for
some time.  Has anybody took a look into the issue?


