Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A11AC19437
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9E923A7B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgLHUQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbgLHUPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:15:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CAC0617A7
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:13:03 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so13196995pga.7
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GfZ7O6NwMiEoAPWYBlxIIWkBcT+LDl4/ywZeU2cRNCE=;
        b=UAfHw7fF4RCiNhjkku2GQztGxgGPdEMS4/GvEmSdGy8+QADzVEWuOGEaeOwM+Mg9ty
         3PDb4hh9yrlaasvXf0eiq5pnGSgdnzVXtBJsDsBhOcCnIKixwf/5cvNoW2L/7wV+YWCS
         W6WQetNCOjS/fFESOFFt/8TuGkygxbhg1+cqsr5KSRxQ2hE33uI0DbU9Iq+RmdzfQeds
         RiKtWv5CIjWihX7KGRb5EHSN5yCU90hlR3rDWBG0OsO7Ap8RvqefuIjOO3ubmkWCz+hX
         JkwL8Nu97GikumsQQG3ij58s6kko74Ymr22nLKsP2yR1NOOvQ9kCLCT9D6lnGdGcN0Lb
         XvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GfZ7O6NwMiEoAPWYBlxIIWkBcT+LDl4/ywZeU2cRNCE=;
        b=CyCJDBBrkB0j1vKpu2mJDyWzNyWymf1vuKpC9yks9PVyTNKEWEraU1TfflyszGqi+8
         tww4ou39BldhDThb14gQAKnEDICxkr1ZSupmgy27BvC29GaNmnj5GjSC1kgnW6gVyKXx
         lbjAB20ZNTwkEbOF2Xkz6NuFPYidyaQa1BbM2F3sF8IsCRv8rxOz3h1hU6qHiLXY63bp
         /OuYjKg7RKuGCnt+7dqTE/JpktCaTyATMs3j01C+TFthgB2+vUOVPax5tU0ukx8yL1Mk
         9CBY3y8uRQVkFYirJT+Epdmap0ftRfDme+Cj3URsEwscldAp4gLw6V9PliheYEKn9OEv
         DC3A==
X-Gm-Message-State: AOAM530bCjFTPWckfcCO0YNeFugy3AJrDxpalyfJsBQn7sWT/Im88CCA
        BMbhNrTrXEhE9tEgwwTtdPSeSg==
X-Google-Smtp-Source: ABdhPJxTD82M+BjZnqbnlmAJ/ufca2Ot5Mgc0bqc2Zykfw4W9R1Ih4wDxplP1YvOZ47G8AROCvy09g==
X-Received: by 2002:a63:550d:: with SMTP id j13mr24197280pgb.365.1607458382682;
        Tue, 08 Dec 2020 12:13:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id z188sm18943992pfb.121.2020.12.08.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:13:01 -0800 (PST)
Date:   Tue, 8 Dec 2020 12:12:56 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
Message-ID: <20201208201256.GK36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.26 20:41, Rafael Silva wrote:
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d9e68bb2bf..ae5c29b0ff 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -441,4 +441,12 @@ test_expect_success 'register preserves existing strategy' '
>  	test_config maintenance.strategy incremental
>  '
>  
> +test_execpt_success 'fails when running outside of a repository' '
> +	nongit test_must_fail git maintenance run &&
> +	nongit test_must_fail git maintenance stop &&
> +	nongit test_must_fail git maintenance start &&
> +	nongit test_must_fail git maintenance register &&
> +	nongit test_must_fail git maintenance unregister
> +'
> +
>  test_done

Caught a typo here, sending this as a squash patch since it's already in
next:

-- >8 --
Subject: [PATCH] t7900: fix typo: "test_execpt_success"

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t7900-maintenance.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4ca3617173..8c061197a6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -441,7 +441,7 @@ test_expect_success 'register preserves existing strategy' '
 	test_config maintenance.strategy incremental
 '
 
-test_execpt_success 'fails when running outside of a repository' '
+test_expect_success 'fails when running outside of a repository' '
 	nongit test_must_fail git maintenance run &&
 	nongit test_must_fail git maintenance stop &&
 	nongit test_must_fail git maintenance start &&
-- 
2.29.2.576.ga3fc446d84-goog

