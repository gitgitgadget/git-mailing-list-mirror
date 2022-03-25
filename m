Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9FAC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiCYT06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiCYT0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:26:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891211E113E
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 11:59:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E30A910F3DD;
        Fri, 25 Mar 2022 13:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZGLP8png6nI9nxXVu9DB90aZULd9Y1m16dXQjm
        x0eOY=; b=kSbQ0eu7/a44/c7JaKfJQ4H4ShWcKNhxHMrahDKoJspl3CHObbCpso
        MJzzVHiP6IDVn0qGYRQz/1NtJQ9N8u1XM/DSncou4H6GiP8lTFr7gJRrYsOYxJNY
        pjbja8JJII//2qa/bwN5LlfRyqhecfHOq8onsNfgel/c6CPiWphAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D954510F3DC;
        Fri, 25 Mar 2022 13:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43C3510F3DB;
        Fri, 25 Mar 2022 13:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] test-lib-functions: fix test_subcommand_inexact
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
        <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
        <xmqqtubnf568.fsf@gitster.g>
        <fc1db75c-868c-08c6-7087-b70460653460@github.com>
Date:   Fri, 25 Mar 2022 10:25:27 -0700
In-Reply-To: <fc1db75c-868c-08c6-7087-b70460653460@github.com> (Derrick
        Stolee's message of "Fri, 25 Mar 2022 10:03:33 -0400")
Message-ID: <xmqqils2aqrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9082D1A2-AC60-11EC-975F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/24/2022 4:48 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>> All existing tests continue to pass with this change. There was one
>>> instance from t7700-repack.sh that was taking advantage of this
>>> flexibility, but it was removed in the previous change.
>> 
>> Of course all existing tests continue to pass, as we no longer have
>> any user of test_subcommand_inexact after the previous step ;-).
>
> Yeah, I definitely should have checked to see if there were other
> uses of this. I thought there was, but I was mistaken.
>
>> Among
>> 
>>  (1) doing nothing,
>>  (2) removing, and
>>  (3) clarifying the implementation,
>> 
>> my preference would be 2 > 1 > 3.  If we add
>
> I agree that (2) is the best option here.
>  
>>  (4) clarify the implementation and document what kind of inexactness we
>>      tolerate with an updated comment"
>> 
>> to the mix, that would come before all 3 others, though.
>
> Is there value in fixing the implementation and adding this comment
> if we are to just delete the helper? I suppose that we could prevent
> a future contribution from reintroducing the broken implementation.

That is a good thoguth to take into account.

> My current feeling is that we should just delete this and refer
> to that deletion if anyone considers needing something like it.

I am very much in favor of deleting it.

Thanks.
