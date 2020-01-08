Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D71C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16B20656
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fXOY9lVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgAHSGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:06:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64559 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgAHSGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 13:06:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43E1498458;
        Wed,  8 Jan 2020 13:06:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YlHuG7unG1jdfAVajL0Dd5oINlM=; b=fXOY9l
        VUPzv2pFHDK36a7gEp1tmQ1xdHYjCWsN0JfAJK1/NsqIeWR+LnL85UXKPKBrp+53
        qi4QmIvztThW8ZvcX4QEaoF+P2t9hGxdsXqEZ+Iv5lWGyKQvbnRmBSLrrwoxUAat
        fyJuloUccufYc477u9UX8CBJRzzrl+ioENo+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dZVOqpSAQAp9pCfK8EfCNi7cQQVUVdIP
        B882q9uVKjeFSeAFOMK9FT9lACZd8/HmvNm0ogoAsQJF+q3l6qrB40NOC/znO0Ih
        X+QDoViSDWx0E1AFzD50dS4wZNCTWkwqQwYJlBf2MbXjVW08K4oUWia8PjCvVh0a
        jzlsXpJSSIY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B5EC98457;
        Wed,  8 Jan 2020 13:06:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6114498455;
        Wed,  8 Jan 2020 13:06:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Graph horizontal fix
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 10:06:37 -0800
In-Reply-To: <pull.518.git.1578457675.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Wed, 08 Jan 2020 04:27:53 +0000")
Message-ID: <xmqq5zhl3jrm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E0CF76C-3241-11EA-BA3F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This depends on ds/graph-assert-fix.
>
> This is a non-critical (not needed for v2.25.0) response to the previous
> discussions [1] [2].
>
> While working to resolve the fix for the assert() bug, I noticed this
> regression when multiple edges wanted to collapse with horizontal lines. It
> takes a reasonably large graph, but real projects are likely to demonstrate
> this behavior.
>
> I arranged the series into two patches: 1. the (failing) test, and 2. the
> fix.
>
> The fix commit includes some details about why the change to compress merge
> commits caused this regression, and why I feel relatively confident that
> this is a correct resolution.

I am not sure if this is "fix" of "bug" in that what is shown
without 2/2 (iow, "before this change" in the description of 2/2) is
"wrong" per-se---it is just that it leaves room to be made even more
compact.  It still is an improvement, of course, though.

Queued.  Thanks.

>
> Thanks, -Stolee
>
> [1] 
> https://lore.kernel.org/git/faa954fa-ccb9-b034-a39d-d2f0696826ea@gmail.com/T/#t
> [2] 
> https://lore.kernel.org/git/xmqqk1635gwu.fsf@gitster-ct.c.googlers.com/T/#t
>
> Derrick Stolee (2):
>   graph: add test to demonstrate horizontal line bug
>   graph: fix collapse of multiple edges
>
>  graph.c                      | 10 ++++--
>  t/t4215-log-skewed-merges.sh | 62 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 2 deletions(-)
>
>
> base-commit: aa2121af50498c7ea9d5c4c87f9dc66605bf772b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-518%2Fderrickstolee%2Fgraph-horizontal-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-518/derrickstolee/graph-horizontal-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/518
