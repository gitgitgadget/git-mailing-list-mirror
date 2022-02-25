Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82A9C4332F
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiBYRft (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbiBYRft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:35:49 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73651B1DC1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:35:16 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EB0517DFA0;
        Fri, 25 Feb 2022 12:35:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZWm60wCvy/8BMWzhkp0bt/qo7Eea8aM6W4C7zg
        vC/fI=; b=JYlUWbNgWSlblq/l3H1KTijNapeWhvK6Jcgzrjev0MrkVzMURfGmW7
        wVYqIO/x3i4WnE0Dv/SziNnac8njOUV4METw6k9F6d4JfW+Mtq9kF7U75LA4WE16
        LMDtq4jLnCftLOqPfbjrNgxAk7wiaVaogNofGCIy8tqaBqHNG0JWc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46A7317DF9F;
        Fri, 25 Feb 2022 12:35:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B26B317DF9D;
        Fri, 25 Feb 2022 12:35:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
Subject: Re: [PATCH 2/7] commit-graph: fix ordering bug in generation numbers
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <6e47ffed25795260c2b8614d4589fb58d892c8df.1645735117.git.gitgitgadget@gmail.com>
        <xmqqh78nkj2x.fsf@gitster.g>
        <756fd005-637d-a067-9949-e87fc15b3bf6@github.com>
Date:   Fri, 25 Feb 2022 09:35:12 -0800
In-Reply-To: <756fd005-637d-a067-9949-e87fc15b3bf6@github.com> (Derrick
        Stolee's message of "Fri, 25 Feb 2022 08:51:11 -0500")
Message-ID: <xmqqwnhietnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49E62772-9661-11EC-94C3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> It is very subtle, which is why it took me a while to debug this
> issue once I managed to trigger it.
>
>>     for each commit ctx->commits.list[i]:
>>         continue if generation number has been computed for it already
>
> This is the critical line in the current version. This includes
> "continue if the generation number was loaded from the previous
> commit-graph file." This means we under-count when building from
> an existing commit-graph with overflows.
>
> If we insert an increment here, then we risk double-counting. I
> should have described this better.

Ah, that obviously I missed.  Thanks.

