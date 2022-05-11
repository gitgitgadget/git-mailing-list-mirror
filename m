Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DDC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 22:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348761AbiEKWah (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiEKWaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 18:30:35 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC1227CD4
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:30:33 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id eq14so3133903qvb.4
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FBoQTZE1l44DRqklcB70Zp+AMxsc3QHT7RGfXOP2tZk=;
        b=eyGR/nvRnY1L7bAezvN9E821Hiwx0etfQnr+/zAVEQMsNNM2k6IuSHYyv2g7MN/QWI
         Bz+wLzGOVLJHKxAY3q0wwCQfvSjf/CMTZohw9SUKftnqVtNqzlWmYg+isLHAS/1lfl4o
         HQo+g8A3AxH9VBwJku+Y/SuThLD8y0ydxmEb2Zp8HEZpHptDzcNRoxaXCQv+xfmzrcmF
         0MbiA1uiopxLkKHZanZRxFjo9jEisJRZFlw8zRXfn3ALzzl1bipXhR1HmIKBfreAnnMz
         irSMxV0Lne2Pl79XgIKAIbBuFGyhRuc4+tKNcNsbSXtM1VfwotLV+qLXQ6B4vsIHguSG
         S+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FBoQTZE1l44DRqklcB70Zp+AMxsc3QHT7RGfXOP2tZk=;
        b=xc9SoNofyqSRd4hdTe9xk1u1O1gGNGZeAOMNFOZbKfhCRl94MQzcMFtDBkMkpnc1Q+
         /fiRFVnjRXJIIw0I33e0uPqIpAk8GgxWSI4KqvJ9jdC3Zc92HO1GIg7HNTxlsexZE83W
         5Owa+Rq+Ozwme7WipLl6aYLlt1H3akSgSA0CikSvbDaOioqmiYJKxCf31+0oG2gDRcY2
         pbMnpZ7r+pSpfJpssHvRjpbhWGm2FmlvGu+q8h4fr7ahAnPTcZaf5c4OM1n4B2XLWO4w
         chYpS7COWzfNmgul5H3RsISX7HInbKhTi5OkXsfHgLItZAoo/znrvdyR4+c1hk8/oNdR
         0vcA==
X-Gm-Message-State: AOAM531kDDQcDkswAT90URyinsbkRojdZ5SEohguXozt3Fbn1cyPkBlb
        zPVMS46aq6wLBbPxWOoSYuU=
X-Google-Smtp-Source: ABdhPJwV0d2UqnZwf72G/mMEoB2yBprRYxgSZimFOm9BE+pm9FzmypqoQxOObrWnrWaNh+UEg9Tffw==
X-Received: by 2002:a05:6214:8eb:b0:456:4fd4:6dd2 with SMTP id dr11-20020a05621408eb00b004564fd46dd2mr24078394qvb.75.1652308232453;
        Wed, 11 May 2022 15:30:32 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o8-20020a05622a008800b002f39b99f688sm2231782qtw.34.2022.05.11.15.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 15:30:31 -0700 (PDT)
Subject: Re: [PATCH v2] pull: only pass '--recurse-submodules' to subcommands
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
 <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <deafd5db-6303-46b3-a5d5-b4117ba16781@gmail.com>
Date:   Wed, 11 May 2022 18:30:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-05-10 à 15:25, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> Fix a bug in "git pull" where `submodule.recurse` is preferred over
> `fetch.recurseSubmodules` when performing a fetch
> (Documentation/config/fetch.txt says that `fetch.recurseSubmodules`
> should be preferred.). Do this by passing the value of the
> "--recurse-submodules" CLI option to the underlying fetch, instead of
> passing a value that combines the CLI option and config variables.
> 
> In other words, this bug occurred because builtin/pull.c is conflating
> two similar-sounding, but different concepts:
> 
> - Whether "git pull" itself should care about submodules e.g. whether it
>   should update the submodule worktrees after performing a merge.
> - The value of "--recurse-submodules" to pass to the underlying "git
>   fetch".
> 
> Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
> invoked with "--recurse-submodules[=value]", overriding the value of
> `fetch.recurseSubmodules`.
> 
> An alternative (and more obvious) approach to fix the bug would be to
> teach "git pull" to understand `fetch.recurseSubmodules`, but the
> proposed solution works better because:
> 
> - We don't maintain two identical config-parsing implementions in "git
>   pull" and "git fetch".
> - It works better with other commands invoked by "git pull" e.g. "git
>   merge" won't accidentally respect `fetch.recurseSubmodules`.
> 
> Reported-by: Huang Zou <huang.zou@schrodinger.com>
> Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     pull: only pass '--recurse-submodules' to subcommands
>     
>     Thanks for the debugging help :)
>     
>     Changes since v1:
>     
>      * add a test that actually tests the precedence of the config values
>        * I've kept the previous test; it has always worked, but it still
>          seems like a useful smoke test
>      * reworded the commit message slightly

Thanks, this version looks good to me. I don't feel to strongly about the 
title either, so as you wish :)

Philippe.

