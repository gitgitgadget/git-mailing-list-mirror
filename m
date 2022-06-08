Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E5C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiFHUkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiFHUkA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:40:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1AEACE7
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:39:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4B9E140321;
        Wed,  8 Jun 2022 16:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Msc9PGRQxhXx6Vvv3y5dhrtAfcFldt/0te3kNw
        gMFJM=; b=iR9hBFUs4A0bjkwhH0UDdSzky4E65/6BThH7LFPnTl30M1QmUDRqYB
        cYCv15HgbggPQHRru0/rg1GFJl2JgvxSTcpaBe/GiGv77n/vyx8jyeipcMyG6UZM
        0eqGI5FkaA7see2c7fAmBzS4i4j2034Pq6R/dwhwhBDxaOEs+Tqhc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB29B140320;
        Wed,  8 Jun 2022 16:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28B4414031F;
        Wed,  8 Jun 2022 16:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqsfoh4ery.fsf@gitster.g>
        <9244644f-2c80-f23d-f054-3f0c961696af@github.com>
Date:   Wed, 08 Jun 2022 13:39:41 -0700
In-Reply-To: <9244644f-2c80-f23d-f054-3f0c961696af@github.com> (Derrick
        Stolee's message of "Wed, 8 Jun 2022 15:20:45 -0400")
Message-ID: <xmqqk09qrisy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FC07E4C-E76B-11EC-B8C0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> How about creationToken? That communicates that we don't really care
> what the number is as long as it comes from an increasing sequence
> controlled by the bundle provider.

Is it important for the clients that this value is tied to creation
time?  I am trying to come up with a word like "serial" that makes
it clear that the values have no meaning other than that they are
always growing in one direction to suggest as a replacement, but
failing to find a good one.  The word should probably not have
any connotation that they must be consecutive, but "serial" numbers
are usually dense.

>> Another thing I noticed.  The above scheme makes it impossible to
>> have <id> that happens to be "list".  I think the variables that
>> apply to the entire list should be given two-level names, i.e.
>> 
>>       [bundle]
>> 	version = 1
>> 	mode = all
>> 	heuristic = timestamp
>>       [bundle "2022-02-09-1644442631-daily"]
>> 	uri = ...
>
> This then means that <id> can't be "version", "mode", or "heuristic",
> or any other possible key that we use in the future, right?

Left ;-).

Two-level variable names and three-level variable names live
completely in a separate namespace (there is no D/F conflict).

    [bundle]
        version = 1
    [bundle "version"]
        url = ...
        mode = ...

is perfectly legit.
