Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C851AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 07:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiBPHUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:20:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiBPHUK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 02:20:10 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46CE02F5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:19:57 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A36F18F5CE;
        Wed, 16 Feb 2022 02:19:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x4OUh8I0TBYV8bJcwEFlORvkHfqMMa67+Wo/H8
        VG3Lo=; b=L/GXYNbZeoUE9l1EhsN8A2YOcibBQTywxMbAOLcMuKEPnChn56MKXf
        Hl2p28RcP3tCSJ/EWHgBFwxj3UdgIREsPZObePP4h5QrfPGPuI4ry8AOzZa8KItz
        yJMnWZP5ZfgZ1bZ1By2MhyjfJcDIfU4GkUyqQMfDhkurugnvVHySE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07B2418F5CD;
        Wed, 16 Feb 2022 02:19:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57DC218F5CC;
        Wed, 16 Feb 2022 02:19:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/5] sparse checkout: fix a few bugs and check
 argument validity for set/add
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 23:19:53 -0800
In-Reply-To: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 16 Feb 2022 04:21:18
        +0000")
Message-ID: <xmqqo837uvl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D685439A-8EF8-11EC-8D6F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Patch to resolve textual and semantic conflict with
> ds/sparse-checkout-requires-per-worktree-config:
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> remerge CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
> index 3c6adeb885..3a95d2996d 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -275,24 +275,8 @@ test_expect_success 'sparse-index enabled and disabled' '
>      diff -u sparse full | tail -n +3 >actual &&
>      test_cmp expect actual &&
>  
> -<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 286c22e5ec (sparse-checkout: reject arguments in cone-mode that look like patterns)
>      git -C repo config --list >config &&
> -    ! grep index.sparse config
> -|||||||||||||||||||||||||||||||| 89bece5c8c
> -        diff -u sparse full | tail -n +3 >actual &&
> -        test_cmp expect actual &&
> -
> -        git -C repo config --list >config &&
> -        ! grep index.sparse config
> -    )
> -================================
> -        diff -u sparse full | tail -n +3 >actual &&
> -        test_cmp expect actual &&
> -
> -        git -C repo config --list >config &&
> -        test_cmp_config -C repo false index.sparse
> -    )
> ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3ce1138272 (config: make git_configset_get_string_tmp() private)
> +    test_cmp_config -C repo false index.sparse
>  '

The above is quite straight-forward.

>  test_expect_success 'cone mode: init and set' '
> @@ -532,6 +516,7 @@ test_expect_success 'reapply can handle config options' '
>      cat >expect <<-\EOF &&
>      core.sparsecheckout=true
>      core.sparsecheckoutcone=true
> +    index.sparse=false
>      EOF
>      test_cmp expect actual &&
>  
> @@ -539,6 +524,8 @@ test_expect_success 'reapply can handle config options' '
>      git -C repo config --worktree --list >actual &&
>      cat >expect <<-\EOF &&
>      core.sparsecheckout=true
> +    core.sparsecheckoutcone=false
> +    index.sparse=false
>      EOF
>      test_cmp expect actual &&

These differences are a bit nasty, but of course understandable once
it is shown X-<.

Thanks.
