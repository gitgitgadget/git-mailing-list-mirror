Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95DD61019
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhJHJkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhJHJk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:40:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7716C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 02:38:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 66so2558713pgc.9
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kzNiNFzINpbRzS0ppPOaw82BcxHH7yBTwmdqtdMoBRQ=;
        b=KlKEMZ65Vqbumt08IKxaaSF0xgx/WAMAJyHQQsuQ36eGy/vjIUZAYHvOI/bSi0JY3G
         ISNg1+kK8H4cu+/y3Fr73SXbF5KMIT+w8bbAEUrt8ODXN6QyBwcpI3yhYV9MddibDyr8
         woIEXy/ypnQzkhp+22hj1HZy9wklZqdqt+Z4g6ZnqT6bJV0XI/3Vqnq6W5zcr7xIXf8V
         NUQX/z4C2JkHeESEz3ycZUDQoZZEDyAO45tnb1e9wSy8gM+kO5m6iPW3AoosrUPv4BsQ
         dL2sICTgqrW47hVnCYehZhpb++akLkS0U9PeHap+hznhR1UqLO6MZihpASn0M7YNiRZz
         700w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kzNiNFzINpbRzS0ppPOaw82BcxHH7yBTwmdqtdMoBRQ=;
        b=AXcsvTkXJkiv4b/MDUby+giaJjWQ5pkxwA7tVgxYXIH3BPf7A2zYlL8G55zc4bBJaz
         hHW5/CCr+6E5f2hm6Wkm7EvnzNjSHRc2pW5Uk4vHzF034BMCHeKKF264PV7ok6aNnPZ3
         UQpOAbUtGuq07PdghYchKYxoL8nIaIVysiaeJMuHxscJPIttsSwylNeENL5GFaLr0BiU
         OFWoKEEYYWV0ZOkwSLeXozIcTOe3aRo5xxgpkbp/x6ZSGLLIAOpx8dUQefGBPFhr8myh
         m9X5nimI2nIefJd8rhr9gHKhO4UHEkkUxSHvRLntFa6lUqv2diL/Swl+C18NGfse+ieT
         z/FQ==
X-Gm-Message-State: AOAM531ojzAGpz3lNA17B5ADKSh/HIe8HrgMBiLkoYXoX+R8uuh6lSoZ
        41acvBhlC6l9I22VRaaSfIg=
X-Google-Smtp-Source: ABdhPJy9aazOeAxeHphu5WA0g5yU1kSMY+7tXsnWhkeW00JSckuEplhyUSsGStYRqCGHWCB1Vak4qw==
X-Received: by 2002:a63:b007:: with SMTP id h7mr3732180pgf.443.1633685913362;
        Fri, 08 Oct 2021 02:38:33 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id q21sm2448916pfj.90.2021.10.08.02.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 02:38:33 -0700 (PDT)
Message-ID: <905e3d0f-0541-ffad-c05b-e7ebc6bed94c@gmail.com>
Date:   Fri, 8 Oct 2021 16:38:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10/21 01.07, Phillip Wood via GitGitGadget wrote:
> -static void verify_one(struct repository *r,
> -		       struct index_state *istate,
> -		       struct cache_tree *it,
> -		       struct strbuf *path)
> +/*
> + * Returns:
> + *  0 - Verification completed.
> + *  1 - Restart verification - a call to ensure_full_index() freed the cache
> + *      tree that is being verified and verification needs to be restarted from
> + *      the new toplevel cache tree.
> + */
> +static int verify_one(struct repository *r,
> +		      struct index_state *istate,
> +		      struct cache_tree *it,
> +		      struct strbuf *path)
>   {
>   	int i, pos, len = path->len;
>   	struct strbuf tree_buf = STRBUF_INIT;

What is verify_one() doing? I think it worth mentioning it in the 
comment above.

-- 
An old man doll... just what I always wanted! - Clara
