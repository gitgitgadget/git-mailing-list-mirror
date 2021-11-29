Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5868C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 16:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbhK2QLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 11:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhK2QJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 11:09:32 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E5C0423B3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:10:40 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so4198626otu.10
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vvXtw0ZBr+ijw4n55ze30/q70h99ZvDv8NhiT36HtOc=;
        b=bqYsEyLlx2AXJCGEaEXuWVTdVWMWvoLeARbbHw/sRJ9oPLHXpg4cBfAscNTz8KoiUz
         /KVUBgHO1z22RG/yB305GF8/lHrbARvLpOEO2N+5AkDoqCFAbmwB/hxk8DWZuq1lFSqA
         CIgQUQ2oRXex2k07NbwkYJSJ9+v/T14NklwEVh3/3WAVIgtUYd7Omvl6Vq+x+c8QkB/E
         f3mIEFYr7/62N1+gR+dFlEdmh8iy14NHDcDwWRM1NYaiearvhi63Q7ZZHcBM4FpBFH+d
         V3SO87YhKgS/HMlGLYDaUlwgk8VSMQ9omIR7DowPPjFxDDd+ZcaGVbZlesFTHZHcGb62
         vcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vvXtw0ZBr+ijw4n55ze30/q70h99ZvDv8NhiT36HtOc=;
        b=MhmahwJ84FAoQC5GIJI5Idp5LIAm7tjBnP7ZYACh7UPZek/6ys8aPC1J5M+9iwUpTq
         TSi51AkAr681jXl5K0bnDCDUFB02MBW9WGPSkCVWZmP0kJUpAiColBLEseTsfvM3uYpl
         BSmPI5igpN6N3x5CXpv9t903oTUerd55Fi7nG+ulOUNgDSzELcVAp0j0GoPBw61KcwYp
         XV8r8b8r9iVHa1bvUtUA7CS3XtQRulAxOEoZaMNVjzPcQHRcJ+TDGg4yrSFy0rtNVDlp
         9FvHI4V+n9+ABMq0UefWgIg6HYvgkqGftapv+pdayS/mx3PPVemo5T1XLD/wHmIJNXtB
         ZM8A==
X-Gm-Message-State: AOAM532cfPCdKFfIz0dZYtf2CGEb2JoWjkxmXEsWA+kJoTp9+4oiwmdX
        7gnijlVPjKjwv9A8uoafFJg=
X-Google-Smtp-Source: ABdhPJwt/+TSlbvkoYcq2rGRZyT+ecIjimhkUj0KomqK/XhYT4IhpgN4wDiNsDMmL15Hz0uCV251xA==
X-Received: by 2002:a9d:12b4:: with SMTP id g49mr45124634otg.232.1638195036248;
        Mon, 29 Nov 2021 06:10:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id k12sm2664117ots.77.2021.11.29.06.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 06:10:35 -0800 (PST)
Message-ID: <ac7e7241-d852-f0e7-d9c1-053adb242fee@gmail.com>
Date:   Mon, 29 Nov 2021 09:10:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/9] unpack-trees: refuse to remove
 startup_info->original_cwd
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

> @@ -36,6 +36,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
>  	/* ERROR_NOT_UPTODATE_DIR */
>  	"Updating '%s' would lose untracked files in it",
>  
> +	/* ERROR_CWD_IN_THE_WAY */
> +	"Refusing to remove '%s' since it is the current working directory.",
> +
>  	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
>  	"Untracked working tree file '%s' would be overwritten by merge.",

Your new message includes a hard stop (".") which is non-standard. I
see that the message after yours has one, but the preceding one does
not. Since the file you are in is not consistent, I would choose to
drop the hard stop here.

Thanks,
-Stolee
