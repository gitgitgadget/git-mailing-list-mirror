Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54768C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 22:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF5B2223E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 22:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLCWSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:18:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61671 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLCWSW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 17:18:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3184E9C689;
        Thu,  3 Dec 2020 17:17:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QHhR9+tjXpYAt5kjcrt6NFywg9c=; b=Rq6fGb
        VLX8hZuh6yqmRAH8q22UWMC5Hecvigq216i/J91Uhmr5G7NwWcRRyoHPib6qmOOp
        +hpbychYbisMamVDpTFWnITLkr74IL/ZZN4JPufdT8hr82LW1HvdZbFuTlaZthNQ
        aigT4v73N9UThIavLRg/W0Kol9pTiKS3klVN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LfOP5u/lEJxchb+AKBOx0Qs7t9I3toxc
        Yt5zAeX1ak5N0sDFA0wuG2KjmoYO8gEX5W0f0gC6pFD1lL/t2Q7OnPkrhWPofWsQ
        TXIWRPqXYlG2T2jqp4MHuZR20mY6c3iAx/Y9vlhan4nzNYr87nzdiZKiARvPc7eu
        5lKLydwGIRc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 284469C688;
        Thu,  3 Dec 2020 17:17:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94A909C687;
        Thu,  3 Dec 2020 17:17:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 13/15] chunk-format: create chunk reading API
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 14:17:38 -0800
In-Reply-To: <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 03 Dec 2020
        16:16:52 +0000")
Message-ID: <xmqq5z5ih6v1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AF4F452-35B5-11EB-927E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Now that the chunk-format API has a consistent mechanism for writing
> file formats based on chunks, let's extend it to also parse chunk-based
> files during read.

Heads-up.  The generation-data work by Abhishek would conflict with
the way how this refactors the way the beginning offset of each
chunk is found.
