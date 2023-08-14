Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602D2C001E0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHNQCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjHNQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 12:02:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34F115
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 09:02:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02CE424E2E;
        Mon, 14 Aug 2023 12:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VvePJn+6JIA5B6Mpltffdh+HyBl66TdywzXbvi
        7tk+I=; b=t9JaF76VqxUHEqS4RjybaUFyXFiFjr4i4nP90Xh1XFxNeFQtUmrIQ9
        PH1SIqPQ6L9nYdx2o0zVROtjYC7z5ItwezSXf+xI8TReHl8XZTY7hbs9nfHS79cI
        13P/sUsjEl8vejzwbbphsTZ9ZhK0J2X3rG4mYshcMkQEtl3wFZQ4k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF7CC24E2D;
        Mon, 14 Aug 2023 12:02:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9039824E2C;
        Mon, 14 Aug 2023 12:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] scalar: add --[no-]src option
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <c1c7e2f049e762b9b60614a5732e4d41db1d0da5.1692025937.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 09:02:31 -0700
In-Reply-To: <c1c7e2f049e762b9b60614a5732e4d41db1d0da5.1692025937.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 14 Aug 2023
        15:12:15 +0000")
Message-ID: <xmqqcyzpmx2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA33B766-3ABB-11EE-AB81-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Some users have strong aversions to Scalar's opinion that the repository
> should be in a 'src' directory, even though it creates a clean slate for
> placing build outputs in adjacent directories.
>
> The --no-src option allows users to opt-out of the default behavior.
>
> While adding options, make sure the usage output by 'scalar clone -h'
> reports the same as the SYNOPSIS line in Documentation/scalar.txt.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/scalar.txt |  8 +++++++-
>  scalar.c                 | 11 +++++++++--
>  t/t9211-scalar-clone.sh  |  8 ++++++++
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
> index f33436c7f65..cd65b3e230d 100644
> --- a/Documentation/scalar.txt
> +++ b/Documentation/scalar.txt
> @@ -8,7 +8,8 @@ scalar - A tool for managing large Git repositories
>  SYNOPSIS
>  --------
>  [verse]
> -scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
> +scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
> +	[--[no-]src] <url> [<enlistment>]
>  scalar list
>  scalar register [<enlistment>]
>  scalar unregister [<enlistment>]
> @@ -80,6 +81,11 @@ remote-tracking branch for the branch this option was used for the initial
>  cloning. If the HEAD at the remote did not point at any branch when
>  `--single-branch` clone was made, no remote-tracking branch is created.
>  
> +--[no-]src::
> +	Specify if the repository should be created within a `src` directory
> +	within `<enlistment>`. This is the default behavior, so use
> +	`--no-src` to opt-out of the creation of the `src` directory.

While there is nothing incorrect in the above per-se, and the first
half of the description is perfectly good, but I find the latter
half places too much stress on the existence of the "src" directory.
As a mere mortal end-user, what is more important is not the
presence of an extra directory, but the fact that everything I have
is now moved one level down in the directory hierarchy to "src/"
directory.

	This is the default behavior; use `--no-src` to place the
	root of the working tree of the repository directly at
	`<enlistment>`.

or something along that line would have been easier to understand
for me.  It is not the creation of `src`, but that everything is
moved into it, is what some users may find unusual.

> +test_expect_success '`scalar clone --no-src`' '
> +	scalar clone --src "file://$(pwd)/to-clone" with-src &&
> +	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
> +
> +	test_path_is_dir with-src/src &&
> +	test_path_is_missing without-src/src
> +'

And another thing that may be interesting, from the above point of
view, is to compare these two:

	(cd with-src/src && ls ?*) >with &&
	(cd without && ls ?*) >without &&
	test_cmp with without

Both output should look something like

    cron.txt
    first.t
    second.t
    third.t

and the earlier confusion point I raised was that

	(cd with-src && ls ?*)

would not look like

    cron.txt
    first.t
    second.t
    src/
    third.t

Thanks.
