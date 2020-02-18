Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5191EC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE8208C4
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLQluX+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRSSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:18:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgBRSSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 13:18:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so11053787pfc.5
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 10:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFeI+bczeaqoAHVobr1ls4+YIqc30sdSM0JRwm6lAzY=;
        b=dLQluX+U4rHfofbeZ0YS/d+SHpMdoVXMIgIds0uOXJUnJQs5MTSVJ2XVMqPcgPK1KF
         hYgpQCDjm98GTJApIkuWZp83VhVzgD6nZIT16qMOGhdVopy50t/4Vj4fY+o1JQjtfPUe
         Z0k5vRxTicF9lhYDa9wohtvmI03LDXtEWyfl13/oVjcnqC6pccrW69rSxRbxgwPwGNGl
         Y23AvDGp4yvdWvDK5ciThQupTjkJwimMVhCteKRSaHFf6Z59DL0WdE8nJQ9xHjF7PZ37
         e87OE2zrkFcvlVsYZu7J+3qSpRc/zWUsHptHAjE2M2/bP1QKCjf7fnd8lq8qcAi3ks0/
         CyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFeI+bczeaqoAHVobr1ls4+YIqc30sdSM0JRwm6lAzY=;
        b=IGZCMY5r/RiM04zCyt+XKgxrcgkWQLCJ3WaXMAmik0Qd0IzswKdgtlSkl3l3Kc1NW7
         RFrG0nZjaB76Wii1gKPUdtXj/oCDMEB8IM6VqbYgaIT4BB+j4ekNnOXTphkWpRfD295G
         +8aRmu3WU34WBSZOrZlAZj+SZXYq/EBH0c0PFaLoqr/S9XNeVFtKE3tJDSJQm72lugq4
         V8M0EPl99d44FtYXe0F3ZAv62IRlm71gMPxFILScmgABtjuCR1F84LaEfz3YCNrrFR4g
         4FGHTbS95YuXzLyMqC627z8PSHlnxWEiMmmX/gxj0+daym1+mvL0yjZ0LuxhYvpq1uUt
         Fk7Q==
X-Gm-Message-State: APjAAAVUBUPlkuixeIc1eRNe4ErbdLc11gu4oGFQKdRXi/8qou2M+1pK
        jgJQSyoCf4tur2zA0PRuaAQ=
X-Google-Smtp-Source: APXvYqzdAN4Vr33GNhLbe6vZjeQbMKdPySY3jzgz7M75XA1Iq0T7DamMR1Fpr/nHPYLjT4hVQFWHGg==
X-Received: by 2002:a63:8f49:: with SMTP id r9mr24405848pgn.190.1582049904819;
        Tue, 18 Feb 2020 10:18:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:493e:b22e:e9c8:d09a? ([2001:4898:e008:1:d27a:b22e:e9c8:d09a])
        by smtp.gmail.com with ESMTPSA id y10sm5120657pfq.110.2020.02.18.10.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:18:24 -0800 (PST)
Subject: Re: [PATCH v2 09/15] rev-list: allow commit-only bitmap traversals
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182227.GI150965@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <967821c8-aca4-52ff-8eb9-01a74f5a8144@gmail.com>
Date:   Tue, 18 Feb 2020 13:18:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200214182227.GI150965@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2020 1:22 PM, Jeff King wrote:
> Here are numbers for linux.git:
> 
>   Test                         HEAD^               HEAD
>   ------------------------------------------------------------------------
>   5310.7: rev-list (commits)   8.29(8.10+0.19)       1.76(1.72+0.04) -78.8%
>   5310.8: rev-list (objects)   8.06(7.94+0.12)       8.14(7.94+0.13) +1.0%

Nice.

> That run was cheating a little, as I didn't have any commit-graph in the
> repository, and we'd built it by default these days when running git-gc.
> Here are numbers with a commit-graph:
> 
>   Test                         HEAD^               HEAD
>   ------------------------------------------------------------------------
>   5310.7: rev-list (commits)   0.70(0.58+0.12)     0.51(0.46+0.04) -27.1%
>   5310.8: rev-list (objects)   6.20(6.09+0.10)     6.27(6.16+0.11) +1.1%
> 
> Still an improvement, but a lot less impressive.

I think this is still impressive, because you are still allocating the
object structs and writing data to the output. The commit-graph code allows
cheating and doing very little work when navigating from one commit to
another. I suppose the biggest difference between these two approaches is
that the object cache contains "parsed" commits at the end (with allocated
parents and initialized commit times) and we needed a priority queue for
the commit walk. I'm impressed that this is still 27% improvement!

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index b8645ae070..2c64d0c441 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -80,6 +80,12 @@ rev_list_tests() {
>  		test_cmp expect actual
>  	'
>  
> +	test_expect_success "enumerate commits ($state)" '
> +		git rev-list --use-bitmap-index HEAD >actual &&
> +		git rev-list HEAD >expect &&
> +		test_bitmap_traversal --no-confirm-bitmaps expect actual
> +	'
> +

I was wondering if there is anything we could add to the "expect"
command that could better guarantee these commits show up in a
different order than the bitmap order, allowing us to drop the
"--no-confirm-bitmaps". Perhaps the issue is the merge structure
of the repository, and how it will cause these orders to always
agree?

I suppose "--topo-order" may actually present an order _even closer_
to the bitmap order.

Thanks,
-Stolee
