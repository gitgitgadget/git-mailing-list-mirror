Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F7C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 15:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbiA1PEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiA1PEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 10:04:46 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AE7C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 07:04:46 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q186so12783115oih.8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CBLZWMqB1n/z63Fs+94O1y24tLcyW8w23qjxw2565cc=;
        b=L+uICzo8hdVKRUqg3g8f+i5sOU3j3uwJ6pAF+hbcL+TyBsutaaM4XEJTnaWr/2imXb
         3Gc4owgsTSl7/5MNEP3Duhv4sOlyexKfQe8M5VCD02PvvgUEC4UjUsMjZIaMpy+rfSQ7
         S9BOoWG6sAWJPqC5v/OkGzVDT2OJkzItD1caaAWjFq7d148kTH46tT7MB26qtP8be+C0
         x5QZRLBUF9RP9d09yvQ1p+tbIpjGDeXGy+j4sfOgtnpMWZwqOQxrsNifpNIJWyYuQyGM
         nLo02M6jEcL9qpybjVKYOF7IrT9DhnBZemITwTZrDKIm/pRqz3VRVWwi8ES0Chdg4N0i
         MhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CBLZWMqB1n/z63Fs+94O1y24tLcyW8w23qjxw2565cc=;
        b=cfgR8/K3Mm1yIRJLhlO3vxCVWsV6/9aSYifbCBqEy1Ui+BKe6jvYT/keYeknlHA4h+
         6pVvkre0Nnn1n2w1j7USaSCayRJK9hjwEOd7mx+8q5MPDeEGwGuO6TLWLk5zPpggNUNr
         sqVtxHc33Wi9A4uIFtKo+Rs3evd/JPTLabeLyLr5vew5hj2edsRYLXDS42UORmlOYjea
         W8DooKT50pUPBTBQcJPny+b3JmviF6Z7IrkYwG3Q119gNeCVv3ugRaH72NjVaiLZ2Iwy
         HPYzkn+BEVhKQd3rvbzHx8h90R/843GSGlKo51CgMv1DXcodLJRQjj8zkA9Eiv2m3Gn7
         qtbQ==
X-Gm-Message-State: AOAM5314sOcL6JWKrgupxctD5rSBfhkXuHOStjzH1+su9BwvS3ed0+K7
        V2AtLVTtCrfz5yElcET5Na8=
X-Google-Smtp-Source: ABdhPJy6qonkdAA9JPArNlR+5eLqND+vtSba5UScCcaaLn10snqUVpUvkcOawfR+1eEasfpSKSy3qw==
X-Received: by 2002:a05:6808:118e:: with SMTP id j14mr9868248oil.196.1643382285873;
        Fri, 28 Jan 2022 07:04:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67? ([2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67])
        by smtp.gmail.com with ESMTPSA id n22sm10381157ooq.27.2022.01.28.07.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:04:45 -0800 (PST)
Message-ID: <2bea96f1-48dd-884f-244c-479d635487f1@gmail.com>
Date:   Fri, 28 Jan 2022 10:04:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] sparse-checkout: fix a couple minor memory leaks
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1189.git.git.1643335098710.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1189.git.git.1643335098710.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2022 8:58 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> These were introduced in commit 55dfcf9591 ("sparse-checkout: clear
> tracked sparse dirs", 2021-09-08) and missed in my review at the time.
> Plug the leaks.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     sparse-checkout: fix a couple minor memory leaks
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1189%2Fnewren%2Fsparse-directory-cleaning-memleaks-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1189/newren/sparse-directory-cleaning-memleaks-v1
> Pull-Request: https://github.com/git/git/pull/1189
> 
>  builtin/sparse-checkout.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 679c1070368..c655517e019 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -185,6 +185,8 @@ static void clean_tracked_sparse_directories(struct repository *r)
>  				item->string);
>  		}
>  
> +		strvec_clear(&s);
> +		clear_pathspec(&p);
>  		dir_clear(&dir);
>  	}

Simple enough. Thanks for catching and fixing this.

-Stolee

