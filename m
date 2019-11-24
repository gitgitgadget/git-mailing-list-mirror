Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC5C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 06:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397392071A
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 06:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ovHEXTQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKXGB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 01:01:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52444 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfKXGB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 01:01:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D024D2AEFC;
        Sun, 24 Nov 2019 01:01:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0HTth1dvV7LyfnBCabe5XUEU0fE=; b=ovHEXT
        QQjIg2rSmL/AmweF4kLC8PriFf/dnbzhKtdyD96PD8BjW3CiVZZ97lKMlXNx9qoR
        JkamEInnAZU0tDC4GQYy1jC6FX8zEyb+IThTj2o3GgUUKzvzkBrqPcYFtjcvThiU
        mPwP28yI4em6CUUmBoyx9kdnYKSi7eyK51ces=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQZRS4gsLUTQ+6q13l1WaqfrcOICuLAh
        84KBgkOaLWw55hdyif5MHUXua7Kyz+JK75q0capG3WfImctIH7n87L1+BB9EjInm
        8jWZSUK6QyRyvSCkeeLrCCuUXiAUoBgmnCoLfJFl9gzdz4BfXyD2tEGRGXDjrLvK
        IfOqAlzSMRA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C71F42AEFB;
        Sun, 24 Nov 2019 01:01:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 218F22AEFA;
        Sun, 24 Nov 2019 01:01:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 15:01:23 +0900
In-Reply-To: <pull.475.git.1574539001.gitgitgadget@gmail.com> (Nika Layzell
        via GitGitGadget's message of "Sat, 23 Nov 2019 19:56:39 +0000")
Message-ID: <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D858605E-0E7F-11EA-8BE5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The refresh command is called from git-add--interactive to ensure that git's
> view of the worktree is up-to-date. This is necessary for most commands
> which use git-add--interactive, as they are interacting with the worktree,
> however it's not necessary for git-reset, which exclusively operates on the
> index. This patch skips the refresh call when performing a git-reset -p,
> which can improve performance on large repositories which have out-of-date,
> or no, caches of the current worktree state.
>
> I chose to use the existing FILTER property of the flavour to make this
> decision. A separate REFRESH property could be added instead.

Hmph, I wonder why this was sent my way.  How does GGG determine
whom to send patches to?  I, like other reviewers, prefer not to see
earlier rounds of patches sent directly to me unless they are about
areas that I am mostly responsible for (other patches I'll see them
and review them on the copies sent to the mailing list anyway).

CC'ing Dscho who has stakes in keeping the scripted "add -i" frozen,
while he is rewriting it in C.

Thanks.

>
> Nika Layzell (1):
>   add--interactive: skip index refresh in reset patch mode
>
>  git-add--interactive.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
>
> base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-475%2Fmystor%2Findex-only-refresh-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-475/mystor/index-only-refresh-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/475
