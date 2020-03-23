Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFF9C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92420714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFCNEEIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCWP5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:57:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34402 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCWP5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:57:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id e9so6854780oii.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Q7vZdcNBc6mQRcT68jlea8XYKdXErYEwL2abqSA4ec=;
        b=TFCNEEIvXWj6I6+ASFp+VUKA6ZRX9EKEEqy52rguO8RaLE/cD5Op4D4IEtCXGIrh8g
         YTSK2iOfQFzH7aF/cq0wk5dNhebUtdTn5rAR+lkh5vgQsne5S4UImawybadBsamBYQtO
         jm4bPNy0jzZ1VorApXCivTxGJ11kGioLYkeoitsApB3YlMbKvKS025OZtnQnnkaEftiC
         X3T+fhu/I0M597VliXH9dU1OW+PQHhiADKrZQQHnQTPtOSHWt4gXYEnE6cttjqgAXSnk
         u4H+ANfBWtE/xABr34vA6LCB4nkGd52C9++q10a9FAmzNtKGf/jYfYAaNKUjTqd5UQ8P
         bPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Q7vZdcNBc6mQRcT68jlea8XYKdXErYEwL2abqSA4ec=;
        b=TfMrzyBnsgOSopQZ9hHJQPyzcTrBSZueInUIXLnkolkn7VaMSyU43L6x2sw4nEFtLk
         vM1F473XadRgA4y8KdEiq5dMmElNB6odJzg9vz227SXDgHDZLHQ4yBFH2ua9s2Hrlv+K
         DJsNZczOe4ASi33F+oJB/nh1y4cH86cJiaQATEvAiCm0IVTv4DGPp+9LdFD1ZJzYs2Ov
         AcrXOBcUf8HQBBgibJucy31ck4rvp2Z0iLc/JTwZW8GmgPY3pH3M/9uuGGYZH3sxbL08
         EHe3xiSqnN0BBcxhpk8pKL1QGUxq+AdWdZTpmEypPKUC3CoxO3NY0xCoao6Li42dK8lV
         kAJA==
X-Gm-Message-State: ANhLgQ0J+kkvbfzN/rqLYm3P+0898sgF+/BNBKbeowECUH9iLdH8aFoD
        zu0lQ9EOeckm+J2joxTkgYo=
X-Google-Smtp-Source: ADFU+vtjhEbVGv5M2QwhXZcsG8O09DA1V/8NEp+Q3RliPzUuXCOZnC+f6ziLtANedUSTCLVa/n6owA==
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr16861887oib.111.1584979042364;
        Mon, 23 Mar 2020 08:57:22 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d84sm915406oig.33.2020.03.23.08.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 08:57:21 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] unpack-trees: simplify pattern_list freeing
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <65772dd46df12d79a41e7ed2d6e1fc197b80d379.1584813609.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d99a17b6-49ab-51d9-621d-adf6eb0b7ffa@gmail.com>
Date:   Mon, 23 Mar 2020 11:57:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <65772dd46df12d79a41e7ed2d6e1fc197b80d379.1584813609.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 1:59 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> commit e091228e17 ("sparse-checkout: update working directory
> in-process", 2019-11-21) allowed passing a pre-defined set of patterns
> to unpack_trees().  However, if o->pl was NULL, it would still read the
> existing patterns and use those.  If those patterns were read into a
> data structure that was allocated, naturally they needed to be free'd.
> However, despite the same function being responsible for knowing about
> both the allocation and the free'ing, the logic for tracking whether to
> free the pattern_list was hoisted to an outer function with an
> additional flag in unpack_trees_options.  Put the logic back in the
> relevant function and discard the now unnecessary flag.

Your approach here is much cleaner. Thanks!

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c | 1 -
>  unpack-trees.c            | 6 ++++--
>  unpack-trees.h            | 3 +--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 740da4b6d54..d102a9697fd 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -122,7 +122,6 @@ static int update_working_directory(struct pattern_list *pl)
>  	o.dst_index = r->index;
>  	o.skip_sparse_checkout = 0;
>  	o.pl = pl;
> -	o.keep_pattern_list = !!pl;
>  
>  	resolve_undo_clear_index(r->index);
>  	setup_work_tree();
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3af2e126abf..d2863fa0310 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1503,6 +1503,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	int i, ret;
>  	static struct cache_entry *dfc;
>  	struct pattern_list pl;
> +	int free_pattern_list = 0;
>  
>  	if (len > MAX_UNPACK_TREES)
>  		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
> @@ -1519,6 +1520,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		else
>  			o->pl = &pl;
>  		free(sparse);
> +		free_pattern_list = 1;
>  	}
>  
>  	memset(&o->result, 0, sizeof(o->result));
> @@ -1686,9 +1688,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	o->src_index = NULL;
>  
>  done:
> -	trace_performance_leave("unpack_trees");
> -	if (!o->keep_pattern_list)
> +	if (free_pattern_list)
>  		clear_pattern_list(&pl);
> +	trace_performance_leave("unpack_trees");
>  	return ret;
>  
>  return_failed:
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 6d7c7b6c2e0..d3516267f36 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -58,8 +58,7 @@ struct unpack_trees_options {
>  		     quiet,
>  		     exiting_early,
>  		     show_all_errors,
> -		     dry_run,
> -		     keep_pattern_list;
> +		     dry_run;
>  	const char *prefix;
>  	int cache_bottom;
>  	struct dir_struct *dir;
> 

