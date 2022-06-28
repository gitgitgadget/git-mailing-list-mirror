Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD400C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiF1VA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiF1VA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:00:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6618D393D3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:00:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE5F91246BA;
        Tue, 28 Jun 2022 17:00:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fnfeiRBuP1cs+MBxZP4kI9qvBiXIUx7mRgG+RW
        sBv3w=; b=ZdeEkH5npUxj/9v/0iZbf2tfDH9aVJj2eBLzuCes2i5Ph1XpfqonrK
        m++LiUYzMr9LIILqON8eficWpYqyshw6t6bmSv6/E5lR3CvafzQBmpljyRx33EVm
        p/sCnaWI2fIXZWaarJXAdDmwlVMTIs9ADTU3Fy00VQUyMjZjsc+yY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2B871246B9;
        Tue, 28 Jun 2022 17:00:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EBA81246B8;
        Tue, 28 Jun 2022 17:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 3/8] rebase-interactive: update 'merge' description
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 14:00:50 -0700
In-Reply-To: <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 Jun 2022
        13:25:54 +0000")
Message-ID: <xmqqletgijul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64EDCCD0-F725-11EC-B6EC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'merge' command description for the todo list documentation in an
> interactive rebase has multiple lines. The lines other than the first
> one start with dots ('.') while the similar multi-line documentation for
> 'fixup' does not.
>
> The 'merge' command was documented when interactive rebase was first
> ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
> 2018-08-10). These dots might have been carried over from the previous
> shell implementation.

The text indeed does come literally from the block removed by that
commit.  I wondered if the shell "gettext" in git-i18n.sh had some
magic in it, but it does not seem to have anything, and po/git.pot
around that time has these lines with leading dots, so I suspect
that they were quite deliberately added, not for the reasons of
formatting machinery (e.g. preventing somebody in the dataflow from
losing leading indentation), but to show them to the end users.

Unfortunately, the offending commit 4c68e7dd (sequencer: introduce
the `merge` command, 2018-04-25) does not justify them X-<.

> Looking at the output in an editor, my personal opinion is that the dots
> are unnecessary and noisy. Remove them now before adding more commands
> with multi-line documentation.

I personally do not mind having them in the UI, but I can also be
happy to see them go.  It is unlikely that any program is consuming
these strings, so I would say this is a fairly safe clean-up.

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  rebase-interactive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 87649d0c016..22394224faa 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -54,9 +54,9 @@ void append_todo_help(int command_count,
>  "l, label <label> = label current HEAD with a name\n"
>  "t, reset <label> = reset HEAD to a label\n"
>  "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
> -".       create a merge commit using the original merge commit's\n"
> -".       message (or the oneline, if no original merge commit was\n"
> -".       specified); use -c <commit> to reword the commit message\n"
> +"        create a merge commit using the original merge commit's\n"
> +"        message (or the oneline, if no original merge commit was\n"
> +"        specified); use -c <commit> to reword the commit message\n"
>  "\n"
>  "These lines can be re-ordered; they are executed from top to bottom.\n");
>  	unsigned edit_todo = !(shortrevisions && shortonto);
