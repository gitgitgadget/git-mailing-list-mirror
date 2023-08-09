Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23560C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 18:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjHISuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjHISum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 14:50:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0CE51
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 11:50:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E55D8188941;
        Wed,  9 Aug 2023 14:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5jKckiShHf6b5V2WqdBnhB3Qt+/sbKzM1zdWNZ
        XO03s=; b=KICRHcNXxZYUziG/1FW8WR1a8qoW6GLXx1mcgHk2M6REM5QikuiCZ8
        6kP3RqGWvbrIAGKzoJi6LW4Qlw1oLzfUV+aB5Jd2FRHH6tyo8OdP3BLUyI7Q2c6E
        4sJJRZ3CsN1bRlEqjizW820Rv8IqfrJ6bmsQApFz+V8ls/BGquHfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD1FA188940;
        Wed,  9 Aug 2023 14:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0466418893F;
        Wed,  9 Aug 2023 14:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net, lenaic@lhuard.fr
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
        <ZNFgIyuhlNd8I9Y2@nand.local>
        <8854e369-fabb-4044-a06c-eaf5b9fbde4a@github.com>
        <ZNKfxOWJAuJ5DxAN@nand.local>
        <a1e7d730-e220-48ec-8393-2d3538b80163@github.com>
Date:   Wed, 09 Aug 2023 11:50:38 -0700
In-Reply-To: <a1e7d730-e220-48ec-8393-2d3538b80163@github.com> (Derrick
        Stolee's message of "Wed, 9 Aug 2023 08:17:37 -0400")
Message-ID: <xmqq7cq4nj7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2B6B5B2-36E5-11EE-9FA1-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Instead of using srand() and rand() (which would make sense to wrap with
>> git_rand() as you propose), we can simplify our lives by using a CSPRNG,
>> which only gets initialized once, as is already the case with
>> csprng_bytes().
>
> So the idea is to use csprng_bytes() everywhere instead of srand()/rand().
>
> I can adjust my local patch to still create git_rand(), but base it on
> csprng_bytes() and not collide with your patch. Mimicking rand()'s behavior
> is a simpler interface to consume.

I am still ambivalent about wasting entropy for something that
srand() would suffice, so git_rand() interface may be an welcome
addition anyway, that serves an extra layer of indirection to
insulate the callers from the implementation.

Thanks.
