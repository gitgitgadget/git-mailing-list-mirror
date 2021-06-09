Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D26EC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B703610A5
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhFIFe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:34:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFIFe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 01:34:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDBBDBE074;
        Wed,  9 Jun 2021 01:33:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eo3ti+ihXVBCARhvOGOSH749ZVqa4lp3TWVfI2
        z/YSQ=; b=Py+osNYcDPZ9HZvwT6QsK3Kfs3Ak/Kh3H7SAmgYYbcLkuJ6kQVztTY
        Kws842xq+VXZn5OY3GoPieO2KNw2fp8+zu8yjWlf7Hlg//wZ1GT8CHQtHvsZfzpL
        CuMLwFvP6k5tVrYcAlwCcPA37Xl6PgR6eKTBZgQraZ2XBahEzThsg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1FA9BE073;
        Wed,  9 Jun 2021 01:33:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFD65BE071;
        Wed,  9 Jun 2021 01:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 4/4] promisor-remote: teach lazy-fetch in any repo
References: <xmqqim2pq8kj.fsf@gitster.g>
        <20210609043950.2325124-1-jonathantanmy@google.com>
Date:   Wed, 09 Jun 2021 14:33:02 +0900
In-Reply-To: <20210609043950.2325124-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 8 Jun 2021 21:39:50 -0700")
Message-ID: <xmqqk0n3k3g1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28E84E1A-C8E4-11EB-B828-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> by filling appropriate environ[] array to be run in a repository
>> that is different from ours (which is "other repo" part of its name)
>> not to want to even know which repository the "other" repo is?
>
> Good point. I'll update prepare_other_repo_env() to have a gitdir
> parameter.

I actually meant that the function should take an in-core "repo"
structure.

>> Object type and object sizes are something that you can
>> safely express in plain text, would be handy for testing, and would
>> not require too much extra code, I'd imagine.
>
> It would, but we can already use "git cat-file -s" (or -t) for that. The
> helper is meant to test a specific code path wherein we access a
> submodule object during a process running in the superproject.

I know, but can you use "git cat-file -s" to check the codepath you
care about?  I do not think so.  Hence the suggestion.

