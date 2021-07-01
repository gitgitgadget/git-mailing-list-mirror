Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD844C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878B06138C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhGAUDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:03:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63878 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGAUDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 16:03:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A974C144C3E;
        Thu,  1 Jul 2021 16:00:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+xcz/lA8Q076GOdUlDxdJ8RN9gKHhB1zRmp1sh
        M6Ne0=; b=ZwTxZT1Gewh4PtxABfxWM1HT0UZMfsR/aHAuQwbEn/pstJ/BFbpPHd
        PE+dsa5KkNH9EW9/h2PrJbb8Eag+vuDUZVKq4VqPzX7UlGT9Ht/lahABd/vguGgP
        o58gT6ee1vp+7ZmHrr8hEMfahmEgjluGjkjRsnehVCKT3ZHySvuPk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A27C9144C3D;
        Thu,  1 Jul 2021 16:00:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4FA3144C3C;
        Thu,  1 Jul 2021 16:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 23/34] t/helper/test-touch: add helper to touch a
 series of files
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <3cf8f3cd7717dad69262ae884a89c1a6ca0ce5fc.1625150864.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 13:00:30 -0700
In-Reply-To: <3cf8f3cd7717dad69262ae884a89c1a6ca0ce5fc.1625150864.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 01 Jul 2021
        14:47:33 +0000")
Message-ID: <xmqqsg0xreht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD835966-DAA6-11EB-9514-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/helper/test-touch.c b/t/helper/test-touch.c
> new file mode 100644
> index 00000000000..e9b3b754f1f
> --- /dev/null
> +++ b/t/helper/test-touch.c
> @@ -0,0 +1,126 @@
> +/*
> + * test-touch.c: variation on /usr/bin/touch to speed up tests
> + * with a large number of files (primarily on Windows where child
> + * process are very, very expensive).
> + */
> +
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +
> +char *seq_pattern;
> +int seq_start = 1;
> +int seq_count = 1;

With this in, "make sparse" dies like this:

    SP t/helper/test-touch.c
t/helper/test-touch.c:11:6: error: symbol 'seq_pattern' was not declared. Should it be static?
t/helper/test-touch.c:12:5: error: symbol 'seq_start' was not declared. Should it be static?
t/helper/test-touch.c:13:5: error: symbol 'seq_count' was not declared. Should it be static?

