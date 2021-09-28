Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C472C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F385613A9
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbhI1Xvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:51:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50652 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbhI1Xvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:51:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DD7D14C18D;
        Tue, 28 Sep 2021 19:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AA85RTzce9Gloa+tyYMC4jCYG3PGE4Wkc6q8Oc
        OELZg=; b=EDuyAIGMqbT4FVAZbsEeiQH2W2wF50rYRb1c14981hqf2rm5PgP++C
        B6ISQq5AbfaSYbL7Xiu3b+xLvQUIWrZwwUiFVB+4nHLBHBW2yFoP/rhknf4hGuCf
        Iz9A2vcMdhoz3qm9ddScI1INPjhjwXJZe9xu3xidaPYyJznmcmUE8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7720E14C18C;
        Tue, 28 Sep 2021 19:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD75814C18B;
        Tue, 28 Sep 2021 19:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/7] ll-merge: add API for capturing warnings in a
 strbuf instead of stderr
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <2bf5efb5169b71ee7c1da006a74aa67794f1399d.1630376800.git.gitgitgadget@gmail.com>
        <YVOZRhWttzF18Xql@coredump.intra.peff.net>
Date:   Tue, 28 Sep 2021 16:49:54 -0700
In-Reply-To: <YVOZRhWttzF18Xql@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 28 Sep 2021 18:37:58 -0400")
Message-ID: <xmqqpmssgt0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C85B7E52-20B6-11EC-9DBA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do wonder if the ll_merge() code should avoid calling warning() in the
> first place. It is after all, meant to be "low-level". We already return
> an error code from the function. I wonder if returning a more detailed
> code instead, like:
>
>   enum LL_MERGE_RESULT {
> 	LL_MERGE_OK = 0,
> 	LL_MERGE_CONFLICT,
> 	LL_MERGE_BINARY_CONFLICT,
>   };
>
> would let the caller do the sensible thing.

I like it better as a longer-term direction.

