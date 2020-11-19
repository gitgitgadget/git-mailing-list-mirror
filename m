Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C385C63798
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AE4221FE
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 23:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yXwCCAaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKSXRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:17:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgKSXRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 18:17:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 562B810130C;
        Thu, 19 Nov 2020 18:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WDeIx9Kw50TLPlLEdKB+sO3TOlw=; b=yXwCCA
        aV/DRfYfO2SxgXlnSjqcFDroTIGzjeMNgV5W/uAZlusj55Q3WQFMsQQaVDTRJiH0
        vEO6KnEVXB3gjF34vl60bpfnhBEGL5+pIbbnz0dILvxCaRY8vXfC0vK+dOR+BXcz
        FIe9KySBtGkFgyN89/um3n4z/0BMxIF+91XYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E0jZydB9NSu1oQVYshx7UOpWXg0KfCmm
        Ti7Je/RFAs/EhjAdKRP1yHgqH4dKJgCh+KnqVFWBnqh1K+WLZMNFLMlDHE/tlxO/
        kFCkjgLMjsE+aWnnk0LurPVYfpYe74mkR24d0FQCua5UfyknHf+VO6+V08QTo3eG
        Abd4lWA4kuc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DF2D10130B;
        Thu, 19 Nov 2020 18:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C3D0101309;
        Thu, 19 Nov 2020 18:17:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 7/7] maintenance: use 'git config --literal-value'
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <1d1c2fd23e805e0f25edd324a614715b1d11a2bb.1605801143.git.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:17:27 -0800
In-Reply-To: <1d1c2fd23e805e0f25edd324a614715b1d11a2bb.1605801143.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 Nov 2020
        15:52:23 +0000")
Message-ID: <xmqq7dqhvsvs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64D73686-2ABD-11EB-8584-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When a repository's leading directories contain regex glob characters,
> the config calls for 'git maintenance register' and 'git maintenance
> unregister' are not careful enough. Use the new --literal-value option
> to direct the config machinery to use exact string matches. This is a
> more robust option than excaping these arguments in a piecemeal fashion.
>
> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Reported-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/gc.c           |  5 +++--
>  t/t7900-maintenance.sh | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index e3098ef6a1..0784bbdc6a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1452,7 +1452,8 @@ static int maintenance_register(void)
>  		git_config_set("maintenance.strategy", "incremental");
>  
>  	config_get.git_cmd = 1;
> -	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
> +	strvec_pushl(&config_get.args, "config", "--global", "--get",
> +		     "--literal-value", "maintenance.repo",
>  		     the_repository->worktree ? the_repository->worktree
>  					      : the_repository->gitdir,
>  			 NULL);
> @@ -1483,7 +1484,7 @@ static int maintenance_unregister(void)
>  
>  	config_unset.git_cmd = 1;
>  	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> -		     "maintenance.repo",
> +		     "--literal-value", "maintenance.repo",
>  		     the_repository->worktree ? the_repository->worktree
>  					      : the_repository->gitdir,
>  		     NULL);
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 20184e96e1..2ee5512158 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -367,6 +367,18 @@ test_expect_success 'register and unregister' '
>  	test_cmp before actual
>  '
>  
> +test_expect_success 'register and unregister with glob characters' '
> +	GLOB="a+b*c" &&
> +	git init "$GLOB" &&
> +	git -C "$GLOB" maintenance register &&
> +	git config --get-all --show-origin maintenance.repo &&
> +	git config --get-all --global --literal-value \
> +		maintenance.repo "$(pwd)/$GLOB" &&
> +	git -C "$GLOB" maintenance unregister &&
> +	test_must_fail git config --get-all --global --literal-value \
> +		maintenance.repo "$(pwd)/$GLOB"
> +'
> +

Makes sense.  Thanks.

As to the topic-branch organization, my plan is for the final shape
(I haven't really reviewed the early 6 yet so I do not know if they
require rerolling at this point) would be to:

 - create ds/config-literal-value topic on somewhere old enough and
   queue [1/7] thru [6/7] on it.

 - merge the above into ds/maintenance-part-3

 - apply [7/7] on top of ds/maintenance-part-3

