Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430CC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674C56113B
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhDNQkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhDNQkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 12:40:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE81C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:39:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n140so21203150oig.9
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xi8P953eqiSGKWmUGcdj8y7Ng4yCUuRN77AbqTcBzd0=;
        b=g4B5cjSWf4DUu+vDrH+hvmfCn0u2/HHU83MJmODw2FLaonObqmSpsGSMsLS+mHH8tr
         cX4lpRtHAkAk31SnvbyeXUm14lqfPTMmOy2duOlxvfY7Gf62mf0UhBzmafhbvBELZIMY
         blcA9UIcXreia0S/dICAQEQ/iHmaBV1eZi9QKTxivXZedzSiAhAfCxBi1x52XHNPpT6Z
         jaw2P53GBzZmIpndHm3bGJs6JOdBFbDO13sJr7m0/Y3tGxFwHm4IF2emcvt0oh2dPcrl
         gDEcLlUXcIqwc7qP7m6T4XZSB6mi1FWW5A+r24+kmCoC5IoljXmPK36XqWyhP2HUMZbz
         Xc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xi8P953eqiSGKWmUGcdj8y7Ng4yCUuRN77AbqTcBzd0=;
        b=ew4M+gzud+iTF/0g+ZP3Tciiiehgvy3oS7EWw9Pk/EsuJma3Zx5wfZXqp3dHW0aIeA
         2mbdw9efAg881EpfLKqhT1+a6Z1qON1M+O0lCBd1Ga3ApcCKRSYoXWB7c+koSD49leXa
         F3D9YtZKM7IOQCdS7Z34oM8sQxO3CDyUPhZldLPa88UbuP5zpzM8qnIJHZGMiWayHuX8
         WUB/r7sK4ZHR1kPkz+z+e5wuQhz030DovQYvbsDMFtKOtLuK/F9/bbnguXj0D6m8G4zm
         Et+ddKfdCKD0O3UbAPPVe223MZuot13ZqcoXs/Hbycfsjg3VMtJgHTeoZ69vmGLmirh1
         0gZw==
X-Gm-Message-State: AOAM533Yx4q+3WPFc1LOo16XTEJNrr/H+VXq/cEB/9HJPyd1rjrCY2s9
        y+qVMqMtkxI5VxpfvB4xdAcCuysVcb2daA==
X-Google-Smtp-Source: ABdhPJxkpSKOxhFftouR7GN3kPRf07GWUos1nvokrxB3XVXHvGUqNGQ8olM/5BseF82kZGg1vmYMvg==
X-Received: by 2002:a54:468b:: with SMTP id k11mr2951062oic.85.1618418384241;
        Wed, 14 Apr 2021 09:39:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e5b3:d157:1c7e:e794? ([2600:1700:e72:80a0:e5b3:d157:1c7e:e794])
        by smtp.gmail.com with ESMTPSA id q13sm23135ool.7.2021.04.14.09.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 09:39:43 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] t3705: add tests for `git add` in sparse checkouts
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
References: <cover.1617914011.git.matheus.bernardino@usp.br>
 <5d0cdb3718ec0230fe199441b6a4089ce828a3e9.1617914011.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <69e2d520-3caf-a64d-8bb4-c2c9723be9de@gmail.com>
Date:   Wed, 14 Apr 2021 12:39:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <5d0cdb3718ec0230fe199441b6a4089ce828a3e9.1617914011.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2021 4:41 PM, Matheus Tavares wrote:
> We already have a couple tests for `add` with SKIP_WORKTREE entries in
> t7012, but these only cover the most basic scenarios. As we will be
> changing how `add` deals with sparse paths in the subsequent commits,
> let's move these two tests to their own file and add more test cases
> for different `add` options and situations. This also demonstrates two
> options that don't currently respect SKIP_WORKTREE entries: `--chmod`
> and `--renormalize`.

These are good tests. I will adapt these for my sparse-index
series to ensure 'git add' works correctly in that environment.

Thanks,
-Stolee
