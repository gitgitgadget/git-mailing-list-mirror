Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E12EC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiBXQKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBXQKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:10:17 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09FF19D777
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:09:37 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id fc19so4354011qvb.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m57jzG0Fl6CbO1ljv9FogP1tN+25Ea6iIJZ4COOKWww=;
        b=f/hm7vUoB03wNaHinIzSiN3YANg40ify4f63cNLSKhHUgbm/pOipRIxu8i+Ku/39Wb
         jlWN0SDDicXAnwpyNsTMHZCAVYq3M+/05rq9HnjOBID9l/rA3W/Fhggl8a1wYp+lSF7g
         DbsFpXhCmjeJ5l3wJts2dooupbMkXermMzFqpGVZeKb5pS+hq++ZtLcGfx/w24JQpi02
         dKoaFUixRD0L8trFPfdg6iqhoaqfJiFUTdErtEZRFOIcSCPYehRT7e7rU8sKpPyADQfh
         O8pTr40k7GqZAM5SstakLh7grvU3rnFKzqCfIpeX4PQk6D3/E6z2npdLVDZnQ/iy89RG
         yRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m57jzG0Fl6CbO1ljv9FogP1tN+25Ea6iIJZ4COOKWww=;
        b=sK034MvK8TBJYtxoQyxO447dAflgllilIvZicZp3unUmSi90jqlCbGGnnWvcn+Z2Q3
         Yvsy1frmBADfXqNoL6p+Ndja3kjUPQ0huaX+8L6leWcgALlmyRUFQk+lTQY9C9u31pPd
         Zb7xIYxwKqqKmUdHssNJ2sBpkOHgxuSMt9mQOPsDRPBe0Pis5UK493JIA6Zj53LEjSIp
         jVMbgnoRBopE1OLsdiAEbr/6pi0gMywueNhEkdCwq5IC+lCgAUEdzwz39cE6T84UXj3c
         6Ly6vwEPtuS5MsHwGN1w1gD1XpLCMnW5npVwNs/ncptZdies1nYPDF9k+clFkn3ACnoW
         DLmg==
X-Gm-Message-State: AOAM531cPWunm3Vs2TWVmVo1ElIbpOg8UevaPupXebZhxPHuypXN0Id1
        U4gjyB2dejJRXqVA9pwLEOHsBot9eNlA
X-Google-Smtp-Source: ABdhPJwT73LNIMxhcOhDcZBxXMF7YLivMBWbnAFlHAxTxT7FWzjVnMi4z810Hyeq8PnXbGjKKBU3jg==
X-Received: by 2002:a05:6214:1c4a:b0:432:ab02:3864 with SMTP id if10-20020a0562141c4a00b00432ab023864mr1676368qvb.48.1645718954314;
        Thu, 24 Feb 2022 08:09:14 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y188-20020a3764c5000000b00609d2c739a6sm7528qkb.49.2022.02.24.08.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:09:14 -0800 (PST)
Message-ID: <c0d69427-aee1-7341-5b5f-1fe44ee0542d@github.com>
Date:   Thu, 24 Feb 2022 11:09:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 19/23] fsm-health-win32: force shutdown daemon if worktree
 root moves
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <023fcd6e2b1163ab3d23b0d5933c14586d814ce0.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <023fcd6e2b1163ab3d23b0d5933c14586d814ce0.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
> index 3c3453369cd..2526ad9194f 100644
> --- a/compat/fsmonitor/fsm-health-win32.c
> +++ b/compat/fsmonitor/fsm-health-win32.c
> @@ -14,7 +14,10 @@ enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };
>  typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
>  			  enum interval_fn_ctx ctx);
>  
> +static interval_fn has_worktree_moved;
> +
>  static interval_fn *table[] = {
> +	has_worktree_moved,
>  	NULL, /* must be last */
>  };

Looking at this now, I think table[] should be defined immediately
before fsm_health__loop() so it is easier to see how they interact.
It also avoids this static declaration of the function before its
implementation.

Or, is there a reason it is so high up in the file?

Thanks,
-Stolee

