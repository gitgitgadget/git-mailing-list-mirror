Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED2C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 20:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfILUlF (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 16:41:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50302 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfILUlF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 16:41:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F1F28BCCC;
        Thu, 12 Sep 2019 16:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kOPdYJpGpJs4oZ6+RqEdH+JLs/8=; b=vUsGk1
        Xd2YHmPcVirsZrxg3VEEB8fNBkMH2pAzSyNvz27UyKmCwilWJo7CZ3/VpEhv187w
        m8hHCB2ZfmcC7r4dcViRaihLWaQaoETpGvNrHwIqCoKBGxfdsZHGxCOIxS9vGihU
        hENIfKlkNwCbq4+dP7M/mmGKjtK47S2zli0Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gCEiB4gTw0wnC+fPGtffZqN2iqV2xRTA
        eAWkqPceXRbNl6PfGXKr7z3Ue7G5j12RrXLMf7Ar4CTpEIL0DJoMeVAHAQbVngS1
        lymLhBu4Y/vtlcL6WAY1qBgioi5VuOGOO0GOn06kr1cA9e3ORf03ARXbm7faSGbx
        70+G4fiXjlU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 965658BCCB;
        Thu, 12 Sep 2019 16:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BFB158BCC8;
        Thu, 12 Sep 2019 16:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 1/1] commit-graph: add --[no-]progress to write and verify.
References: <pull.315.git.gitgitgadget@gmail.com>
        <pull.315.v2.git.gitgitgadget@gmail.com>
        <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
Date:   Thu, 12 Sep 2019 13:40:55 -0700
In-Reply-To: <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Mon, 26 Aug 2019 09:29:58
        -0700 (PDT)")
Message-ID: <xmqqef0lfdt4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FBC172E-D59D-11E9-9B42-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index eb5e7865f0..ca0b1a683f 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -10,8 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit-graph read' [--object-dir <dir>]
> -'git commit-graph verify' [--object-dir <dir>] [--shallow]
> -'git commit-graph write' <options> [--object-dir <dir>]
> +'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
> +'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]

This is not a problem with this patch, but it is disturbing to see
<options> and other concrete "--option" listed explicitly.  It could
be that "--object-dir <dir>" is so important an option that deserves
to be singled out while other random options can be left to individual
option's description, but in that case, would "--progress" be equally
important (if anything, as an option that is purely about appearance,
I would expect it to be with a lot lower importance)?

I guess with a preparatory clean-up patch to deal with the <options>
part, the result of applying this patch would not look so bad.
Perhaps renaming <options> to <write-specific-options> and moving it
to the end of the line might be sufficient.  I dunno.  At least we'd
need to make sure that it is clear to readers what options are
allowed where we wrote <options> above.

> @@ -29,6 +29,9 @@ OPTIONS
>  	commit-graph file is expected to be in the `<dir>/info` directory and
>  	the packfiles are expected to be in `<dir>/pack`.
>  
> +--[no-]progress::
> +	Turn progress on/off explicitly. If neither is specified, progress is 

Trailing whitespace.

> +	shown if standard error is connected to a terminal.
>   ...
> +	if (opts.progress)
> +		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
> +	

Trailing whitespace.

> diff --git a/commit-graph.c b/commit-graph.c
> index f2888c203b..2802f2ade6 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1992,8 +1992,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>  	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>  		return verify_commit_graph_error;
>  
> -	progress = start_progress(_("Verifying commits in commit graph"),
> -				  g->num_commits);
> +	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
> +		progress = start_progress(_("Verifying commits in commit graph"),
> +					g->num_commits);
> +

This is correct, but it feels funny that it is sufficient to
castrate start_progress() and we do not have to muck with existing
calls to show and stop progress output.  We rely on progress being
NULL for that to work, and existing code initializes the variable
to NULL, so we are OK.
