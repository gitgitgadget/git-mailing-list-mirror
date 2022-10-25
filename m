Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA6C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJYSAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJYSAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 14:00:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2A33873
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:00:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gn9-20020a17090ac78900b0020d7a817d36so4731149pjb.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQ3rqzdR0Gz+pTB+1riTofh+k9ukA5WqWyXp2jqJHeA=;
        b=MhwxDNudlyqMkqp3DrFz9zWAqjw61f4+ex4ysXxzY+JpYwAmVARTnA1R9iHuNDEK+S
         VqIxJzI+76Mfbr0M/615RYC2cutqiO03XxoUa1iCQfuuQJ54Z7R4hSWPiPhsVzvWIbFs
         XQNh5uMQGCToVkfR7h37OZYcBcgwID54zpQ8Vkrp0YX6Zrl5i/xUzb+OwfLmGcszS/dW
         rhO1GNDA6kf09XNFlvIJJGFWc2pkO1FPlke/buXxeW/FmtjYFwlHx/LMZzC9HWLfGFGe
         gp/Zfl/bXraFGWamSlu/vBdffhd5LYWdEvJimqGe3yGs3QTSVo8uGn/2TaQuo3DuZOjw
         V/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ3rqzdR0Gz+pTB+1riTofh+k9ukA5WqWyXp2jqJHeA=;
        b=zJOgYdQT3FIfwAd11/ZXwP6YCUKAGxuZNri2FqkoRqNqxU3bNQ9/C1GSLvUCQHoLt4
         O8c+P7+DyE73OFJpf0Hv2SdLMjiE45/a2EpnKG1oZQKvr1GKJ6cNar7kZcMtG1UVxpkT
         8yC97AkpZz1k4b0K5eYX11LaPCS9Hoz0+1Vtc1XeH2NJE3X4J+Qh9liGoU5qEMf+z2WV
         oKgCT7nzAWNOJ8FU8UisiW7T93stSVA4/WskLf9r2EmNhpqVsesGqj012vDzgvWbIFYA
         gt/7FZKtqz6q3VpFNmnDhJULXgNaQ96KMPqgX7SXXBJyjBXLEnRqNH89jgpRIJ7aRZzj
         lccw==
X-Gm-Message-State: ACrzQf1/7yUW24S1Z3/dLWsMixTJ6hYNc++wf0OAB/qRq8tQfaIIEW6b
        3jSXy/cM1VyFRDjyWKxAQz3ylyxkHQ6LqX/N8vjH
X-Google-Smtp-Source: AMsMyM4IqYEwaF5I0xEgGeEGMpuV6Vib8TR85S2nBPkUKolu9Y7rjrgGNgSB0ovR4fziq/dy6JV7BaxX4HyggC5n+RC+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with
 SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr80308579pjb.200.1666720820139;
 Tue, 25 Oct 2022 11:00:20 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:00:17 -0700
In-Reply-To: <a4056e200eda9958efe77801b39bdebfdc1497a2.1666297239.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025180017.977401-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/7] submodule--helper clone: create named branch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Signed-off-by: Glen Choo <chooglen@google.com>

Add a note in the commit message that this will be used and tested in a 
subsequent patch. 

> -	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
> +	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path)
> +	    || (!!clone_data.branch != !!clone_data.branch_oid))
>  		usage_with_options(git_submodule_helper_usage,
>  				   module_clone_options);

I know that this is just internal code, but could we have a better 
diagnostic? You can leave the existing check alone, and then do the 
!!clone_data.branch != !!clone_data.branch_oid with a BUG() if the 
result is not what you expect. 
