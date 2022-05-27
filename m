Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8DEC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbiE0RDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiE0RDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:03:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D913B8C1
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:03:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so4849150pjf.5
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y7ddhPOlIjFs3NfJoRNjMmf0VqDo7Ddezhq77fdXSNo=;
        b=bSlKaeYQDLiCDfwyvO97G9L/Ku1BKEJeTjNgl2YSOpNXxBQZcdQaJkzLo56QGc051e
         t34/UvYEC2y3TMK1nzBC2JDLD8s28kF0+UhZYyzDiBbVkJIdDEsQfktvYmOTVXvGVQlz
         6jidH5CE9L2Mvr/tgcw4TTHaWXBnjuJFOMLZOcNecw2qh1w49H38VnmW97fAoTTyfOyk
         ONwjfcC0nMsUw0o9AimN0WRjc2owRCuPe7OijtqlZUiTpr2qDtyDEPXK/U3qPmQOTVhH
         EvxpJ5vSShynaXPXEc7N/9noxDE96blxY7fy2d7TEPWJaqmjpyschHxrr9PZb+CZIyt1
         0agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=y7ddhPOlIjFs3NfJoRNjMmf0VqDo7Ddezhq77fdXSNo=;
        b=CdFPIxO3/LeVPKjqCvZX8gx5d3l1g8q3ca4sxAjPkLM5l0y8pLrxiRYydqY6JF2R/m
         UmV1YdkjRb5yIMr96+nk+2I5OL5w5ym1nKQja+G7A0ZSl47KOC5vygj6uEvI5nKQ6dqR
         xuWVnu0mHYHRsYOLNGybj7hIGk82MamydFev1+yHxDk45v2G7UV/WPgmtTjrp1qQJhp2
         zjtPCh89erFTBSqxITpOYsnTLnVKYMGiG596VZ569OxEGiv65tatYR8IUhRKxSn3b+W/
         SmVQsQV6bFpvbRhVCLRoPF/KMtjAGY3xxhLsTBgXhq1pEUvltuEh+iDp2VoY+KB3SPKf
         zJDw==
X-Gm-Message-State: AOAM531VURzFUxwQI4UFf0yQBgh66mdOBVKAge8tRn+8wu7ME1RL/UNk
        cDWDjMYC7YoVQpVpUxOkuFpCVg==
X-Google-Smtp-Source: ABdhPJzHmW3XR9sa1BmoerEml5NDZw8XYVHAnAL2IuEzcOzWLiw4DRwJ2g86Tr6H1RktuGpDJfw+Aw==
X-Received: by 2002:a17:90b:1bcc:b0:1e0:1c94:ebcf with SMTP id oa12-20020a17090b1bcc00b001e01c94ebcfmr9364699pjb.140.1653671017198;
        Fri, 27 May 2022 10:03:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fbc7:30a9:c3f6:e550])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001620960f1dfsm3961879plh.198.2022.05.27.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:03:36 -0700 (PDT)
Date:   Fri, 27 May 2022 10:03:30 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
Message-ID: <YpEEYpANXEnywDvN@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.21 19:14, Ævar Arnfjörð Bjarmason wrote:
> Add a bug() function to use in cases where we'd like to indicate a
> runtime BUG(), but would like to deref the BUG() call because we're

Typo: I assume you meant s/deref/defer/


[snip]

> diff --git a/trace2.c b/trace2.c
> index e01cf77f1a8..d49d5d5a082 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -211,6 +211,12 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
>  
>  	code &= 0xff;
>  
> +	if (bug_called_must_BUG) {
> +		/* BUG_vfl() calls exit(), which calls us again */
> +		bug_called_must_BUG = 0;
> +		BUG("had bug() output above, in addition missed BUG_if_bug() call");
> +	}
> +
>  	if (!trace2_enabled)
>  		return code;

While it does seem that trace2_cmd_exit_fl() is the only reasonable
place to put this cleanup code, perhaps it makes sense to rename this
function and move it out of trace2.c, to more clearly show that it has
multiple responsibilities now?
