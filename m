Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CDC2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F220733
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0ulpu92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBIR1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:27:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52476 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgBIR1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 12:27:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A86B59C1B;
        Sun,  9 Feb 2020 12:27:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bUAQg6c4zT49K1zKSzgLl7VeQkQ=; b=a0ulpu
        92RQ0hyRwZjEsD28vbXqJEBBb6NL1JK3UjxZKt3DtO09AJnG0zOF3ajnp6qOsqz+
        vKnTczq+2fgxtZqA5lvw8iCmyxBpwLjsjbN1a0XWGvztWTkd9Vu8zDBKcOo7McgO
        hvSmNfr4sqxCotcXQLq4yTYw5EuDrbfx79KFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gFkJArQg5SEbfqJL+yczZrFlFjne/6pz
        9zQFm8z9HfU/HqPDoQOwSr4SGerELkccJ/Y87qTYWSgbUzhiNdqaIUwceUTZWEhs
        uP0rl7KWVaxjnb9btue2ur5OGM57GvRCadq2zt5lcZ+HqG+bKhtCT3cdjjI7BQ51
        uJ2oNkbailg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 701FE59C1A;
        Sun,  9 Feb 2020 12:27:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97CA559C17;
        Sun,  9 Feb 2020 12:27:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Finn Bryant <finnbryant@gmail.com>
Subject: Re: [PATCH v4 00/15] Harden the sparse-checkout builtin
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
        <CABPp-BHoEgYXgzxjweWDR2BZPhLdW9wcbWzwo6N+HF2kste3WA@mail.gmail.com>
        <f28beb17-50dc-ff53-46bf-35010d48d23d@gmail.com>
        <20200208233247.GD33529@syl.local>
Date:   Sun, 09 Feb 2020 09:27:15 -0800
In-Reply-To: <20200208233247.GD33529@syl.local> (Taylor Blau's message of
        "Sat, 8 Feb 2020 15:32:47 -0800")
Message-ID: <xmqq1rr33c3w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AF26AD6-4B61-11EA-B92C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Feb 03, 2020 at 09:09:54AM -0500, Derrick Stolee wrote:
> ...
> Thanks for including these. I haven't been super active in the earlier
> rounds of review on this series, but I gave a thorough look to what you
> have in v4, and it all looks good to me.
>
> Please consider this:
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks, all.
