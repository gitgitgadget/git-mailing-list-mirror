Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93292C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7E66138F
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbhITR7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 13:59:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63909 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355924AbhITR5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 13:57:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1741EE44C;
        Mon, 20 Sep 2021 13:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r2l+TMhWm6miuy18LuZBg7bH/CGD+nP3HLvq9j
        Hbs10=; b=egMXAt1bnmE/WhaNMvmuu6gnRo/bLC+zowrynRHL9RK7rh7f14avlc
        f6VenQuDQnk+tEWZnkEDzUqhLpJqBKpDfD95hSzrTbWvGObZjJYS9VydULj32Ju9
        tBlxHHYqLFwY9vXa6KXCZ6qmx5MatgF4rSn12grfuLcmLJxqtLKzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8D80EE44B;
        Mon, 20 Sep 2021 13:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D8B1EE44A;
        Mon, 20 Sep 2021 13:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/2] Squash leaks in t0000
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 10:55:49 -0700
In-Reply-To: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com> (Andrzej
        Hunt via GitGitGadget's message of "Sat, 18 Sep 2021 13:49:36 +0000")
Message-ID: <xmqq4kafcesa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDA827C6-1A3B-11EC-9514-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Carlo points out that t0000 currently doesn't pass with leak-checking
> enabled in:
> https://public-inbox.org/git/CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEWH4AcU7Q@mail.gmail.com/T/#m7e40220195d98aee4be7e8593d30094b88a6ee71
>
> Here's a series that I've sat on for a while, which adds some UNLEAK's to
> "fix" this situation - see the individual patches for a justification of why
> an UNLEAK seems appropriate.

It seems that discussion on 1/2 seemed to be heading in an
improvement but has petered out?  

I think the simplest fix in these two patches are worth taking, even
if we plan to further improve either by refining the granularity of
UNLEAK application or by introducing repo_clear_revisions() as Carlo
mentions (which is a preferred way to do this if we can manage it),
on top.

Thanks.
