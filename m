Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F36C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BED2166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vBxJMYP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgEARev (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 13:34:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50901 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgEARev (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 13:34:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C540767881;
        Fri,  1 May 2020 13:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QBRrj8UjIy1AsrJYHiMdE7QC9Kw=; b=vBxJMY
        P1tpku/zh2NEoF0MSXiO3ZUIetXRL/4YXsFYF3sOQ1HoMt77WyYD7NN+3W0wbSfh
        lraU5ZAnH0edgcZSBt2cl4kUOCZfKGZa8vU8F1OGraRElIeTp6jE1o1SJZnF08Sm
        zirZT+39A+hkKmoJdM5SyEQpjrt91jTZXbiKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NROwsi5C7QQisEKn27fb352JE5wDlx5r
        ySsuZtQNO37U09u9isv3aow8d3SEwKUKCA3q3dDT77GW1rl5+5/HVygcXSTbD8Vp
        WBbdXf7IdY1GK8cFS1RKj1hEmiIPm4aED7CELMZUxORghbOzaQ357l7q7XXz7KYG
        W+qRsmvM75I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B253967880;
        Fri,  1 May 2020 13:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE1206787F;
        Fri,  1 May 2020 13:34:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/12] Integrating line-log and changed-path Bloom filters
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 10:34:46 -0700
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Fri, 01 May 2020 15:30:17 +0000")
Message-ID: <xmqqzharmudl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DC7A8E2-8BD2-11EA-8AEB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is organized as follows:
>
>  * Patches 1-4 are minor Bloom filter cleanups, including a documentation
>    bug.
>    
>    
>  * Patch 5 fixes a problem where the Bloom filters use much larger filters
>    than expected.
>    
>    
>  * Patch 6 fixes a bug related to the short-circuit of large diffs from
>    e369698016 (diff: halt tree-diff early after max_changes, 2020-03-30).
>    The condition for halting the diff computation is different than the
>    check in bloom.c to see if that short-circuit was hit, which leads to
>    some commits with large diffs getting an incomplete Bloom filter. This
>    happened on the root commit of the Linux kernel repo, for example.
> ...   
> I organized these patches so patches 1-6 could be split into its own topic,
> if beneficial to take earlier than the line-log changes.

Nice.

> The end result of this combined effort is the following: git log -L commands
> feel much more responsive to a terminal user because Szeder's changes make
> the computation incremental, and they have better end-to-end performance
> because of the integration with Bloom filters to reduce time spent running
> tree diffs for TREESAME commits.

Nice, again.

