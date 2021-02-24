Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A308FC43381
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7057364F09
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhBXPx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhBXPoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 10:44:09 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD5C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:43:22 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d9so2494958ote.12
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JpWWcD+3cWEsJV/QhFO2HQ1yP38pmdyBta9mYxx0kis=;
        b=Q616g/jap82xvLPxZnZHo0eGVlgzZJOQTMTc04RZGm1zHKUVE//ZuvZul57TH/BkJ+
         s2MvPEvmlOgo39WngVBCcOVRZjX5J4EzscJeomwsBm4Gsvc24WKnr2i6/P/aGC3S0HgL
         NqAUSLJwRJWJGQlMWBeqingGSpL8NYOd2MDdPAyvlG4Y9F2IvQjsW9baAQ5IQvG0mj3k
         ff5gWPdWjqpFKBdwrBMSSaQhoWka2bAzYkplOLrqxF7rd+MuaxBu5bRm5FlR8dBXAHvW
         J5q0wGA6zZhPqmu36YQF0bslor4ODlz+RQFdVQXGWKuDpGa1EFopH5EwMTX61oJynahu
         tlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JpWWcD+3cWEsJV/QhFO2HQ1yP38pmdyBta9mYxx0kis=;
        b=hCRKvImQBED5o7PucWCpLMpE591xirGZbNA7uuC5R+WdO77gdNjzsQsj40kOWXY9ZB
         humvuh2ospVN7EQtYBw/qwc77Ds+i581fV+iRkABqglYD+YqEnoMi6IpPXHBC57A2FXi
         PKBu68j6gcRKqVieCKWE04UJhRjmmDpw5d8sHgaDrra8cDw76VTqres0LBFC73IbvwPl
         +zcXzH8BUoM5z3RAwPgkJk3ANcVyp93ofnJJgycRXWdrO6LobpzFt5D0ROrofv/3gJeS
         utOMZZlUcr39x1y+UlRPxXv4n5qakE/KTnh6exlB0wXhKleJ/XF6iCqvcQw0WEzLD+8O
         Pt0w==
X-Gm-Message-State: AOAM533B6XR22jdVjdoZmJCqNFu6Wif+2ihRTrrbk23ycxxZ59x4BXg5
        6Rj4IaHUdUawTKctx/MzzsI=
X-Google-Smtp-Source: ABdhPJxqputhIAaJuq6vAio1zMhJnZtz7cwRvlBx4o0PlyjlaI3w94OBYvSuukL+bOBPVmTQ/Ds/6A==
X-Received: by 2002:a9d:5907:: with SMTP id t7mr24957827oth.105.1614181402022;
        Wed, 24 Feb 2021 07:43:22 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id o3sm449056oou.47.2021.02.24.07.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:43:21 -0800 (PST)
Message-ID: <1c3b2aa7-d56f-00a6-cd19-0810d12540c0@gmail.com>
Date:   Wed, 24 Feb 2021 10:43:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 05/10] diffcore-rename: compute dir_rename_counts in
 stages
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <3a29cf9e526fba0227a7eec92c0c6bd58a7850f0.1614123848.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <3a29cf9e526fba0227a7eec92c0c6bd58a7850f0.1614123848.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 6:44 PM, Elijah Newren via GitGitGadget wrote:
> +	info->setup = 0;
> +	if (!dirs_removed)
> +		return;
>  	info->setup = 1;

This would probably be clearer as

	if (!dirs_removed) {
		info->setup = 0;
		return;
	}
	info->setup = 1;

> -MAYBE_UNUSED

Good cleanup.

> @@ -931,10 +974,17 @@ void diffcore_rename_extended(struct diff_options *options,
>  		remove_unneeded_paths_from_src(want_copies);
>  		trace2_region_leave("diff", "cull after exact", options->repo);
>  
> +		/* Preparation for basename-driven matching. */
> +		trace2_region_enter("diff", "dir rename setup", options->repo);
> +		initialize_dir_rename_info(&info,
> +					   dirs_removed, dir_rename_count);
> +		trace2_region_leave("diff", "dir rename setup", options->repo);
> +

The parts visible in this context are pretty trivial, but this
method _is_ doing a lot of work. Good to mark it with a trace
region so we can identify if/when it is a problem.

Thanks,
-Stolee
