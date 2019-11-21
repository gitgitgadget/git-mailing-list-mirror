Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B462DC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C4B206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di19Ot/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKUXSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:18:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46643 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXSW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:18:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so2508298pfc.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iM+h+scjaHMFasITgtbS7TTnWz8lg+WTLkZJFNmCUN8=;
        b=Di19Ot/YDzWIxigOZKVGm6okfPCJxVPmFVF7kv5b5ONh28qSKc+exL+v5+/x23Frlw
         Vtzfx8dbfFdvIiqE6tGkGdfK6mvlqM2ZLKB74av3Vn3kdJ9X8qLq2ZC9QzwgSUdCHF+y
         t+e4E+HFk/yo47Kv1pSW0fDj99USELWG/vG4TO/+xwhDAO1dqXrCwJcFwIAXUIOoWnG5
         o2TA3+ijvyKzyFdAtg9vAnjJOHf6oW6bHc8lkHa990XnKqb3i9axuyjm7sUQaRPvVzgv
         UaQ6c0LWl9ujBEUFCv01karkroud0C7a8pxBXrhFVCOF/tL+7N4V9HbwTRPrKtACVTDD
         mXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iM+h+scjaHMFasITgtbS7TTnWz8lg+WTLkZJFNmCUN8=;
        b=F4n0AFes4prfYCOIKWad/Al/gqDjaZ9VY1uvBtWPtJxFCdZIarbseVRvWmlFu8vA9/
         NKyKI3jZABToxcXU1547kK1s7gtJC8o1zyz5gCYblrRCMzlzMXmEiO5l/R4ieQaDauOr
         FOyLaj19AiM9qI+MphM0C2hMBMxpavitDkQ+6/XSX1WZTPIvx/h7HaEu1mT6/8SAZFqe
         G0DjNWZNerksPszIHtKlaAjZdqTIh85P93yTB2MbSfPqIS4UvgcwgeRQEQaoFZ9QwNEb
         xDLt73Cnnvi8AX9CW2KMTtuZ1hqnD4p4nwcssC1C6cXG4k8+wBvTDsGpfdg23XBKQB1X
         8rYg==
X-Gm-Message-State: APjAAAUSRr6u9Ol016lkWpe/Ts9SKWk9DiaZQ+sVTZSiEc+SKssiNRFg
        XKfbxnulA9mSivLLAI7Td9w=
X-Google-Smtp-Source: APXvYqwmPPCcmdyKmNB4S3cSD/RsY23HdvIQVpKOHzSASHZmD9/iwf1xMccDxutsCtEyBkE49jaryQ==
X-Received: by 2002:a62:8645:: with SMTP id x66mr14099431pfd.158.1574378301662;
        Thu, 21 Nov 2019 15:18:21 -0800 (PST)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id z2sm4066256pgo.13.2019.11.21.15.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:18:20 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:18:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] fsmonitor: disable in a bare repo
Message-ID: <20191121231818.GA22688@generichostname>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <9bf5a803e6d44ce1ff03225e57933c97c8841327.1574374826.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf5a803e6d44ce1ff03225e57933c97c8841327.1574374826.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, Nov 21, 2019 at 10:20:16PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> t0003-attributes.sh

Patches 1 and 2 have this line in the commit message. I assume it's a
typo?

Also, for the patches with empty commit message bodies, it would be nice
if they were filled in with detail for _why_ the change is being made.
For example, in this patch, a future reader might wonder why having
fsmonitor enabled in a bare repo causes problems.

Thanks,

Denton

> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  config.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 3900e4947b..f6d4e2fae3 100644
> --- a/config.c
> +++ b/config.c
> @@ -2339,6 +2339,11 @@ int git_config_get_max_percent_split_change(void)
>  
>  int git_config_get_fsmonitor(void)
>  {
> +	if (!the_repository->worktree) {
> +		core_fsmonitor = 0;
> +		return 0;
> +	}
> +
>  	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
>  		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
>  
> -- 
> gitgitgadget
> 
