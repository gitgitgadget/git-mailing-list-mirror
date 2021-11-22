Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D9FC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhKVSWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:22:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55952 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKVSW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:22:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C47B153ABD;
        Mon, 22 Nov 2021 13:19:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y5aCpB2CBF3mJdCZa/VF0vl/dg/96WbyyoebDm
        U5Y9w=; b=JiJ7t70Lzd7ywbk+jjYLRyZTeL1atn++Hfb+7rvIyOLavfXwfYrF5c
        iZXEnZtPB6hV9WDWEzN5183l4UbLC674X514eSgxXwaITn3uJbRrENOVtg8qT0fm
        2rNe6xdY7gblG1lAHam+MDsrQwfMKn5oLj6ctavuXDZsv9MwjtEAw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45F03153ABC;
        Mon, 22 Nov 2021 13:19:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4EF2153ABA;
        Mon, 22 Nov 2021 13:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
        <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
        <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
        <xmqqk0h0gjnh.fsf@gitster.g>
Date:   Mon, 22 Nov 2021 10:19:15 -0800
In-Reply-To: <xmqqk0h0gjnh.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Nov 2021 09:55:14 -0800")
Message-ID: <xmqq35nogijg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F94946-4BC0-11EC-A30E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I know $GIT_PAGER trumps core.pager, which indicates between
> equivalents, environment is taken as a stronger wish.  But I do not
> mind if the order were updated to pager.<cmd> trumps $GIT_PAGER,
> which in turn trumps core.pager, which in turn trumps $PAGER.

If such a precedence order makes it impossible to override a
configured pager.<cmd> value at runtime, then it is a bad idea.  But
luckily, we can do

    git -c "pager.<cmd>=<this one-shot pager>" cmd ...

to override a configured one, so perhaps it is OK.

I tend to agree with opinions I read elsewhere in this thread that
it would be better not to do the fallback in the first place, but
in this case, what I said I am OK with is when pager.<cmd> is
defined, we do not even look at $GIT_PAGER or later choices, which
is orthogonal.



