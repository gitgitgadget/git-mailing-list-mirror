Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10FC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BAC64E41
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBPSgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhBPSf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:35:59 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65EDC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:35:19 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d3so7743058qtr.10
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T8AtufgCao6VsR0jHbydV+vy0aQf/kzxnje7+HuUX6U=;
        b=VZJp8PfAa4UZ0rz9UmpZJZvCkhdr/Rob0Jo5Mc4nocn3L4arZCgKWohkplJ09CwNVe
         iGRsXN6LZrR23RioJ8Wgufp5crp2qlNoUksRLrBMOewURdTYkP6jNBcjgvVah/+nG+VY
         VRWJvmTtYgFVh4sVvMxkl+hqFQUzlssWQBeKpLeYvGJt0BqxbWHY9V3tizSzspZh/SAv
         PJdNYDj5tuHLeOSRNI2QMNyTchlA9CTl38djAuvfBtWQzFVw3osTjXzUOFLzRa+tS+c8
         9GHCInzYAOio0/8P1l3rOy6XJJaa/N7uwlS48QsnIK88Wxf18nNRHV7a/TJg2JsaJ770
         BepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T8AtufgCao6VsR0jHbydV+vy0aQf/kzxnje7+HuUX6U=;
        b=Uby6qovsmI2rILv+i/GcAdKNThFoQqnmgQt9dWLLTnKMIy+BxCx4nHdfNs26GckCDA
         JCW0IiFesb96aL7uBQActJoTHId+EpTv7vGC68lPErzRhpojrBB2jxIdTzyibFxkd6Dy
         0jWtO10VaniWX94+E0XMkw9wYjJ1teG4sTFdMz3O+eJPf2eeK84X1QAu+lp5kqU3nvZo
         9giAhAn+eW65PmupZZoMIOqWQisY60C6yYNlXkqII1COEJq+b3Nslco83Iot0pRsWvgt
         pnwqVDdI36jOUnjJEA7la7ZjeCh2m/wIHlGQDCPw7IGD+wR/YFltfT/lCqa5+5lVzG72
         NipA==
X-Gm-Message-State: AOAM533Xfwc+pEMOycfb/e67qrlkpv+B4FaqBpLKswCSpUByQMqTePKn
        SZbSkOKct6eOV/3ZUoPgl/k=
X-Google-Smtp-Source: ABdhPJw6ZL9fDIO4d4dlkvkG2N4c3hEc/uz/TgFSjNGDsVJz9UWrOy2z9IkFemuPRiXAq/LI9r+OZg==
X-Received: by 2002:ac8:6715:: with SMTP id e21mr20596567qtp.64.1613500517743;
        Tue, 16 Feb 2021 10:35:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id c126sm14902158qkg.16.2021.02.16.10.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 10:35:17 -0800 (PST)
Message-ID: <ce29b876-a5dd-76e9-bf79-5b917249b508@gmail.com>
Date:   Tue, 16 Feb 2021 13:35:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 0/1] blame: remove unnecessary use of get_commit_info()
Content-Language: en-US
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/2021 11:31 AM, Rafael Silva wrote:
> Running Git PERF suite in linux.git, I've got a subtle performance
> improvement for some runs:
> 
> 	# git.328c109303 - compiled git from commit 328c109303
> 	# git.blame-patched - compiled git from commit 328c109303 + this patch
>         Test                                          git.328c109303    git.blame-patched
>         -------------------------------------------------------------------------------------
>         blame --color-by-age kernel/fork.c            1.96(1.81+0.15)   1.95(1.80+0.14) -0.5%
>         blame --color-by-age kernel/sys.c             1.67(1.53+0.13)   1.66(1.52+0.14) -0.6%
>         blame --color-by-age mm/slab.c                2.16(2.00+0.16)   2.15(1.99+0.15) -0.5%
>         blame --color-by-age lib/packing.c            0.20(0.14+0.05)   0.20(0.14+0.05) +0.0%
>         blame --color-by-age drivers/cdrom/cdrom.c    1.62(1.46+0.15)   1.62(1.46+0.15) +0.0%
>         blame --color-by-age crypto/crypto_engine.c   0.37(0.29+0.06)   0.36(0.28+0.06) -2.7%
>         blame --color-by-age net/ipv4/ip_forward.c    1.49(1.35+0.13)   1.48(1.34+0.13) -0.7%

Have you updated the commit-graph with changed-path Bloom filters in
your copy of linux.git before running the perf tests? You might get
smaller numbers overall (both sides) but make the difference for this
patch be more pronounced:

	git commit-graph write --reachable --changed-paths

> To dig a little deeper, I enabled the Git's trace2 API to record every
> call to the determine_line_heat() function:
> 
>         ...
> +       trace2_region_enter("blame", "determine_line_heat", the_repository);
>         determine_line_heat(ent, &default_color);
> +       trace2_region_enter("blame", "determine_line_heat", the_repository);
>         ...
> 
> Then, running `blame` for "kernel/fork.c` and _summing_ all the execution
> time for every call (around 1.3k calls) resulted in 2.6x faster execution
> (best out 3):
> 
> 	git built from 328c109303 (The eighth batch, 2021-02-12) = 42ms
> 	git built from 328c109303 + this patch                   = 16ms

This is a good way to demonstrate the change. Definitely worthwhile for
demonstrating the value of the patch. I'll second Taylor's request that
this performance data goes in the commit message so we can see the details
in the future.

Thanks,
-Stolee
