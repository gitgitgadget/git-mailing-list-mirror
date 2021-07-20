Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C127C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0952610F7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhGTRmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:42:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhGTRl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:41:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 806E2E7D35;
        Tue, 20 Jul 2021 14:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMy4xf6wu9ui3I3r1vbcqPxgHD5dPYNIY7bPBX
        SQ3VU=; b=Gw1jPILWVPR38QS38V7QZy7t0qUz7dzaxTS4fGO+WnRveDUUvjH2z0
        cQw7V+85B1vsfjlxkSxtACLsyd/dmbvQyCCiQWlGIzMl9g0M9h/2dN9cF9kbvjYx
        JDuqyp+uUaVkVBUKF9b0RiRvGRl6U+nIrbQfawnxOGK7PLW9gY0xs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 782FEE7D34;
        Tue, 20 Jul 2021 14:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04987E7D33;
        Tue, 20 Jul 2021 14:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/9] t7601: add relative precedence tests for merge and
 rebase flags/options
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
        <xmqq35samac9.fsf@gitster.g>
        <CABPp-BFMHhxgaLnA+gLHJENVfzVv6j2Ax4G6y+XsrU3wBJq6rQ@mail.gmail.com>
Date:   Tue, 20 Jul 2021 11:22:34 -0700
In-Reply-To: <CABPp-BFMHhxgaLnA+gLHJENVfzVv6j2Ax4G6y+XsrU3wBJq6rQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 20 Jul 2021 10:10:58 -0700")
Message-ID: <xmqq35s8j15h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 748FEA62-E987-11EB-B25D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> OK.  These all ensure that when the history does not fast-forward,
>> the command will fail when --ff-only tells us to allow only
>> fast-forward.  I am not sure "takes precedence" is a meaningful
>> label, though.  It is more like "ff-only means ff-only and fails
>> when the upstream history is not a descendant, no matter how the
>> possible integration is set to be performed".
>
> So, I think you're saying you view fast-forwards as a subset of valid
> rebases (and fast-forwards are also a subset of valid rmerges), and
> thus you view --ff-only --rebase as an instruction to only proceed if
> both command line flags can be satisfied.

Ah, I didn't think of it myself, but now you put it in these words,
I do agree that the view makes sense.  When we have nothing of our
own, a degenerated form of a rebase is a fast-forward, even more so
than a fast-forward being a degenerated form of a merge.

> That makes sense, but I don't know how to put that into a test
> description that isn't ridiculously long.

Me neither.  Let's not waste too much brain-cycles over this.

Thanks.
