Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1154DCA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjIKXQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352282AbjIKVoy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 17:44:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2043959B
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 14:14:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA58D2BB2E;
        Mon, 11 Sep 2023 17:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=EjLY6fv3uxMf78Qm5opS9K9I4iQcwnIFLBKTMK
        3I70o=; b=a6no6urTbfBKqYFZmSGFb3WPnU3rnIWKvPFegUiiofXz6dLgm/F2Hd
        +oodeoWc9SzDXkgHe6A2qyRYMXh2ZcUfWHvOcsiqFnPUnVmd2HX6jr2FcusfwbNl
        tR01fg8GIGTfTWZBQS3OrNLhGuhxuEMV+6I+5V0UlQJzMHTstDIms=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2C792BB2D;
        Mon, 11 Sep 2023 17:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 626C82BB2B;
        Mon, 11 Sep 2023 17:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff-merges: improve --diff-merges documentation
In-Reply-To: <20230909125446.142715-2-sorganov@gmail.com> (Sergey Organov's
        message of "Sat, 9 Sep 2023 15:54:45 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-2-sorganov@gmail.com>
Date:   Mon, 11 Sep 2023 14:12:59 -0700
Message-ID: <xmqqfs3ktnvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD67B6FC-50E7-11EE-90B8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>  ifdef::git-log[]
> ---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
> +-m::
> +	Show diffs for merge commits in the default format. This is
> +	similar to '--diff-merges=on' (which see) except `-m` will
> +	produce no output unless `-p` is given as well.
> ++
> +Note: This option not implying `-p` is legacy feature that is
> +preserved for the sake of backward compatibility.

It is more like that `-p` does not imply `-m` (which used to mean
"consider showing the comparison between parent(s) and the child,
even for merge commits"), even though newer options like `-c`,
`--cc` and others do imply `-m` (simply because they do not make
much sense if they are not allowed to work on merges) that may make
new people confused.  If `-p` implied `-m` (or if `-m` implied
`-p`), it would also have been utterly confusing and useless for
human consumption.

In either case, unless the reason why `-p` does not imply `-m`
unlike others is explained, I do not think the note adds that much
value.  I'd suggest dropping it.

>  --no-diff-merges::
> +	Synonym for '--diff-merges=off'.
> +
> +--diff-merges=<format>::
>  	Specify diff format to be used for merge commits. Default is
> -	{diff-merges-default} unless `--first-parent` is in use, in which case
> -	`first-parent` is the default.
> +	{diff-merges-default} unless `--first-parent` is in use, in
> +	which case `first-parent` is the default.
>  +
> +The following formats are supported:
> ++
> +--
> +off, none::
>  	Disable output of diffs for merge commits. Useful to override
>  	implied value.
>  +
> +on, m::
> +	Make diff output for merge commits to be shown in the default
> +	format. The default format could be changed using
>  	`log.diffMerges` configuration parameter, which default value
>  	is `separate`.
>  +
> +first-parent, 1::
> +	Show full diff with respect to first parent. This is the same
> +	format as `--patch` produces for non-merge commits.
>  +
> +separate::
> +	Show full diff with respect to each of parents.
> +	Separate log entry and diff is generated for each parent.
>  +
> +remerge, r::
> +	Remerge two-parent merge commits to create a temporary tree
> +	object--potentially containing files with conflict markers
> +	and such.  A diff is then shown between that temporary tree
> +	and the actual merge commit.
>  +
>  The output emitted when this option is used is subject to change, and
>  so is its interaction with other options (unless explicitly
>  documented).
>  +
> +combined, c::
> +	Show differences from each of the parents to the merge
> +	result simultaneously instead of showing pairwise diff between
> +	a parent and the result one at a time. Furthermore, it lists
> +	only files which were modified from all parents.
>  +
> +dense-combined, cc::
> +	Further compress output produced by `--diff-merges=combined`
> +	by omitting uninteresting hunks whose contents in the parents
> +	have only two variants and the merge result picks one of them
> +	without modification.
> +--

Looks reasonable, even though I didn't quite see much problem with
the original.  If we were shuffling the sections like this patch, I
wonder if moving combined/dense-combined a bit higher (perhaps
before the "remerge") may make more sense, though (the ordering
would simply become "simpler to more involved").
