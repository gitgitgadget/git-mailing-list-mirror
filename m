Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB4DC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhKWXvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:51:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60989 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWXvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:51:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2EAFF3C6;
        Tue, 23 Nov 2021 18:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LoXNTK5McNX9/If0BijShP3z2P09rXP3l319oz
        7Xn+M=; b=le8NLTfoQSXc9x6jq9dclyz+gbzMh9/IWtcD9sxXKzXOfIEXAmNY15
        dikM44f+mJf8GrxI1SHGeF/3W8IIZlA4bGvFzbeSNAXafSSIDH0iujbRQH38FNQD
        hiElCJaAMrVsyPWHIjJYdSVtZoWCUDSls6/6i+5oDpsCfR8IV/xOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8860FF3C5;
        Tue, 23 Nov 2021 18:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29A4DFF3C4;
        Tue, 23 Nov 2021 18:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v4 3/4] diff: enable and test the sparse index
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <273ee16b74ed4b36ffba5762fa892410317ea02b.1637620958.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 15:48:28 -0800
In-Reply-To: <273ee16b74ed4b36ffba5762fa892410317ea02b.1637620958.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Mon, 22 Nov 2021
        22:42:37 +0000")
Message-ID: <xmqqzgpu5t83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBCB88EC-4CB7-11EC-9166-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/diff.c b/builtin/diff.c
> index dd8ce688ba7..fa4683377eb 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -437,6 +437,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  
>  	prefix = setup_git_directory_gently(&nongit);
>  
> +	if (!nongit) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}
> +

It is very pleasing to see that with all the preparations, it is
jsut a very simple matter of adding four lines to enable the big
feature.

At this point immediately after asking setup_git_directory_gently(),
we positively know if we are in a repository, so the placement of
the new code makes perfect sense.

Nice.


