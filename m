Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB96AC433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiC2QxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiC2QxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:53:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA82527BF
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:51:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A729118EB3;
        Tue, 29 Mar 2022 12:51:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QjUizor22tmXqDmH1q8x2/Uaz+qhxh7pgcgoh3
        zcQ7s=; b=ScO7KUOb/W6fesnjyuGDHGZfKj+2OE8C0Pk6kLdywPkoFyqeREGABc
        tI1jQ0CIPnQYdh78B+YuqiSp1yTMXalYYkzv4DrcSRhXOEjJYDrO/hVabNE0fr1u
        IxCwtuz9VtZU/8T2ua8c6BJXwOaTEfI/D3GfQbnYnC62XyjYfHtOE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72C5E118EB2;
        Tue, 29 Mar 2022 12:51:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFECB118EB1;
        Tue, 29 Mar 2022 12:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 1/2] untracked-cache: test untracked-cache-bypassing
 behavior with -uall
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
        <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
        <98a4d8f35c5abfcda5590f7e511f7b576000fd5a.1648553134.git.gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 09:51:21 -0700
In-Reply-To: <98a4d8f35c5abfcda5590f7e511f7b576000fd5a.1648553134.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Tue, 29 Mar 2022 11:25:33
        +0000")
Message-ID: <xmqq5ynwwvli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7707EDCA-AF80-11EC-8874-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +# Bypassing the untracked cache here is not desirable, but it expected
> +# in the current implementation

If that is the case, it is much more desirable to squash it into a
single [2/2] patch so that the desirable working is documented (so
future breakage can be caught), the reviewers can read what the
intended behaviour is more easily (so we do not have to be confused
by this one saying "expect success"), make it easier to cherry-pick
the fix and test in the same patch elsewhere, and the existing
breakage can easily be caught by applying only the test part of the
patch.

Thanks.

> +test_expect_success 'untracked cache is bypassed with -uall' '
> +	: >../trace.output &&
> +	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
> +	git status -uall --porcelain >../actual &&
> +	iuc status -uall --porcelain >../status.iuc &&
> +	test_cmp ../status_uall.expect ../status.iuc &&
> +	test_cmp ../status_uall.expect ../actual &&
> +	get_relevant_traces ../trace.output ../trace.relevant &&
> +	cat >../trace.expect <<EOF &&
> + ....path:
> +EOF
> +	test_cmp ../trace.expect ../trace.relevant
> +'
> +
> +test_expect_success 'untracked cache remains after bypass' '
> +	test-tool dump-untracked-cache >../actual &&
> +	test_cmp ../dump.expect ../actual
> +'
> +
>  test_expect_success 'modify in root directory, one dir invalidation' '
>  	: >four &&
>  	test-tool chmtime =-240 four &&
