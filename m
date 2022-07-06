Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 16:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiGFQwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiGFQws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 12:52:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B3A2A425
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 09:52:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6301135404;
        Wed,  6 Jul 2022 12:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9GL2RWLhJUY2sk5PevJG+6sXediUyNBElEZQ44
        wNgcA=; b=Kj2DZpG5bxBvxbz9enb7VL5Zi6mHg6PF+zrY24wKOa4HvyTJaRc5FG
        2VcQQlSQImjUCo8hlq4E0en/byNMLPHccZUVaxA0jkwu2qgnU8pDrc0u9Lb4YGcC
        PLGYByX38zKThceOf6XPiXxSa3iBSXjqCM8xhmpOZKl1FneQERWg4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD652135403;
        Wed,  6 Jul 2022 12:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 399BD135400;
        Wed,  6 Jul 2022 12:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 0/5] Fix dual rename into each other plus conflicting
 adds
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
Date:   Wed, 06 Jul 2022 09:52:45 -0700
In-Reply-To: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Tue, 05 Jul 2022 01:33:38
        +0000")
Message-ID: <xmqqwncqi3oi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F970BA2-FD4C-11EC-A5E3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series adds some testcases based on the tensorflow repository issue
> reported by Glen Choo at [1], demonstrating bugs in both the ort and
> recursive strategies. It also provides a fix for the ort strategy.
>
> Changes since v3:
>
>  * Remove use of for-initializer

I missed them while queuing the previous round and updates look OK.

I however personally find the resulting code irritating to read.
The counter 'i', which never is used for two purposes at the same
time, has multiple "hiding" declarations in this function, in
addition to its top-level declaration.  It forces the readers to
think about which variable each reference of 'i' talks about, and
more importantly, if the value in outer 'i' of its last use, after
an inner 'i' is used, matters.

Will queue.

Thanks.
