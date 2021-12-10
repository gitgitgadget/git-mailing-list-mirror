Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ADEC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbhLJWRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:17:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57881 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhLJWRm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:17:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B038710433D;
        Fri, 10 Dec 2021 17:14:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yf8Pw8NepUpylMaS0Yyaa9wDB4LtGAone85BYj
        9CWOU=; b=hn/sDneL/IjzXBKH80Z5NZKYp9m665/ljjY3VRCUgC9unSCXhwnZ6A
        N5MZQQz/CNtPJxIoItPi7pXbKE2IqKR4XqPZ+dxqfTVQNXgg7QpVNZHc8/SGdT0X
        J8adNS8cds+phcU3vVMTiXNLq15nlJIDsFyQQrbWdvwWqIZUdyoA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 549E910433C;
        Fri, 10 Dec 2021 17:14:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 132C610433B;
        Fri, 10 Dec 2021 17:14:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
        <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 14:14:01 -0800
In-Reply-To: <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Fri, 10 Dec 2021 06:22:09
        +0000")
Message-ID: <xmqq5yrwm7km.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B908142-5A06-11EC-9ED0-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> When we want checkout to a branch (e.g. dev1) which reference
> to a commit, but sometimes we only remember the tag (e.g. v1.1)
> on it, we will use `git checkout v1.1` to find the commit first,
> git will be in the state of deatching HEAD, so we have to search the
> branches on the commit and checkout the branch we perfer. This will
> be a bit cumbersome.
>
> Introduce "--to-branch" option, `git checkout --to-branch <tag>`
> and `git checkout --to-branch <commit>` will search all branches
> and find a unique branch reference to the commit (or the commit which
> the tag reference to) and checkout to it. If the commit have more
> than one branches, it will report error "here are more than one
> branch on commit".

Sorry, but the above explanation does not make any sense to me.  

It is unclear if you mean "dev1" exactly point at the commit tagged
as v1.1, or you want the branch "dev1" that is a descedanant of
v1.1.  Without telling that to the reader, the above explanation is
useless.

And whether you meant the former or the latter, neither use case does
not make much sense.

First, suppose you meant "checkout --to-branch v1.1" to find a
branch whose tip exactly points at v1.1.  You instead check out
"dev1" branch, and work on it to advance its history.  When you are
done, you may go to another branch and work on something else.

But then what?  When you need another topic that also needs to be
later merge-able to v1.1, "checkout --to-branch v1.1" no longer will
be able to find "dev1", because, well, you have already used it to
build something else.

So, "--to-branch v1.1" that finds and checks out a branch whose tip
exactly points at v1.1 would be pretty useless.

So let's correct the unwritten assumption and say "--to-branch v1.1"
finds a branch that is descendant of the tag.  It is like I have
maint-2.33 branch to prepare for v2.33.1, v2.33.2,... maintenance
releases and being able to find maint-2.33 by saying v2.33.2 (or
v2.33.1) _might_ be convenient.

But that would only be true if there is only one single branch per
family of tags (in the above example, v2.33.* tags).  You cannot use
the workflow where many topic branches run in parallel, and get
merged to the integration branch(es) only after they are ready,
because you need bugfix-1-for-v2.33, bugfix-2-for-v2.33,... branches
all forked from v2.33.0 (or a commit with a later tag in the v2.33.*
family) to cook these independent fixes that are destined for the
maint-2.33 integration branch, so you cannot uniquely find maint-2.33
by saying v2.33.0 or v2.33.1 or whatever.

I also sense that the first paragraph of the proposed log message
for this commit hints that the user needs a bit more studying of
existing tools.  When we know v1.1 but do not know if we already
have branches that are based on it, we DO NOT do "git checkout v1.1".
Instead the first thing we would do is "git branch --contains v1.1"
(add "--no-merged main" to exclude the branches that have already
graduated to 'main').

So, for this partcular topic, what I would recommend is *not* jump
in and add a new feature, but to study what's available and build a
workflow around the existing features.




