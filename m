Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4CEC433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8060C60EDF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 22:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhJJWFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 18:05:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65100 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhJJWFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 18:05:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C803F2AEB;
        Sun, 10 Oct 2021 18:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kPb8bEFmIabgmAwg49gKr83TYCbJf8GO0VhJS6
        vJHIU=; b=qrsItWJ+PO9P9xvnPcZBMXrTqwTfM05116VeD+jVYMT2KCnOsUgv4Z
        Adg+Mf8Q9oqphMxZG6y0t/jdTgL20h5rs6NZbpf++2z19yL7/dvqrODY+RbxIPSW
        1yzPgrejVj5Ag3ymNY9qzjS7ptTB5qjhNexemTMcr9SqZT29odHGk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81D94F2AEA;
        Sun, 10 Oct 2021 18:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAF3AF2AE6;
        Sun, 10 Oct 2021 18:03:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
        <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
        <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
        <xmqq1r4vl65w.fsf@gitster.g>
        <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com>
Date:   Sun, 10 Oct 2021 15:03:48 -0700
In-Reply-To: <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com> (Phillip Wood's
        message of "Sat, 9 Oct 2021 12:18:03 +0100")
Message-ID: <xmqqlf30edvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2E11C00-2A15-11EC-B42E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 08/10/2021 19:31, Junio C Hamano wrote:
>> Victoria Dye <vdye@github.com> writes:
>> 
>>> Phillip Wood wrote:
>> 
>>>> I was looking at the callers to prime_cache_tree() this morning
>>>> and would like to suggest an alternative approach - just delete
>>>> prime_cache_tree() and all of its callers!
>> Do you mean the calls added by new patches without understanding
>> what they are doing, or all calls to it?
>
> I mean all calls to prime_cache_tree() after having understood (or at
> least thinking that I understand) what they are doing.

Sorry, my statement was confusingly written.  I meant "calls added
by new patches, written by those who do not understand what
prime_cache_tree() calls are doing", but after re-reading it, I
think it could be taken to be referring to "you may be commenting
without understanding what prime_cache_tree() calls are doing",
which wasn't my intention.

> (a) a successful call to unpack_trees() updates the cache tree
>
> (b) all the existing calls to prime_cache_tree() follow a successful
> call to unpack_trees() and nothing touches in index in between the
> call to unpack_trees() and prime_cache_tree().

Ahh, OK.

I think we originally avoided calling cache_tree_update() lightly
(because it is essentially a "write-tree", a fairly heavy-weight
operation, without I/O) and instead relied on prime_cache_tree() to
get degraded cache-tree back into freshness.

What I forgot was that 52fca218 (unpack-trees: populate cache-tree
on successful merge, 2015-07-28) added cache_tree_update() there at
the end of unpack_trees().  The commit covers quite a wide range of
operations---the log message says "merge", but in fact anything that
uses unpack_trees() including branch switching and the resetting of
the index are affected, and they cause a full reconstruction of the
cache tree by calling cache_tree_update().

For most callers of prime_cache_tree(), like the ones in "git
read-tree" and "git reset", it is immediately obvious that we just
read from the same tree, and we should have everything from the tree
and nothing else in the resulting index, so it is clear that the
prime_cache_tree() call is recreating the same cache-tree
information that we already should have computed ourselves, and
these calls can go (or if "prime" is still cheaper than "update",
these callers can pass an option to tell unpack_trees() to skip the
cache_tree_update() call, because they will call "prime" immediately
after).

For other callers it is not immediately obvious, but I trust you are
correctly reading the code ;-)

Thanks.



