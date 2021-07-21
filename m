Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34828C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE260D07
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhGTXgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:36:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhGTXgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 19:36:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E28F413C0C5;
        Tue, 20 Jul 2021 20:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2FDe3iBqUB5yUVV16SGHO0Mk30EpLoogIdZmeo
        g+4W8=; b=WHrH+7hmqviWN+NAA5wMup0uYSCZdHS/nqq8sgzkK1VsrJhMb1KEqr
        HoaCV9jDBXjGLTijo1+m2lxtR0aH61nTUn4K7Z4/coXM5eY6an++XfG1F7Yip7kv
        r0SnLmld7Aj3jfVIEohDbHVzzbzYIFrp0xRCEnm9PlqWVEQqtdCQE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF59F13C0C4;
        Tue, 20 Jul 2021 20:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F32A013C0C3;
        Tue, 20 Jul 2021 20:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 8/9] pull: update docs & code for option compatibility
 with rebasing
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <d1952f014f20d2770c74a311df27f956c8b95e21.1626536508.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:17:19 -0700
In-Reply-To: <d1952f014f20d2770c74a311df27f956c8b95e21.1626536508.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 17 Jul 2021
        15:41:46 +0000")
Message-ID: <xmqq5yx4frlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03FE1BE8-E9B9-11EB-95D3-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> git-pull.txt includes merge-options.txt, which is written assuming
> merges will happen.  git-pull has allowed rebases for many years; update
> the documentation to reflect that.

Yes, as I might have said elsewhere recently, "pull --rebase" has
been afterthought and the way how it interacts with many niche
"features" of "git pull" has never been designed but started with
whatever the code happened to do and then fixed/tweaked as people
found it suboptimal.  Hopefully with this series we are covering
these interactions and whipping them into a much better shape with
coherent semantics.

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index cad3f6bfcee..6e6e95a7595 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -125,6 +125,8 @@ When false, merge the current branch into the upstream branch.
>  +
>  When `interactive`, enable the interactive mode of rebase.
>  +
> +Note that `--ff-only` takes precedence over any `--rebase` flag.
> ++

"`ff-only` overrides any `--rebase` flag"?

> @@ -58,6 +61,10 @@ could instead be resolved as a fast-forward.
>  +
>  With `--ff-only`, resolve the merge as a fast-forward when possible.
>  When not possible, refuse to merge and exit with a non-zero status.

This part may want to become conditional with git-pull[] to use a
verb different than "merge"?

> +ifdef::git-pull[]
> ++
> +Note that `--no-ff` and `--ff` are ignored when rebasing is requested.
> +endif::git-pull[]

OK.
