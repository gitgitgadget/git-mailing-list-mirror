Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739FEC4742C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F107B206D9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEftIKjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgKKRdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKRdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:33:51 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDB1C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:33:51 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so3079492wmd.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KeeWq949HZC8hzxt5P4EZYKlWurqikxHOh3KPzsa7Dk=;
        b=AEftIKjckic7U72BXOvwlhpm5+I/y+EgfI1VRObb4QZLzQs/JPiU7PB3gxN6JKgnNs
         l2b+nXDTieRb0aBfDhKS4F9gJsb1NDJPwcgxbEYAdqhoThT4bn2pQawRUEW86v3q0nJI
         Ed6tVdrJB1kyNKrb3tisoLMxsy27p/wD6EHtP4Jypqe9eUsf2pHHQtaOn0KYSUU5cKas
         x/gbZmL2gNqMyBmpYkSJ5OPxiXNMogqLIdpm0LTz21fBf9w6XFR+C+L3OmyeIRWN/mNF
         lIi+1ByMWLuC9bRXkdD4m+wZlcLB9uAvApujlpjMA86iT5Q+tG3MVVcjvo2EJKCq8OGE
         EBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KeeWq949HZC8hzxt5P4EZYKlWurqikxHOh3KPzsa7Dk=;
        b=Kao90oFPryyGH6Iw3UCXpJ+h2sos/B4vu0FYmnEFWVYny8uh7UcHNNZuB/617Hrr5G
         l7RlRy1mthx5uWIWZ801naYe8aiapz+hQhMhGdIpD+4oOKjFMxWmJMTYkCDGRcZVQ8oo
         trH5VzgWOeYdHF+jTd5lwYvYfznIqt/YIEiujBsV1eI9SmA8pIX4d6Op8KjTwcu1EnhY
         v8eYWx5IivEb5B0Snkj6pa0Z5ETYvAVH/S7ume9wOtiO9hH1KXXblV6roJBKaXXsq1fg
         ahJ7vUmMlRuomZ86LTM3YZH+ETkDqiPFanXNP2x3w1uxeYq8DRREzn6uG/G4f7rTRSA9
         Z04A==
X-Gm-Message-State: AOAM5324taJc742MCFdcjyL0cfJI8wfsoaAoJPbPf8Mu/UOJihjJcIAN
        OJKR7Iz2Ri1E0GFrX05HyWw=
X-Google-Smtp-Source: ABdhPJyRK3vHA3BysXdMJqWiZ2zAnqJwiCYuxJnQfqW4ZdbV5Zi3tIb1Zxf1NtFDFKzGVKURwXCPfA==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr5070676wmk.125.1605116029619;
        Wed, 11 Nov 2020 09:33:49 -0800 (PST)
Received: from [192.168.1.240] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.gmail.com with ESMTPSA id v6sm3675400wrb.53.2020.11.11.09.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:33:48 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 12/15] strmap: enable allocations to come from a
 mem_pool
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
 <34f542d9dd846da5fd81274966ee2ebe0660dcef.1604622299.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fbaa60c4-ee6b-02b7-68b5-e5873f8ec713@gmail.com>
Date:   Wed, 11 Nov 2020 17:33:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <34f542d9dd846da5fd81274966ee2ebe0660dcef.1604622299.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 06/11/2020 00:24, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> For heavy users of strmaps, allowing the keys and entries to be
> allocated from a memory pool can provide significant overhead savings.
> Add an option to strmap_init_with_options() to specify a memory pool.
> [...]
> diff --git a/strmap.h b/strmap.h
> index c8c4d7c932..dda928703d 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -3,8 +3,10 @@
>   
>   #include "hashmap.h"
>   
> +struct mempool;

I think this is a typo - I assume you wanted to declare `struct 
mem_pool` but it's not strictly necessary as you're only adding a 
pointer to the struct below.

Best Wishes

Phillip

>   struct strmap {
>   	struct hashmap map;
> +	struct mem_pool *pool;
>   	unsigned int strdup_strings:1;
>   };
>   
> @@ -37,9 +39,10 @@ void strmap_init(struct strmap *map);
>   
>   /*
>    * Same as strmap_init, but for those who want to control the memory management
> - * carefully instead of using the default of strdup_strings=1.
> + * carefully instead of using the default of strdup_strings=1 and pool=NULL.
>    */
>   void strmap_init_with_options(struct strmap *map,
> +			      struct mem_pool *pool,
>   			      int strdup_strings);
>   
>   /*
> @@ -137,9 +140,10 @@ static inline void strintmap_init(struct strintmap *map, int default_value)
>   
>   static inline void strintmap_init_with_options(struct strintmap *map,
>   					       int default_value,
> +					       struct mem_pool *pool,
>   					       int strdup_strings)
>   {
> -	strmap_init_with_options(&map->map, strdup_strings);
> +	strmap_init_with_options(&map->map, pool, strdup_strings);
>   	map->default_value = default_value;
>   }
>   
> @@ -221,9 +225,10 @@ static inline void strset_init(struct strset *set)
>   }
>   
>   static inline void strset_init_with_options(struct strset *set,
> +					    struct mem_pool *pool,
>   					    int strdup_strings)
>   {
> -	strmap_init_with_options(&set->map, strdup_strings);
> +	strmap_init_with_options(&set->map, pool, strdup_strings);
>   }
>   
>   static inline void strset_clear(struct strset *set)
> 
