Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4AAC47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8999E208D6
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="s0im+QDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEAWv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAWv0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 18:51:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3FC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:51:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so489878pjb.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dyGfrTq+I0ValApm2YcjPKHTDyUv1RDSHnOwYcWf9wU=;
        b=s0im+QDYesuNAkoZCXJKp74uAZpiuqJTdb7kUZNeMJjaHPxGykHMq4CRHKZwrYgvla
         LbtdfvLcWIOrQXHRQMtghf4uF+yZTQ/wtGQlOkQE3bsjzWOsahFkS0kZ4L8vEQYhGfAg
         7T/qV2pYFoOb0VJr8a7ePqaZKQSY/nxgq6NhmoSBRZFRRxPDnHto5/VOpi9RWlK7WE2Z
         0cu22RJ4fYMVwXLfrVgAFRxep6wAwFa2yNR/oGeBWDdAy9hnBVtC77inMPk1NBCUSCN8
         PTkwRB2ec+ewUf578vbNo6TVf2fmrdVHREPVMitUPuZfzdPwgowtGZtLLoTyyLMXGREq
         Z24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyGfrTq+I0ValApm2YcjPKHTDyUv1RDSHnOwYcWf9wU=;
        b=tWK7CTC5CLWy8y6ub1LXsmvwNHAIpPRPJAttXS7ceoDHahdjxSxPoHSSQBkpg8E6Nu
         pIi4toBkJjZQiIYrTB45EfmkSe27XYUEkdqHzSffmLuQiQ6A+KVgSnxM6VP9U0eT3PnO
         zzd0LBla8Jl/bWdXoxHWP8w2zP5Pc4pQ1/audD9Y4bK9VjyZKxAU64QVjVIkrGjvgBiA
         66gWEsXcr8QyVIkNxzF84ofwOCPiVL13/JUqHQlrRK6P9+AIGJ3hRCUrER+jNSnkeGnZ
         J/VAKcxJa43ID1qn5UcURQNusxKpd+XOBYq/OHsHhy3eRTzTt3a7XFcjOx4nUz4ah6SP
         V5Aw==
X-Gm-Message-State: AGi0PubUzRt9E/E1CruIqm8IuLxw9Ukg9OaBkKmRRKP+/iQ4LVbk5vCO
        yo6Q/7MyOXYpEyXMEciRwZc00IwdflY7UDVU
X-Google-Smtp-Source: APiQypK2DzgNcHxmBmT7jeTDZbKikZE3+8eK39EzQmcV4RK7p+b1+rjumHlRiyWSuZC7gbj8RGgHiA==
X-Received: by 2002:a17:90a:7d16:: with SMTP id g22mr2218902pjl.179.1588373485751;
        Fri, 01 May 2020 15:51:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id cv21sm589344pjb.23.2020.05.01.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:51:25 -0700 (PDT)
Date:   Fri, 1 May 2020 16:51:23 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/12] test-bloom: fix usage typo
Message-ID: <20200501225123.GJ41612@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <572d0508fe0364119d83c08e01a66153810958e9.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <572d0508fe0364119d83c08e01a66153810958e9.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:19PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/helper/test-bloom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index 77eb27adac7..00c1d44a561 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -44,7 +44,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
>  }
>
>  static const char *bloom_usage = "\n"
> -"  test-tool bloom get_murmer3 <string>\n"
> +"  test-tool bloom get_murmur3 <string>\n"

I stared at this change for _far_ longer than I'm willing to admit
trying to find the difference between these lines. Looks good, though.

>  "  test-tool bloom generate_filter <string> [<string>...]\n"
>  "  test-tool get_filter_for_commit <commit-hex>\n";
>
> --
> gitgitgadget

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
