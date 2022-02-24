Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D783C4332F
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiBXTjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBXTjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:39:10 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD51E1486
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:38:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F33D21748F9;
        Thu, 24 Feb 2022 14:38:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y+DnMGAKT2y33LD2Rl4loMd7QepUJwy9tMNYkw
        88sjg=; b=KjnsObAuM+jI7xQIAv6OdLlo5Mb5AtvnNcYD7El2IzwU1TZWKLX6gY
        fwvkxR5REzvHmhK4Fbr43QnqVN8/Emd4/EUkKAy2cFLUWD6i8MQZWf8E3IKaXUVd
        zBPQm0YqTosJldua6mOfKU42ucVBjdw07jSiE83l1yqMgmK4ln1aQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBE201748F6;
        Thu, 24 Feb 2022 14:38:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5FBA51748F4;
        Thu, 24 Feb 2022 14:38:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 3/3] branch documentation: new autosetupmerge option
 "simple"
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
        <39c14906e7b65843c2543682bb577c6a2253240a.1645695940.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 11:38:36 -0800
In-Reply-To: <39c14906e7b65843c2543682bb577c6a2253240a.1645695940.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Thu, 24 Feb 2022 09:45:40
        +0000")
Message-ID: <xmqq1qzsm4w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C69B624-95A9-11EC-AC88-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> Updating the branch and config documentation to reflect
> the new "simple" option to branch.autosetupmerge.

Documentation/Submittingpatches[[describe-changes]].

But it would be moot; these changes are better done as part of [1/3]
and in that case, updating the documentation (or testing the desired
behaviour, for that matter) is not something we need to justify
separately.  It is something we must done as part of the change.

> diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
> index 1e0c7af014b..7b4e5ca5b74 100644
> --- a/Documentation/config/branch.txt
> +++ b/Documentation/config/branch.txt
> @@ -9,7 +9,9 @@ branch.autoSetupMerge::
>  	automatic setup is done when the starting point is either a
>  	local branch or remote-tracking branch; `inherit` -- if the starting point
>  	has a tracking configuration, it is copied to the new
> -	branch. This option defaults to true.
> +	branch; `simple` -- automatic setup is done when the starting point is

It may be clearer to say "done only when".  I dunno.

> +	a remote-tracking branch and the new branch has the same name as the
> +	remote branch. This option defaults to true.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index c8b4f9ce3c7..f99d6a6b008 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -227,7 +227,9 @@ want `git switch`, `git checkout` and `git branch` to always behave as if `--no-
>  were given. Set it to `always` if you want this behavior when the
>  start-point is either a local or remote-tracking branch. Set it to
>  `inherit` if you want to copy the tracking configuration from the
> -branch point.
> +branch point. Set it to `simple` if you want this behavior only when
> +the start-point is a remote branch and the new branch has the same name
> +as the remote branch.

The existing "if you want this behaviour when" is already awkward.
What it means is that only those who want to use the "start-point"
itself as the upstream whether the start-point is local or
remote-tracking,can use "always" and does not get hurt.

But using the phrase for "simple" makes it even worse, as the
condition that the tracking behaviour kicks in is even narrower.  If
you know that start-point is not a remote-tracking branch (by the
way, do not say "remote branch" when you mean "remote-tracking
brnach"), or its name is not the same as the local branch, you just
do not pass --track=simple from the command line.  Strike everything
after "Set it to `simple`" and replace with something like

    `--track=simple` sets up the upstream information only when the
    start-point is a remote-tracking branch and ...

perhaps?

Thanks.
