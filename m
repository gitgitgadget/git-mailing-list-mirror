Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E2CC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E145A60E08
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhJVEGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJVEGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 00:06:22 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66216C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:04:05 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id r17so5217584uaf.8
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCXO/xHZfx2QTZDSvhQ207lnal40ct4LgF0B2sr8HyM=;
        b=hi+XhEWb6goD3881HlIS6mlACsQrQDcxDwgvHaj3fRWyMllNURBCzYEMsNBDEROK1Y
         BfGTw8LsrTz8b9JBPtG4fmR191jV2ecPa4Ck/2xJ0D8vK5LI2bwZfZ2KhhkEHlJW1vC7
         ICH9/ZKEEf+dD4SZqc5Z9SYQeqqV8m+fa3nIn78lTCLWA+UYpHs8zHwlR/nYJ+I04QyI
         bXnh1SMhFCFjzvcr+DDPeqN9xxbqOeJS5Y7JUdoAQm38rNqRvBa8IPUZGZI5mzXtRsaV
         EqitbiuZD9DWVu/JrXkKs3pGcFxR+a5A2oBv6HRZngxAFowVr6z+h8qdOJMDw9D96ad9
         Kh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCXO/xHZfx2QTZDSvhQ207lnal40ct4LgF0B2sr8HyM=;
        b=oxrUWqQS3qv/fgm1iGEadRS0UHh5utAEyL2dsxtXiXW8GeNKCNMQ2b0/XcCStw22qa
         ptE37udIPQJGkyuLsMp+18jO8XKc3CsjsuV/pHsL15pJ9VClOoaR4sFMTe6+LnmuSqFt
         w7AAM4/onqFx+eBL3HoHUIarK691KfqEhol9lkbSxe4iSnIyw/2hYhvhAEK8d88kHf1T
         ykK0U43zv9fMxvdJQvabDlgHLBhKNd4lxxURi3UTL1BhkhfKFyQvsl5HMtFe7+rhmI2B
         9NhnRZYq2rbyxaq7lY41XaRBCJ0tmTXutcghlKHLI9kfvG3qLX9LDbTU7AHpAy8G+s33
         X1hA==
X-Gm-Message-State: AOAM530V4foHKjGwq8LptXjwLZOupSCIaaTYqcUbiXkS1E47qlFmfJMj
        vVhx7DHODq1OLkY9f6a6Ulds9KLHdybXUQ==
X-Google-Smtp-Source: ABdhPJzC7AJ1rBftZ0q8uFItng7x+hOfDIWZWwlhRBBSmTxG85xsK+r1lZImZB3t1kV3C2rWufDJOw==
X-Received: by 2002:a05:6102:5114:: with SMTP id bm20mr12177333vsb.6.1634875444140;
        Thu, 21 Oct 2021 21:04:04 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id u75sm4401842vke.29.2021.10.21.21.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:04:03 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, stolee@gmail.com,
        vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH] add|rm|mv: fix bug that prevent the update of non-sparse
Date:   Fri, 22 Oct 2021 01:03:52 -0300
Message-Id: <20211022040352.16773-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br>
References: <80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 11:28 PM Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> diff --git a/dir.c b/dir.c
> index a4306ab874..225487a59c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1516,11 +1517,31 @@ static int path_in_sparse_checkout_1(const char *path,
>  	     !istate->sparse_checkout_patterns->use_cone_patterns))
>  		return 1;
>  
> -	base = strrchr(path, '/');
> -	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
> -					 &dtype,
> -					 istate->sparse_checkout_patterns,
> -					 istate) > 0;
> +	if (istate->sparse_checkout_patterns->use_cone_patterns) {
> +		const char *base = strrchr(path, '/');
> +		return path_matches_pattern_list(path, strlen(path),
> +				base ? base + 1 : path, &dtype,
> +				istate->sparse_checkout_patterns, istate) > 0;
> +	}
> +
> +	for (p = path; ; p++) {
> +		enum pattern_match_result match;
> +
> +		if (*p && *p != '/')
> +			continue;
> +
> +		match  = path_matches_pattern_list(path, p - path,
> +				last_slash ? last_slash + 1 : path, &dtype,
> +				istate->sparse_checkout_patterns, istate);
> +
> +		if (match != UNDECIDED)
> +			ret = match;
> +		if (!*p)
> +			break;
> +		last_slash = p;
> +	}
> +
> +	return ret;
>  }

Of course, after hitting send I realized it would make a lot more sense
to start the pattern matching from the full path and only go backwards
through the parent dirs until we find the first non-UNDECIDED result.
I.e. something like this:

static int path_in_sparse_checkout_1(const char *path,
				     struct index_state *istate,
				     int require_cone_mode)
{
	int dtype = DT_REG;
	enum pattern_match_result ret;
	const char *p, *base;

	/*
	 * We default to accepting a path if there are no patterns or
	 * they are of the wrong type.
	 */
	if (init_sparse_checkout_patterns(istate) ||
	    (require_cone_mode &&
	     !istate->sparse_checkout_patterns->use_cone_patterns))
		return 1;

	if (istate->sparse_checkout_patterns->use_cone_patterns) {
		base = strrchr(path, '/');
		return path_matches_pattern_list(path, strlen(path),
				base ? base + 1 : path, &dtype,
				istate->sparse_checkout_patterns, istate) > 0;
	}

	/*
	 * If the match for the path is UNDECIDED, try to match the parent dir
	 * recursively.
	 */
	for (p = path + strlen(path); p && p > path; p = base) {
		base = memrchr(path, '/', p - path);
		ret = path_matches_pattern_list(path, p - path,
				base ? base + 1 : path, &dtype,
				istate->sparse_checkout_patterns, istate);

		if (ret != UNDECIDED)
			break;
	}

	return ret == UNDECIDED ? NOT_MATCHED : ret;
}

But I will let others comment on the overall idea and/or other
alternatives before sending a possible v2.
