Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED79DC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 00:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C189B61179
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 00:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbhHFAyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbhHFAyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 20:54:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A8C0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 17:54:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so15994806pji.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=po6o4IPVvevim2Oz6UnTRkWbkxzqolAB8fTpptigJ7U=;
        b=hTMOfS8oVvR702C7oFb8k2wvtofZjgH5h/V7xtTTD5R5IhGPsL4Gkt9VwnML4+iI0o
         NaF66ejAPMpeJuUC43td0gVtKznYRAAs70O2lnybWXI3ub5mpFVXaiDSY+i63Z5qdgRV
         UHnyCguK7jDvHGSPB/nLt2S5I9IXInTWOS4LViJ8FP9F3NXVezsV8gXNgbEQupqr02fR
         W1HuXDAkm3xVUWBt89/Lm1Mnenj8gzU6Xk5JgMtzsjnZeWIcJAjhq44e6dL0URYRvFKl
         p9HYja07IJsNAkVuDsurJdV0ubTcjZRCSK3pyTGHUIm0fvEFJtlHl2P1pJ/KKxRsrilF
         cs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=po6o4IPVvevim2Oz6UnTRkWbkxzqolAB8fTpptigJ7U=;
        b=sScUat6/JpQUYdcHuglYwZokfAbZbIreCE78oNM0xD3KT61ukmiOj4MZgy7rw7C6NE
         mlUYdX+Gz/EmZ/xHEtLC59+/LDRX3S11QJYKpG0n+qRAlgMYOlW1ZUGF1hBEec5ClPXF
         5OsR4iGD/B2KqtZ7K2X6bWqWruA6TVztdSJh+XEs+dOaY6MSuzkaVv2VZFt9bgJVYzNO
         RPw09+oVGXCpSzwRPn0paMJbnwLCezJpC3arSJ9M7goVHQMYHQmhMUK5cqleDQW9633Z
         khINlp7Td+quY8cIYMSHzi4zBx1Yc3AUI9DMyf7ZE2F0pSo3d0V6My9g72582mAs2PSB
         uVhw==
X-Gm-Message-State: AOAM532IDE/5L0PfLuo3FnCstgp5hh9Sf9U86SNOdO2+FMVMBXEbVAOE
        6ACtDnOZDh39x+tLFgsRCac=
X-Google-Smtp-Source: ABdhPJzSq9q16udH1Z65/xnBUTpug+9LzOlyCnGVwUDGsHoE54ffUnR+pJ0LuqWyrEvqcK+G+TfctQ==
X-Received: by 2002:a17:902:6bc8:b029:117:6a8a:f7af with SMTP id m8-20020a1709026bc8b02901176a8af7afmr3552834plt.51.1628211241100;
        Thu, 05 Aug 2021 17:54:01 -0700 (PDT)
Received: from localhost ([2402:800:63ed:3989:4118:d609:c805:f509])
        by smtp.gmail.com with ESMTPSA id 37sm8439015pgt.28.2021.08.05.17.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:54:00 -0700 (PDT)
Date:   Fri, 6 Aug 2021 07:53:58 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH 2/8] submodule--helper: remove repeated code in
 sync_submodule()
Message-ID: <YQyIJpq/r0O7zhb1@danh.dev>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805071917.29500-3-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805071917.29500-3-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-05 12:49:11+0530, Atharva Raykar <raykar.ath@gmail.com> wrote:
> This part of `sync_submodule()` is doing the same thing that
> `compute_submodule_clone_url()` is doing. Let's reuse that helper here.
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> ---
>  builtin/submodule--helper.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4b496bac6..9b676c12f8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
>  	if (sub && sub->url) {
>  		if (starts_with_dot_dot_slash(sub->url) ||
>  		    starts_with_dot_slash(sub->url)) {
> -			char *remote_url, *up_path;
> -			char *remote = get_default_remote();
> -			strbuf_addf(&sb, "remote.%s.url", remote);
> -
> -			if (git_config_get_string(sb.buf, &remote_url))
> -				remote_url = xgetcwd();
> -
> -			up_path = get_up_path(path);
> -			sub_origin_url = relative_url(remote_url, sub->url, up_path);
> -			super_config_url = relative_url(remote_url, sub->url, NULL);
> -
> -			free(remote);
> +			char *up_path = get_up_path(path);
> +			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
> +			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);

While previous patch is definitely a refactoring, this patch add small
overhead to the system, the new code will query (then free())
git_config_get_string() and/or xgetcwd() one more time in the second
compute_submodule_clone_url()

I think the abstraction overhead is not that big, though.

>  			free(up_path);
> -			free(remote_url);
>  		} else {
>  			sub_origin_url = xstrdup(sub->url);
>  			super_config_url = xstrdup(sub->url);
> -- 
> 2.32.0
> 

-- 
Danh
