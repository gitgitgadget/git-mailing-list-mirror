Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CDEC433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 23:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiACXsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 18:48:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61837 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiACXsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 18:48:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D42610F15C;
        Mon,  3 Jan 2022 18:48:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wut+Gu8dcHyd10LRCz5lgY0fo/dcLueYFl25DP
        pVawA=; b=dpzFobveiiz95OaFQnZQHPxXJfIn7NIQYS2G/Lj8/m9RngVRdsvTM8
        wj5xoMGgDXro9UUJTw1XvQZndib/hZLcZ+QSQRgKbjlicaTCWCszc0W0LSOoutV9
        qa52NBq8wP1FUY7FOYJGW3NpfPZoqau1PmhLD4nZPD8bwsWhIJmbc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3288610F15B;
        Mon,  3 Jan 2022 18:48:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 819D210F15A;
        Mon,  3 Jan 2022 18:48:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 4/7] progress.c tests: test some invalid usage
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
        <patch-v7-4.7-40e446da277-20211217T041945Z-avarab@gmail.com>
        <20211227011100.g3pwc67onlc7qs7t@gmail.com>
Date:   Mon, 03 Jan 2022 15:48:00 -0800
In-Reply-To: <20211227011100.g3pwc67onlc7qs7t@gmail.com> (Johannes
        Altmanninger's message of "Mon, 27 Dec 2021 02:11:00 +0100")
Message-ID: <xmqqy23wgz4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96DA33F2-6CEF-11EC-9D80-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>> +	grep region_enter.*progress trace-start.event &&
>> +	! grep region_leave.*progress trace-start.event
>
> should "!" be "test_must_fail"? Same below.

The answer is no.  The main difference between test_must_fail and
"!" is that the former is designed to catch ungraceful death (e.g.
by segfault) and to be used to expect controlled failure from OUR
programs (i.e. "git" and "test-tool" invocations).  We are not in
the business of catching segfaulting bug in system's "grep", so it
is perfectly fine to use "!" here.
