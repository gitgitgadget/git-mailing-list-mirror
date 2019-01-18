Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4A81F453
	for <e@80x24.org>; Fri, 18 Jan 2019 20:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfARUAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 15:00:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43375 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfARUAh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 15:00:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so16486420wrs.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3i0ATIAjpClufEit9Q83Nb0dn0QOff5EEo9WDt9tcNs=;
        b=aAcUBz63almzO8NKsOUSF+4fAeIpHO+8h1x/2jecKrrlQJmAj0RRnI22cU26WTPnb2
         6zSw62xUGcTkphmJslyFTohKS0RuTjPa4MExlNUn9hpkJIYm8c+y8bVpfNUlSDGQEI2V
         0IoHwYt0zv8jpJVtbcLua0qA8uE7ZiJB9x5/0Sm8+b53EJFVLSdfINGRX/1OER0s3RS4
         U+Twy8ma2YUrFkyfNINAF4FANjdBgiQFKeLzo8+GN7QCjJ5UVe94JUmrD6vkCO0+Js9I
         bNQP+6w0j8ES8/cebupD1LwjT9VZoXglREAw6fGPX+uaxAKgY8qPd5m54mqH27n+JVgh
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3i0ATIAjpClufEit9Q83Nb0dn0QOff5EEo9WDt9tcNs=;
        b=pbkVJHub1panbW6+e6HfdvFBLuSisg9onY7+dDmDlGSIgeYL2r3czOCWmVmKvcfOyA
         ce5t+tXSi/JaypIrbVFxdz5vhqDjkCzXEeEkOFkfSHqes9kqaxZiNws4NFDYV/YYOiYa
         WUPGy1ZxxEl1VZRuL6RFNpB3ssX3NPB/0YW7nwJ1HOsZtrswotVPx+ZxAMOco9kQD17D
         8yAW1zAHBubwQrSJVJgMIfEOUNLialy7e3CsxVcGLJn4h1R/8ROgY1HGoME75pqmfBNH
         ZDkEGvD4Rvb/11ev/YBRRMfVhDaFJkxz+1TqSM4nPWLExvOJK3r5smIpUKdPQ8IA51qp
         VdSA==
X-Gm-Message-State: AJcUukd2SJjk+Wvfp4kCGdrtydXux/S7V991cuQ6/CUwANQnTC2TDWyE
        WjWdKlfWrxiIe4UVYYjaRS4=
X-Google-Smtp-Source: ALg8bN6b5fkyVzfD5OW7HKfNjTqWLWum0+Tnbe7Gph6A8nl9rLeBsK+AK7Kud+ya1dsjJpV8cryu0g==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr16970722wrj.91.1547841635600;
        Fri, 18 Jan 2019 12:00:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x10sm106526225wrn.29.2019.01.18.12.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 12:00:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, asottile@umich.edu,
        pclouds@gmail.com
Subject: Re: [PATCH v1 2/2] checkout: fix regression in checkout -b on intitial checkout
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
        <20190118185558.17688-1-peartben@gmail.com>
        <20190118185558.17688-3-peartben@gmail.com>
Date:   Fri, 18 Jan 2019 12:00:34 -0800
In-Reply-To: <20190118185558.17688-3-peartben@gmail.com> (Ben Peart's message
        of "Fri, 18 Jan 2019 13:55:58 -0500")
Message-ID: <xmqqef99ka71.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> From: Ben Peart <benpeart@microsoft.com>
>
> When doing a 'checkout -b' do a full checkout including updating the working
> tree when doing the initial checkout.  This fixes the regression in behavior
> caused by fa655d8411 checkout: optimize "git checkout -b <new_branch>"
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  builtin/checkout.c         | 6 ++++++
>  t/t2018-checkout-branch.sh | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6fadf412e8..af6b5c8336 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -517,6 +517,12 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>  	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
>  		return 0;
>  
> +	/*
> +	 * We must do the merge if this is the initial checkout
> +	 */
> +	if (is_cache_unborn())
> +		return 0;
> +

Yup, that's a trivial fix ;-)

>  	/*
>  	 * We must do the merge if we are actually moving to a new commit.
>  	 */
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 35999b3adb..c438889b0c 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -206,7 +206,7 @@ test_expect_success 'checkout -b after clone --no-checkout does a checkout of HE
>  	rev="$(git -C src rev-parse HEAD)" &&
>  	git clone --no-checkout src dest &&
>  	git -C dest checkout "$rev" -b branch &&
> -	test_must_fail test -f dest/a
> +	test -f dest/a
>  '

This is flipping the wrong thing.  Rather, introduce the whole test
as test_expect_failure that wants to make sure dest/a exists, and
with this 2/2 patch flip test_expect_failure into test_expect_success.

Thanks.
