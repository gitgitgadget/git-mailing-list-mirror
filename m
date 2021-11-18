Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C7CC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC5D6142A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhKRWQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:16:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63863 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRWQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:16:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC4C8167D8B;
        Thu, 18 Nov 2021 17:13:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q45KhMMu7PzeHAlCHVZCAm8frW0bCbMaw1+f8Y
        e5avM=; b=uOiTIkUe4jeDEfNpWkG+B806gZO2j2v6kqQyYirKygu1ogmqEJouCB
        eA/Mlhm+3F0F1vsW678/MGiSU2/JC0TYk/QMqTNg4S1ofOWr7DZhCZ8nBpntg3kZ
        cLMWbGPmpnP56jg28l07BRXPkcI4jfC/dxZ2cEyNEnok2R0ig17/A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5D89167D8A;
        Thu, 18 Nov 2021 17:13:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14EDC167D89;
        Thu, 18 Nov 2021 17:13:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Sparse index: fetch, pull, ls-files
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <xmqqlf1n2krf.fsf@gitster.g>
        <08679a6f-51c1-0e48-9dcc-e7ac4c9a9c80@gmail.com>
Date:   Thu, 18 Nov 2021 14:13:17 -0800
In-Reply-To: <08679a6f-51c1-0e48-9dcc-e7ac4c9a9c80@gmail.com> (Derrick
        Stolee's message of "Wed, 17 Nov 2021 10:28:22 -0500")
Message-ID: <xmqqfsrtw1s2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC400D3A-48BC-11EC-A9F5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> But what makes sure, after all of the above happens, that no new
>> changes that assume it can walk the full index enters in the
>> codebase?
>> 
>> In other words, after "fetch" is declared "sparse clean" with patch
>> [1/2], what effort from us will it take to stay clean?
>
> The tests in t1092 that use the "ensure_not_expanded" helper are
> intended to be regression tests that would start failing if the
> sparse index starts expanding in a new way. I think this is what
> you mean by staying "sparse clean".

It is more like how would we help a new piece of code, which does
not even consider the possibility that the in-core index might be
sparse, and instead blindly walks the in-core index entries, doing
something unexpected (to both the author of the new code and to
those who are aware of the sparse-index feature) when it sees an
"tree" entry.  We'll hopefully see a breakage and the developer who
added such a new piece of code can keep both halves?

> One direction I could see is that as new features are contributed
> that change how the index is used, these features are not
> automatically tested with sparse-checkout and the sparse index.
> In this case, we will need to increase our awareness when reviewing
> such features to ensure that they could fit within the sparse index
> model (or are sufficiently protected by ensure_full_index() in their
> first version).

Yup, making developers aware of the issue is probably the good first
thing to do.

