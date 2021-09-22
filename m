Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1A7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B8860F4C
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhIVWyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:54:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59146 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbhIVWxx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:53:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10AB91594A0;
        Wed, 22 Sep 2021 18:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CcD4nSAInNA1s/tDPPHtM1Saup1QGnwYBJUYGl
        /5+tg=; b=bmSscxmMvjBGBKbwSVz2UDXdHY0DK0oq28R+4NkNq9Sbm1skYCCzNu
        zCtqgDjW2L5m2ewgTBVPjWWLNLai3v5AUdgbUN3ZVc7D+gyyatzm7J9sJIM8aGb3
        aVg44SV44fa+I7Xuk9ZbO3S2CB1QDCF+jzqQZyz3qnQt/DxoNLfDQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0895D15949F;
        Wed, 22 Sep 2021 18:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C80615949E;
        Wed, 22 Sep 2021 18:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 01/14] t3705: test that 'sparse_entry' is unstaged
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <ea940f10a7cd26c6be3693b5a800afb7d6f752f2.1632159937.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Sep 2021 15:52:11 -0700
In-Reply-To: <ea940f10a7cd26c6be3693b5a800afb7d6f752f2.1632159937.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 20 Sep 2021
        17:45:24 +0000")
Message-ID: <xmqq7df85ilg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B97ECF4C-1BF7-11EC-8692-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
> behaves with paths outside the sparse-checkout definition. These
> currently check to see if a given warning is present but not that the
> index is not updated with the sparse entries. Add a new
> 'test_sparse_entry_unstaged' helper to be sure 'git add' is behaving
> correctly.
>
> We need to modify setup_sparse_entry to actually commit the sparse_entry
> file so it exists at HEAD and as an entry in the index, but its exact
> contents are not staged in the index.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t3705-add-sparse-checkout.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 2b1fd0d0eef..e202a2ff74a 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -19,6 +19,7 @@ setup_sparse_entry () {
>  	fi &&
>  	git add sparse_entry &&
>  	git update-index --skip-worktree sparse_entry &&
> +	git commit --allow-empty -m "ensure sparse_entry exists at HEAD" &&
>  	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
>  }
>  
> @@ -36,6 +37,11 @@ setup_gitignore () {
>  	EOF
>  }
>  
> +test_sparse_entry_unstaged () {
> +	git status --porcelain >actual &&
> +	! grep "^[MDARCU][M ] sparse_entry\$" actual

Does this say "we do not want any difference from the index, be it
modification, deletion, addtion, etc."?

Just wondering if there were a reason why the pattern is more
complex than "^[^ ][M ]" (i.e. anything but "unmodified since the
index"), not necessarily suggesting to spell the test differently.

Thanks.
