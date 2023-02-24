Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E6C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBXXzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBXXzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:55:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F6E4AFD9
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:55:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536e8d6d9ceso15533827b3.12
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DYJKj367Vk8ExkluzMBf8kTy9v1zBJp5Ln/RWcPVWXw=;
        b=JMzeJNam6doTRB0h3IZz2ZU3DzR1ENPB3akAlECeO8EWcLODaB+zngFNYFgYGsyl65
         egBy1LUe4ZXYI8N4R6QHxYHd152862t/HjgCQZW0+H4mK5Cgm44xUiSpMlxAwgi/hRRi
         LM7hYNNO7drxcx9Tp3tKVx8RGfj8GkqOsPZNNw6LI1zaybDPukurBxU7f9v388wJ/zer
         VvYilDeX0piYrRbl90OsL/4aGhORZn7pc7qBrmtwkkcSz6JaE/ShYbmMsmdcWJiR7qK2
         rY7oLOwOG5A/ahm3k7GgYUWK9lRZHu6kSZBAJn7KzGVyAE0vegBeRIEEhqaof5Z8FPFX
         aWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYJKj367Vk8ExkluzMBf8kTy9v1zBJp5Ln/RWcPVWXw=;
        b=Qkwa5l3x/vwJXN5UnSWmDq/ZOZx3mcuFY77T3hpDIDSaIauO9VNhaslMa9a2TsRKZ9
         5gm8MhjycqjNVLoCQQVoj1SVKp/hxttm6/HBCplLymrVpC+BNZvwYMbClJA1f0+ZK+H2
         j+P7sTCxHW68EgEwhmPFzLSpE9tq7mRfuUR0vgCGJuEWFhTa1mXOFRSi9D2apIavjfP7
         sP7ntbGJOKU28XzjKuuFEDJX9AsvSJ9ADXEM3MdOJ2q74lYScQLbIfnMhiAlaH0cgvq9
         K4IX46UH96YMDZKn5HBI3m4H2Sn2hNpJ/IrIR+PLVUmN+Rodpaq2vNnkSETSRbiDKFB6
         aFSw==
X-Gm-Message-State: AO0yUKUeIxTpsZqiMyhn9TFr5UueqhfEe5aJYbz8p8aiKn06hWisP/Mo
        0uwq3vKmQttBvAaty+VOzOGpuRHW+WvV8nX6bZ8a
X-Google-Smtp-Source: AK7set8Q8KN7eBmcp3AvDL9T2NMW3JNpm+14EmSNkDHHX2xatk1TzygeqPwjdxSW92546moDNvZ/sDq9vTyfjksVn7q1
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:60fb:bc56:6979:1f96])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4418:0:b0:52e:ec03:9b2f with
 SMTP id r24-20020a814418000000b0052eec039b2fmr5156508ywa.8.1677282946453;
 Fri, 24 Feb 2023 15:55:46 -0800 (PST)
Date:   Fri, 24 Feb 2023 15:55:44 -0800
In-Reply-To: <9f78f0f215595d55ead4d82d20e1d0c9892171ec.1677139522.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224235544.2045718-1-jonathantanmy@google.com>
Subject: Re: [PATCH 06/16] hash.h: move some oid-related declarations from cache.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/submodule-config.h b/submodule-config.h
> index 28a8ca6bf46..c2045875bbb 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -1,7 +1,6 @@
>  #ifndef SUBMODULE_CONFIG_CACHE_H
>  #define SUBMODULE_CONFIG_CACHE_H
>  
> -#include "cache.h"
>  #include "config.h"
>  #include "hashmap.h"
>  #include "submodule.h"
> diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
> index dc1c14bde37..a3848a8b668 100644
> --- a/t/helper/test-submodule-nested-repo-config.c
> +++ b/t/helper/test-submodule-nested-repo-config.c
> @@ -1,4 +1,5 @@
>  #include "test-tool.h"
> +#include "cache.h"
>  #include "submodule-config.h"

This addition of including cache.h caught me a bit off-guard, but I
can see that it is because submodule-config.h lost its own include of
cache.h. Thanks - the patches up to and including this patch look good.
