Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F99C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7307764F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhBCLpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhBCLpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 06:45:31 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F5C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 03:44:51 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m7so1454649oiw.12
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 03:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=plTq1Ysdh7ut6mfkTtQz9Cm+ozex6I6iZ7+NQ3+BZV8=;
        b=kEI1UEViKBvk0au604fnLUvvyn/LkpVDVmvUzfd9UWQ4IzqpIT4YWzBx4RUcG/BjDu
         QgW4b59vGLI/ksUZG+bO50B6nsQYL2ZSt5Zp37UtJb6r/I6m8EMp/NygNjllnSADB5TR
         2Tgt8yadYcsDXN+tO8gHamnKnG8J1mmzinoX4G4DFs5kOMQX6CcU4Kz3F1B3FCQzkjxI
         5B0j2HUm3c/Aa+rUtq5b5Dle49YnU0c4UWujdA7Fmt5/m5ZUk8dBwZDtEXbt6ZZdqCX1
         kC+hqpvz4NzmORK4XK214T5dYw5geC4eRUSeOZqhfx4ByYzSyiITL+KqutQR50XeX8V7
         ZZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=plTq1Ysdh7ut6mfkTtQz9Cm+ozex6I6iZ7+NQ3+BZV8=;
        b=j4yRmeYE0qWB4vMgX40fp22yl42sXgzTETtT7RE/XIbt0AAgqASXiaauagFFjp/gb+
         ar4MUJim3AZWM24+xh0Bj1IqcoheLvUMyq25DCS8yO6FOspia3hBSE44K9IswLdgo2qS
         XaeglVMEATAvndweVvEt6TUjeAgjc233WxjasYPJ9XOw//SBD4jb6whVgjqLVsH1ZN2w
         K49aKH4RbHasvEuZPs71gJlJlhTXJxgEAA3MV34pYol8mkWvdr5TDek9LHrzEIqgKGfQ
         XwaKOwX98fc2evaUVP5wuANuhxQc5yp/W7mi0FLKjI5E5nsl6yEql9GWsb1Z7sL8X4DR
         uNhQ==
X-Gm-Message-State: AOAM530/MaBnjwihYT6bVFN05MCvkJVI9DLStMFAdMtMjQweLF+sLb92
        Y7RGS0tDtS7Z+wtyFFEwqmo=
X-Google-Smtp-Source: ABdhPJwWhrbrFaeYSaftlLlnB+M+rVhZ73y5coXekOSi6isyjyeiXjDC8An9L+v5huEyE7nHjrgAjw==
X-Received: by 2002:a05:6808:20f:: with SMTP id l15mr1739089oie.53.1612352691123;
        Wed, 03 Feb 2021 03:44:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:79cd:7444:bf97:c4d4? ([2600:1700:e72:80a0:79cd:7444:bf97:c4d4])
        by smtp.gmail.com with UTF8SMTPSA id j100sm368469otj.66.2021.02.03.03.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:44:50 -0800 (PST)
Message-ID: <515f55bd-90e2-9a7f-0973-501c9351969e@gmail.com>
Date:   Wed, 3 Feb 2021 06:44:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/2] diffcore-rename: no point trying to find a match
 better than exact
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <3e69857f37e12540f7986245b99916b68702217a.1612331345.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <3e69857f37e12540f7986245b99916b68702217a.1612331345.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/3/2021 12:49 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> diffcore_rename() had some code to avoid having destination paths that
> already had an exact rename detected from being re-checked for other
> renames.  Source paths, however, were re-checked because we wanted to
> allow the possibility of detecting copies.  But if copy detection isn't
> turned on, then this merely amounts to attempting to find a
> better-than-exact match, which naturally ends up being an expensive
> no-op.  In particular, copy detection is never turned on by the merge
> machinery.
...
> +	num_sources = rename_src_nr;
> +	if (detect_rename != DIFF_DETECT_COPY)
> +		num_sources -= rename_count;

Ok, delete the renamed files from the sources. Using a new variable
because rename_src_nr is actually a static global to diffcore-rename.c,
describing the number of entries in the rename_src table. This is
scary, but I think your new local is a good way to change the local
logic of this method without adjusting that global.

>  
>  	/* All done? */
> -	if (!num_destinations)
> +	if (!num_destinations || !num_sources)
>  		goto cleanup;

And add an extra quit condition which is very possible to hit.
Is it only hit when every "delete" is actually a rename?

> -	switch (too_many_rename_candidates(num_destinations, rename_src_nr,
> +	switch (too_many_rename_candidates(num_destinations, num_sources,
>  					   options)) {

This is all about checking if we need to skip inexact renames. Makes
sense to use the new number.
  
> +			if (one->rename_used &&
> +			    detect_rename != DIFF_DETECT_COPY)
> +				continue;
> +

Have we "consumed" this input? Skip over it. Good. And this is inside
a double-loop:

	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
		...
		for (j = 0; j < rename_src_nr; j++) {

Keeping rename_src_nr in the inner loop makes sense, but this new
'continue;' gives most of the speedup, I imagine.

This is a nice speedup for such a simple optimization.

Thanks,
-Stolee
