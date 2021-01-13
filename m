Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6828DC433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 19:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213D7204EF
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 19:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbhAMT3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:29:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61622 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbhAMT3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 14:29:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E1CA6105;
        Wed, 13 Jan 2021 14:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qGG9HmRXoi2CXky2hVSLJnpRkQ8=; b=yH6mpR
        rIVt/b9Vfbl+eVtn6/vgtHnPYvx61W42twNFNxUcGGbRazYOWp63BCHAUpBbvESe
        02EPKNafTHdHlsEgkzyKI6vp/PsYM2tUy6Eg5SBbeQQ/B/bMBe9gx4ZRxeSWLaW+
        lJEbkFzaM+SM8aILOSChGAIVPWHZrAYnv5gNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VQJpKtWoGYEHl26QjpYCr0aByy9abthm
        vhNFsNLqXLGnrVmm4YXfi2eGqYuCknknUvtWtcLfCN3tIGI40+MioNE/g8z5Xjn6
        nTcPLKZWx03TP6mBKGOrDqTBcQ8djQxMBTNI+FEjXjkBCX81oHvm2DBatXLhNk3q
        nS10ZdM4aYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A37FA6104;
        Wed, 13 Jan 2021 14:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FB16A6103;
        Wed, 13 Jan 2021 14:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Arnaud Morin <arnaud.morin@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] patch-ids: handle duplicate hashmap entries
References: <20210109162440.GM31701@sync>
        <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
        <X/28IXBpse2dNZQH@coredump.intra.peff.net>
        <20210112153438.GC32482@sync>
        <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
        <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
        <20210113092448.GE32482@sync>
Date:   Wed, 13 Jan 2021 11:28:40 -0800
In-Reply-To: <20210113092448.GE32482@sync> (Arnaud Morin's message of "Wed, 13
        Jan 2021 09:24:48 +0000")
Message-ID: <xmqqk0sgy6tz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AD98076-55D5-11EB-9E6E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arnaud Morin <arnaud.morin@gmail.com> writes:

> Without this patch, that's even worst, consistency is broken.
> Let me explain.
>
> With your history example:
>
>      ---o---o---M---o---o---W---o---o---M---o--- branch
>          \
>           o---o---o---M---o--- master
>
> # WITHOUT PATCH
> If we imagine that master is having more commits count than branch.
> The result of rev-list will be like you described:
> $ git rev-list --left-right --cherry-pick branch...master
> <M
> <W
>
> In other words, it's showing both W and M.

So, at least they cancel out and the reader can tell that the net
effect was none --- that is "sort of understandable" result.

> BUT, if we imagine now that master is having less commits count than branch.
> $ git rev-list --left-right --cherry-pick branch...master
> <W
>
> It's only showing W!

Which is what I felt misleading.

> # WITH PATCH
> With the patch, everything is consistent, and only W is kept in ouptut,
> no matter the size of history:
> $ git.p rev-list --left-right --cherry-pick branch...master
> <W

So with the patch, the former case is made the same as the latter
misleading result, which would mean that they are consistently
misleading?

I guess that it is better to be misleading all the time than being
"sort of understandable" half the time and misleading the rest of
time.  At least that is consistent.

Thanks.
