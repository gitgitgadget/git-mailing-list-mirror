Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A471C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A1A233EB
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgLPUmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:42:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51780 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgLPUml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:42:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02A7FA6471;
        Wed, 16 Dec 2020 15:41:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TE+oMiz0cWclX1G6tVUIMwhxx+4=; b=LYoMxp
        sbRvP8Y9uFVQeLk0MYa7LTYRvvEWyzV2R0WeA5y0FliwzSTWf3b3ybEHBtgOSj0a
        eHrug/Z19fF7xRvZIcUKKCZVayUHer01rVorBsFHpqixE5mkGk9IbEpL4sM7nc/B
        aMNSc//rv3qM9tLgLuDK9PewJnIoaij2N9xsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gRy4UTPjZGIOyqTFk3hwxszC+TuZ1eGs
        QzNC0Uf+GZyy8HtQyHNEYc50WrCWFpWVxzkE+Ho5Kxtx8HOkr0KZolBUirgl9mqn
        AE93tHiyUdeF7PfDfJcb2230hGYfuQ8bHqitvTlTQV6ZQMarORkSJh7qregvY0OM
        ruNPmMp1vj8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC88DA6470;
        Wed, 16 Dec 2020 15:41:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7643DA646F;
        Wed, 16 Dec 2020 15:41:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
        <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com>
        <xmqqim914pfs.fsf@gitster.c.googlers.com>
        <CABPp-BG+_4Dv_+HNgQxW8KNe1q04NwuhRpExeOuc=wLeunsj_w@mail.gmail.com>
Date:   Wed, 16 Dec 2020 12:41:56 -0800
In-Reply-To: <CABPp-BG+_4Dv_+HNgQxW8KNe1q04NwuhRpExeOuc=wLeunsj_w@mail.gmail.com>
        (Elijah Newren's message of "Wed, 16 Dec 2020 11:20:45 -0800")
Message-ID: <xmqqlfdx32ln.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23C0A9A2-3FDF-11EB-ACD3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I wonder if a slightly different codeflow may be easier to follow
>>
>>         struct commit_list *result = NULL;
>>         while (list) {
>>                 struct commit_list *next = list->next;
>>                 list->next = result;
>>                 result = list;
>>                 list = next;
>>         }
>>         return result;
>>
>> if we were to try improving this for readability?
>
> Looks like Felipe also came up with the same version you did (modulo
> the temporary variable name).

Funny if it was sent as a response to the message that already had
the same answer...

>> I dunno if it matters too much, though.
>
> Yeah, reverse_commit_list() has been unchanged in merge-recursive.c
> since its introduction in August of 2006.  The function's purpose
> seems obvious from its name, so no one ever needs to look at or modify
> the implementation.  I'm certain I'll never touch it again.  So, I
> personally don't care what the particular implementation is, and I'm
> happy to take whatever reviewers prefer here.
>
> Since we have three people weighing in with opinions though -- and on
> a point that's irrelevant to me -- do you want to make the call here
> Junio?

If I were pressed to give a suggestion, I have two ;-)

I would prefer to see us first find out if all other callers of
get_merge_bases() _care_ about a particular order of the resulting
list.  If they do not care [*1*] and if it seems feasible to teach
get_merge_bases() build its return value reversed already without
too much extra effort, then the commit list reverser can
disappear and get_merge_bases() can be fixed to return its commit
list in older-to-newer order.

If the above does not happen, then I'd prefer to see a single commit
list reverser in commit.c and have it *shared* between the two merge
backends, instead of adding another one in merge-ort.c while leaving
the one in merge-recursive.c behind.  And the single implementation
can be either "copied from merge-recursive as that may be
unintuitive or harder to follow but at least we know it is battle
tested", or the one we see above.  If we were to take the latter, we
really need to avoid making stupid mistakes while attempting to
replace an existing awkward one with "simplified" version, though.

Sorry for listing even more work, but since you asked ... ;-)


[Footnote]

*1* if those who care actually would benefit if we used
older-to-newer order, it would be even better.
