Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C4C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357BB61214
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhIOItY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOItX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 04:49:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D6C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:48:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u18so2068358pgf.0
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoIVj9TVaId6M1SAED05TtHBHIEmr1/Y1A2IWbj+zl0=;
        b=g+ei3ms+/NT7onepigOONgow0uwHC9sCN7pif6piAWax//fL8o6h2DKdY4RdiK4ctI
         VOsW7ylt1B5F9oES2uKQKhnbhNduIW/V+BdwftyD9fJacAE2tgV64F1kmvoNjwKg3fHE
         Jg62VxPVyfbtye+RJosZzD6yCxD0V4MJmmsVb5QmTHygwxoSWJkj7BD2KWM0GxG8brfp
         IYZHj5ZwKi07Jkq2YY41FvJe7xgzPPBTBmI/OqWfza+lAc9nKI43jaG+X46r09IpsySe
         uS+PCUDRDwSArI8uZ0fatYwUN8loRisrQ68OOzAdLcJVn5mu3k9P9YTA/td6HcQ2gg6i
         oIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoIVj9TVaId6M1SAED05TtHBHIEmr1/Y1A2IWbj+zl0=;
        b=PD8WNvAgA3RGSWpkWFuJ1BF6wlZxNjyW0Hh7LQvVi690CAOZPkLmG+lUjvZ+K7ELSo
         eJjmPM0IbfQF3q4KL0MJI8y/69+yOtXYzampOcJp8iF4j/5pAigSXrld+Lw85D6qlKxX
         54bzt6J26UgV1P8ZElWYXNvfrcfPdd3usXm1Zo3Pj0Io8TlhSR5i6XHPfAf1iLu3kjds
         lClUB1Nuihnm6ci/g2g+PqVaC4aXN+1aawCpAruh9a98wTp4qx/Zopagcktj1/zDLEH8
         3DwLDB9n6EElcrWBRhM25jUz20pT3UNMh+EglH+RfGBHrGWN5egvDbdDkUtb7ve0uCp/
         jmmg==
X-Gm-Message-State: AOAM530+vgk9aQjPu0eO0GTuKQf+A2JD9bUKXqz7HtyDNq9uiqoIah16
        vEHPqKWHZZgCgVQ4DKJn/9E=
X-Google-Smtp-Source: ABdhPJxWLoNgy0jKN1yNCeQGyFSyCq9+nQ0CxsckzYHhdsZuI4c+A36i75GOgVLMp9EwUdzJf7PKfw==
X-Received: by 2002:aa7:8106:0:b0:416:143c:44e3 with SMTP id b6-20020aa78106000000b00416143c44e3mr9228381pfi.41.1631695684988;
        Wed, 15 Sep 2021 01:48:04 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-4.three.co.id. [116.206.28.4])
        by smtp.gmail.com with ESMTPSA id y13sm689023pjc.50.2021.09.15.01.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:48:04 -0700 (PDT)
Subject: Re: [PATCH] pack-revindex.h: fix typos of time complexity
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Kyle Zhao <keyu98@qq.com>,
        kylezhao <kylezhao@tencent.com>
References: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <617e94d7-6c34-8e89-fd3a-d96dc70fd9dd@gmail.com>
Date:   Wed, 15 Sep 2021 15:48:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/21 15.42, Kyle Zhao via GitGitGadget wrote:
> From: kylezhao <kylezhao@tencent.com>
> 
> Signed-off-by: kylezhao <kylezhao@tencent.com>
> ---
>      pack-revindex.h: fix typos of time complexity
>      
>      It looks like the time complexity descriptions were written wrong.
>      
>      Regards, Kyle
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1039%2Fkeyu98%2Fkz%2Ffix-pack-revindex-typo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1039/keyu98/kz/fix-pack-revindex-typo-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1039
> 
>   pack-revindex.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pack-revindex.h b/pack-revindex.h
> index 479b8f2f9c9..74f4eae668d 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -109,7 +109,7 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
>    * If the reverse index has not yet been loaded, or the position is out of
>    * bounds, this function aborts.
>    *
> - * This function runs in time O(log N) with the number of objects in the MIDX.
> + * This function runs in constant time.
>    */
>   uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
>   
> @@ -120,7 +120,7 @@ uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
>    * If the reverse index has not yet been loaded, or the position is out of
>    * bounds, this function aborts.
>    *
> - * This function runs in constant time.
> + * This function runs in time O(log N) with the number of objects in the MIDX.
>    */
>   int midx_to_pack_pos(struct multi_pack_index *midx, uint32_t at, uint32_t *pos);
>   
> 
> base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
> 

The commit message should be "time complexities for pack_pos_to_midx and 
midx_to_pack_pos are swapped, correct it". Of course, this is not typofix.

-- 
An old man doll... just what I always wanted! - Clara
