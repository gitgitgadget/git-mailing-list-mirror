Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4020FC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 02:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAF561378
	for <git@archiver.kernel.org>; Thu, 27 May 2021 02:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhE0CTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 22:19:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59349 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhE0CTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 22:19:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85471BCA0B;
        Wed, 26 May 2021 22:18:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3/o1536A4K8xv08Wcgq+h/kbey2cglIXlvonS
        +v4k8=; b=WW7W7HOKmcLHCkPc19X00z0bn7dEnx0ca5NUTkLUIgx8A8K7Yash1v
        3CdPnhoKtKVCFXN2drCkGIsVmB0jCaB/Wr52ZPJJD00HtLDTlZ5MneHBTI+MTvJU
        8tDaoFfxCCY1igdihuVHkso54g6Cn7TdOEyOD0fjBgsp9PpJqJujM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D4BBBCA0A;
        Wed, 26 May 2021 22:18:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15D6FBCA07;
        Wed, 26 May 2021 22:18:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 02/37] hook: introduce git-hook subcommand
References: <20210527000856.695702-1-emilyshaffer@google.com>
        <20210527000856.695702-3-emilyshaffer@google.com>
Date:   Thu, 27 May 2021 11:18:12 +0900
In-Reply-To: <20210527000856.695702-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 26 May 2021 17:08:21 -0700")
Message-ID: <xmqqim34api3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9DAE498-BE91-11EB-A4D5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/hook.c b/hook.c
> new file mode 100644
> index 0000000000..d3e28aa73a
> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,120 @@
> +#include "cache.h"
> +
> +#include "hook.h"
> +#include "config.h"
> +
> +void free_hook(struct hook *ptr)

Should this be "static" (and be removed from hook.h)?  Even after
the whole series, nobody outside seems to use this function.
