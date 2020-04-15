Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC97C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 21:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831912076C
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 21:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vw38BgzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439074AbgDOV0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:26:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53156 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439052AbgDOVZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 17:25:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DEF5C6C9D;
        Wed, 15 Apr 2020 17:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s8JQXCb6o78WLo9PWlTQoseU8cI=; b=vw38Bg
        zQSuSeLQ86UgMcF8YUVwAVpszeOJS7lQUHnJGGuPjCOCuWhduUFbRXjNwur5FQnI
        ggsUJMvBLCNwlnx44Vn5KonrWSVAgsxZKm4ad9V6txYMkDrAx+N1c36mI6D3ioBd
        WxRkLWjiCbzxvMG/2x5lrSKeBp0THjims8apA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xa4smQ2Vt4YLw8AvG1BAvyEvlcCFEfCA
        pslWHM/x2k1cYGovMksN5Ts2WbTXRSIKZc//DU9DtK3BzjvOSmHwgE24zSRB9wwV
        2h9lfjEyQ8b4gPjPG7tGivbnrIjRpTWG10TiraTppKyH6GLhfQH2/CJsSlzukWQG
        0Lm2zZIK5Zc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6549DC6C9C;
        Wed, 15 Apr 2020 17:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28B60C6C9B;
        Wed, 15 Apr 2020 17:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        <xmqqeesthfbf.fsf@gitster.c.googlers.com>
        <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
        <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
        <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
        <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
Date:   Wed, 15 Apr 2020 14:25:48 -0700
In-Reply-To: <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com> (Derrick
        Stolee's message of "Wed, 15 Apr 2020 14:37:40 -0400")
Message-ID: <xmqq8siw5tlv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADBEA7F8-7F5F-11EA-AB8C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
> Bloom filters computed by a previous commit will not be compatible
> with the filters computed in this commit, nor will we get correct
> results when testing across these incompatible versions. Normally,
> this would be a completely unacceptable change, but the filters
> have not been released and hence are still possible to update
> before release.

Sure, it hasn't even hit 'next' yet.  

But I think we are both sort-of leaning towards concluding that it
does not help all that much.  So I think it is OK.

> TODO: If we decide to move in this direction, then the following
> steps should be done (and some of them should be done anyway):

Even if we decide not to do this "downcase before hashing" thing, we
should document how exactly we compute, I think.

And if we decide do change our mind later, it is not the end of the
world.  We should be able to use a different chunk type to store the
filters computed over downcased paths.

> * We need to document the Bloom filter format to specify exactly
>   how we compute the filter data. The details should be careful
>   enough that someone can reproduce the exact file format without
>   looking at the C code.
>
> * That document would include the tolower() transformation that is
>   being done here.

As the tree-diff comparison done internally while running "git
blame" does not take an end-user specified pathspec in any
meaningful way, this does not matter in practice, but there is
another possible complication we would want to consider when we
extend the support to "git log" and friends---negative pathspecs
(e.g. "git log ':(exclude)COPYING'").  A commit that cannot possibly
have touched the COPYING file would be eligible for output without
actually running tree-diff between it and its parent (as long as the
trees of the two commits are different, we know it must be shown).

Thanks.
