Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C4C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiHIQ4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiHIQ4N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:56:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879B38B4
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:56:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 881271BC931;
        Tue,  9 Aug 2022 12:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wp/RGE4rMsk3zmO7LBjjNHOM2EGf5b0HeNJbqb
        vIzsc=; b=Ixn4M5h7xofyRsAZlWQxX7la/gppmOhW2Pg7U1o0xttAwRJiRanczE
        IFQnwrVup6aOsqmNWDahnf3MsB8lTTq1PjHPl+nRuzIVbof98MLH72uV7P5L4RwT
        t+heNE4d9fuZGewG2YxGQ2r+OeTZBDwfXer0vSL8fAKq6aY4Gtd74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 808DF1BC930;
        Tue,  9 Aug 2022 12:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 353CF1BC92F;
        Tue,  9 Aug 2022 12:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Noneman <emily.noneman@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Paul Horn <git@knutwalker.engineer>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault
 in pack-objects
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
        <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
        <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
        <Yu02dOo4G8sy8tI6@coredump.intra.peff.net>
        <xmqqo7wyzlpm.fsf@gitster.g>
        <CAKvVO18Du5M6broAJ6WqTAk6C4jxtqbXoS=9x03JgSdJAak80Q@mail.gmail.com>
        <YvJZWUVULB5Y8zih@coredump.intra.peff.net>
Date:   Tue, 09 Aug 2022 09:56:08 -0700
In-Reply-To: <YvJZWUVULB5Y8zih@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 9 Aug 2022 08:55:53 -0400")
Message-ID: <xmqqa68dqrtj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A9E8F7E-1804-11ED-BF0C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 08, 2022 at 02:15:21PM -0400, Emily Noneman wrote:
>
>> The latest changes seem to have resolved the issue for me. My repo was
>> a bit different than Pauls, it's a big corporate repo with a partial
>> checkout and a worktree. What's confusing is that I do see an "index"
>> file in worktrees/NetLedger_GitRepo , but git 2.37.1 exhibits the
>> crash. 2.37.1.377.g679aad9e82 works just fine.
>
> Thanks for testing. It is odd that you see an "index" file, since the
> code change is definitely focused around getting ENOENT from open() on
> the index. Is it possible that you have another worktree (even the
> initial one) without an index in it?

Yes, it affects the relevance of the new test to the case observed
in the field.

Thanks.
