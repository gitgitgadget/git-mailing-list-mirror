Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF4C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A62422597
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAWVmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:42:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53144 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAWVmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:42:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6409E9061C;
        Sat, 23 Jan 2021 16:41:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uyjFhPEges202K6llyUvI0Motdk=; b=EhI/yP
        gmr58ugwwTlIBpYr0WfkvxL/T/BUB3cGY33lU8ryXFWXSDmtjxcN17i0R9bIQ7ev
        ZAV0b3qFu9Ikq5KvMswjxWV6ffmbSgugXPRqH9S6GR4zUN736MoOHVr+np0Kgo3n
        U+3mzO0tp4gb8nzel8aZfiuEB9cVHYQnwEk/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dbchvUhgaseHwiD5OKSce/APRzyoh7y+
        Y1tWezNiJo5B4SHbVOiYSq/K3ZMmLxniLrKYZuVBH8+eL08lJuEO77zuEBremMX0
        M0IqAEnKLSOpj38KQy2GjkS/VqFV+6pW/mFqKo34u/PhqEu/N734GiilXio1NpE6
        T7zb1YlGCXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 556709061B;
        Sat, 23 Jan 2021 16:41:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9A5A9061A;
        Sat, 23 Jan 2021 16:41:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
        <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
        <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
        <d910be29-ba90-bbe1-fd96-523508b99781@gmail.com>
Date:   Sat, 23 Jan 2021 13:41:22 -0800
In-Reply-To: <d910be29-ba90-bbe1-fd96-523508b99781@gmail.com> (Derrick
        Stolee's message of "Sat, 23 Jan 2021 16:02:22 -0500")
Message-ID: <xmqqh7n72uwt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC991090-5DC3-11EB-B0D1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/23/2021 3:24 PM, Elijah Newren wrote:
>> On Sat, Jan 23, 2021 at 11:58 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> -       for (i = 0; i < entries - 1; i++) {
>>> +       for (i = 0; i + 1 < istate->cache_nr; i++) {
>>>                 /* path/file always comes after path because of the way
>>>                  * the cache is sorted.  Also path can appear only once,
>>>                  * which means conflicting one would immediately follow.
>>>                  */
>>> -               const struct cache_entry *this_ce = cache[i];
>>> -               const struct cache_entry *next_ce = cache[i + 1];
>>> +               const struct cache_entry *this_ce = istate->cache[i];
>>> +               const struct cache_entry *next_ce = istate->cache[i + 1];
>>>                 const char *this_name = this_ce->name;
>>>                 const char *next_name = next_ce->name;
>>>                 int this_len = ce_namelen(this_ce);
>> Makes sense.  Thanks for explaining the i + 1 < istate->cache_nr bit
>> in the commit message; made it easier to read through quickly.  I'm
>> curious if it deserves a comment in the code too, since it does feel
>> slightly unusual.
>
> I would argue that "i + 1 < N" is a more natural way to write this,
> because we use "i + 1" as an index, so we want to ensure the index
> we are about to use is within range. "i < N - 1" is the backwards
> way to write that statement.

Our mails have crossed, I guess.  Comparing i+1 and N is also good.


