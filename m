Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8BDC4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FCE20665
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rEM9mT5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgKJCiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:38:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55223 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKJCiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 21:38:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC745100A33;
        Mon,  9 Nov 2020 21:37:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMWpM3ZSPz3rvrqAKn6FKVFzyQg=; b=rEM9mT
        5CITYumE/L69xlp8t3WsDKcH+m+Vk9kLLsMXZEXkCCNVg46pXvMIFEHGLrykJBt3
        VRqWNVzPL/L1QFgc1c2Dq5x1HP6BTJgjruaLp74yDc2/bmkfYf/7oJ3/sU3IAHhH
        qulTKzOryhun1dE3Z3U9WZ2zFOnrIbUlL9Kis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YXz21oJnKBs/q5wCvzA7Zdp7mmq7882s
        HER35pBEAjhRIvKvRYuR6GIAPaLe6wjAVW/zh71zGbL9JYaRApmdKQ64HXDjelGy
        lhXTDZ8NLqE5lGJK+nQ84YlxizXFGZ2wNE0WskZEW4g4qp+grpWdGr/nNQdbVOCZ
        c1iaPtc5d/g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5141100A32;
        Mon,  9 Nov 2020 21:37:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B538100A31;
        Mon,  9 Nov 2020 21:37:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     hukeping <hukeping@huawei.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>,
        Patrick Hemmer <git@stormcloud9.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch: make output filename configurable
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
        <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
        <xmqqwnyubagr.fsf@gitster.c.googlers.com>
        <9d4b387655024b24a20ce2384740b03a@huawei.com>
Date:   Mon, 09 Nov 2020 18:37:54 -0800
In-Reply-To: <9d4b387655024b24a20ce2384740b03a@huawei.com>
        (hukeping@huawei.com's message of "Tue, 10 Nov 2020 02:31:38 +0000")
Message-ID: <xmqqr1p27x8d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD3E192E-22FD-11EB-ACEB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hukeping <hukeping@huawei.com> writes:

> It would be very hard to remove a config knob rather than add a
> new one and we already have too many.
>
> Does it worth to add a new configuration variable for this or just
> a hard-coded value is enough?

I personally would say "yes, the current code that limits to 64 is
enough", but you, as the person who said that you do not like the
current hard-coded value, are not in the position to ask that
question, I would have to say---if it were enough for you, you
wouldn't have complained about 64 in the first place ;-)



