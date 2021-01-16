Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C994C433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 07:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD25223AA9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 07:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbhAPG7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 01:59:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57494 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPG7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 01:59:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2192311BF22;
        Sat, 16 Jan 2021 01:58:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5ji4XosY2XHBfiG/+1M/TIhbu/c=; b=dNnlVM
        JcGmegkDqa1rHkpbF7afT/mDVpI0Di3ZZ80Z40wdyYjAaVBxbRRwmOi5RziHQ2Mw
        OlZw7E7Iu3iRKKwe16RfHejgh+9cqwr4cMfKLa7anoCaEWmOv05geE8MHz/2NRG8
        GvQr7pl0+QLGMHNOn2dQjAyj/S2Uw1ZBh2xX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AwwXa0feoLXgljYxknzipjtJ4igMOWbq
        CWaNag9xRZf0wFsGduEaOHgNY331VA+pRLkbRYgybs3FUWuzG/ZDkA+yH0ow+j7B
        186lyQUqx0HJIzLz53+sR4rpndKWqRJRk4TXyn999oadm7kz5FoyvJw3JbCPm6cb
        pKPPkwTAV40=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 135F611BF21;
        Sat, 16 Jan 2021 01:58:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5002911BF20;
        Sat, 16 Jan 2021 01:58:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 00/10] Cleanups around index operations
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
Date:   Fri, 15 Jan 2021 22:58:23 -0800
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 07 Jan 2021 16:32:01
        +0000")
Message-ID: <xmqqr1mlpdv4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A9E1758-57C8-11EB-93A2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I've taken a professional interest in the index lately, and I've been trying
> mostly to learn about it and measure different operations. Along the way,
> I've seen some possible improvements in documentation, behavior, and
> tracing.
>
> This series collects most of my thoughts so far, including:
>
>  1. Adding extra trace2 regions and statistics (similar to [1]) (Patches
>     1-5).
>  2. Update documentation about the cached tree extension (Patches 6-7).
>  3. Improved the performance of verify_cache() (Patches 8-9).
>
> Thanks, -Stolee

I've given all the patches in the series another reading, and found
them to be nicely done.

Let's merge it down to 'next'.

Thanks.
