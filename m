Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1438BC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 08:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiGFIud (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiGFIuc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 04:50:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1004F240A8
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 01:50:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y8so12603777eda.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=r1q9XX2rJia609Odxb1KLSAwGfeSqDaTg05B0jG4gLw=;
        b=ZLLaPYx+TnS5fUYkxWGeowWsRvVW0voOdhhBiOS3jVbYvPTDrE8vql7TTrPGDpwJsm
         U3xMb4qkCopOVuwxh9f45wcbyZD8DbknXYo7J30xHsy8MlYpvEijFnnqnYvTPKYPUvie
         eMPB9QTdPWonRtr+e35bwVmEoADeWAax1Mb6QfFhctT0fJIFRtpe5atOVmiXIqJR6D6Y
         UTWqx6nPlwD+q4vI89r6+n+er0Wwg6FVY7EG9cBpwOA6bTujGeaKzxPQjqxf0AjKO6RB
         OXUJgoJ189ByC9/ndvhbCDVce73DHNt8w8UIfGk+lcAewAWyOGeDHQPdOmGmBgR1O7t1
         3UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=r1q9XX2rJia609Odxb1KLSAwGfeSqDaTg05B0jG4gLw=;
        b=zCx/Yjom5nFNbvtD/QURb6di81nDDHY1t3HQQpgA0yo52Yb7uioyYdL2/9GO0zwEjq
         NGacRj7iWh0HEM12nuxjXVrUrxw++zwgBpb5q7l52KqL17xV+GpSLf02UjwB9iPD2SlN
         by1cTS8BRGSc4+0WbltTOzsJAQssXpEpTGuJMfCA5kZz1ReZStvU0xuOkB0laTyX1lHd
         CPhFUpalxuAge2z8vaZUajM9GxYq7QStAIXhDpSxIFLlDrqWwzKKRArF4koV1UTGfrhw
         aFunirWvZpch7jsQXwIp2+oNtUXKNz15KpR13i16UefHgfQlVjtbK9+oHOpnRaJn/3CY
         Y8VQ==
X-Gm-Message-State: AJIora8YxPfav6/UsyOuaqfoOGSPczVG/bVj4FhRSgzVTUx7qU99Vqvo
        DACiGX+wCjVPJHUzKAlHDMtzLmJVz3Dnsg==
X-Google-Smtp-Source: AGRyM1uii1vVYCiwivfRCsn+k4RLaJ3ZDLBQFi6WvccAI0wPxSqu1Q1p2T645XxfdNDdzLdyfYmEUQ==
X-Received: by 2002:a50:fe98:0:b0:435:a8b:c4c3 with SMTP id d24-20020a50fe98000000b004350a8bc4c3mr51523285edt.78.1657097429473;
        Wed, 06 Jul 2022 01:50:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f15-20020a170906084f00b00718d18a1860sm17050296ejd.61.2022.07.06.01.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:50:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o90jr-004DKj-If;
        Wed, 06 Jul 2022 10:50:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha256: add support for Nettle
Date:   Wed, 06 Jul 2022 10:45:06 +0200
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220705230518.713218-1-sandals@crustytoothpaste.net>
Message-ID: <220706.86fsjeaalo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 05 2022, brian m. carlson wrote:

Do any of those security issues in libcrypt have to do with the narrow
"hash stuff" part of the API we're using?

> Let's add another option that's compatible with the GPLv2, which is
> Nettle.  It also has recently gained support for Intel's SHA-NI
> instructions, which compare very favorably to other implementations.
> For example, using this implementation and SHA-1 DC on a machine with
> SHA-NI, hashing a 2 GiB file with SHA-1 takes 7.582 seconds, while
> hashing the same file with SHA-256 takes 2.278 seconds.

Interesting, but as Jeff notes downthread we really should be comparing
the different sha256 backends for speed, i.e. the interesting thing
isn't sha1dc v.s. this sha256 ,but if this sha256 backend in particular
offers performance benefits.

> -#if defined(SHA256_GCRYPT)
> +#if defined(SHA256_NETTLE)
> +#include "sha256/nettle.h"
> +#elif defined(SHA256_GCRYPT)
>  #define SHA256_NEEDS_CLONE_HELPER
>  #include "sha256/gcrypt.h"
>  #elif defined(SHA256_OPENSSL)
> diff --git a/sha256/nettle.h b/sha256/nettle.h
> new file mode 100644
> index 0000000000..9b2845babc
> --- /dev/null
> +++ b/sha256/nettle.h
> @@ -0,0 +1,28 @@
> +#ifndef SHA256_GCRYPT_H
> +#define SHA256_GCRYPT_H
> +
> +#include <nettle/sha2.h>
> +
> +typedef struct sha256_ctx nettle_SHA256_CTX;
> +
> +inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
> +{
> +	sha256_init(ctx);
> +}
> +
> +inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)

Needs a line wrap;

> +{
> +	sha256_update(ctx, len, data);
> +}
> +
> +inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
> +{
> +	sha256_digest(ctx, SHA256_DIGEST_SIZE, digest);
> +}
> +
> +#define platform_SHA256_CTX nettle_SHA256_CTX
> +#define platform_SHA256_Init nettle_SHA256_Init
> +#define platform_SHA256_Update nettle_SHA256_Update
> +#define platform_SHA256_Final nettle_SHA256_Final
> +
> +#endif

Would it be viable / at all sane to embed the part of the library we
need in our sources, similar to what we do for sha1dc? Or perhaps it's
not worth it at all...
