Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E754BC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FBF650A6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCEVwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:52:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61417 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCEVwj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 16:52:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E67EB1A97;
        Fri,  5 Mar 2021 16:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yJWY8rHsdLmWC5KV1PQopWUJZic=; b=SZkq3R
        tEDmwOTltw4tKKjxvz5EFJgXgt1hkZL2UZcLzGFi1st2w5q1fEQq7Y7Rd6TKvRaJ
        1OQhhTLVBkJj08XoIm4YEJmw41FoNuKZLslw3tTmW/CJ0KyvEnCG35wnGhdHUU1b
        keIrlGd3DCv1An+ruLUBUHoLrimwLB7TdsDII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hGnh85FgdXRBPeyi4c5eZEbJq6e2gC8k
        UZ3hHTgJjDt7fQVBrm96Wvx01jtFtztYObFM6Edjlo0b1t6f1nTf1ekRt438/JO0
        yb2jjCY6IS5AIL3FbwL9kAN6SGpuuD0ZljL+MOLyBTgu8au7baC5u3WBKNwvaPNA
        Mh2mziNkkHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04612B1A96;
        Fri,  5 Mar 2021 16:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64B40B1A94;
        Fri,  5 Mar 2021 16:52:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
        <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
        <YED1DmLWd+ciySNa@coredump.intra.peff.net>
        <xmqqa6riejyp.fsf@gitster.c.googlers.com>
        <ed933c34-85d2-c238-122f-13751a11ca7f@jeffhostetler.com>
Date:   Fri, 05 Mar 2021 13:52:36 -0800
In-Reply-To: <ed933c34-85d2-c238-122f-13751a11ca7f@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 5 Mar 2021 16:30:57 -0500")
Message-ID: <xmqq5z259skb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1994B926-7DFD-11EB-B3FD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> I am OK to keep the series as-is, and leave it to a possible future
>> work to remove the need for chdir even for long paths and not having
>> to return an error with ENAMETOOLONG; when such an update happens,
>> the "fail if need to chdir" feature this patch is adding will become
>> a no-op.
>
> I think I'd like to keep things as I have them now with the "disallow
> chdir()" option bit

So we are on the same page.

> and save the "fork() / bind()" solution for a
> later patch series.  Simple IPC is large enough as it is and the new
> ENAMETOOLONG error will only affect callers who set the bit.  A later
> patch series can easily test and confirm the "fork() / bind() solution
> in isolation and test it on the other Unix hosts and then remove the
> bit from those callers (if we want).

The bit will then become an unused API relic, but that is OK (I do
not think fork/bind would be the best and/or only way to avoid
chdir, though, but it won't matter in the context ofh tis
discussion).

