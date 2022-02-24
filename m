Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD82C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiBXQLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiBXQLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:11:52 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8C184B4D
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:11:13 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id x3so4359174qvd.8
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EnhaMEGq0QNtR5UfFJlKJ5qHYuHXuLSgfdMmQ+qh5IQ=;
        b=JtI+ibojgjzXBxWFLV/+FKIzwhuKpNC6oJ7Yb0JPctQXhnJBVHJoF2N6Q/Ecco1htt
         XzM+H9ID14CV3ccoaWGI0S0Bwfpg/h1khjKwp2+U2q5uisF//jyNx/R23LeJo1Jzm45K
         dC2+d9IQU0WOLMxvCye5zwIipd7r9b44S5omigJw2LjcaTGFreKJlajR7gyJ3fbovSN3
         cdbmq6vGgrJhtkcN0BfRg3DEtcB2bLfYu7znjwNl11C3K4P2ltJa092xF1T55+Ic5n4y
         vYKz8pYGqGFZMH6KicGxmTq8wmcT5JaDMXyxKMikeE9mTasSkOWvcjGplBAs6zwPXjc+
         zthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EnhaMEGq0QNtR5UfFJlKJ5qHYuHXuLSgfdMmQ+qh5IQ=;
        b=zlFATtMCaj0Qz/YtZ+IJoacRf0+9vyhRo/j7Qfii5xGakC8YMKLZup4a24Qm8fScge
         oCvrD3ME5bMF3wx+rsint5Jds0Ninhuyef35iZch0WEaEl4ENBySgkJLqv5TvTP+ME9F
         uIBuaTKBg8Oa60cQt91evVpa94uMdkaOEr965BpeIIAG290NDn1cfcjCpZetam/S+v3R
         Lz5LD7VbnPm7urCqXw9bGjn0OebUNc/2TXeXUlSwgzLjDW5kEojEyEILQHlKkZINAxlI
         u6qS2alm+N7CMXV42bReF8kyr/uJqb47dakdz9dSl2i3gBMnD+7LsMmmOX+rzLzJONmE
         gDJw==
X-Gm-Message-State: AOAM532wPEIVGcqbMLG9LIiNKBDbAR85vrN8cazbzfalCA1WqPH9LCoX
        0M96d1LFw+k4rIEdyZ6CW+S0CyZsnmGC
X-Google-Smtp-Source: ABdhPJyZ2EVL358ejeqq18Z5ETnq/aANVc4Ht5mcKIUavIRcYxJpkr7GmC8AERnEdoxW1vJQKPKrlg==
X-Received: by 2002:a05:622a:24b:b0:2de:2bf3:5784 with SMTP id c11-20020a05622a024b00b002de2bf35784mr2965483qtx.664.1645719020240;
        Thu, 24 Feb 2022 08:10:20 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05620a22d300b0046d7f2a6841sm2156qki.74.2022.02.24.08.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:10:20 -0800 (PST)
Message-ID: <87f9a63c-97d5-9aa7-c952-8d7498a5825c@github.com>
Date:   Thu, 24 Feb 2022 11:10:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 20/23] fsm-listen-darwin: shutdown daemon if worktree root
 is moved/renamed
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <496b3da35d0f9b8c68c6bc6c2bf2ca93ffe224b9.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <496b3da35d0f9b8c68c6bc6c2bf2ca93ffe224b9.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:

> +		if (ef_is_root_changed(event_flags[k])) {
> +			/*
> +			 * The spelling of the pathname of the root directory
> +			 * has changed.  This includes the name of the root
> +			 * directory itself of of any parent directory in the

s/of of/or of/

> +			 * path.
> +			 *
> +			 * (There may be other conditions that throw this,
> +			 * but I couldn't find any information on it.)
> +			 *
> +			 * Force a shutdown now and avoid things getting
> +			 * out of sync.  The Unix domain socket is inside
> +			 * the .git directory and a spelling change will make
> +			 * it hard for clients to rendezvous with us.
> +			 */
> +			trace_printf_key(&trace_fsmonitor,
> +					 "event: root changed");
> +			goto force_shutdown;
> +		}
> +

Thanks,
-Stolee

