Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB40C43461
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CF1613C0
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhELX3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:29:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62611 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhELXZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:25:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB734145801;
        Wed, 12 May 2021 19:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R8O2NCV40QAw4oOxYKTBjkX8gnXXDHZvMMeHPf
        sEHdE=; b=iObU+MsuFfL81OmNvWZ5xjJM25RFGdmxK0ZWn2s6r9NqKdukMx985W
        EV88YjwIGNKHjNgezjmJ8sHajcXfiGEty1WciqEw6Q2T39QN5WTI5ek+JrFYoYnp
        J7XUwd9GZRobgZu0gBeSeVRnW6Y8pQoMoeH/b47tvImllauRmcxSM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3852145800;
        Wed, 12 May 2021 19:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16EF51457FF;
        Wed, 12 May 2021 19:24:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com>
        <pull.949.v6.git.1620821572126.gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 08:24:20 +0900
In-Reply-To: <pull.949.v6.git.1620821572126.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Wed, 12 May 2021 12:12:51 +0000")
Message-ID: <xmqqfsyredsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EB72698-B379-11EB-8D76-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success '%(color:#aa22ac) must succeed' '
> +	mkdir test &&

You do not need "mkdir test" here, as "git init test" would take
care of it.

On the other hand, you'd want to get 'test' directory removed after
this passes, so 

	test_when_finished rm -fr test &&

would be useful.

Other than that, looks good to me.

Thanks.

> +	git init test &&
> +	(
> +		cd test &&
> +		test_commit initial &&
> +		git branch -M main &&
> +		cat >expect <<-\EOF &&
> +		refs/heads/main
> +		refs/tags/initial
> +		EOF
> +		git remote add origin nowhere &&
> +		git config branch.main.remote origin &&
> +		git config branch.main.merge refs/heads/main &&
> +		git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'left alignment is default' '
>  	cat >expect <<-\EOF &&
>  	refname is refs/heads/main    |refs/heads/main
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
