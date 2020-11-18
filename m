Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E4C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1B020B1F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="afo3q8qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKRUVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:21:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54565 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKRUVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:21:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAD138FEBB;
        Wed, 18 Nov 2020 15:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8qEw1rtR3QQXGf+oinRZCSSjAPg=; b=afo3q8
        qjC/LQNieU4lBxnmbxGD4iwGI4SuWsMHjpoZ4+rWvuZ3gtEzxLiixHtkPC4se6iL
        nl2Ov5HK97cjY5LQAvMN8UqcquOOZcHsnz7l4AmIlkBf8Bn94/R6zCOXHXf46OWm
        1CljPDYU4wDUfnzxyMAGuhojjii7GNFCi8+mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sAqa1NP/gmCExjshpf/0ZsGBagFtzpHT
        LXnKwOKEcFHVqftFMa8Sa1hqiMpHby/r4JO45xSMQA9QigH8ftVeBajCjKgXXfVN
        WYqqBAqXatEvCJR2Ma5ddAFGahhoafpcExrHDgHO+GYo2uUdtTstGIqlKwO5Xs2A
        JHfXiBb+zjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE4908FEBA;
        Wed, 18 Nov 2020 15:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61B8D8FEB9;
        Wed, 18 Nov 2020 15:20:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t4015: let the test pass with any default branch name
References: <pull.794.git.1605727594021.gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 12:20:56 -0800
In-Reply-To: <pull.794.git.1605727594021.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 18 Nov 2020 19:26:33
        +0000")
Message-ID: <xmqqd00a1knr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 911E4B18-29DB-11EB-B3EF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We do not need to hard-code the actual branch name, as we have access to
> the reflog and can be a lot more precise at what we want.

I am not enthused to see us going beyond "@{1}" or "@{-1}".  It
would make the test a bit too brittle as a future changes need to
refrain from creating another commit and/or switching to a third
branch to do some more set-up before coming here to attempt an
merge.  

In this particular case, "git merge @{-1}" may be more robust from
that point of view

Thanks.

>  t/t4015-diff-whitespace.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 8bdaa0a693..c9dd62b70e 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -883,7 +883,8 @@ test_expect_success 'combined diff with autocrlf conversion' '
>  	echo >x goodbye &&
>  	git commit -m "the other side" x &&
>  	git config core.autocrlf true &&
> -	test_must_fail git merge master &&
> +	test_must_fail git merge @{2} >actual &&
> +	test_i18ngrep "Automatic merge failed" actual &&
>  
>  	git diff >actual.raw &&
>  	sed -e "1,/^@@@/d" actual.raw >actual &&
>
> base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
