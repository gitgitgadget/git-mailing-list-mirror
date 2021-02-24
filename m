Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79AC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD4B64EF1
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhBXTo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:44:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60746 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBXToz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:44:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0546A112508;
        Wed, 24 Feb 2021 14:44:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z2//mI9oABkgWghtwQNGTJWFZm8=; b=RywPTC
        m6GxUDT8zsSyZC1MS3aW+mxnCO03RRrZsnEmn+uMdBMOUtbRSxHHn8Y3WnizoG7G
        1TQ6JWCyMzu24ukX3EJecvveQAZkPdJhknFY+uVQ5wjbBH9cDB0R8s32WnNqq5Ia
        oeTETOXa9Q3115KyKfnzFxs4X4BcV7/Rnd85o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mpwu/zNyASfdiqOXObDzT1pL7gDizpkL
        jnGs4hP16fXBHylgWO7S1LODsZMkv8/+hEYi7Z6ILqMU3O/KtpTmRjHrXWcQluqj
        eNQ8SXudnA3pRAM1YHnlyBJ8PlU7TIeGtMoX6LCjueDDz7lDXn91XuWVkly3U0Cu
        IBvbYj43jmY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0BA7112507;
        Wed, 24 Feb 2021 14:44:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DE99112506;
        Wed, 24 Feb 2021 14:44:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, l.s.r@web.de,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/17] commit-graph: use chunk-format write API
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
        <ddebf2389880e14a332e354f7b1dbc86a3964985.1613657259.git.gitgitgadget@gmail.com>
        <20210224165242.GB3590451@szeder.dev> <YDaI9pVzW5wkK1aT@nand.local>
        <bb2ca73b-f60b-0030-2b28-753da48bf7a5@gmail.com>
Date:   Wed, 24 Feb 2021 11:44:09 -0800
In-Reply-To: <bb2ca73b-f60b-0030-2b28-753da48bf7a5@gmail.com> (Derrick
        Stolee's message of "Wed, 24 Feb 2021 12:52:16 -0500")
Message-ID: <xmqqv9ahz1x2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA986B60-76D8-11EB-A6A8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> This patch series messes up the "Writing out commit graph" progress
>>> display, and starting at this commit I get:
>
> Thanks for the report and identifying the exact place that caused the
> mistake.
>  
>> I can confirm. It looks like we never dropped the 'num_chunks' variable,
>> which should have happened in this patch.
>
> Yes, makes sense. Hard to see that 'num_chunks' wasn't used because it
> _was_ being used, just not as intended.
> ...
>
> This is obviously correct. Thanks for the quick patch!

Thanks all for noticing and fixing before the series hit the master
branch.

