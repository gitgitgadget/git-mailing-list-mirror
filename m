Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C010BC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D8B6127C
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhGMWoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:44:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65131 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhGMWog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:44:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5925C79D2;
        Tue, 13 Jul 2021 18:41:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f4zq8U/lkudXmmc6SNK8D1ZePgmmJqauO2aeDn
        OYEoc=; b=Z11UfqJwG/0vPJoNqIfw+TX/UhENbg/zYnBn7XiZVLPrSndxh29M0n
        JM3Xq+PHVONDNXxAs1NgxYNBE6c6lwQJI7PfeulA98ENviOjUiMIsr5dIuVZGZPZ
        UAFdZgNB04inUI3gHIbsYuP2ffcKp1bvfkToFlQG/1dK34JjLX89g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD822C79D1;
        Tue, 13 Jul 2021 18:41:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DE13C79D0;
        Tue, 13 Jul 2021 18:41:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 15:41:44 -0700
In-Reply-To: <pull.994.git.1626177086682.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 13 Jul 2021 11:51:26
        +0000")
Message-ID: <xmqqbl7525w7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8068AE16-E42B-11EB-B375-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Occasionally we receive reviews after patches were integrated, where
> `sparse` identified problems such as file-local variables or functions
> being declared as global.

I really appreciate addition of this task, as I often notice sparse
errors _after_ queuing and refreshing the incoming patches for the
day and soon after starting to run the day's test cycle.

> By running `sparse` as part of our Continuous Integration, we can catch
> such things much earlier. Even better: developers who activated GitHub
> Actions on their forks can catch such issues before even sending their
> patches to the Git mailing list.
>
> This addresses https://github.com/gitgitgadget/git/issues/345
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci: run make sparse as a GitHub workflow
>     
>     One of the earliest open source static analyzers is called "sparse", and
>     occasionally Ramsay Jones sends out mails on the Git mailing list that
>     some function or other should be declared static because sparse found
>     out that it is only used within the same file.
>     
>     Let's add a GitHub workflow running "make sparse".
>     
>     Example run: https://github.com/gitgitgadget/git/actions/runs/1026303823
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-994%2Fdscho%2Fci-enable-sparse-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-994/dscho/ci-enable-sparse-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/994
>
>  .github/workflows/run-sparse.yml | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 .github/workflows/run-sparse.yml

We choose to do this as a separate new workflow not as part of the
main one because this is more like check-whitespace where there is
no room for tests over the matrix of compilers and platforms play
any useful role?  Unlike check-whitespace one that has

    on:
      pull_request:
        types: [opened, synchronize]

but just like the primary one, this is triggered

    on: [push, pull_request]

and before the patches even hit the list via GGG, which would be
ideal.

As has already been pointed out downthread, use of separate and
different ways to install the sparse itself and its dependencies
looks strange, so it would be appropriate to either explain why they
have to be that way in the proposed log message or to install them
in the same way in the YAML file.

Also, "\ No newline at end of file" would be a good thing to fix
while we are at it.

> diff --git a/.github/workflows/run-sparse.yml b/.github/workflows/run-sparse.yml
> new file mode 100644
> index 00000000000..25f6a6efb40
> --- /dev/null
> +++ b/.github/workflows/run-sparse.yml
> @@ -0,0 +1,22 @@
> +name: Run `sparse`
> +
> +on: [push, pull_request]
> +
> +jobs:
> +  sparse:
> +    runs-on: ubuntu-20.04
> +    steps:
> +    - name: Download the `sparse` package
> +      uses: git-for-windows/get-azure-pipelines-artifact@v0
> +      with:
> +        repository: git/git
> +        definitionId: 10
> +        artifact: sparse-20.04
> +    - name: Install the `sparse` package
> +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
> +    - name: Install a couple of dependencies
> +      run: |
> +        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
> +    - uses: actions/checkout@v2
> +    - name: make sparse
> +      run: make sparse
> \ No newline at end of file
>
> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
