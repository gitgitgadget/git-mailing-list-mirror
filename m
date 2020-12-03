Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DECC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 21:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB1922285
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 21:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgLCVur (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 16:50:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65250 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgLCVur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 16:50:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 830DD9C0FD;
        Thu,  3 Dec 2020 16:50:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+LgF4jMxfFWnJd4tr+eLwDqGnSM=; b=TpOrL0
        ZQuQ2QsywZuKX5OpEHnKv4qTbEC7i0uz3Vat83fY6655bnmySQq1ibZo6m1uMT12
        xz/Y1SvPShX9A1dVQbJxAYY+zlndmHho+u89K7DrzVnw76XZ2XsHrzSf9sYuhy9C
        h7qokB3Mi1quJf9NxmOHnaTtbPRO0SZd7p2oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B+GqobdqQFKRpNDhLKIz+njwKFHz/PAY
        3DEMDWH+HGT0ZAsXVUUEftP3e6rAqog3aj/Ca2Arl9JClHx4YkGkvAWcFnsIR/5Y
        scuDuhHLzlzeaSJebuUH8uVy65nisPruFhhO6EvQUCjdBrO5ro714c7E/AOz6twK
        GHgMkKdTor8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B78659C0FA;
        Thu,  3 Dec 2020 16:50:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBB299C0F7;
        Thu,  3 Dec 2020 16:50:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 08/15] midx: convert chunk write methods to return int
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <dbb637a7ac6d2cc6bb78428ef7bda67687095f88.1607012215.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 13:50:00 -0800
In-Reply-To: <dbb637a7ac6d2cc6bb78428ef7bda67687095f88.1607012215.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 03 Dec 2020
        16:16:47 +0000")
Message-ID: <xmqqeek6h853.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E3A88AE-35B1-11EB-9E2F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>

> Subject: Re: [PATCH 08/15] midx: convert chunk write methods to return int

Please rephrase the title to avoid misleading the readers; it is not
like we used to return the number of bytes written in size_t but we
realized that we never write mroe than INTMAX and narrowed the
return type to "int".

In other words, returning "int" is not the most important thing in
this change.  What is more important is that the function will
eventually signal success/failure with its return value.

