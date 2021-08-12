Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE6C432BE
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0206108C
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhHLR36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhHLR3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 13:29:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E0C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 10:29:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bi32so11544468oib.2
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7HkJEbJG87RoPxQUREOFJ64JVcN6O/P0h44VBZLRTog=;
        b=Q+J6GJaZLSZ47hvl7V7DlemTlDv8TeIIHVYb+fK/Lxhm2ezYY33k7waMFtRsdYNxrN
         sfWjZRMxQHTZaDEStsTa/glmGfAjHXDIOoGNFTlQ1GtiHe06833qb158Ou6lH4X1yUPw
         UwNZS2GmY80t56Jn79PeEayDFAWYrbqrauOl8pDzCm23W/87zE9ecD2FhYfD+oO8efY/
         CQ6rbM1CEhEfChanen3lrQAoIavK6bLG8R4QsLB4uLW0VgT7II7x1JA7rUHaMQ1sdLIL
         ObsOM+CW2ALgzn6cmWbusb7COFpIqEIzu1u62SFTqLIyLfTobiZ3txESLIz4+VKJ5b7m
         BM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HkJEbJG87RoPxQUREOFJ64JVcN6O/P0h44VBZLRTog=;
        b=YGWjfoNtO+rxioqN/E2KUGBZCjVWRUfmY6yGtlHOhDwLVumthl1gp0/yNn/hCCZEB+
         MCZv2FMwxwwaCTRSHOzPBxuOSYyywYQrYfB88Egmlpl5+MJfvUA6lxbYqEMzsBTosV96
         6Ts79ikvvgUfv4osoYHxkrvuNsRXvTex8DVSxBarGj01fRDjJ9qWdbxcVHdBYk6jioxc
         fFRwVjdkUKHQQQEAXqZMUlTLiPKSwxYPWEbQnUl5GNOjcC7sIY2XsMclp5wC9PxNnQBO
         WEEKegv5dwp8RlPFKfCFmuWX3niAr4CBzMxBNmOL+FD5J5pINteY3CxSGnfVhoVcL6iA
         x7bA==
X-Gm-Message-State: AOAM532K3Be2bA1WSXuHe2ZdrQtYiZo4bi2hHFFkdww5BLnFF6QbTHKe
        qXUmDjw6awcX5eoXlfn+C/s=
X-Google-Smtp-Source: ABdhPJwXCsamxwGOwYGVUXXHP2tLBkaa/tJUGAtzB56e7p/e1IkmZrAScROFuTyVEcRHw/wrJDGKFA==
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr4294867oiu.19.1628789351231;
        Thu, 12 Aug 2021 10:29:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:296a:10d6:96d9:d708? ([2600:1700:e72:80a0:296a:10d6:96d9:d708])
        by smtp.gmail.com with ESMTPSA id l16sm690750ooa.9.2021.08.12.10.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:29:10 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] sparse-checkout: create helper methods
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <e9ed5cd283087b8f23112f6f3ecbb5a282c4c717.1628625014.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bac76c72-955d-1ade-4ecf-778ffc45f297@gmail.com>
Date:   Thu, 12 Aug 2021 13:29:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e9ed5cd283087b8f23112f6f3ecbb5a282c4c717.1628625014.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/2021 3:50 PM, Derrick Stolee via GitGitGadget wrote:
...
> +enum pattern_match_result path_in_sparse_checkout(const char *path,
> +						  struct index_state *istate)
> +{
> +	int dtype = DT_REG;
> +	init_sparse_checkout_patterns(istate);
> +
> +	if (!istate->sparse_checkout_patterns)
> +		return MATCHED;
> +
> +	return path_matches_pattern_list(path, strlen(path), NULL, &dtype,
> +					 istate->sparse_checkout_patterns,
> +					 istate);

While expanding on this work to fix behavior in 'git (add|rm|mv)' around
sparse entries, I noticed a problem with this method, specifically with
non-cone-mode patterns:

1. The NULL here should be the "basename" of the path, not NULL. This doesn't
   matter for cone mode, but _does_ matter for more general patterns.

2. The return type here can be UNDECIDED with general patterns, which really
   means "not matched" but is distinct from NOT_MATCHED because of the recursive
   assumptions when a directory is returned with NOT_MATCHED. Since the usage
   pattern for path_in_sparse_checkout() is to get a boolean result, the
   return type should switch to 'int' and we should return
   "path_matches_pattern_list(...) > 0".

I'm still doing some more testing to ensure I've got the necessary tweaks in
place to work with the other changes I'm going for. Plan on me sending a v3
with the appropriate changes here.

>  	/*
>  	 * Is the current path outside of the sparse cone?
>  	 * Then check if the region can be replaced by a sparse
>  	 * directory entry (everything is sparse and merged).
>  	 */
> -	match = path_matches_pattern_list(ct_path, ct_pathlen,
> -					  NULL, &dtype, pl, istate);
> +	match = path_in_sparse_checkout(ct_path, istate);
>  	if (match != NOT_MATCHED)
>  		can_convert = 0;

We could remove the use of "match" here and use the boolean result of
path_in_sparse_checkout() instead.

Thanks,
-Stolee
