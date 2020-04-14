Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB9C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0647A20678
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m3HKAP8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407663AbgDNR04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:26:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59590 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407592AbgDNR0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 13:26:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 394B6CA5C8;
        Tue, 14 Apr 2020 13:26:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J7ngPOgQn+2oZsFSrnBb+Inn1og=; b=m3HKAP
        8GpKOPfjx/4nsfbn8Qyac8LF4rtTrOvWD56xsiTKjdrfeqnrUSuteRGk4JoHI/Qq
        uKSu2VzggUPNKSzJ2+v1bnqFnjULPrC/xVMuUoOyxQEZd3RxQR9b/7XrKt2UaNLU
        mxyILwVcr0XXaoZxWUN4tO3y0Ms3+3tx3DoCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LjqKN/reENjuu3VWms4ZAuFO7sgBySWy
        k9XRck2hqKHj6EuLDru+bDlr4C6f3bbTwj85M1ITAavDyPslUM7hMF0CN1l3aHx0
        4950T9AsMuadnI/r5ccCcZFgd6YEXq16vQDLb8QYdmDA4lMRI3pHeYjhc41z7p4u
        DHYqJ9g8Nc4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FEF0CA5C7;
        Tue, 14 Apr 2020 13:26:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 702D3CA5C6;
        Tue, 14 Apr 2020 13:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
        <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
        <20200413161245.GE59601@syl.local>
        <xmqqh7xnauxc.fsf@gitster.c.googlers.com>
        <74e4e8d6-d401-081d-14cc-c4b6087bdeda@gmail.com>
Date:   Tue, 14 Apr 2020 10:26:43 -0700
In-Reply-To: <74e4e8d6-d401-081d-14cc-c4b6087bdeda@gmail.com> (Derrick
        Stolee's message of "Tue, 14 Apr 2020 11:04:05 -0400")
Message-ID: <xmqqa73e9dws.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DD1D81C-7E75-11EA-8F02-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/13/2020 6:21 PM, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>>> Hmm. I'm not crazy about a library function looking at 'GIT_TEST_*'
>>> environment variables and potentially ignoring its arguments, but given
>>> the discussion we had in v1, I don't feel strongly enough to recommend
>>> that you change this.
>>>
>>> For what it's worth, I think that 'write_commit_graph' could behave more
>>> purely if callers checked 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS' and set
>>> 'flags' appropriately from the outside,...
>> 
>> Yeah, I agree that it would be a lot cleaner if that is easy to
>> arrange.  I have a suspicion that Derrick already tried and the
>> resulting code looked messier and was discarded?
>
> Perhaps I could fix both concerns by
>
> 1. Use a macro instead of a library call.
>
> 2. Check the _CHANGED_PATHS variable in the macro.

I am not sure how use of a macro "fixes" purity, though.  And what
is the other concern?

How widely would this "if we are testing, write out the graph file"
call be sprinkled over the codebase?  I am hoping that it won't be
"everywhere", but only at strategic places (like "just once before
we leave a subcommand that creates one or bunch of commits").  And
how often would they be called?  I am also hoping that it won't be
"inside a tight loop".  In short, I am wondering if we can promise
our codebase that 

 - git_test_write_commit_graph_or_die() calls won't be an eyesore
   (and/or distraction) for developers too much.

 - git_env_bool() call won't have performance impact.


> The macro would look like this:
>
>
> #define git_test_write_commit_graph_or_die() \
> 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0)) { \
> 		int flags = 0; \
> 		if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0)) \
> 			flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS; \
> 		if (write_commit_graph_reachable( \
> 			the_repository->objects->odb, flags, NULL)) \
> 			die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH"); \
> 	}
>
> Thanks,
> -Stolee
