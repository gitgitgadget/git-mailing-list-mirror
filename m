Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F84C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 02:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B109064FB3
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 02:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBECJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:09:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59099 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBECJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 21:09:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA315B6CA5;
        Thu,  4 Feb 2021 21:08:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TpgNECCFprFWdSZeCyyE4IqWOsU=; b=Xv9Ow6
        WiT1YGsLgZz6tMzxzOGtZ5SyeDlzCaYF8N7kBo2EOfJtYW3xUJKswuMTHTtaMCHk
        nElNcW6DaW6x3+ilga+clFWlqI+RvUuspE/R+XGagvZqhmisbNIoj5w7LMP1Jbj5
        Oc+ObUaz9t+WFUVBif7ef0xUMTTEmbTiVt6CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QwU+6CFWL1KHOQgaJFyBDOJ+PDeiNFdp
        8laB+RARPXCkOhXjAQsRWM0r3ZCKhZql0oTuuvcQww1jHibJS5Y9hzrNe3wnJLeL
        sBEDuhPJ1qsLD7onP+5Cw57PMTmzh++4bwzvVRz3pHtXa8DBdjyg/WNqNf+m7eTB
        VzMCTbSShvI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C230BB6CA4;
        Thu,  4 Feb 2021 21:08:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D36CB6CA3;
        Thu,  4 Feb 2021 21:08:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/17] Refactor chunk-format into an API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 18:08:54 -0800
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 27 Jan 2021 15:01:39
        +0000")
Message-ID: <xmqqa6sj2rm1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1981FD98-6757-11EB-A3DC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is a restart on the topic previously submitted [1] but dropped because
> ak/corrected-commit-date was still in progress. This version is based on
> that branch.

I've read the topic through, and found it a pleasant read.  There
are some questionable use of integer types, some uneven application
of casts, and the reading side API is somewhat underdocumented, but
the overall direction looked quite sane.

I am undecided if I should expect a reroll, or declare what we have
"already good enough" for 'next' and expect incremental refinements,
though.  A reroll that catches all nits would certainly make the
resulting topic's history nicer for future developers to work with,
but its also a pain to re-read essentially the same patches again,
so...


