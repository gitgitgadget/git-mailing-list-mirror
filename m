Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB1C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiFFR5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiFFR5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:57:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D020BDB
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:57:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CF6511AE6B;
        Mon,  6 Jun 2022 13:57:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsFdfrt4RZYT9GwRwSyddcZhpF7ymePMijZGkP
        ZVsVo=; b=c+YXhMMGFjhQJ/4Ry7/J3AcH/9eu3Q04kSAv2OIt9fhk1PkCt7xAFC
        EGd5GDSCowO8b1W1EGeJlKr+epYLuGDGaPJaC4fR60XWhW5SxrKcRfA2sFB4hY2A
        jb81bNDqFRMKg9/d4RPWmYgR5W58sf4/CtTAkvIGjZEpSOgGhIYUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34F3E11AE6A;
        Mon,  6 Jun 2022 13:57:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99D3611AE68;
        Mon,  6 Jun 2022 13:57:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/4] rebase: note `preserve` merges may be a pull
 config option
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
        <fe000f062078e544361c87c319830cd36aabbc91.1654341469.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 10:57:33 -0700
In-Reply-To: <fe000f062078e544361c87c319830cd36aabbc91.1654341469.git.gitgitgadget@gmail.com>
        (Philip Oakley via GitGitGadget's message of "Sat, 04 Jun 2022
        11:17:48 +0000")
Message-ID: <xmqq1qw18yk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24DC5CFC-E5C2-11EC-993F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Oakley <philipoakley@iee.email>
>
> The `--preserve-merges` option was removed by v2.34.0. However
> users may not be aware that it is also a Pull configuration option,
> which is still offered by major IDE vendors such as Visual Studio.
>
> Extend the `--preserve-merges` die message to also direct users to
> the possible use of the `preserve` option in the `pull.rebase` config.
> This is an additional 'belt and braces' information statement.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  builtin/rebase.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 17cc776b4b1..5f8921551e1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1205,7 +1205,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			     builtin_rebase_usage, 0);
>  
>  	if (preserve_merges_selected)
> -		die(_("--preserve-merges was replaced by --rebase-merges"));
> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
> +			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
> +			"which is no longer supported; use 'merges' instead"));

"be  set" -> "be set".

I am not sure how this helps anybody, though.  

When pull.rebase is parsed, rebase.c::rebase_parse_value() is called
from builtin/pull.c::parse_config_rebase() and would trigger an
error, whether it comes from the pull.rebase or the branch.*.rebase
configuration variable.  An error() message already said that
'preserve' was removed and 'merges' would be a replacement when it
happened.

If the user has *not* reached this die() due to a configuration
variable, then there is not much point giving this new message,
either.
