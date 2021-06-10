Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D2C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0CC61182
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJJ2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJJ2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:28:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D4C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:26:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m3so514147wms.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RXkhjDJLUpgy/qLS6UiJP0hJGEDdspatee5ZqhaLjBg=;
        b=Ys6VglFI2sktzwD/tJ4F9u+EmPtzxHGVe7tLVhyb4JqA3Jq9yJBr2KoVzFUIlh8oFL
         f6XDWVR9IbQnQkczbOsajwJFFQTos2RvzJZc7JQwdfSO7m8ipopRCmxZwnE35Tjg4qQo
         9gqkm64Wjh9jShZqb3riUNdtSStTvFS3F7RAssaj4HrqpKXN6Yu7y7SQXawT2yqE0ZwV
         f2fulgnZf2itpw1DCYhptzbGlYoPt9OzLCadoJwWHkoQtN3NAv+qZfK1tBrSpSUhtJz9
         AwxsizBfjIjkm507fjC7NLMpQxJibjNhsu2L9KvuZj32Pf8RacIdlf8STeE0juH2W0pB
         dl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RXkhjDJLUpgy/qLS6UiJP0hJGEDdspatee5ZqhaLjBg=;
        b=iDg0S37Qy2O4nI2Wtk18aPzQEcs3g1P+KsJsmPX1tdg0zXxxnmUeD9t5Z9X1tjuuyk
         P6VdDVumXx+C985PNaX4mouHUmgE3VZ0v/+dpz2ovCKdTkOy4Pe96WXTkCzlAmHr5DOT
         lHuuNfBY3/4MAjhv2ta3OtV1+ajHxnwHGKunjVTvWsnykeMTWpK5wjI9c8kquS4BbG/c
         1gDY+xgO0+5GJBq4PIIgJkGalAfkctnQdN7gWmcDppOVKK8bh1MPqtl1q3LDISh+HwEj
         X88Fdd0ZsuIpphzt/GxljUn4nmhk5GqMSpGr9ldYi4wHYVC6Z1Rpzz2NuTvYRdDNaDL0
         e7AQ==
X-Gm-Message-State: AOAM531FdQuans/D0VqhCHpI6R0ircYa8hhQGyDznUog63++XByiHfCe
        mWGdXcww+tEd9sOoMoW3hfTtnZyHyn8=
X-Google-Smtp-Source: ABdhPJzQhPq2+ZV/Y0L4wRmlU9nms9M/32yc+Sjcm8J6ve1OOT9sHjGzMVsSFyQWIrd7LjZxyceSkw==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr3992562wmq.13.1623317192817;
        Thu, 10 Jun 2021 02:26:32 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id x18sm2824402wrw.19.2021.06.10.02.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:26:32 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/7] xdiff: simplify style assignments
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-7-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cc8bbc34-1048-0e7b-c783-33f556843a3f@gmail.com>
Date:   Thu, 10 Jun 2021 10:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-7-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2021 20:28, Felipe Contreras wrote:

I don't find the commit message explains this change very well

> There is little value in checking that git_xmerge_style isn't 0 before
> changing it's default value.

I think the check is actually that git_xmerge_style isn't -1. Why is 
there little value in the check?

> Most of the time it isn't 0 anyway, so just assign the value directly.

Why to the times when it is zero (or -1) not matter?

> Also, add the missing constant for the default value: XDL_MERGE_STYLE_MERGE.
> 
> Additionally this change has the benefit that it gets rid of a Yoda
> condition.
> 
> No functional changes.

I think that is probably correct but it would be helpful if the commit 
message offered a bit more explanation.

Best Wishes

Phillip

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   builtin/merge-file.c | 3 +--
>   ll-merge.c           | 3 +--
>   xdiff-interface.c    | 4 ++--
>   xdiff/xdiff.h        | 1 +
>   4 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index a4097a596f..01951762ec 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -55,8 +55,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>   	if (startup_info->have_repository) {
>   		/* Read the configuration file */
>   		git_config(git_xmerge_config, NULL);
> -		if (0 <= git_xmerge_style)
> -			xmp.style = git_xmerge_style;
> +		xmp.style = git_xmerge_style;
>   	}
>   
>   	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
> diff --git a/ll-merge.c b/ll-merge.c
> index 9a8a2c365c..4ce8d3f9cc 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -124,8 +124,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>   	xmp.level = XDL_MERGE_ZEALOUS;
>   	xmp.favor = opts->variant;
>   	xmp.xpp.flags = opts->xdl_opts;
> -	if (git_xmerge_style >= 0)
> -		xmp.style = git_xmerge_style;
> +	xmp.style = git_xmerge_style;
>   	if (marker_size > 0)
>   		xmp.marker_size = marker_size;
>   	xmp.ancestor = orig_name;
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 64e2c4e301..19a030fbe2 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -299,7 +299,7 @@ int xdiff_compare_lines(const char *l1, long s1,
>   	return xdl_recmatch(l1, s1, l2, s2, flags);
>   }
>   
> -int git_xmerge_style = -1;
> +int git_xmerge_style = XDL_MERGE_STYLE_MERGE;
>   
>   int git_xmerge_config(const char *var, const char *value, void *cb)
>   {
> @@ -309,7 +309,7 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
>   		if (!strcmp(value, "diff3"))
>   			git_xmerge_style = XDL_MERGE_STYLE_DIFF3;
>   		else if (!strcmp(value, "merge"))
> -			git_xmerge_style = 0;
> +			git_xmerge_style = XDL_MERGE_STYLE_MERGE;
>   		/*
>   		 * Please update _git_checkout() in
>   		 * git-completion.bash when you add new merge config
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 45883f5eb3..d24cd9f6ae 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -64,6 +64,7 @@ extern "C" {
>   #define XDL_MERGE_FAVOR_UNION 3
>   
>   /* merge output styles */
> +#define XDL_MERGE_STYLE_MERGE 0
>   #define XDL_MERGE_STYLE_DIFF3 1
>   
>   typedef struct s_mmfile {
> 
