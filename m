Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E92BC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 23:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF16164FE4
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCIXGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCIXGY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 18:06:24 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99CC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 15:06:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x135so12421206oia.9
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 15:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48yTimAk0UKQP4/j1P8n384e+eKbeA6m8eHFvZvHmhk=;
        b=UtTQV166CXGHO8I8H5RcZVmMHrMpZrl7W5gt5UW8ntKmY2WL3Tg5YuCl+lqh6aOumM
         WRJUu24FF3DjKp9ds1EFeOi4zcK9xkPMZmgwHI451AqeEQZcMlWSjK8n5znjr7HXbOHz
         xJEEECf+8s/+Gqj/JPTAUtcqjvzf5MwuHoVG6Ba3/hFCLq/Nauf9MrOZFzrd1HUDevKl
         6M0tkVTWDZ6taa2WYtywO0iCz5wz10AVplTHMUAdKrHVI0jn4Nn7Y+kDKxujF17oUuQr
         YkSWYmBObngYz1sI8kVyxECRrQY29VyJe3pyjBbS7PJWzqcj5fAtQnps3paJ3IXFZJ0D
         0hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48yTimAk0UKQP4/j1P8n384e+eKbeA6m8eHFvZvHmhk=;
        b=psAfinIRhg3rtREOH1+9C5cqJ2fw0xr+eMuMisxshxrE2RJOI+v4YRcS+TnlbPUDCc
         1SFF9XZMYMSaZCZTNhYXgHRkJTDX3kF27J0K0HzlscLdlAjL+jfR71i4+I+h6POrbz2L
         mE2AtMJXC/pdtBIS+aaSIckhAW+GrQ/nzr4qZdVAlUdiN78VYxwe9f2VJ/nk82gIZ/dN
         cIqdjXPfBqt/DIQRWmYobmkaS30YnjXP0uxZBrw4omnxOvVeKsXTrK0u4vbzg/mcbIvT
         rFPncFrTVXyYDG1xORJBIbZy6OGxqRG5ZNI9vLPTCFKpaw0O65s6la+1fqHtPngClz/f
         vOtQ==
X-Gm-Message-State: AOAM533tcF2qiH/lVKff2QYyVXWe/aGUsoQrKsfyhc58VjISRK9DApok
        ubsXSI7Scc7zm6VYH2WE48bw8bTfwhi50w==
X-Google-Smtp-Source: ABdhPJzdX1wb1EHaAy8+ydIvV2GE53D0IP64b3xZmWpDHKtFLLDkAsLCdr8bQQRDn0yVyNcsA7J3Pg==
X-Received: by 2002:a05:6808:148f:: with SMTP id e15mr384961oiw.120.1615331183460;
        Tue, 09 Mar 2021 15:06:23 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:ddb1:296a:2c5d:556a? ([2600:1700:e72:80a0:ddb1:296a:2c5d:556a])
        by smtp.gmail.com with ESMTPSA id i21sm3762986otj.33.2021.03.09.15.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 15:06:23 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/8] merge-ort: introduce wrappers for alternate tree
 traversal
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
 <6497050c00126bdeff6880e5a2a52cd7b8457513.1615248599.git.gitgitgadget@gmail.com>
Message-ID: <6bc2af18-dd16-5e41-1f5b-31ab73d7b9d3@gmail.com>
Date:   Tue, 9 Mar 2021 18:06:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6497050c00126bdeff6880e5a2a52cd7b8457513.1615248599.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Add traverse_trees_wrapper() and traverse_trees_wrapper_callback()
> functions.  The former runs traverse_trees() with info->fn set to
> traverse_trees_wrapper_callback, in order to simply save all the entries
> without processing or recursing into any of them.  This step allows
> extra computation to be done (e.g. checking some condition across all
> files) that can be used later.  Then, after that is completed, it
> iterates over all the saved entries and calls the original info->fn
> callback with the saved data.
> 
> Currently, this does nothing more than marginally slowing down the tree
> traversal since we do not take advantage of the opportunity to compute
> anything special in traverse_trees_wrapper_callback(), and thus the real
> callback will be called identically as it would have been without this
> extra wrapper.  However, a subsequent commit will add some special
> computation of some values that the real callback will be able to use.

I'm glad that you use the normal callback in the appropriate case.

It took me a couple reads to understand this last sentence, but I think
I'm with you now.

> +	info->traverse_path = renames->callback_data_traverse_path;
> +	info->fn = old_fn;
> +	for (i = old_offset; i < renames->callback_data_nr; ++i) {
> +		info->fn(n,
> +			 renames->callback_data[i].mask,
> +			 renames->callback_data[i].dirmask,
> +			 renames->callback_data[i].names,
> +			 info);
> +

nit: extraneous newline.

Thanks,
-Stolee
