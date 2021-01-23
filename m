Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7EAC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1C22CAF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAWVL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:11:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWVL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:11:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87B12117FE4;
        Sat, 23 Jan 2021 16:10:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lfp5uumzPpajfrJSRrnA7uAHPTc=; b=ecqL7R
        BKF5ANlFRb5vsC9nZ/YK/wTDNjvjyOM/0B4jiWKsPRe6ltLc7CxODYA59UIsUw5V
        ucENuAlALLTvM1q1lozKgiB0HcpZmdEThTEp19QNjnRsK4+7XehLmDpQimLJ8f98
        0HguOi7Pe5gTfz3QZmC1Ez3HJrNw8/rvJJNx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wvaqV/cQOjtnI/SrA+qkannqlD3NKXdr
        T+fqemipy6s15JlecpuIPP712BNoIxLmpHFzXhkPedO0rqR+IePpm+No9NqSZkA4
        ZcXlhX3Qh5Emetu/Qcl0ZXvjfG8HiGTUbgIl2HiTSlAtfvpjnpLenWlKhRmRbZUG
        M8DF8zXnvq8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FE6F117FE3;
        Sat, 23 Jan 2021 16:10:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7660F117FE1;
        Sat, 23 Jan 2021 16:10:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
        <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
        <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
Date:   Sat, 23 Jan 2021 13:10:39 -0800
In-Reply-To: <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
        (Elijah Newren's message of "Sat, 23 Jan 2021 12:24:30 -0800")
Message-ID: <xmqqy2gj2wc0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73088888-5DBF-11EB-A3D3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> -       for (i = 0; i < entries - 1; i++) {
>> +       for (i = 0; i + 1 < istate->cache_nr; i++) {
>>                 /* path/file always comes after path because of the way
>>                  * the cache is sorted.  Also path can appear only once,
>>                  * which means conflicting one would immediately follow.
>>                  */
>> -               const struct cache_entry *this_ce = cache[i];
>> -               const struct cache_entry *next_ce = cache[i + 1];
>> +               const struct cache_entry *this_ce = istate->cache[i];
>> +               const struct cache_entry *next_ce = istate->cache[i + 1];
>
> Makes sense.  Thanks for explaining the i + 1 < istate->cache_nr bit
> in the commit message; made it easier to read through quickly.  I'm
> curious if it deserves a comment in the code too, since it does feel
> slightly unusual.

I think this is entirely my fault.

It probably reads more natural to start from 1 and interate through
to the end of the array, comparing the current one with the previous
entry, i.e.

	for (i = 1; i < istate->cache_nr; i++) {
        	prev = cache[i - 1];
		this = cache[i];
                compare(prev, this);

