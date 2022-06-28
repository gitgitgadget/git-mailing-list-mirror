Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06882C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiF1VCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiF1VCK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:02:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF760393E7
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:02:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A4DD198961;
        Tue, 28 Jun 2022 17:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vmxlu5h8pay2OQhRBLmbCSuLSS3icvN8nkDG8l
        H7gCQ=; b=v6tri24hbJ5qdJtwgVnI5NaSsPvsjH7o71LBx67ZvhTJ3pgCqld+/M
        ovCCT7iUrkRqOXs+1m95cNvyl0uvAEr2e4L7Dn111e04JV2I5FuF9ORP+EbJfZZ2
        Sedr3GTAST504Fv4BLeN9QaXBlifL9jt9hh62htDzRKdi/gfFHKXY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32DAA198960;
        Tue, 28 Jun 2022 17:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B007D19895E;
        Tue, 28 Jun 2022 17:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 4/8] sequencer: define array with enum values
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <6528a50343f0fc3c0b2134f1af29cc30fab4f81f.1656422759.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 14:02:03 -0700
In-Reply-To: <6528a50343f0fc3c0b2134f1af29cc30fab4f81f.1656422759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 Jun 2022
        13:25:55 +0000")
Message-ID: <xmqqh744ijsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 903C96E6-F725-11EC-BDB4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The todo_command_info array defines which strings match with which
> todo_command enum values. The array is defined in the same order as the
> enum values, but if one changed without the other, then we would have
> unexpected results.
>
> Make it easier to see changes to the enum and this array by using the
> enum values as the indices of the array.

OK.  It is a bit of shame that we cannot define this array and enum
at the same time in a single construct, but this is much safer than
the status quo.  Thanks.

>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  sequencer.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 1094e146b99..2ffee79619c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1685,20 +1685,20 @@ static struct {
>  	char c;
>  	const char *str;
>  } todo_command_info[] = {
> -	{ 'p', "pick" },
> -	{ 0,   "revert" },
> -	{ 'e', "edit" },
> -	{ 'r', "reword" },
> -	{ 'f', "fixup" },
> -	{ 's', "squash" },
> -	{ 'x', "exec" },
> -	{ 'b', "break" },
> -	{ 'l', "label" },
> -	{ 't', "reset" },
> -	{ 'm', "merge" },
> -	{ 0,   "noop" },
> -	{ 'd', "drop" },
> -	{ 0,   NULL }
> +	[TODO_PICK] = { 'p', "pick" },
> +	[TODO_REVERT] = { 0,   "revert" },
> +	[TODO_EDIT] = { 'e', "edit" },
> +	[TODO_REWORD] = { 'r', "reword" },
> +	[TODO_FIXUP] = { 'f', "fixup" },
> +	[TODO_SQUASH] = { 's', "squash" },
> +	[TODO_EXEC] = { 'x', "exec" },
> +	[TODO_BREAK] = { 'b', "break" },
> +	[TODO_LABEL] = { 'l', "label" },
> +	[TODO_RESET] = { 't', "reset" },
> +	[TODO_MERGE] = { 'm', "merge" },
> +	[TODO_NOOP] = { 0,   "noop" },
> +	[TODO_DROP] = { 'd', "drop" },
> +	[TODO_COMMENT] = { 0,   NULL },
>  };
>  
>  static const char *command_to_string(const enum todo_command command)
