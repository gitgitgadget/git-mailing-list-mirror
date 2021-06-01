Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC583C47083
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B5661186
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhFABmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 21:42:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57454 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhFABmU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 21:42:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0B68BF5A2;
        Mon, 31 May 2021 21:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yiAW9UUaX43w5kNWQkULr/MsSGwbKJXyb/1b30
        vXDG0=; b=msSumHSoYQfPoUoE5ZNsl0sl0vwvJ31v94ndJ4W3eg7/53JWJDCh95
        2iv4KokJhDnj6cM+McuPjKJK7FSifmAyACQWPVzzAyfQa7GG2KmIseqg+bmx9VON
        njuM/JvYBiWjGXhdlF8KHhciM6TeDAwlMZyRiZFJmzNg31WMP0Amw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C81C0BF5A1;
        Mon, 31 May 2021 21:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 515E0BF5A0;
        Mon, 31 May 2021 21:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
        <xmqqy2bv3ovf.fsf@gitster.g>
        <YLQFRU2avYFBfdPu@coredump.intra.peff.net>
Date:   Tue, 01 Jun 2021 10:40:38 +0900
In-Reply-To: <YLQFRU2avYFBfdPu@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 30 May 2021 17:36:05 -0400")
Message-ID: <xmqq35u2uzu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E941500-C27A-11EB-B965-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 31, 2021 at 06:15:00AM +0900, Junio C Hamano wrote:
>
>> There however is one curious thing about this.  The log message of
>> the original commit that introduced this optimization does use the
>> batch-check and batch-all-objects at the same time.  Was this
>> breakage not there when the original was written and we broke it in
>> a later update?  If so, with what commit?  Can that commit have
>> broken other places in cat-file in a similar manner?
>
> The subtlety here is that it is broken with --batch, not --batch-check.
> Only the former calls print_object_or_die(), which is after all the
> difference between the two. :)
>
>> [...]
>
> Everything else you noted was quite reasonable, but I think we can get
> further at the root of the issue; see my other email.

Yup, I missed the place we depend on type being set without
checking.
