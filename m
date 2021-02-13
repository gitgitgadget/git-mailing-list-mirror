Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B717C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D67F64DA5
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBMBQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:16:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61349 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBMBQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:16:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EA13AED31;
        Fri, 12 Feb 2021 20:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=46L20/SHmMVMBaLsFLxc6CLJxQo=; b=U8/Dhm
        5RBoGEeuNC4GIdSFvR+EHnhPlX5HB0PudpaSxd7ZRZJkcjYOupI+/jAnTS1wwx8T
        xybXRXq+lgpJ8leflO0Ieu9qX9wuzFr4JclscND6x7WFko6++n6pOei+/9uIRlhW
        B5kl8zVofMZ/PULPYRaZr19rvAr6coHXCmO/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jqL8OG6lyF5505uB8BeKcpCMhLMAiRfO
        +hkCH2EjS1rtB3d4FEXUdkfoh1UeMQq8RMJEemR7Vu+HzzeRqDyxAcWAwaRXsPGH
        KVG6bEk2ToVxWBz9NtFcNgf+be4u0V9dMNqjzygcWg0V8TPzP9/B6lyAShOiid25
        uisApiKHLiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93C89AED30;
        Fri, 12 Feb 2021 20:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13025AED2F;
        Fri, 12 Feb 2021 20:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/5] t4001: add a test comparing basename similarity
 and content similarity
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:15:30 -0800
In-Reply-To: <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 10 Feb 2021
        15:15:36 +0000")
Message-ID: <xmqq4kigvkct.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6FA6FE2-6D98-11EB-B004-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Add a simple test where a removed file is similar to two different added
> files; one of them has the same basename, and the other has a slightly
> higher content similarity.  Without break detection, filename similarity
> of 100% trumps content similarity for pairing up related files.  For
> any filename similarity less than 100%, the opposite is true -- content
> similarity is all that matters.  Add a testcase that documents this.

I am not sure why it is the "opposite".  When contents are similar
to the same degree of 100%, we tiebreak with the filename.  We never
favor a pair between the same filename over a pair between different
filenames with better content similarity.

And when contents are similar to the same degree of less than 100%,
we do not favor a pair between the same filename over a pair between
different filenames, as long as they are similar to the same degree.

So, I do not think "opposite" is helping readers to understand what
is going on.

> +test_expect_success 'basename similarity vs best similarity' '
> +	mkdir subdir &&
> +	test_write_lines line1 line2 line3 line4 line5 \
> +			 line6 line7 line8 line9 line10 >subdir/file.txt &&
> +	git add subdir/file.txt &&
> +	git commit -m "base txt" &&
> +
> +	git rm subdir/file.txt &&
> +	test_write_lines line1 line2 line3 line4 line5 \
> +			  line6 line7 line8 >file.txt &&
> +	test_write_lines line1 line2 line3 line4 line5 \
> +			  line6 line7 line8 line9 >file.md &&
> +	git add file.txt file.md &&
> +	git commit -a -m "rename" &&
> +	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
> +	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
> +	# but since same basenames are checked first...

I am not sure what the second line of this comment wants to imply
with the ellipses here.  Care to finish the sentence?

Or was the second line planned to be added when we start applying
the "check only the same filename first and see if we find a
better-than-reasonable match" heuristics but somehow survived
"rebase -i" and ended up here?

> +	cat >expected <<-\EOF &&
> +	R088	subdir/file.txt	file.md
> +	A	file.txt
> +	EOF
> +	test_cmp expected actual

Thanks.
