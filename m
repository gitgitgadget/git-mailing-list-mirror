Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70DC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0062F20789
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sHov6p/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405982AbgFYSLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:11:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405949AbgFYSLo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 14:11:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2AB05AEEA;
        Thu, 25 Jun 2020 14:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=poYNeTCAfZ9mc72aOPn3wzkMEDc=; b=sHov6p
        /bRGSwGqorEnQe2dbV8U7lsAtxuGmXvOCOZrk3qunQ/qV/2ZBERifh9srZ4ezquN
        k5WcZwQH63kdwd9nkyEPTFwS3OPeYNj9zqGjSAMINgYGzZINhzlsRSgl5YY7Xndb
        FsE+69Bd99zCVQeUQdK+eFHL4eh/tmjtuKd9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W2JuXUUKyWG+DKXa0i4YeOPpuOI4z4FN
        CAuWA78ze5yN6ncibmfVyT2pbEIaqwCxE42C4wrKOjtR9TfxvWWIuhj4KscbnZk+
        rFb2W6HRF3tNyTvsqcpNnqmlP9d/TD8PeEIrpG9ngcQu8p6/GAQqsL3Vgt6/Calm
        ZcHKz0Hvo20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB96D5AEE9;
        Thu, 25 Jun 2020 14:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7250B5AEE8;
        Thu, 25 Jun 2020 14:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/2] difftool -d: ensure that intent-to-add files are handled correctly
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <9bb8d84ea956dcddefbe7b62baa3a5ff23b6b1e2.1593107621.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 11:11:40 -0700
In-Reply-To: <9bb8d84ea956dcddefbe7b62baa3a5ff23b6b1e2.1593107621.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 25 Jun 2020
        17:53:41 +0000")
Message-ID: <xmqqimff3tib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51E92F4C-B70F-11EA-916E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In https://github.com/git-for-windows/git/issues/2677, a `git difftool
> -d` problem was reported. The underlying cause was a bug in `git
> diff-files --raw` that we just fixed.

That leaves a gap between "there is some unspecified problem" and
"the problem was cased by such and such" that forces readers to
either know the problem at heart (may apply to you and me right now,
but I am not sure about me 3 months in the future) or go check the
external website.

Can we fill the gap by saying how seeing the object name of empty
blob (or worse, tree) instead of 0{40} made "difftool -d" upset?

Thanks.


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t7800-difftool.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 29b92907e2..524f30f7dc 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -720,6 +720,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'add -N and difftool -d' '
> +	test_when_finished git reset --hard &&
> +
> +	test_write_lines A B C >intent-to-add &&
> +	git add -N intent-to-add &&
> +	git difftool --dir-diff --extcmd ls
> +'
> +
>  test_expect_success 'outside worktree' '
>  	echo 1 >1 &&
>  	echo 2 >2 &&
