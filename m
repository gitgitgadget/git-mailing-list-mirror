Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D72C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34662650BB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhCIWWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIWVl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:21:41 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C80C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:21:41 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id p24so537793ota.11
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4yeMUAf81XAi3FsC0E6elWRip3E0XViovfhvw48TTmc=;
        b=RUp8BaxPUBO6Inr3sbLSfE0owpNmTLoRwb60vBO9Gy2+0A9P8nuo3xE1uwcFYjayoc
         RcMMyFGTlE6EFGJ8zAPXUHQBwzg0HIDZe/WOK+zOcpMZJ/EEYMotMb+QqbP6rPfJNVB5
         ayoS6OMktSoqb5Mvq0/kkTIznqI3GtqEHmfJ2Bb3QcH+GCKbrCYtOuGx2sLOF9lJoYbF
         IlQyte0NqCx6uO+peJqagat80aH9mxszVBW9wroTK1meIfbc6Ywzs1hcAHodHF6fIZny
         ZieehlFGA3WoQKFclVVHj1x11j1ytilyonZSjj/Ci9xSrjLh//z2Ib4ZH5pXqO6y9RZ1
         4guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4yeMUAf81XAi3FsC0E6elWRip3E0XViovfhvw48TTmc=;
        b=JjKmXM80px0RcGG//L0WN3k58XdNPXB1trzzj0v3XmFsqAvhQ7cr19KHCGhdVcwQk6
         ZoMfqQXmJUZ5rbk8+LJ/0EdEkin3Wlh9ojqH1+NcQadU+nyT1xnfHyukTxpgwfSk+pAG
         rx4a75QhBOBCrJomj2LRitxWHhZ7kt32iww0aqSTtcij+5YNxQbUZ+kDUOMlj8J71gJh
         lw84TYJXJ6fAd0BgIyTJrA06cBq4xclxHV8YgSGovzcx/JxxJFXMIb1OuLD8dH1ArZi9
         Ls+719Xx66rvOA/VDfEZchLPzHQj+l/FJ9smS9a7oa+YKqyl76B+8T1D2EiQ1JO56EbG
         +SmQ==
X-Gm-Message-State: AOAM532ppsLvFLQTIJ+7a8Ptcf6oFxQoTWDpUZ61ksguGUNs6d8oUeNF
        JZ9BENlneytB36Q+c+LGTF4=
X-Google-Smtp-Source: ABdhPJyH/uTuO2f+OfPicmd7kUUzBU68a8vd3bdPL2vk5Xy42gTYozftGXRl1zzg4RCdny4gwL7BEg==
X-Received: by 2002:a05:6830:232f:: with SMTP id q15mr259512otg.165.1615328500481;
        Tue, 09 Mar 2021 14:21:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id v2sm3151051ota.59.2021.03.09.14.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:21:39 -0800 (PST)
Subject: Re: [PATCH v2 1/8] diffcore-rename: enable filtering possible rename
 sources
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
 <dab8e3c6aee5a852ad46c569c0be729d64310ad9.1615248599.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c646e320-566b-3b53-63d8-a97c6d17c5bd@gmail.com>
Date:   Tue, 9 Mar 2021 17:21:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <dab8e3c6aee5a852ad46c569c0be729d64310ad9.1615248599.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:> @@ -1127,9 +1137,10 @@ void diffcore_rename_extended(struct diff_options *options,
>  		/*
>  		 * Cull sources:
>  		 *   - remove ones corresponding to exact renames
> +		 *   - remove ones not found in relevant_sources
>  		 */
>  		trace2_region_enter("diff", "cull after exact", options->repo);
> -		remove_unneeded_paths_from_src(want_copies);
> +		remove_unneeded_paths_from_src(want_copies, relevant_sources);
>  		trace2_region_leave("diff", "cull after exact", options->repo);

In this case, we are checking for copies. Perhaps there is a reason
why we want to include relevant_sources in that case, so I'll look
for it later.

>  	} else {
>  		/* Determine minimum score to match basenames */
> @@ -1148,7 +1159,7 @@ void diffcore_rename_extended(struct diff_options *options,
>  		 *   - remove ones involved in renames (found via exact match)
>  		 */
>  		trace2_region_enter("diff", "cull after exact", options->repo);
> -		remove_unneeded_paths_from_src(want_copies);
> +		remove_unneeded_paths_from_src(want_copies, NULL);
>  		trace2_region_leave("diff", "cull after exact", options->repo);
>  
>  		/* Preparation for basename-driven matching. */
> @@ -1167,9 +1178,10 @@ void diffcore_rename_extended(struct diff_options *options,
>  		/*
>  		 * Cull sources, again:
>  		 *   - remove ones involved in renames (found via basenames)
> +		 *   - remove ones not found in relevant_sources
>  		 */
>  		trace2_region_enter("diff", "cull basename", options->repo);
> -		remove_unneeded_paths_from_src(want_copies);
> +		remove_unneeded_paths_from_src(want_copies, relevant_sources);
>  		trace2_region_leave("diff", "cull basename", options->repo);

This seems backwards from your cover letter. You are using the exact renames
_and_ basename matches to remove the unneeded paths. Why are we not stripping
out the relevant_sources in the call further up, before we call
find_basename_matches()?

Thanks,
-Stolee
