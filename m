Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3760C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B96321775
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DGZPHXCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEAXqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEAXqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 19:46:21 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EAC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 16:46:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so4177021plp.6
        for <git@vger.kernel.org>; Fri, 01 May 2020 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V6VkPJ6JAmXltz6vOqLYctzHkTZcdht6TWc/6nXH9iI=;
        b=DGZPHXCHrqhU20TF2mjIFVqGa5HGDhw9EhvY7rmMu2LcjjyyBNyJogr7efUUV/+/o5
         DuJfwZ+0XLWx8XGr9Tw+ZseNK5AhQVd7aSWClFopgOeyqjhpxBbwnk0gEt0a7ZEfPxiL
         qTgLR4zFVo4EOOshWcPx6tWdsK6hzfIvAPctRhWcszCndPIWg8QiEyACt2Lsvbb3h0vx
         loDk7ANUPfMiB3Xj2MTQGkA2t7NJzWNoXky2BTXvPBcPq5lBwbr7l/ywYEKB/r7p6zoE
         eI7DVZFwlHEzlRKY/InhNDblU3FLi0W9NEK0/2gypxLPR71bl3amAWoe91zuGCpbQI6V
         /F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V6VkPJ6JAmXltz6vOqLYctzHkTZcdht6TWc/6nXH9iI=;
        b=WbBoT7vMYF0ixzV6eWps2mjxyXoV511C70nUgkRSPOhCqaKdCCOIE0q+kyv2mMztsi
         xJgl+qnwlqRisHviFedj/ZtAHryYD4LbZf/3+vQEff5puWO8kgOilWzjOaohwsvOj9qP
         WDRv9EjJrnoCPS03tk0XL3tMeC+VL+bZwSs9Vq8Gjf7q6y/siPGVUsrcUitmSliS6hE2
         H4jn/CjcgZteJgDhOU7sX766ijdkeVz9CCXral5uJEb4AMSq4OseKhMk4GKZQE7l/bbr
         25FMsft1InusuhTnCLShy1yGkkp/SjHcQHvSWYidCoFnxpeo/XUHd1Z1b507j/gTELfV
         vhvw==
X-Gm-Message-State: AGi0PuaGG95rMetysHnFekFXTgc7fYFUIFbqebcXpS+UcL8PmudI6X8S
        IWa+op9Tty35XrlPq+KqziJxyQ==
X-Google-Smtp-Source: APiQypKF2XPGWU9btCWkcpS460B/hjdGM0TmuZtashCwNSrcBEe6DDZ4AeAItlmamFycubjMMc7m+w==
X-Received: by 2002:a17:90a:2023:: with SMTP id n32mr2538276pjc.150.1588376780449;
        Fri, 01 May 2020 16:46:20 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t80sm3237386pfc.23.2020.05.01.16.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:46:19 -0700 (PDT)
Date:   Fri, 1 May 2020 17:46:18 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 08/12] line-log: remove unused fields from 'struct
 line_log_data'
Message-ID: <20200501234618.GE46422@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <1f326612da05dfa74ebaaee6a852d5ef92a4ed29.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f326612da05dfa74ebaaee6a852d5ef92a4ed29.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:25PM +0000, SZEDER Gábor via GitGitGadget wrote:
> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>
> Remove the unused fields 'status', 'arg_alloc', 'arg_nr' and 'args'
> from 'struct line_log_data'.  They were already part of the struct
> when it was introduced in commit 12da1d1f6 (Implement line-history
> search (git log -L), 2013-03-28), but as far as I can tell none of
> them have ever been actually used.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  line-log.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/line-log.h b/line-log.h
> index 8ee7a2bd4a1..882c5055bb8 100644
> --- a/line-log.h
> +++ b/line-log.h
> @@ -46,10 +46,7 @@ void sort_and_merge_range_set(struct range_set *);
>  struct line_log_data {
>  	struct line_log_data *next;
>  	char *path;
> -	char status;
>  	struct range_set ranges;
> -	int arg_alloc, arg_nr;
> -	const char **args;
>  	struct diff_filepair *pair;
>  	struct diff_ranges diff;
>  };
> --
> gitgitgadget

Very sensible.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
