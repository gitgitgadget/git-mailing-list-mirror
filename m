Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4211FC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGJOoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJOoN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 10:44:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB12DE
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 07:44:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so4906192ejc.13
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cPqS3WTpl81K2TXyjLlArpNSG9yW9Lqd4N1jngqGc3g=;
        b=StOhRdJePkDd/Soaz/JoAlhMk2Kn40uaJqtwhY5Fff0+uMLnT0w2+52ik97rUWT/MP
         0TBVvoBXVAP/lRYklk+U8xzLq82+dE0uXoCKAJF0FbwNYPR+0kg+/4bQy4fe4fr0mGDJ
         y/N/ku1yJatOfNuZN+iRKTv/D0KHUelWaUsgGc4eVKqja2FkJxuJ8hyjBjRiRcw5OPVu
         z7fbHTQsx2NUWkMZAHIBLnfwtKhQK7OOv0ShDht9Ya7UNVkXoo8/Ao38kIxAdKYt2YdK
         ElgD6xxZTSkl9cjtDR3/l/FnpAtWiGlVNWYILazD4ryotZZmd0bXYORXeyRV761Gs4uu
         GcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cPqS3WTpl81K2TXyjLlArpNSG9yW9Lqd4N1jngqGc3g=;
        b=8PmV9zHpqV+QpgPtRw3gAw7aobV53zHhuHYz5qLj1lXwwJSCwGbQZZ/6grzkVAHPmi
         rFR0N++wY6iPDnq5H61BvpMZfHO6TICb5DvU405QcBj/VQsl8w7BnNAH2JE/Or0bskst
         GuZlaZGKkNGYQD6eTD0TYkxHh1pdXegohq5Lty9BFT5mo24IfKz6vqxTqrMxtYvGPvkt
         jx6Ud+S/bkbQQ/e9Oar7MF16shbsktL9qcBVAerJUYlTzLLD++32Yn4s5g8CFAJirtdl
         Pd4pr/sQl6hT+yPKDK4V+la0LU8yy7htSrKOwbo2+npirWiqb9tM0GCbcr4oEi8JeO5y
         ys9A==
X-Gm-Message-State: AJIora9PqnA2ekJIyuR/1vdXUE9jI3X51BkCky8iocj8fhtxm7aUdZhu
        86/d9By7/+VfVIldSrJIcjYuy0dagQI=
X-Google-Smtp-Source: AGRyM1tr3Q6gOWksQ5NX0ZbairAioasnr7M9wjQrX3VaEeEcy7sT4xnDWPsAiEQOjtlyVp7nZpuGsw==
X-Received: by 2002:a17:907:3e9a:b0:72b:44d4:4482 with SMTP id hs26-20020a1709073e9a00b0072b44d44482mr4697137ejc.34.1657464251439;
        Sun, 10 Jul 2022 07:44:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709064a0200b0072b32de7794sm1634558eju.70.2022.07.10.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 07:44:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAYAL-0009tQ-KX;
        Sun, 10 Jul 2022 16:44:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha256: add support for Nettle
Date:   Sun, 10 Jul 2022 16:41:23 +0200
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
 <20220710132907.1499365-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220710132907.1499365-1-sandals@crustytoothpaste.net>
Message-ID: <220710.86mtdh81ty.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 10 2022, brian m. carlson wrote:

> @@ -182,6 +182,8 @@ include shared.mak
>  #
>  # Define BLK_SHA256 to use the built-in SHA-256 routines.
>  #
> +# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
> +#
>  # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
>  #
>  # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
> @@ -1842,6 +1844,10 @@ ifdef OPENSSL_SHA256
>  	EXTLIBS += $(LIB_4_CRYPTO)
>  	BASIC_CFLAGS += -DSHA256_OPENSSL
>  else
> +ifdef NETTLE_SHA256
> +	BASIC_CFLAGS += -DSHA256_NETTLE
> +	EXTLIBS += -lnettle
> +else
>  ifdef GCRYPT_SHA256
>  	BASIC_CFLAGS += -DSHA256_GCRYPT
>  	EXTLIBS += -lgcrypt
> @@ -1850,6 +1856,7 @@ else
>  	BASIC_CFLAGS += -DSHA256_BLK
>  endif
>  endif
> +endif

This just carries forward existing technical debt, but it's unfortunate
that we don't catch OPENSSL_SHA256 overridding NETTLE_SHA256, and error
if both are defined.

>  ifdef SHA1_MAX_BLOCK_SIZE
>  	LIB_OBJS += compat/sha1-chunked.o
> @@ -3091,6 +3098,9 @@ $(SP_OBJ): %.sp: %.c %.o
>  sparse: $(SP_OBJ)
>  
>  EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
> +ifndef NETTLE_SHA256
> +	EXCEPT_HDRS += sha256/nettle.h
> +endif
>  ifndef GCRYPT_SHA256
>  	EXCEPT_HDRS += sha256/gcrypt.h
>  endif
> diff --git a/hash.h b/hash.h
> index 5d40368f18..ea87ae9d92 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -16,7 +16,9 @@
>  #include "block-sha1/sha1.h"
>  #endif
>  
> -#if defined(SHA256_GCRYPT)
> +#if defined(SHA256_NETTLE)
> +#include "sha256/nettle.h"
> +#elif defined(SHA256_GCRYPT)
>  #define SHA256_NEEDS_CLONE_HELPER
>  #include "sha256/gcrypt.h"
>  #elif defined(SHA256_OPENSSL)
> diff --git a/sha256/nettle.h b/sha256/nettle.h
> new file mode 100644
> index 0000000000..b63e1c8190
> --- /dev/null
> +++ b/sha256/nettle.h
> @@ -0,0 +1,31 @@
> +#ifndef SHA256_NETTLE_H
> +#define SHA256_NETTLE_H
> +
> +#include <nettle/sha2.h>
> +
> +typedef struct sha256_ctx nettle_SHA256_CTX;
> +
> +static inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
> +{
> +	sha256_init(ctx);
> +}
> +
> +static inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx,
> +					const void *data,
> +					size_t len)
> +{
> +	sha256_update(ctx, len, data);
> +}
> +
> +static inline void nettle_SHA256_Final(unsigned char *digest,
> +				       nettle_SHA256_CTX *ctx)
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

This looks good to me, except for the small nit that I think this should
be squashed in. For the others we need this inline wrappers, but not for
"init":

diff --git a/sha256/nettle.h b/sha256/nettle.h
index b63e1c81903..5c9811c309a 100644
--- a/sha256/nettle.h
+++ b/sha256/nettle.h
@@ -5,11 +5,6 @@
 
 typedef struct sha256_ctx nettle_SHA256_CTX;
 
-static inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
-{
-	sha256_init(ctx);
-}
-
 static inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx,
 					const void *data,
 					size_t len)
@@ -24,7 +19,7 @@ static inline void nettle_SHA256_Final(unsigned char *digest,
 }
 
 #define platform_SHA256_CTX nettle_SHA256_CTX
-#define platform_SHA256_Init nettle_SHA256_Init
+#define platform_SHA256_Init sha256_init
 #define platform_SHA256_Update nettle_SHA256_Update
 #define platform_SHA256_Final nettle_SHA256_Final
 
