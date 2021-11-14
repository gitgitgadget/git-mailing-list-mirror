Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5467FC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 18:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC8C61152
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 18:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhKNSlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:41:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57537 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNSlV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 13:41:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DDC5FB495;
        Sun, 14 Nov 2021 13:38:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wrjGOYfEOsdOxXfWXrvy6QzvqewO/OaGPHr9un
        c7jSU=; b=yI5qlP0LtwD4tz/gzMpd3jJE84PTxdYEaon9T8zlRRVWGomxevslqt
        RREHu6p4LWp/jdABpTMfTMM304Y3RbSm7EirgzqEsHpGid9bPFD73/tTOulfyIqx
        gboh3Vy16o3wiTuNwhX+BB6wN7Eh6iLRuDdbocqeo1yYH1Irob7tI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55017FB494;
        Sun, 14 Nov 2021 13:38:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF069FB491;
        Sun, 14 Nov 2021 13:38:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH] subtree: ignore merge.ff setting
References: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
Date:   Sun, 14 Nov 2021 10:38:24 -0800
In-Reply-To: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com> (Thomas
        Koutcher via GitGitGadget's message of "Sun, 14 Nov 2021 15:07:34
        +0000")
Message-ID: <xmqqee7ilh0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D972682-457A-11EC-A44A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Thomas Koutcher <thomas.koutcher@online.fr>
>
> When `merge.ff` is set to `only` in .gitconfig, `git subtree pull` will
> fail with error `fatal: Not possible to fast-forward, aborting.`. This
> fix ignores the `merge.ff` setting when using `git merge` within subtree.

The first sentence is understandasble as a statement of fact.  There
is a small logic gap between it and the second sentence, calling the
change in the patch a "fix".  I think ", but the command does want
to make merges in these places." added after the first sentence
would fix it.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1139%2Fkoutcher%2Fsubtree-merge-ff-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1139/koutcher/subtree-merge-ff-fix-v1
> Pull-Request: https://github.com/git/git/pull/1139
>
>  contrib/subtree/git-subtree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7f767b5c38f..de918d9fb05 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -976,10 +976,10 @@ cmd_merge () {
>  
>  	if test -n "$arg_addmerge_message"
>  	then
> -		git merge -Xsubtree="$arg_prefix" \
> +		git -c merge.ff= merge -Xsubtree="$arg_prefix" \
>  			--message="$arg_addmerge_message" "$rev"
>  	else
> -		git merge -Xsubtree="$arg_prefix" $rev
> +		git -c merge.ff= merge -Xsubtree="$arg_prefix" $rev

And the natural way to override what is configured is to pass a
countermanding command line option, e.g. "git merge --ff" (or "git
merge --no-ff", if it wants to always create a merge even when
taking a change that is a descendant---I do not know the need of
"git subtree" well enough to tell), and that is easier to read than
"git -c ...".
