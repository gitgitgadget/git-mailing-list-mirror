Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885FC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9F7206CC
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQJjgFAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbgDAN5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:57:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37130 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDAN5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 09:57:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id u20so17494507oic.4
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8tVqHIZkfdAfSA8puSsdfHJN+AOL+ignL/lHpnUaI9o=;
        b=QQJjgFAFiD4cH5y2aJOQ7dQpVkMszkfkcCrkzVTrFHh8nG9isjHbpuAuaAGD8kTOZc
         44ZNHQP2GDnhWyCKUsQygbgEQRU9e/lpnMUw6Yt2rsQMceNS/6YkWoUTM4hiGQGwSZxB
         NFKYNE5/wM0JuNxdYb0c1Mo7u0+3PTdppU5cOYfQowQJdWpPhv/4j8WnV8ql6KmTtTZB
         GThWV25scYsJA/wfVZZb8LNPm5XQPNB2CKgWzYfSHUPARJ42Bivz+OKgvjSOKlaIiUDn
         ziZfBqDLEMXejJ0GYQEUvgxt1FGTe56JMUcCOfT6+QZ0Nxf4ImSCicLRcpclfTSuWzSy
         D7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8tVqHIZkfdAfSA8puSsdfHJN+AOL+ignL/lHpnUaI9o=;
        b=LNmLsBiONUBFyHFPu1aUMe6Jp79FW1e5Mbj9TYHb1YunbCGQxWqyFLfsa4hM8GeDSf
         cq4bCFgASxZBqHSPTWv4HfmE6MPDQW/mkSCrDMRn9jk4sEzMzo8l9BRuyqF/5I7IC5ps
         ABWojqda/DlRSttOTOGlM64cDg4Ke4cGlpkjJwTLEFZi6ZKQmN58Xs145lKIynAXhPnm
         EhrW53feePwSUEvo0EC2xO6HzfcB3jLX4kWsWek4/qsO+WsZgUhsaP4S0WL1Lkyk8xzH
         kPlal3D716HVs9FoMuSb5H+mlUeLlRG37dgRndlZllX4fb0M1EeRaJL5Z0O6b6WQndCD
         +VWw==
X-Gm-Message-State: AGi0PuaTGzl7FKKYnekLVQfVs/CG62xcqrHCntlIc7cJZpjjCuzyVmeQ
        GMffOmgOnFXoylWi5quGzF0=
X-Google-Smtp-Source: APiQypLU/SwlK3/JuNg1QHFeYssOztzwbeD6r62or7pNAXtGDZQQPlcs3UViA9pSfklXZKupxKCJSA==
X-Received: by 2002:aca:ac46:: with SMTP id v67mr2883846oie.62.1585749470037;
        Wed, 01 Apr 2020 06:57:50 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b4sm491048oov.18.2020.04.01.06.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 06:57:49 -0700 (PDT)
Subject: Re: [PATCH v5 08/12] dir: replace exponential algorithm with a linear
 one
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
 <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
 <b2caa426790a2cd6a510e5ebf2d182b018f12185.1585714667.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <977213ee-3d5f-150a-2982-e1083557bce3@gmail.com>
Date:   Wed, 1 Apr 2020 09:57:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <b2caa426790a2cd6a510e5ebf2d182b018f12185.1585714667.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 12:17 AM, Elijah Newren via GitGitGadget wrote:
> @@ -1659,7 +1659,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  	const char *dirname, int len, int baselen, int excluded,
>  	const struct pathspec *pathspec)
>  {
> -	int nested_repo = 0;
> +	/*
> +	 * WARNING: From this function, you can return path_recurse or you
> +	 *          can call read_directory_recursive() (or neither), but
> +	 *          you CAN'T DO BOTH.
> +	 */
> +	enum path_treatment state;
> +	int nested_repo = 0, old_ignored_nr, check_only, stop_early;
>  	/* The "len-1" is to strip the final '/' */
>  	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
>  
> @@ -1711,18 +1717,135 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  
>  	/* This is the "show_other_directories" case */
>  
> -	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> +	/*
> +	 * If we have a pathspec which could match something _below_ this
> +	 * directory (e.g. when checking 'subdir/' having a pathspec like
> +	 * 'subdir/some/deep/path/file' or 'subdir/widget-*.c'), then we
> +	 * need to recurse.

I was extremely skeptical about this approach due to leading wildcards
like "*.c" or "sub*/*.h" but found this comment inside math_pathspec_item():

		/*
		 * Here is where we would perform a wildmatch to check if
		 * "name" can be matched as a directory (or a prefix) against
		 * the pathspec.  Since wildmatch doesn't have this capability
		 * at the present we have to punt and say that it is a match,
		 * potentially returning a false positive
		 * The submodules themselves will be able to perform more
		 * accurate matching to determine if the pathspec matches.
		 */
		return MATCHED_RECURSIVELY_LEADING_PATHSPEC;

So it looks like it will return MATCHED_RECURSIVELY_LEADING_PATHSPEC as
expected by this block below:

> +	 */
> +	if (pathspec) {
> +		int ret = do_match_pathspec(istate, pathspec, dirname, len,
> +					    0 /* prefix */, NULL /* seen */,
> +					    DO_MATCH_LEADING_PATHSPEC);
> +		if (ret == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
> +			return path_recurse;
> +	}

I can't say that I fully understand the change to this patch yet, but at
least my initial "THAT CAN'T POSSIBLY WORK!" reaction has been tempered.

Thanks,
-Stolee
