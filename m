Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79450EB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 13:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjF1N2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjF1N1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 09:27:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E42D7B
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:27:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso5064720e87.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687958826; x=1690550826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9oQkhGDYSozwZFJVch5Bd+WS344NOqG9ZnuGVC8t3qc=;
        b=ZrNe4h2zqUxxV0LV/PwBuepwuHKJgwJtAWsOhbGL4X0Bgdhg2g/SIF0G4UvXm+/N/G
         8GsD2zxt6GTvc7MREvTyO0aKbBwnBhK2GvNqNXbzKp79EU7mI1UNWU5GYjTtBmj1gG3S
         UYE6Fnhz/DPM8ffJ6iAj97LNENfAK83kQxtIxeS1sG7oGNsu4hzDm0cYeK8qSFTU9Dpz
         Jo1VnE9NBG2Qqfnl7BPXvu6/wQ0kyE+WPMAuOfVxnVLh27icOP/YiY0rtRSbMgiefKbr
         3yJ4tV5ttepEtxCqMRJhqhZih8vk/MkQlL8NkxQhnHGGZBDQkrir9XoDiLBHu/4l4E+1
         oVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958826; x=1690550826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oQkhGDYSozwZFJVch5Bd+WS344NOqG9ZnuGVC8t3qc=;
        b=FkswjVrDWO9T9paOENAI80muYHFwm1CeK0ErwLLOAz2ZeR6ZCk3JoMHZcG18wltQ6E
         l6tlYrrWr04eKUusEU1jnr9n/GzeILjcpmV7Q5nRBatOc2M4s8TF/i1tMlHmXBVedi41
         xAL/w0u6lZPj82lS84/iu4KTve9w3u9ibTX5UuidbQbXlXAF6fZ+uP/2cMUAI0jwJQFg
         VZjykLsaO4DlptMYlW6+/Zl7qOVWiEnyOuRthhQre92jt8/9H97f3PWU3tI8PEnAIvzo
         JTLqh3WwSmJeKkH21O1K75zZBN2VpKAr9z9ru4LYGGzB3dZ3iPfnbs9wnHD/TO0bzZX/
         jECQ==
X-Gm-Message-State: AC+VfDytqECaoJJ1FpKLDuiMyzci4lyjLUaf6LUoNRjRsSXf11k5fe2a
        VaVHVaBn7465mzzK6wHjRn8=
X-Google-Smtp-Source: ACHHUZ5oOFr7xXiKwKpCAQhhNM8GiwEx67Lexo6BYNbyzuIIUNQFqKn9WHERRSYiyuYzLMVKGAQ4RA==
X-Received: by 2002:a19:915d:0:b0:4f6:1805:6095 with SMTP id y29-20020a19915d000000b004f618056095mr22190307lfj.8.1687958825861;
        Wed, 28 Jun 2023 06:27:05 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id v24-20020a197418000000b004f37b88eacfsm1933821lfe.187.2023.06.28.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:27:05 -0700 (PDT)
Message-ID: <d77f99df-f50a-39fa-a7c5-1bb958f196fb@gmail.com>
Date:   Wed, 28 Jun 2023 14:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 7/8] git-std-lib: introduce git standard library
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-8-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230627195251.1973421-8-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 27/06/2023 20:52, Calvin Wan wrote:
> The Git Standard Library intends to serve as the foundational library
> and root dependency that other libraries in Git will be built off of.
> That is to say, suppose we have libraries X and Y; a user that wants to
> use X and Y would need to include X, Y, and this Git Standard Library.

I think having a library of commonly used functions and structures is a 
good idea. While I appreciate that we don't want to include everything 
I'm surprised to see it does not include things like "hashmap.c" and 
"string-list.c" that will be required by the config library as well as 
other code in "libgit.a". I don't think we want "libgitconfig.a" and 
"libgit.a" to both contain a copy of "hashmap.o" and "string-list.o"

> diff --git a/Makefile b/Makefile
> index e9ad9f9ef1..255bd10b82 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2162,6 +2162,11 @@ ifdef FSMONITOR_OS_SETTINGS
>   	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
>   endif
>   
> +ifdef GIT_STD_LIB
> +	BASIC_CFLAGS += -DGIT_STD_LIB
> +	BASIC_CFLAGS += -DNO_GETTEXT

I can see other projects may want to build git-std-lib without gettext 
support but if we're going to use git-std-lib within git it needs to be 
able to be built with that support. The same goes for the trace 
functions that you are redefining in usage.h

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 481dac22b0..75aa9b263e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -396,8 +396,8 @@ static inline int noop_core_config(const char *var UNUSED,
>   #define platform_core_config noop_core_config
>   #endif
>   
> +#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
>   int lstat_cache_aware_rmdir(const char *path);
> -#if !defined(__MINGW32__) && !defined(_MSC_VER)
>   #define rmdir lstat_cache_aware_rmdir
>   #endif

I'm not sure why the existing condition is being moved here

Thanks for posting this RFC. I've only really given it a quick glance 
but on the whole it seems to make sense.

Best Wishes

Phillip

