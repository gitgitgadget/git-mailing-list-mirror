Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592BC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8FF613F5
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEYCmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 22:42:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51303 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhEYCme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 22:42:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A7ECBB2A3;
        Mon, 24 May 2021 22:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B5fHsPucJDzGwqf9o4WL0gISNrbLhgRdhFEDbF
        QB8ek=; b=YK+J2/aPn4YxmNOxlRCBeyJRRct/guCAgcT26uBWX0wsUNWH++0H7O
        gOCuhMl0zjUisvKtvobHoY5an2prgCSQMIdUHoBr9dQptXrnsv+s9mV02XkcOYtw
        caczcu3ZKrpfzqwuFe6OLHCTGcWnzqZ18JWLVAzkLz3f4JyocgIcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 929E3BB2A2;
        Mon, 24 May 2021 22:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EF9FBB2A1;
        Mon, 24 May 2021 22:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
Date:   Tue, 25 May 2021 11:41:04 +0900
In-Reply-To: <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com> (Derrick
        Stolee's message of "Mon, 24 May 2021 16:38:18 -0400")
Message-ID: <xmqqa6ojilhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6CA1BEE-BD02-11EB-ABCA-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The test is comparing the same exact Git command just with
> different configurations. Any change to what Git writes to
> stderr should be consistent across these, unless there is
> an explicit reason why it would behave differently across
> these options (for example, saying "You are in a sparse
> checkout" in 'git status').
>
> There are no expectations that stderr is stable across
> versions of Git. These tests don't add friction to developers
> making new features or changing the error messages that appear
> over stderr. It's just that these tests should catch any
> unintended inconsistency across these modes.

If it just happens that an auto-gc gets triggered, and millions of
other similar reasons in the future, will break that expectation,
without running two different vintages of Git.

I agree with Jonathan that it fundamentally is flakey to expect two
invocations of Git will behave exactly the same.  Even repacking a
repository starting from exactly the same state into a single pack
may not produce byte-for-byte identical result due to thread
scheduling.
